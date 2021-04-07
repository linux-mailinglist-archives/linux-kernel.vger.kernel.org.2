Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA46A356F5B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhDGOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:54:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhDGOyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:54:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617807274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQDvV6O5oeVaS/yN3NwHYisGy5rzTbhXoebeh+w3qGc=;
        b=udCJSXP5OspQSqJo5LqGzS6IAGnkaUxO5aFdlPC6+JxywEiXJyTiDqapHJvVNhoOUKMsy3
        Y1bsBfSvQURgR2fM64601+F3S2H7Ba/wCiywAzsYCugwdobDoVNJCzMIcZo5wEZkwxIlAr
        XvrlvFAnaYa1FkN5otyTuJzSaa7NQCQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0976B02B;
        Wed,  7 Apr 2021 14:54:34 +0000 (UTC)
Date:   Wed, 7 Apr 2021 16:54:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/12] module: Add printk format to add module build
 ID to stacktraces
Message-ID: <YG3HqcI173aPn0l+@alley>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331030520.3816265-5-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-30 20:05:12, Stephen Boyd wrote:
> Let's make kernel stacktraces easier to identify by including the build
> ID[1] of a module if the stacktrace is printing a symbol from a module.
> This makes it simpler for developers to locate a kernel module's full
> debuginfo for a particular stacktrace. Combined with
> scripts/decode_stracktrace.sh, a developer can download the matching
> debuginfo from a debuginfod[2] server and find the exact file and line
> number for the functions plus offsets in a stacktrace that match the
> module. This is especially useful for pstore crash debugging where the
> kernel crashes are recorded in something like console-ramoops and the
> recovery kernel/modules are different or the debuginfo doesn't exist on
> the device due to space concerns (the debuginfo can be too large for
> space limited devices).
> 
> Originally, I put this on the %pS format, but that was quickly rejected
> given that %pS is used in other places such as ftrace where build IDs
> aren't meaningful. There was some discussions on the list to put every
> module build ID into the "Modules linked in:" section of the stacktrace
> message but that quickly becomes very hard to read once you have more
> than three or four modules linked in. It also provides too much
> information when we don't expect each module to be traversed in a
> stacktrace. Having the build ID for modules that aren't important just
> makes things messy. Splitting it to multiple lines for each module
> quickly explodes the number of lines printed in an oops too, possibly
> wrapping the warning off the console. And finally, trying to stash away
> each module used in a callstack to provide the ID of each symbol printed
> is cumbersome and would require changes to each architecture to stash
> away modules and return their build IDs once unwinding has completed.
> 
> Instead, we opt for the simpler approach of introducing a new printk
> format '%pS[R]b' for "pointer symbolic backtrace with module build ID"
> and then updating the few places in the architecture layer where the
> stacktrace is printed to use this new format.
> 
> Example:
> 
>  WARNING: CPU: 3 PID: 3373 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
>  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE hci_uart <modules trimmed>
>  CPU: 3 PID: 3373 Comm: bash Not tainted 5.11 #12 a8c0d47f7051f3e6670ceaea724af66a39c6cec8
>  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
>  pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
>  pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
>  lr : lkdtm_do_action+0x24/0x40 [lkdtm]
>  sp : ffffffc013febca0
>  x29: ffffffc013febca0 x28: ffffff88d9438040
>  x27: 0000000000000000 x26: 0000000000000000
>  x25: 0000000000000000 x24: ffffffdd0e9772c0
>  x23: 0000000000000020 x22: ffffffdd0e975366
>  x21: ffffffdd0e9772e0 x20: ffffffc013febde0
>  x19: 0000000000000008 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000037
>  x15: ffffffdd102ab174 x14: 0000000000000003
>  x13: 0000000000000004 x12: 0000000000000000
>  x11: 0000000000000000 x10: 0000000000000000
>  x9 : 0000000000000001 x8 : ffffffdd0e979000
>  x7 : 0000000000000000 x6 : ffffffdd10ff6b54
>  x5 : 0000000000000000 x4 : 0000000000000000
>  x3 : ffffffc013feb938 x2 : ffffff89fef05a70
>  x1 : ffffff89feef5788 x0 : ffffffdd0e9772e0
>  Call trace:
>   lkdtm_WARNING+0x28/0x30 [lkdtm 6c2215028606bda50de823490723dc4bc5bf46f9]
>   direct_entry+0x16c/0x1b4 [lkdtm 6c2215028606bda50de823490723dc4bc5bf46f9]
>   full_proxy_write+0x74/0xa4
>   vfs_write+0xec/0x2e8
>   ksys_write+0x84/0xf0
>   __arm64_sys_write+0x24/0x30
>   el0_svc_common+0xf4/0x1c0
>   do_el0_svc_compat+0x28/0x3c
>   el0_svc_compat+0x10/0x1c
>   el0_sync_compat_handler+0xa8/0xcc
>   el0_sync_compat+0x178/0x180
>  ---[ end trace f89bc7f5417cbcc6 ]---

