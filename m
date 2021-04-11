Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1E35B0E1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 02:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhDKAaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 20:30:55 -0400
Received: from mail.efficios.com ([167.114.26.124]:57276 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhDKAax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 20:30:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D204D3242B8;
        Sat, 10 Apr 2021 20:30:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hIF5GPhcVfwk; Sat, 10 Apr 2021 20:30:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E03173241EA;
        Sat, 10 Apr 2021 20:30:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E03173241EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618101036;
        bh=+4w8kUO/0tlm0zbKEpsgFUnWCSgfNukUfJf8nrovDKc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nSI8dFLwvloseFaKZe+gBAFJ0QCZe940dtUYqBkTBI9XjZh3Z5Key9GOetVxPsXxQ
         R1XOunAcbSVel1rEswMpfRqSDsEX9igN2cWgmkVwjLcNIolML3StaQMEyaUlW+6HvO
         CO76PS7o49tj+1QvC6P9ouyaj8/lOxOmsb3g4xF20lcT0B/KScIi6A+cjCFmhsk5wI
         8PAhWsiIp6u3YlrqDt1XKnMcZYFm6vNy53425OA9JavBct6hbXO3HPCa+q9MLWnhE4
         G1QgGN20kR9+MV3ZtO6LZT/RkVdRCCkJnvhmfs2Devv1AeAg6LzTmoDBPMEzroq+Ib
         ZHNdikzcfNWiQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 29kMKcgFkPsd; Sat, 10 Apr 2021 20:30:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C778532431D;
        Sat, 10 Apr 2021 20:30:36 -0400 (EDT)
Date:   Sat, 10 Apr 2021 20:30:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Mingyi Liu <mingyiliu@gatech.edu>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Message-ID: <1319761610.67951.1618101036661.JavaMail.zimbra@efficios.com>
In-Reply-To: <MN2PR07MB8014361586F3E8DAF347A8C6D1729@MN2PR07MB8014.namprd07.prod.outlook.com>
References: <MN2PR07MB80147F72667BBA151586486ED1769@MN2PR07MB8014.namprd07.prod.outlook.com> <723248518.60240.1617801901472.JavaMail.zimbra@efficios.com> <MN2PR07MB8014361586F3E8DAF347A8C6D1729@MN2PR07MB8014.namprd07.prod.outlook.com>
Subject: Re: about seg fault inside rseq critical section
MIME-Version: 1.0
Content-Type: multipart/alternative; 
        boundary="=_d0ae2f63-5f2e-44a0-bf9a-fd80a6629123"
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: about seg fault inside rseq critical section
Thread-Index: AQHXKzICNtuXzcd7b0S3OpsM3Zas5DaS7ozSqPm99ISEB1Pp+g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_d0ae2f63-5f2e-44a0-bf9a-fd80a6629123
Content-Type: multipart/related; 
	boundary="=_dae49eca-5006-496e-88f9-35d0d7a10f41"

--=_dae49eca-5006-496e-88f9-35d0d7a10f41
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



----- On Apr 10, 2021, at 6:49 PM, Mingyi Liu mingyiliu@gatech.edu wrote:

> Hi Mathieu ,

> Thanks for your reply. From my current understanding of rseq, when flags
> enabled, any signal generated/happened inside the critical section would
> trigger the user-defined abort handler.

No, that's not how rseq works.

If a signal handler is executed on top of a rseq critical section, it will be allowed
to run on top of the userspace thread, but the instruction pointer where the signal
handler will return is modified by the kernel when it detects that it delivers a signal
on top of a rseq critical section so the signal handler will return to the abort ip.

See rseq_signal_deliver() for details.

Thanks,

Mathieu


> However, I tried to cause a segmentation fault like the following but it didn't
> go to the abort handler and was terminated by OS immediately.

> sigsegv_case.c

>> #define _GNU_SOURCE
>> #include <linux/rseq.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <syscall.h>
>> #include <stdint.h>
>> #include <unistd.h>
>> #include <sys/syscall.h>
>> #include <signal.h>

>> static __thread volatile struct rseq __rseq_abi;

>> #define RSEQ_SIG 0x53053053

>> static int sys_rseq ( volatile struct rseq * rseq_abi , uint32_t rseq_len ,
>> int flags , uint32_t sig ) {
>> return syscall (__NR_rseq, rseq_abi, rseq_len, flags, sig);
>> }

>> static void register_thread ( void ) {
>> int rc;
>> rc = sys_rseq (&__rseq_abi, sizeof ( struct rseq), 0 , RSEQ_SIG);
>> if (rc) {
>> fprintf (stderr, "Failed to register rseq \n " );
>> exit ( 1 );
>> }
>> }

>> #define RSEQ_ACCESS_ONCE( x ) ( * (__volatile__ __typeof__ (x) * ) & (x))

>> int do_test ( void * addr , int cpu ) {

>> __asm__ __volatile__ goto (

>> ".pushsection __rseq_table, \" aw \"\n\t "
>> ".balign 32 \n\t "
>> "cs_obj: \n\t "
>> ".int 0, 0 \n\t "
>> /* start_ip, post_commit_offset, abort_ip */
>> ".quad 1f, 2f - 1f, 4f \n\t "
>> ".popsection \n\t "
>> "1: \n\t "
>> "leaq cs_obj(%%rip), %%rax \n\t "
>> "movq %%rax, % [rseq_cs] \n\t "
>> "cmpl % [cpu_id], % [current_cpu_id] \n\t "
>> "jnz 4f \n\t "

>> /* enable seg fault */
>> "jmp * % [_addr] \n\t " // seg falut
>> /********************/

>> "jmp % l[committed] \n\t "

>> "2: \n\t "
>> /* Disassembler-friendly signature: nopl <sig>(%rip). */
>> ".byte 0x0f, 0x1f, 0x05 \n\t "
>> ".long 0x53053053 \n\t " /* RSEQ_SIG */
>> "4: \n\t "
>> "jmp % l[aborted] \n\t "
>> : /* no outputs */
>> : [cpu_id] "r" (cpu),
>> [current_cpu_id] "m" ( __rseq_abi . cpu_id ),
>> [rseq_cs] "m" ( __rseq_abi . rseq_cs ),
>> [_addr] "r" (addr)
>> : "memory" , "cc" , "rax"
>> : aborted, committed

>> );

>> committed:
>> printf ( "committed \n " );
>> return 0 ;

>> aborted:
>> printf ( "aborted \n " );
>> return - 1 ;

>> }

>> int main ( int argc , char ** argv ) {
>> int cpu, ret;

>> register_thread ();
>> cpu = RSEQ_ACCESS_ONCE ( __rseq_abi . cpu_id_start );

>> printf ( "ret = %d \n " , do_test (( void *) 0xdeadbeef , cpu));
>> return 0 ;
>> }

> Also, I've tried SIGINT inside the critical section as below, but the program
> didn't go to the abort handler, either.

> sigint_case.c

>> #define _GNU_SOURCE
>> #include <linux/rseq.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <syscall.h>
>> #include <stdint.h>
>> #include <unistd.h>
>> #include <sys/syscall.h>
>> #include <signal.h>

>> static __thread volatile struct rseq __rseq_abi;

>> #define RSEQ_SIG 0x53053053

>> static int sys_rseq ( volatile struct rseq * rseq_abi , uint32_t rseq_len ,
>> int flags , uint32_t sig ) {
>> return syscall (__NR_rseq, rseq_abi, rseq_len, flags, sig);
>> }

>> static void register_thread ( void ) {
>> int rc;
>> rc = sys_rseq (&__rseq_abi, sizeof ( struct rseq), 0 , RSEQ_SIG);
>> if (rc) {
>> fprintf (stderr, "Failed to register rseq \n " );
>> exit ( 1 );
>> }
>> }

>> #define RSEQ_ACCESS_ONCE( x ) ( * (__volatile__ __typeof__ (x) * ) & (x))

>> int do_test ( int cpu ) {

>> __asm__ __volatile__ goto (

>> ".pushsection __rseq_table, \" aw \"\n\t "
>> ".balign 32 \n\t "
>> "cs_obj: \n\t "
>> ".int 0, 0 \n\t "
>> /* start_ip, post_commit_offset, abort_ip */
>> ".quad 1f, 2f - 1f, 4f \n\t "
>> ".popsection \n\t "
>> "1: \n\t "
>> "leaq cs_obj(%%rip), %%rax \n\t "
>> "movq %%rax, % [rseq_cs] \n\t "
>> "cmpl % [cpu_id], % [current_cpu_id] \n\t "
>> "jnz 4f \n\t "
>> /* enable signal testing */
>> "movq $5, %%rdi \n\t "
>> "call sleep@plt \n\t "
>> /*************************/

>> "jmp % l[committed] \n\t "

>> "2: \n\t "
>> /* Disassembler-friendly signature: nopl <sig>(%rip). */
>> ".byte 0x0f, 0x1f, 0x05 \n\t "
>> ".long 0x53053053 \n\t " /* RSEQ_SIG */
>> "4: \n\t "
>> "jmp % l[aborted] \n\t "
>> : /* no outputs */
>> : [cpu_id] "r" (cpu),
>> [current_cpu_id] "m" ( __rseq_abi . cpu_id ),
>> [rseq_cs] "m" ( __rseq_abi . rseq_cs )
>> : "memory" , "cc" , "rax"
>> : aborted, committed

>> );

>> committed:
>> printf ( "committed \n " );
>> return 0 ;

>> aborted:
>> printf ( "aborted \n " );
>> return - 1 ;

>> }

>> void signal_callback_handler ( int signum ) {
>> printf ( "Caught signal %d \n " , signum);
>> }

>> int main ( int argc , char ** argv ) {
>> signal (SIGINT, signal_callback_handler);
>> int cpu, ret;

>> register_thread ();
>> cpu = RSEQ_ACCESS_ONCE ( __rseq_abi . cpu_id_start );

>> printf ( "ret = %d \n " , do_test (cpu));

>> return 0 ;
>> }

> As the screenshot is shown, the program executed the signal handler instead of
> rseq abort handler after interrupted the program.

> I am confused about how rseq deal with signal delivery as I assumed abort
> handler will be triggered anyway when flags permitted. Could you please explain
> such two cases or could you please share any references (code, article, etc)
> here?

> Thanks in advance!

> My virtual machine environment:

>> $ cat /etc/os-release
>> NAME="Ubuntu"
>> VERSION="20.04.2 LTS (Focal Fossa)"
>> ...

>> $ uname -r
>> 5.4.0-66-generic

> Best regards,
> Mingyi

> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Sent: Wednesday, April 7, 2021 9:25 AM
> To: Liu, Mingyi <mingyiliu@gatech.edu>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>; Peter Zijlstra
> <peterz@infradead.org>; paulmck <paulmck@kernel.org>; Boqun Feng
> <boqun.feng@gmail.com>
> Subject: Re: about seg fault inside rseq critical section
> (re-sent in plain-text for lkml)

> ----- On Apr 6, 2021, at 6:24 PM, Mingyi Liu mingyiliu@gatech.edu wrote:

> > Hi Mathieu,

> > I notice that the program will be terminated with segmentation fault when it is
> > even seg faulted inside the rseq critical section. In Linux kernel rseq.c, I
> > haven't found comment or code regarding this. Could you share any references on
> > why it doesn't execute user defined abort handler but uses the OS handler
> > instead?

> > Thanks in advance!

> Hi Mingyi,

> Please let me add the other rseq maintainers and LKML in CC. I'm a bit stretched
> on time
> here, so maybe they will have time to answer before I do.

> Meanwhile, if you could provide details about your architecture, kernel .config,
> and a
> small reproducer program, it would help bootstrapping the discussion.

> Thanks,

> Mathieu

> > Best,

> > Mingyi

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> [ http://www.efficios.com/ | http://www.efficios.com ]

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

--=_dae49eca-5006-496e-88f9-35d0d7a10f41--

--=_d0ae2f63-5f2e-44a0-bf9a-fd80a6629123--
