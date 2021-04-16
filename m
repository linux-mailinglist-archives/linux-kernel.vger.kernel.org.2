Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFC5361AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbhDPHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbhDPHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:52:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C479C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 00:51:58 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id e13so18152236qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BizjiGX7CK7NjPG3BovU7t24ZMIVaovvNxFJE+wsBXQ=;
        b=vI+aMtELxlNIzIJMPLcC4V1frvgUhkH01PvdlxpYg06klmvQYA8kuSK04/cL8O+eRS
         ZRHLP2IHb780+a8Ktl+bIwClqMU0OehGGsouVxVmaBMY3SffvyIS5lD/MrDasJerbJpM
         cIVzQKb9xrP9SHk6UAVNbIYTMi3bPL36arW6GfWfni31nPD2lpgl8IakVKULxpFNCEM1
         F7NM5A2IOXY9x34QknLbjPXRIGMEMCEEaQR68wSEg1Kjxzq4kL4DinCio3HkUmRaHDbr
         /tluu2R2zZ14/piduklaqwLEgY59DmM+8uTMetfuSi4z1DhGre8OsH5nuKuPZxYOGpgo
         AMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BizjiGX7CK7NjPG3BovU7t24ZMIVaovvNxFJE+wsBXQ=;
        b=fRnXCsb+CUt1bl8xXCqRHOXNeteVtHiWLOgbkXELIwq7DBq+Ks+Nxb8vHztusl+I+o
         N8xaT+LnZXVx4LuNSmivndU9JsWcLZo7c0j189kB2mUyZ4Gou3GYy1UUrv9jS8rnPcr9
         5qqS6nMU7BhyitXuWolDsHTz01RsOAMDiWWdYQOJx1Ncb3Ww3HOdU+QlWdvvKMZKdTE2
         ZLv/5q+JGJiDiNUunNx9PiJtHJv+Wo5tTMrDzAm3ovgqhceC7YKXjoN/dVgq2DUfi69v
         UYMd/ktF8p/3aA4WJPF9tZ2xxF4kPzmy3aq4a6boC97tjk389zSMwjjCv7BwhtVakR4o
         bs5A==
X-Gm-Message-State: AOAM532Z8SLW8AJ/bod9oMHSg2zSZTmszm03mCBC2KCu8nqCH9T/to5o
        r5AQD/FcsEr0yyg9PuAiBBJclGI578P8hRWIg+sEuA==
X-Google-Smtp-Source: ABdhPJwEtiakJYwu3/9foJYpXSrj8LxrAzHvwF1aRhkw1e9k2vb8/qow2YEeRFwq+MdgQSvXF7YZSoZaigW7DwlgsdU=
X-Received: by 2002:a37:4042:: with SMTP id n63mr3263745qka.501.1618559517123;
 Fri, 16 Apr 2021 00:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae236f05bfde0678@google.com> <20210413134147.54556d9d@gandalf.local.home>
 <20210413134314.16068eeb@gandalf.local.home> <CACT4Y+ZrkE=ZKKncTOJRJgOTNfU8PGz=k+8V+0602ftTCHkc6Q@mail.gmail.com>
 <20210413144009.6ed2feb8@gandalf.local.home> <20210413144335.4ff14cf2@gandalf.local.home>
In-Reply-To: <20210413144335.4ff14cf2@gandalf.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Apr 2021 09:51:45 +0200
Message-ID: <CACT4Y+YipDUHQiqJ=gtEeBQGz2AjqT6e_fje5DHsm0a5e+-GRQ@mail.gmail.com>
Subject: Bisections with different bug manifestations
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, masahiroy@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        rafael.j.wysocki@intel.com,
        Sean Christopherson <seanjc@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 8:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 13 Apr 2021 14:40:09 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > ------------[ cut here ]------------
> > raw_local_irq_restore() called with IRQs enabled
> > WARNING: CPU: 0 PID: 8777 at kernel/locking/irqflag-debug.c:9 warn_bogus_irq_restore kernel/locking/irqflag-debug.c:9 [inline]
> > WARNING: CPU: 0 PID: 8777 at kernel/locking/irqflag-debug.c:9 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:7
>
> In fact, when you have the above, which is a WARN() with text:
>
>  "raw_local_irq_restore() called with IRQs enabled"
>
> It is pretty much guaranteed that all triggers of this bug will have the
> above warning with the same text.

This looks nice on paper and looking at only 1 bisection log. But
unfortunately in practice theory and practice are different...

This was discussed at length multiple times:
https://groups.google.com/g/syzkaller/search?q=bisection+different+manifestations
https://groups.google.com/g/syzkaller-bugs/c/nFeC8-UG1gg/m/y6gUEsvAAgAJ
https://groups.google.com/g/syzkaller/c/sR8aAXaWEF4/m/tTWYRgvmAwAJ
https://groups.google.com/g/syzkaller/c/9NdprHsGBqo/m/Yj9uWRDgBQAJ

