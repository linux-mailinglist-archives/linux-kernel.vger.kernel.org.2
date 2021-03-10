Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D955933387B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCJJPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhCJJOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:14:42 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA76AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k6edGbn+vPekoJZII3mMJI4xd+2gj/4sv7pPUzi5WJQ=; b=E+pee9Wzo/fkYoZEG9bnxWp6Y5
        +X0RI9Dw8d0Z0VhOUeYm8BOR3qHGIh22jonj0bFCzvyxeayNykc+E65iWrYRNook76NbFqVCjLE85
        pktdK6JOLt91pqLcCZyO/sU3zKXZElqKWUL/Dx5Aw3FPIY/trqPdW8XNN8I5mvH3J8a7I3eHehKdQ
        qm5pBJP6/qusrt6vbv9sd1y3Q8E87cdL/fPMBv89KlhuDzqKsVRyey177OPA4mJf8pqpQvrB9HUX5
        DOuin804TdfZOf/DTARSIddf4DU3UvnOsUkDkcq912S6EUscK+/V2ocLFAlfP+mO86Yx7Bs29m4Mz
        U2mPCM7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJuvM-006RQg-QT; Wed, 10 Mar 2021 09:14:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCB71300455;
        Wed, 10 Mar 2021 10:14:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D4222B7F3E94; Wed, 10 Mar 2021 10:14:35 +0100 (CET)
Date:   Wed, 10 Mar 2021 10:14:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: The killing of ideal_nops[]
Message-ID: <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net>
References: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
 <20210309120519.7c6bbb97@gandalf.local.home>
 <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
 <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:33:45PM -0800, hpa@zytor.com wrote:
> On March 9, 2021 1:24:44 PM PST, Peter Zijlstra <peterz@infradead.org> wrote:
> >On Tue, Mar 09, 2021 at 12:05:19PM -0500, Steven Rostedt wrote:
> >> On Tue, 9 Mar 2021 17:58:17 +0100
> >> Peter Zijlstra <peterz@infradead.org> wrote:
> >> 
> >> > Hi,
> >> > 
> >> > AFAICT everything made in the past 10 years ends up using p6_nops.
> >Is it
> >> > time to kill off ideal_nops[] and simplify life?
> >> > 
> >> 
> >> Well, the one bug that was reported recently was due to a box that
> >uses a
> >> different "ideal_nops" than p6_nops. Perhaps we should ask him if
> >there's
> >> any noticeable difference between using p6_nops for every function
> >than the
> >> ideal_nops that as found for that box.
> >
> >If the machine is more than a decade old, I'm not really caring about
> >optimal performance. If it is 32bit, I really couldn't be arsed as long
> >as it boots.
> 
> p6_nops don't boot on all 32-bit chips.

Sure, but we can have one set on 32bit and another set on 64bit.

$ cat nops.s
.section .text
nop1: .nops 1
nop2: .nops 2
nop3: .nops 3
nop4: .nops 4
nop5: .nops 5
nop6: .nops 6
nop7: .nops 7
nop8: .nops 8

$ as --32 nops.s -o nops.o ; objdump -wd nops.o

nops.o:     file format elf32-i386


Disassembly of section .text:

00000000 <nop1>:
0:   90                      nop

00000001 <nop2>:
1:   66 90                   xchg   %ax,%ax

00000003 <nop3>:
3:   8d 76 00                lea    0x0(%esi),%esi

00000006 <nop4>:
6:   8d 74 26 00             lea    0x0(%esi,%eiz,1),%esi

0000000a <nop5>:
a:   8d 74 26 00             lea    0x0(%esi,%eiz,1),%esi
e:   90                      nop

0000000f <nop6>:
f:   8d b6 00 00 00 00       lea    0x0(%esi),%esi

00000015 <nop7>:
15:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi

0000001c <nop8>:
1c:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
23:   90                      nop

$ as --64 nops.s -o nops.o ; objdump -wd nops.o

nops.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <nop1>:
0:   90                      nop

0000000000000001 <nop2>:
1:   66 90                   xchg   %ax,%ax

0000000000000003 <nop3>:
3:   0f 1f 00                nopl   (%rax)

0000000000000006 <nop4>:
6:   0f 1f 40 00             nopl   0x0(%rax)

000000000000000a <nop5>:
a:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)

000000000000000f <nop6>:
f:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

0000000000000015 <nop7>:
15:   0f 1f 80 00 00 00 00    nopl   0x0(%rax)

000000000000001c <nop8>:
1c:   0f 1f 84 00 00 00 00 00         nopl   0x0(%rax,%rax,1)


---

Although I would use DS prefix nops for 32bit nop5/nop8 to keep them
single instructions.

Then we can do away with runtime nop selection and special atomic nops
and simplify things.

All this runtime faffing about nops is tedious and causes complications
we can do without.
