Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4431C4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 02:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBPBHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 20:07:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhBPBHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 20:07:22 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5DF364DCF;
        Tue, 16 Feb 2021 01:06:40 +0000 (UTC)
Date:   Mon, 15 Feb 2021 20:06:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ftrace: Do not reference symbols in sections without
 size
Message-ID: <20210215200639.67141685@oasis.local.home>
In-Reply-To: <20210216000504.axm3k4xho47c6drz@treble>
References: <20210215164446.530f6311@gandalf.local.home>
        <20210216000504.axm3k4xho47c6drz@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 18:05:04 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Feb 15, 2021 at 04:44:46PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > Starting with binutils 2.36, sections were being removed if they had weak
> > functions that were optimized out. Unfortunately, these weak functions would
> > leave references to mcount/fentry calls, that would make recordmcount fail
> > to find the symbol that matched the call to fentry.  
> 
> Binutils 2.36 isn't removing sections, just section *symbols*.
> 
> > Before returning the symbol of the section to create the mcount location,
> > check if that section size is greater than zero. If it has no size, skip
> > referencing that mcount call location.  
> 
> How does this even work?  The .text.unlikely section isn't empty:
> 
>   # readelf -SW kernel/kexec_file.o

Bah, because I messed up, and realized I was using the first section (shdr0)
and not the one it was being used for.

Strange, that when I applied this to the latest kernel on a my build
system (binutils 2.35), it still created all the necessary mcount
locations??

I'll look more into this.

Thanks for pointing this out.

-- Steve



>   
>   Section Headers:
>     [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>     [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
>     [ 1] .text             PROGBITS        0000000000000000 000040 001acf 00  AX  0   0  1
>     [ 2] .rela.text        RELA            0000000000000000 0049e0 001b30 18   I 27   1  8
>     [ 3] .data             PROGBITS        0000000000000000 001b20 000e80 00  WA  0   0 32
>     [ 4] .rela.data        RELA            0000000000000000 006510 0010e0 18   I 27   3  8
>     [ 5] .bss              NOBITS          0000000000000000 0029a0 000060 00  WA  0   0 32
>     [ 6] .rodata           PROGBITS        0000000000000000 0029a0 000b80 00   A  0   0 32
>     [ 7] .rodata.str1.1    PROGBITS        0000000000000000 003520 0001c6 01 AMS  0   0  1
>     [ 8] .text.unlikely    PROGBITS        0000000000000000 0036e6 000038 00  AX  0   0  1
> 

