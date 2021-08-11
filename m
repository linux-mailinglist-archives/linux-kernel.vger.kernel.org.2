Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C163E99D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhHKUls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229918AbhHKUlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628714483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Xa4LqRu2FqBjZJyk4DMoDX5ERp8A9peVUVlHjzR3/k=;
        b=bf50K1S2VGxI5oYiw/W14PhdG7c0yRf4gUeLZDfl9ctaQOxhFi29yGhfmYRsct2br/XX5v
        VUj5ON32REX4SKf+wLbgcFFGS6PZXK9XnxC14qWouIYX/VXF83CES7bD7nhtm2s0la/9Pm
        5jdj0xb2ErN///TO/ZMKe+V1ncehJsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-nrz0801wMb6yUaOlEi2DoA-1; Wed, 11 Aug 2021 16:41:19 -0400
X-MC-Unique: nrz0801wMb6yUaOlEi2DoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D98C3801A92;
        Wed, 11 Aug 2021 20:41:17 +0000 (UTC)
Received: from starship (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 284BB5D6CF;
        Wed, 11 Aug 2021 20:41:15 +0000 (UTC)
Message-ID: <5b593e0db73301bab605d75536309c94eb306292.camel@redhat.com>
Subject: Re: [PATCH] scripts/gdb: rework lx-symbols gdb script
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kieran Bingham <kbingham@kernel.org>
Date:   Wed, 11 Aug 2021 23:41:14 +0300
In-Reply-To: <4d9e6fbf-48d6-58f9-98ae-ed2e7b72317f@siemens.com>
References: <20210811133152.904945-1-mlevitsk@redhat.com>
         <651bf834-5855-d298-bc1c-383e5da74aa5@siemens.com>
         <6ebb9699530e245f33628c10bc774035fe7bfc84.camel@redhat.com>
         <4d9e6fbf-48d6-58f9-98ae-ed2e7b72317f@siemens.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-08-11 at 22:15 +0200, Jan Kiszka wrote:
> On 11.08.21 22:10, Maxim Levitsky wrote:
> > On Wed, 2021-08-11 at 21:01 +0200, Jan Kiszka wrote:
> > > On 11.08.21 15:31, Maxim Levitsky wrote:
> > > > Fix several issues that are present in lx-symbols script:
> > > > 
> > > > * Track module unloads by placing another software breakpoint at
> > > >   'free_module'
> > > >   (force uninline this symbol just in case), and use remove-symbol-file
> > > >   gdb command to unload the symobls of the module that is unloading.
> > > > 
> > > >   That gives the gdb a chance to mark all software breakpoints from
> > > >   this module as pending again.
> > > >   Also remove the module from the 'known' module list once it is unloaded.
> > > > 
> > > > * Since we now track module unload, we don't need to reload all
> > > >   symbols anymore when 'known' module loaded again
> > > >   (that can't happen anymore).
> > > >   This allows reloading a module in the debugged kernel to finish
> > > >   much faster, while lx-symbols tracks module loads and unloads.
> > > > 
> > > > * Disable/enable all gdb breakpoints on both module load and unload
> > > >   breakpoint hits, and not only in 'load_all_symbols' as was done before.
> > > >   (load_all_symbols is no longer called on breakpoint hit)
> > > >   That allows gdb to avoid getting confused about the state of the
> > > >   (now two) internal breakpoints we place.
> > > >   Otherwise it will leave them in the kernel code segment, when
> > > >   continuing which triggers a guest kernel panic as soon as it skips
> > > >   over the 'int3' instruction and executes the garbage tail of the optcode
> > > >   on which the breakpoint was placed.
> > > > 
> > > > * Block SIGINT while the script is running as this seems to crash gdb
> > > > 
> > > > * Add a basic check that kernel is already loaded into the guest memory
> > > >   to avoid confusing errors.
> > > > 
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  kernel/module.c              |   8 +-
> > > >  scripts/gdb/linux/symbols.py | 203 +++++++++++++++++++++++------------
> > > >  2 files changed, 143 insertions(+), 68 deletions(-)
> > > > 
> > > > diff --git a/kernel/module.c b/kernel/module.c
> > > > index ed13917ea5f3..242bd4bb0b55 100644
> > > > --- a/kernel/module.c
> > > > +++ b/kernel/module.c
> > > > @@ -906,8 +906,12 @@ int module_refcount(struct module *mod)
> > > >  }
> > > >  EXPORT_SYMBOL(module_refcount);
> > > >  
> > > > -/* This exists whether we can unload or not */
> > > > -static void free_module(struct module *mod);
> > > > +/* This exists whether we can unload or not
> > > > + * Keep it uninlined to provide a reliable breakpoint target,
> > > > + * e.g. for the gdb helper command 'lx-symbols'.
> > > > + */
> > > > +
> > > > +static noinline void free_module(struct module *mod);
> > > >  
> > > >  SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
> > > >  		unsigned int, flags)
> > > 
> > > You likely want and need to push that as separate patch, analogously to
> > > be02a1862304.
> > 
> > I will do.
> > 
> > > And as you are factoring the patch, maybe think about whether you can
> > > split the changes to symbols.py into logical steps as well. The commit
> > > messages suggests that, thought that might be misleading.
> > 
> > I can try doing that.
> > 
> > > > diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> > > > index 08d264ac328b..78e278fb4bad 100644
> > > > --- a/scripts/gdb/linux/symbols.py
> > > > +++ b/scripts/gdb/linux/symbols.py
> > > > @@ -14,45 +14,23 @@
> > > >  import gdb
> > > >  import os
> > > >  import re
> > > > +import signal
> > > >  
> > > >  from linux import modules, utils
> > > >  
> > > >  
> > > >  if hasattr(gdb, 'Breakpoint'):
> > > > -    class LoadModuleBreakpoint(gdb.Breakpoint):
> > > > -        def __init__(self, spec, gdb_command):
> > > > -            super(LoadModuleBreakpoint, self).__init__(spec, internal=True)
> > > > +
> > > > +    class BreakpointWrapper(gdb.Breakpoint):
> > > > +        def __init__(self, callback, **kwargs):
> > > > +            super(BreakpointWrapper, self).__init__(internal=True, **kwargs)
> > > >              self.silent = True
> > > > -            self.gdb_command = gdb_command
> > > > +            self.callback = callback
> > > >  
> > > >          def stop(self):
> > > > -            module = gdb.parse_and_eval("mod")
> > > > -            module_name = module['name'].string()
> > > > -            cmd = self.gdb_command
> > > > -
> > > > -            # enforce update if object file is not found
> > > > -            cmd.module_files_updated = False
> > > > -
> > > > -            # Disable pagination while reporting symbol (re-)loading.
> > > > -            # The console input is blocked in this context so that we would
> > > > -            # get stuck waiting for the user to acknowledge paged output.
> > > > -            show_pagination = gdb.execute("show pagination", to_string=True)
> > > > -            pagination = show_pagination.endswith("on.\n")
> > > > -            gdb.execute("set pagination off")
> > > > -
> > > > -            if module_name in cmd.loaded_modules:
> > > > -                gdb.write("refreshing all symbols to reload module "
> > > > -                          "'{0}'\n".format(module_name))
> > > > -                cmd.load_all_symbols()
> > > > -            else:
> > > > -                cmd.load_module_symbols(module)
> > > > -
> > > > -            # restore pagination state
> > > > -            gdb.execute("set pagination %s" % ("on" if pagination else "off"))
> > > > -
> > > > +            self.callback()
> > > >              return False
> > > >  
> > > > -
> > > >  class LxSymbols(gdb.Command):
> > > >      """(Re-)load symbols of Linux kernel and currently loaded modules.
> > > >  
> > > > @@ -61,15 +39,52 @@ are scanned recursively, starting in the same directory. Optionally, the module
> > > >  search path can be extended by a space separated list of paths passed to the
> > > >  lx-symbols command."""
> > > >  
> > > > -    module_paths = []
> > > > -    module_files = []
> > > > -    module_files_updated = False
> > > > -    loaded_modules = []
> > > > -    breakpoint = None
> > > > -
> > > >      def __init__(self):
> > > >          super(LxSymbols, self).__init__("lx-symbols", gdb.COMMAND_FILES,
> > > >                                          gdb.COMPLETE_FILENAME)
> > > > +        self.module_paths = []
> > > > +        self.module_files = []
> > > > +        self.module_files_updated = False
> > > > +        self.loaded_modules = {}
> > > > +        self.internal_breakpoints = []
> > > > +
> > > > +    # prepare GDB for loading/unloading a module
> > > > +    def _prepare_for_module_load_unload(self):
> > > > +
> > > > +        self.blocked_sigint = False
> > > > +
> > > > +        # block SIGINT during execution to avoid gdb crash
> > > > +        sigmask = signal.pthread_sigmask(signal.SIG_BLOCK, [])
> > > > +        if not signal.SIGINT in sigmask:
> > > > +            self.blocked_sigint = True
> > > > +            signal.pthread_sigmask(signal.SIG_BLOCK, {signal.SIGINT})
> > > > +
> > > > +        # disable all breakpoints to workaround a GDB bug where it would
> > > > +        # not correctly resume from an internal breakpoint we placed
> > > > +        # in do_module_init/free_module (it leaves the int3
> > > 
> > > Seems the comment ends prematurely.
> > 
> > Yep, GDB leaves the int3 instruction in the guest memory, and the guest dies after
> > it encounters the truncated instruction that follows it.
> > 
> > > Any reference to a gdb bug tracker entry? Or affected versions? The
> > > description is a bit too fuzzy.
> > 
> > Well stricly speaking this isn't a GDB bug.
> > GDB documentation explictly prohibits what we are doing in this script.
> > 
> > https://sourceware.org/gdb/current/onlinedocs/gdb/Breakpoints-In-Python.html
> > 
> > "You should not alter the execution state of the inferior (i.e., step, next, etc.), alter the current frame context 
> > (i.e., change the current active frame), or alter, add or delete any breakpoint. 
> > As a general rule, you should not alter any data within GDB or the inferior at this time."
> > 
> > However we are reloading the whole symbol table as a response to a breakpoint.
> > 
> > However there is pretty much no other way to do what this script does so the next best thing
> > is to workaround this as was already partially done, and I just made it more robust.
> > 
> > Same for blocking SIGINT which I added, which otherwise crashes GDB
> > while the symbols are reloading.
> > It probably will also be blamed on this.
> > 
> > Do you think I might have some luck taking with GDB maintainers and asking them to support
> > this use case of updating symbol table when a breakpoint hits?
> > 
> 
> We should at least clarify if it's a GDB bug or our use case is outside
> of the envisioned ones, thus need to account for that. Then we should
> not call it a bug.

100% agree.

Do you think it makes sense to CC gdb@sourceware.org to this discussion or
should I make a new post there. I do think I have some energy to try and discuss
this issue with them.

> 
> [...]
> 
> > > > +            if not module_list:
> > > > +                gdb.write("no modules found\n")
> > > > +            else:
> > > > +                [self._do_load_module_symbols(module) for module in module_list]
> > > 
> > > Is that common python style? Elsewhere, you do
> > > 
> > > for var in list:
> > >     function(var)
> > 
> > It is a code I moved verbatim from the above. 
> > I can change it to use the more common syntax.
> 
> Oh, missed that. And it seems I once wrote it this way - no idea anymore
> why...

Python has various wierd syntaxes which we all at some point tried to adopt,
but eventually reverted back to something simple.

Thanks for the review!

Best regards,
	Maxim Levitsky

> 
> Jan
> 