If you look at substantial base of bisection logs, you will find lots
of cases where bug types, functions don't match. Kernel crashes
differently even on the same revision. And obviously things change if
you change revisions. Also if you see presumably a different bug, what
does it say regarding the original bug.

I would very much like to improve automatic bisection quality, but it
does not look trivial at all.

Some random examples where, say, your hypothesis of WARN-to-WARN,
BUG-to-BUG does not hold even on the same kernel revision (add to this
different revisions and the fact that a different bug does not give
info regarding the original bug):

run #0: crashed: KASAN: use-after-free Read in fuse_dev_do_read
run #1: crashed: WARNING in request_end
run #2: crashed: KASAN: use-after-free Read in fuse_dev_do_read
run #3: OK
run #4: OK

run #0: crashed: KASAN: slab-out-of-bounds Read in __ip_append_data
run #1: crashed: inconsistent lock state in rhashtable_walk_enter
run #2: crashed: inconsistent lock state in rhashtable_walk_enter
run #3: crashed: inconsistent lock state in rhashtable_walk_enter
run #4: crashed: inconsistent lock state in rhashtable_walk_enter
run #5: crashed: inconsistent lock state in rhashtable_walk_enter
run #6: crashed: inconsistent lock state in rhashtable_walk_enter
run #7: crashed: kernel BUG at arch/x86/mm/physaddr.c:LINE!
run #8: crashed: inconsistent lock state in rhashtable_walk_enter
run #9: crashed: inconsistent lock state in rhashtable_walk_enter

run #0: crashed: kernel BUG at arch/x86/mm/physaddr.c:LINE!
run #1: crashed: inconsistent lock state in rhashtable_walk_enter
run #2: crashed: inconsistent lock state in rhashtable_walk_enter
run #3: crashed: inconsistent lock state in rhashtable_walk_enter
run #4: crashed: inconsistent lock state in rhashtable_walk_enter
run #5: crashed: kernel BUG at arch/x86/mm/physaddr.c:LINE!
run #6: crashed: inconsistent lock state in rhashtable_walk_enter
run #7: crashed: kernel BUG at arch/x86/mm/physaddr.c:LINE!
run #8: crashed: inconsistent lock state in rhashtable_walk_enter
run #9: crashed: inconsistent lock state in rhashtable_walk_enter

run #0: crashed: KASAN: use-after-free Read in __vb2_perform_fileio
run #1: crashed: KASAN: use-after-free Write in __vb2_cleanup_fileio
run #2: crashed: KASAN: use-after-free Read in __vb2_perform_fileio
run #3: crashed: KASAN: use-after-free Read in __vb2_perform_fileio
run #4: crashed: INFO: task hung in vivid_stop_generating_vid_cap
run #5: crashed: INFO: task hung in vivid_stop_generating_vid_cap
run #6: crashed: INFO: task hung in vivid_stop_generating_vid_cap
run #7: crashed: INFO: task hung in vivid_stop_generating_vid_cap
run #8: crashed: INFO: task hung in vivid_stop_generating_vid_cap
run #9: crashed: INFO: task hung in vivid_stop_generating_vid_cap

run #0: crashed: general protection fault in sctp_assoc_rwnd_increase
run #1: crashed: general protection fault in sctp_ulpevent_free
run #2: crashed: general protection fault in sctp_assoc_rwnd_increase
run #3: crashed: general protection fault in sctp_assoc_rwnd_increase
run #4: crashed: general protection fault in sctp_assoc_rwnd_increase
run #5: crashed: general protection fault in sctp_assoc_rwnd_increase
run #6: crashed: general protection fault in sctp_assoc_rwnd_increase
run #7: crashed: general protection fault in sctp_assoc_rwnd_increase

run #0: crashed: general protection fault in sctp_assoc_rwnd_increase
run #1: crashed: general protection fault in sctp_assoc_rwnd_increase
run #2: crashed: general protection fault in sctp_assoc_rwnd_increase
run #3: crashed: general protection fault in sctp_assoc_rwnd_increase
run #4: crashed: general protection fault in corrupted
run #5: crashed: general protection fault in sctp_assoc_rwnd_increase
run #6: crashed: general protection fault in sctp_assoc_rwnd_increase
run #7: crashed: general protection fault in corrupted

