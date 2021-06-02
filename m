Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0607399129
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFBRL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhFBRL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:11:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE49C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7MByiACCt+EBcbMKufTZdyDHt18gjWbb9Nex7veSKRA=; b=lT082MMaojIefsMThvrnbf3ABd
        owoFlztIqbJ6HzWXuy2xT+DrfxEgISJhjwDIfculH+6VENqcBXVMLo4tjvild1iyzB6UQronWc7LJ
        3Qsa0e8R/J+IJKE3+23e5JzV6T4iswwjXiMwkCtvB4ZIoNj2c1yb/QeyTaIc2msnMUOPrXeMKCGP0
        GejqFfBlMniJzppV0cMY4h9qULlqyT3vfdsVw8G3x67QgArvtFvzre5PbAPiDsC4L1CB2hHD39Dk2
        m1N6exDCm1xLazfXtbuLNnjK26S/JmyN2s4QDKWpzEJb/QI8UEYiWWupjsp59DD1ory2T7pY2qYHS
        Nx8Hg3CQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loUNV-002wLL-As; Wed, 02 Jun 2021 17:10:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CF8B986458; Wed,  2 Jun 2021 19:10:07 +0200 (CEST)
Date:   Wed, 2 Jun 2021 19:10:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        jgross@suse.com, mbenes@suse.com, linux-kernel@vger.kernel.org,
        upstream@semihalf.com,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210602171007.GA2458@worktop.programming.kicks-ass.net>
References: <20210326151159.128534163@infradead.org>
 <20210326151300.320177914@infradead.org>
 <20210329163826.anuqkv5ahvoyus5c@treble>
 <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <YLe4U9FgmMlYu/JN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLe4U9FgmMlYu/JN@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 06:56:51PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 02, 2021 at 05:51:01PM +0200, Lukasz Majczak wrote:
> > Hi Peter,
> > 
> > This patch seems to crash on Tigerlake platform (Chromebook delbin), I
> > got the following error:
> > 
> > [    2.103054] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
> > [    2.110148] pcieport 0000:00:1c.0: pciehp: Slot #7 AttnBtn-
> > PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+
> > IbPresDis- LLActRep+
> > [    2.126754] pcieport 0000:00:1d.0: PME: Signaling with IRQ 123
> > [    2.133946] ACPI: \_SB_.CP00: Found 3 idle states
> > [    2.139708] BUG: kernel NULL pointer dereference, address: 000000000000012b
> > [    2.140704] #PF: supervisor read access in kernel mode
> > [    2.140704] #PF: error_code(0x0000) - not-present page
> > [    2.140704] PGD 0 P4D 0
> > [    2.140704] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [    2.140704] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U
> >   5.13.0-rc1 #31
> > [    2.140704] Hardware name: Google Delbin/Delbin, BIOS
> > Google_Delbin.13672.156.3 05/14/2021
> > [    2.140704] RIP: 0010:cpuidle_poll_time+0x9/0x6a
> > [    2.140704] Code: 44 00 00 85 f6 78 19 55 48 89 e5 48 8b 05 16 44
> > 44 01 4c 8b 58 40 4d 85 db 5d 41 ff d3 66 90 00 c3 0f 1f 44 00 00 55
> > 48 89 e5 <48> 8b 46 20 48 85 c0 75 56 4c 63 87 28 04 00 00 b8 24 f49
> 
> All code
> ========
>  0:   44 00 00                add    %r8b,(%rax)
>  3:   85 f6                   test   %esi,%esi
>  5:   78 19                   js     0x20
>  7:   55                      push   %rbp
>  8:   48 89 e5                mov    %rsp,%rbp
>  b:   48 8b 05 16 44 44 01    mov    0x1444416(%rip),%rax        # 0x1444428
> 12:   4c 8b 58 40             mov    0x40(%rax),%r11
> 16:   4d 85 db                test   %r11,%r11
> 19:   5d                      pop    %rbp
> 1a:   41 ff d3                callq  *%r11
> 1d:   66 90                   xchg   %ax,%ax
> 1f:   00 c3                   add    %al,%bl
> 21:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> 26:   55                      push   %rbp
> 27:   48 89 e5                mov    %rsp,%rbp
> 2a:*  48 8b 46 20             mov    0x20(%rsi),%rax          <-- trapping instruction
> 2e:   48 85 c0                test   %rax,%rax
> 31:   75 56                   jne    0x89
> 33:   4c 63 87 28 04 00 00    movslq 0x428(%rdi),%r8
> 3a:   b8                      .byte 0xb8
> 3b:   24 49                   and    $0x49,%al
> 
> What does something like:
> 
> OBJ=vmlinux.o FUNC=0010:cpuidle_poll_time objdump -wdr $@ $OBJ | awk "/^\$/ { P=0; } /$FUNC[^>]*>:\$/ { P=1; O=strtonum(\"0x\" \$1); } { if (P) { o=strtonum(\"0x\" \$1); printf(\"%04x \", o-O); print \$0; } }"
> 
> look like for that build?

I'm being daft; we build debug stuff for this.

Can you please do something like:

$ touch drivers/cpuidle/cpuidle.c
$ OBJTOOL_ARGS="--backup" make drivers/cpuidle/cpuidle.o

and send me both: drivers/cpuidle/cpuidle.o{,.orig}


