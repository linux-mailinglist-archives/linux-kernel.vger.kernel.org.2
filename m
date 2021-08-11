Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56D93E9831
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhHKTCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:02:00 -0400
Received: from thoth.sbs.de ([192.35.17.2]:41520 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhHKTB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:01:58 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 17BJ1MCF010468
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 21:01:22 +0200
Received: from [167.87.241.87] ([167.87.241.87])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 17BJ1LQT028274;
        Wed, 11 Aug 2021 21:01:21 +0200
Subject: Re: [PATCH] scripts/gdb: rework lx-symbols gdb script
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kieran Bingham <kbingham@kernel.org>
References: <20210811133152.904945-1-mlevitsk@redhat.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <651bf834-5855-d298-bc1c-383e5da74aa5@siemens.com>
Date:   Wed, 11 Aug 2021 21:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811133152.904945-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.21 15:31, Maxim Levitsky wrote:
> Fix several issues that are present in lx-symbols script:
> 
> * Track module unloads by placing another software breakpoint at
>   'free_module'
>   (force uninline this symbol just in case), and use remove-symbol-file
>   gdb command to unload the symobls of the module that is unloading.
> 
>   That gives the gdb a chance to mark all software breakpoints from
>   this module as pending again.
>   Also remove the module from the 'known' module list once it is unloaded.
> 
> * Since we now track module unload, we don't need to reload all
>   symbols anymore when 'known' module loaded again
>   (that can't happen anymore).
>   This allows reloading a module in the debugged kernel to finish
>   much faster, while lx-symbols tracks module loads and unloads.
> 
> * Disable/enable all gdb breakpoints on both module load and unload
>   breakpoint hits, and not only in 'load_all_symbols' as was done before.
>   (load_all_symbols is no longer called on breakpoint hit)
>   That allows gdb to avoid getting confused about the state of the
>   (now two) internal breakpoints we place.
>   Otherwise it will leave them in the kernel code segment, when
>   continuing which triggers a guest kernel panic as soon as it skips
>   over the 'int3' instruction and executes the garbage tail of the optcode
>   on which the breakpoint was placed.
> 
> * Block SIGINT while the script is running as this seems to crash gdb
> 
> * Add a basic check that kernel is already loaded into the guest memory
>   to avoid confusing errors.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  kernel/module.c              |   8 +-
>  scripts/gdb/linux/symbols.py | 203 +++++++++++++++++++++++------------
>  2 files changed, 143 insertions(+), 68 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index ed13917ea5f3..242bd4bb0b55 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -906,8 +906,12 @@ int module_refcount(struct module *mod)
>  }
>  EXPORT_SYMBOL(module_refcount);
>  
> -/* This exists whether we can unload or not */
> -static void free_module(struct module *mod);
> +/* This exists whether we can unload or not
> + * Keep it uninlined to provide a reliable breakpoint target,
> + * e.g. for the gdb helper command 'lx-symbols'.
> + */
> +
> +static noinline void free_module(struct module *mod);
>  
>  SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>  		unsigned int, flags)

You likely want and need to push that as separate patch, analogously to
be02a1862304.

And as you are factoring the patch, maybe think about whether you can
split the changes to symbols.py into logical steps as well. The commit
messages suggests that, thought that might be misleading.

> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index 08d264ac328b..78e278fb4bad 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -14,45 +14,23 @@
>  import gdb
>  import os
>  import re
> +import signal
>  
>  from linux import modules, utils
>  
>  
>  if hasattr(gdb, 'Breakpoint'):
> -    class LoadModuleBreakpoint(gdb.Breakpoint):
> -        def __init__(self, spec, gdb_command):
> -            super(LoadModuleBreakpoint, self).__init__(spec, internal=True)
> +
> +    class BreakpointWrapper(gdb.Breakpoint):
> +        def __init__(self, callback, **kwargs):
> +            super(BreakpointWrapper, self).__init__(internal=True, **kwargs)
>              self.silent = True
> -            self.gdb_command = gdb_command
> +            self.callback = callback
>  
>          def stop(self):
> -            module = gdb.parse_and_eval("mod")
> -            module_name = module['name'].string()
> -            cmd = self.gdb_command
> -
> -            # enforce update if object file is not found
> -            cmd.module_files_updated = False
> -
> -            # Disable pagination while reporting symbol (re-)loading.
> -            # The console input is blocked in this context so that we would
> -            # get stuck waiting for the user to acknowledge paged output.
> -            show_pagination = gdb.execute("show pagination", to_string=True)
> -            pagination = show_pagination.endswith("on.\n")
> -            gdb.execute("set pagination off")
> -
> -            if module_name in cmd.loaded_modules:
> -                gdb.write("refreshing all symbols to reload module "
> -                          "'{0}'\n".format(module_name))
> -                cmd.load_all_symbols()
> -            else:
> -                cmd.load_module_symbols(module)
> -
> -            # restore pagination state
> -            gdb.execute("set pagination %s" % ("on" if pagination else "off"))
> -
> +            self.callback()
>              return False
>  
> -
>  class LxSymbols(gdb.Command):
>      """(Re-)load symbols of Linux kernel and currently loaded modules.
>  
> @@ -61,15 +39,52 @@ are scanned recursively, starting in the same directory. Optionally, the module
>  search path can be extended by a space separated list of paths passed to the
>  lx-symbols command."""
>  
> -    module_paths = []
> -    module_files = []
> -    module_files_updated = False
> -    loaded_modules = []
> -    breakpoint = None
> -
>      def __init__(self):
>          super(LxSymbols, self).__init__("lx-symbols", gdb.COMMAND_FILES,
>                                          gdb.COMPLETE_FILENAME)
> +        self.module_paths = []
> +        self.module_files = []
> +        self.module_files_updated = False
> +        self.loaded_modules = {}
> +        self.internal_breakpoints = []
> +
> +    # prepare GDB for loading/unloading a module
> +    def _prepare_for_module_load_unload(self):
> +
> +        self.blocked_sigint = False
> +
> +        # block SIGINT during execution to avoid gdb crash
> +        sigmask = signal.pthread_sigmask(signal.SIG_BLOCK, [])
> +        if not signal.SIGINT in sigmask:
> +            self.blocked_sigint = True
> +            signal.pthread_sigmask(signal.SIG_BLOCK, {signal.SIGINT})
> +
> +        # disable all breakpoints to workaround a GDB bug where it would
> +        # not correctly resume from an internal breakpoint we placed
> +        # in do_module_init/free_module (it leaves the int3

Seems the comment ends prematurely.

Any reference to a gdb bug tracker entry? Or affected versions? The
description is a bit too fuzzy.

> +        self.saved_breakpoints = []
> +        if hasattr(gdb, 'breakpoints') and not gdb.breakpoints() is None:
> +            for bp in gdb.breakpoints():
> +                self.saved_breakpoints.append({'breakpoint': bp, 'enabled': bp.enabled})
> +                bp.enabled = False
> +
> +        # disable pagination to avoid asking user for continue
> +        show_pagination = gdb.execute("show pagination", to_string=True)
> +        self.saved_pagination = show_pagination.endswith("on.\n")
> +        gdb.execute("set pagination off")
> +
> +    def _unprepare_for_module_load_unload(self):
> +        # restore breakpoint state
> +        for breakpoint in self.saved_breakpoints:
> +            breakpoint['breakpoint'].enabled = breakpoint['enabled']
> +
> +        # restore pagination state
> +        gdb.execute("set pagination %s" % ("on" if self.saved_pagination else "off"))
> +
> +        # unblock SIGINT
> +        if self.blocked_sigint:
> +            sigmask = signal.pthread_sigmask(signal.SIG_UNBLOCK, {signal.SIGINT})
> +            self.blocked_sigint = False
>  
>      def _update_module_files(self):
>          self.module_files = []
> @@ -107,7 +122,7 @@ lx-symbols command."""
>                      name=section_name, addr=str(address)))
>          return "".join(args)
>  
> -    def load_module_symbols(self, module):
> +    def _do_load_module_symbols(self, module):
>          module_name = module['name'].string()
>          module_addr = str(module['core_layout']['base']).split()[0]
>  
> @@ -130,56 +145,112 @@ lx-symbols command."""
>                  addr=module_addr,
>                  sections=self._section_arguments(module))
>              gdb.execute(cmdline, to_string=True)
> -            if module_name not in self.loaded_modules:
> -                self.loaded_modules.append(module_name)
> +
> +            self.loaded_modules[module_name] = {"module_file": module_file,
> +                                                "module_addr": module_addr}
>          else:
>              gdb.write("no module object found for '{0}'\n".format(module_name))
>  
> +
> +    def load_module_symbols(self):
> +        module = gdb.parse_and_eval("mod")
> +
> +        # module already loaded, false alarm
> +        # can happen if 'do_init_module' breakpoint is hit multiple times
> +        # due to interrupts

Maybe better move this comment into the if-clause to make the context
clearer.