I used this test patch:

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 95a2f82427c7..06716948de3c 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -686,6 +686,7 @@ test_pointer(void)
        kernel_ptr();
        struct_resource();
        addr();
+       BUG();
        escaped_str();
        hex_string();
        mac();

Then I did

  # modprobe test_printf

and got the following:

[  125.707281][ T1837] test_printf: loaded.
[  125.707707][ T1837] ------------[ cut here ]------------
[  125.708227][ T1837] kernel BUG at lib/test_printf.c:689!
[  125.709102][ T1837] invalid opcode: 0000 [#1] SMP NOPTI
[  125.709111][ T1837] CPU: 3 PID: 1837 Comm: modprobe Kdump: loaded Tainted: G            E     5.12.0-rc6-default+ #171 00000080ffffffff000000000000000000000000
[  125.712102][ T1837] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  125.712191][ T1837] RIP: 0010:test_printf_init+0x561/0xc99 [test_printf c2388ff0552611501b4d2ad58d8e5ca441d9a350]
[  125.712233][ T1837] Code: 00 48 c7 c7 b8 96 0f c0 e8 19 f9 ff ff b9 ab 00 00 00 48 c7 c2 93 96 0f c0 be 08 00 00 00 48 c7 c7 af 96 0f c0 e8 fc f8 ff ff <0f> 0b 8b 05 44 07 00 00 8b 35 3a 07 00 00 8b 1d 3c 07 00 00 85 c0
[  125.712235][ T1837] RSP: 0018:ffffb060004abc78 EFLAGS: 00010282
[  125.712240][ T1837] RAX: 0000000000000000 RBX: ffffb060004abc80 RCX: ffffd05fffc00b70
[  125.712241][ T1837] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffad352fd5
[  125.712242][ T1837] RBP: ffffffffc00fd367 R08: 0000000000000001 R09: 0000000000000001
[  125.712243][ T1837] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9b6cc49ffc00
[  125.712244][ T1837] R13: 0000000000000001 R14: ffff9b6cc2ee0000 R15: ffffb060004abe90
[  125.712247][ T1837] FS:  00007f70c4466b80(0000) GS:ffff9b6d3fc00000(0000) knlGS:0000000000000000
[  125.712248][ T1837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  125.712249][ T1837] CR2: 00007ffdb02e8b38 CR3: 000000010b6f2002 CR4: 0000000000370ee0
[  125.712257][ T1837] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  125.712257][ T1837] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  125.712258][ T1837] Call Trace:
[  125.712275][ T1837]  ? __test+0x13c/0x149 [test_printf]
[  125.723404][ T1837]  ? rcu_read_lock_sched_held+0x52/0x80
[  125.723425][ T1837]  do_one_initcall+0x5b/0x2d0
[  125.724367][ T1837]  do_init_module+0x5b/0x21c
[  125.724377][ T1837]  load_module+0x1eaa/0x23c0
[  125.725381][ T1837]  ? show_modinfo_version+0x30/0x30
[  125.725422][ T1837]  ? __do_sys_finit_module+0xad/0x110
[  125.725425][ T1837]  __do_sys_finit_module+0xad/0x110
[  125.725431][ T1837]  do_syscall_64+0x33/0x40
[  125.725464][ T1837]  entry_SYSCALL_64_after_hwframe+0x44/0xae

It shows wrong build id for vmlinux.
And it does not show the build if for the module at all.


readelf shows the following:

# readelf -Wn /lib/modules/5.12.0-rc6-default+/kernel/lib/test_printf.ko

Displaying notes found in: .note.gnu.build-id
  Owner                 Data size       Description
  GNU                  0x00000014       NT_GNU_BUILD_ID (unique build ID bitstring)         Build ID: c2388ff0552611501b4d2ad58d8e5ca441d9a350


Best Regards,
Petr