run #0: crashed: INFO: rcu detected stall in corrupted
run #1: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #2: crashed: INFO: rcu detected stall in sys_sendfile64
run #3: crashed: INFO: rcu detected stall in corrupted
run #4: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #5: crashed: INFO: rcu detected stall in corrupted
run #6: crashed: INFO: rcu detected stall in corrupted
run #7: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #8: crashed: INFO: rcu detected stall in sys_sendfile64
run #9: crashed: INFO: rcu detected stall in ext4_file_write_iter

run #0: crashed: INFO: rcu detected stall in sys_sendfile64
run #1: crashed: INFO: rcu detected stall in corrupted
run #2: crashed: INFO: rcu detected stall in corrupted
run #3: crashed: INFO: rcu detected stall in sys_sendfile64
run #4: crashed: INFO: rcu detected stall in corrupted
run #5: crashed: INFO: rcu detected stall in corrupted
run #6: crashed: INFO: rcu detected stall in corrupted
run #7: crashed: INFO: rcu detected stall in corrupted
run #8: crashed: INFO: rcu detected stall in sys_sendfile64
run #9: crashed: INFO: rcu detected stall in corrupted

run #0: crashed: INFO: rcu detected stall in rw_verify_area
run #1: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #2: crashed: INFO: rcu detected stall in corrupted
run #3: crashed: INFO: rcu detected stall in corrupted
run #4: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #5: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #6: crashed: INFO: rcu detected stall in corrupted
run #7: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #8: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #9: crashed: INFO: rcu detected stall in rw_verify_area

run #0: crashed: INFO: rcu detected stall in ext4_file_write_iter
run #1: crashed: INFO: rcu detected stall in corrupted
run #2: crashed: INFO: rcu detected stall in sys_sendfile64
run #3: crashed: INFO: rcu detected stall in sys_sendfile64
run #4: crashed: INFO: rcu detected stall in corrupted
run #5: crashed: INFO: rcu detected stall in sys_sendfile64
run #6: crashed: INFO: rcu detected stall in sys_sendfile64
run #7: crashed: INFO: rcu detected stall in corrupted
run #8: crashed: INFO: rcu detected stall in corrupted
run #9: crashed: INFO: rcu detected stall in sys_sendfile64

run #0: crashed: KASAN: use-after-free Read in link_path_walk
run #1: crashed: KASAN: use-after-free Read in link_path_walk
run #2: crashed: KASAN: use-after-free Read in trailing_symlink
run #3: crashed: KASAN: use-after-free Read in trailing_symlink
run #4: crashed: KASAN: use-after-free Read in trailing_symlink
run #5: crashed: KASAN: use-after-free Read in link_path_walk
run #6: crashed: KASAN: use-after-free Read in link_path_walk
run #7: crashed: KASAN: use-after-free Read in link_path_walk
run #8: crashed: KASAN: use-after-free Read in trailing_symlink
run #9: crashed: KASAN: use-after-free Read in trailing_symlink

run #0: crashed: BUG: unable to handle kernel NULL pointer dereference
in mrvl_setup
run #1: crashed: BUG: unable to handle kernel NULL pointer dereference
in mrvl_setup
run #2: crashed: BUG: unable to handle kernel NULL pointer dereference
in mrvl_setup
run #3: crashed: BUG: unable to handle kernel NULL pointer dereference
in mrvl_setup
run #4: crashed: WARNING: ODEBUG bug in corrupted
run #5: crashed: BUG: unable to handle kernel NULL pointer dereference
in mrvl_setup
run #6: crashed: BUG: unable to handle kernel NULL pointer dereference
in mrvl_setup
run #7: crashed: BUG: unable to handle kernel NULL pointer dereference
in mrvl_setup
run #8: crashed: BUG: unable to handle kernel NULL pointer dereference
in mrvl_setup
run #9: crashed: BUG: unable to handle kernel NULL pointer dereference
in mrvl_setup

run #0: crashed: KASAN: use-after-free Read in delayed_uprobe_remove
run #1: crashed: KASAN: use-after-free Read in delayed_uprobe_remove
run #2: crashed: general protection fault in delayed_uprobe_remove
run #3: crashed: KASAN: use-after-free Read in delayed_uprobe_remove
run #4: crashed: general protection fault in delayed_uprobe_remove
run #5: crashed: KASAN: use-after-free Read in delayed_uprobe_remove
run #6: OK
run #7: OK
run #8: OK
run #9: OK

run #0: crashed: general protection fault in delayed_uprobe_remove
run #1: crashed: KASAN: use-after-free Read in delayed_uprobe_remove
run #2: crashed: KASAN: use-after-free Read in delayed_uprobe_remove
run #3: crashed: KASAN: use-after-free Read in delayed_uprobe_remove
run #4: crashed: general protection fault in delayed_uprobe_remove
run #5: crashed: KASAN: use-after-free Read in delayed_uprobe_remove
run #6: OK
run #7: OK
run #8: OK
run #9: OK
