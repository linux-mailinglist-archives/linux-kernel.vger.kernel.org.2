Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D073628D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbhDPTpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:45:07 -0400
Received: from mail128-19.atl41.mandrillapp.com ([198.2.128.19]:53888 "EHLO
        mail128-19.atl41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235907AbhDPTpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=tW3n4iXTwRJ8zOqIkbHUARclgCzpKeFKhfYKy43eRDE=;
 b=mtncgwEteDwJMBBD5hLgJzYuCkGQwfEOCFeHXIgrI7mTTXG6sGjzc+PiYddCBFHz4ktUVx1075bL
   PEA4974iGda+BpRNiDV7c0HMwoli+pYNqfPjkQEVu0Qt1KYRS5epKy/wtni97XxXtlHMJuzoZrXA
   lNs+P+9gCFSXArKjsBM=
Received: from pmta01.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail128-19.atl41.mandrillapp.com id hf7kii1mquka for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 19:29:41 +0000 (envelope-from <bounce-md_31050260.6079e5a5.v1-18557e227bf247bd8addf26ad27e94ed@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1618601381; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=tW3n4iXTwRJ8zOqIkbHUARclgCzpKeFKhfYKy43eRDE=; 
 b=E6M1C599X5N/4zTKFMfV61ZN4khQLUUGHEpWKmB6OoA0DTJwuQbdDebdlNgo9gf5DNDdl6
 Qw4sqdrhi5lQ+qJ3cS0lioySEjKtVLfCVOBQkiGRKoQWZlSAOKecD0552R64OTVhO8Om9O0C
 6NB2bwYRaiKWGPFL3zDkP8eDF6OPo=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another address space
Received: from [87.98.221.171] by mandrillapp.com id 18557e227bf247bd8addf26ad27e94ed; Fri, 16 Apr 2021 19:29:41 +0000
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Message-Id: <YHnlmm7mK3tmxcdr@deco.navytux.spb.ru>
References: <20210414055217.543246-1-avagin@gmail.com>
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.18557e227bf247bd8addf26ad27e94ed
X-Mandrill-User: md_31050260
Date:   Fri, 16 Apr 2021 19:29:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:52:13PM -0700, Andrei Vagin wrote:
> We already have process_vm_readv and process_vm_writev to read and write
> to a process memory faster than we can do this with ptrace. And now it
> is time for process_vm_exec that allows executing code in an address
> space of another process. We can do this with ptrace but it is much
> slower.

I'd like to add that there are cases when using ptrace is even hardly possible:
in my situation one process needs to modify address space of another process
while that target process is being blocked under pagefault. From
https://lab.nexedi.com/kirr/wendelin.core/blob/539ec405/wcfs/notes.txt#L149-171 ,
https://lab.nexedi.com/kirr/wendelin.core/blob/539ec405/wcfs/wcfs.go#L395-397 :

---- 8< ----
Client cannot be ptraced while under pagefault
==============================================

We cannot use ptrace to run code on client thread that is under pagefault:

The kernel sends SIGSTOP to interrupt tracee, but the signal will be
processed only when the process returns from kernel space, e.g. here

     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/entry/common.c?id=v4.19-rc8-151-g23469de647c4#n160

This way the tracer won't receive obligatory information that tracee
stopped (via wait...) and even though ptrace(ATTACH) succeeds, all other
ptrace commands will fail:

     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/ptrace.c?id=v4.19-rc8-151-g23469de647c4#n1140
     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/ptrace.c?id=v4.19-rc8-151-g23469de647c4#n207

My original idea was to use ptrace to run code in process to change it's
memory mappings, while the triggering process is under pagefault/read
to wcfs, and the above shows it won't work - trying to ptrace the
client from under wcfs will just block forever (the kernel will be
waiting for read operation to finish for ptrace, and read will be first
waiting on ptrace stopping to complete = deadlock)

...

//	( one could imagine adjusting mappings synchronously via running
//	  wcfs-trusted code via ptrace that wcfs injects into clients, but ptrace
//	  won't work when client thread is blocked under pagefault or syscall(^) )
---- 8< ----

To workaround that I need to add special thread into target process and
implement custom additional "isolation protocol" in between my filesystem and
client processes that use it:

https://lab.nexedi.com/kirr/wendelin.core/blob/539ec405/wcfs/wcfs.go#L94-182
https://lab.nexedi.com/kirr/wendelin.core/blob/539ec405/wcfs/client/wcfs.h#L20-96
https://lab.nexedi.com/kirr/wendelin.core/blob/539ec405/wcfs/client/wcfs.cpp#L24-203

Most parts of that dance would be much easier, or completely
unnecessary, if it could be possible to reliably make changes to address
space of target process from outside.

Kirill