> +        module_name = module['name'].string()
> +        if module_name in self.loaded_modules:
> +            gdb.write("spurious module load breakpoint\n")
> +            return
> +
> +        # enforce update if object file is not found
> +        self.module_files_updated = False
> +        self._prepare_for_module_load_unload()
> +        try:
> +            self._do_load_module_symbols(module)
> +        finally:
> +            self._unprepare_for_module_load_unload()
> +
> +
> +    def unload_module_symbols(self):
> +        module = gdb.parse_and_eval("mod")
> +        module_name = module['name'].string()
> +
> +        # module already unloaded, false alarm
> +        # can happen if 'free_module' breakpoint is hit multiple times
> +        # due to interrupts

Same as above.

> +        if not module_name in self.loaded_modules:
> +            gdb.write("spurious module unload breakpoint\n")
> +            return
> +
> +        module_file = self.loaded_modules[module_name]["module_file"]
> +        module_addr = self.loaded_modules[module_name]["module_addr"]
> +
> +        self._prepare_for_module_load_unload()
> +        try:
> +            gdb.write("unloading @{addr}: {filename}\n".format(
> +                addr=module_addr, filename=module_file))
> +            cmdline = "remove-symbol-file {filename}".format(
> +                filename=module_file)
> +            gdb.execute(cmdline, to_string=True)
> +            del self.loaded_modules[module_name]
> +
> +        finally:
> +            self._unprepare_for_module_load_unload()
> +
>      def load_all_symbols(self):
>          gdb.write("loading vmlinux\n")
>  
> -        # Dropping symbols will disable all breakpoints. So save their states
> -        # and restore them afterward.
> -        saved_states = []
> -        if hasattr(gdb, 'breakpoints') and not gdb.breakpoints() is None:
> -            for bp in gdb.breakpoints():
> -                saved_states.append({'breakpoint': bp, 'enabled': bp.enabled})
> -
> -        # drop all current symbols and reload vmlinux
> -        orig_vmlinux = 'vmlinux'
> -        for obj in gdb.objfiles():
> -            if obj.filename.endswith('vmlinux'):
> -                orig_vmlinux = obj.filename
> -        gdb.execute("symbol-file", to_string=True)
> -        gdb.execute("symbol-file {0}".format(orig_vmlinux))
> -
> -        self.loaded_modules = []
> -        module_list = modules.module_list()
> -        if not module_list:
> -            gdb.write("no modules found\n")
> -        else:
> -            [self.load_module_symbols(module) for module in module_list]
> +        self._prepare_for_module_load_unload()
> +        try:
> +            # drop all current symbols and reload vmlinux
> +            orig_vmlinux = 'vmlinux'
> +            for obj in gdb.objfiles():
> +                if obj.filename.endswith('vmlinux'):
> +                    orig_vmlinux = obj.filename
> +            gdb.execute("symbol-file", to_string=True)
> +            gdb.execute("symbol-file {0}".format(orig_vmlinux))
> +            self.loaded_modules = {}
> +            module_list = modules.module_list()
> +            if not module_list:
> +                gdb.write("no modules found\n")
> +            else:
> +                [self._do_load_module_symbols(module) for module in module_list]

Is that common python style? Elsewhere, you do

for var in list:
    function(var)

> +        finally:
> +            self._unprepare_for_module_load_unload()
>  
> -        for saved_state in saved_states:
> -            saved_state['breakpoint'].enabled = saved_state['enabled']
> +        self._unprepare_for_module_load_unload()
>  
>      def invoke(self, arg, from_tty):
>          self.module_paths = [os.path.abspath(os.path.expanduser(p))
>                               for p in arg.split()]
>          self.module_paths.append(os.getcwd())
>  
> +        try:
> +            gdb.parse_and_eval("*start_kernel").fetch_lazy()
> +        except gdb.MemoryError:
> +            gdb.write("Error: Kernel is not yet loaded\n")
> +            return
> +
>          # enforce update
>          self.module_files = []
>          self.module_files_updated = False
>  
> +        for bp in self.internal_breakpoints:
> +            bp.delete()
> +        self.internal_breakpoints = []
> +
>          self.load_all_symbols()
>  
>          if hasattr(gdb, 'Breakpoint'):
> -            if self.breakpoint is not None:
> -                self.breakpoint.delete()
> -                self.breakpoint = None
> -            self.breakpoint = LoadModuleBreakpoint(
> -                "kernel/module.c:do_init_module", self)
> +            self.internal_breakpoints.append(
> +                BreakpointWrapper(self.load_module_symbols,
> +                                  spec="kernel/module.c:do_init_module",
> +                                  ))
> +            self.internal_breakpoints.append(
> +                BreakpointWrapper(self.unload_module_symbols,
> +                                  spec="kernel/module.c:free_module",
> +                                  ))
>          else:
>              gdb.write("Note: symbol update on module loading not supported "
>                        "with this gdb version\n")
> 

The logic of the changes look good to me.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
