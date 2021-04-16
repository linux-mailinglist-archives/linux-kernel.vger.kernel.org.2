Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F78361F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbhDPMRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:17:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35768 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240467AbhDPMRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:17:05 -0400
Received: from zn.tnic (p200300ec2f0cc5001db9c03a7172309d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c500:1db9:c03a:7172:309d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73F431EC009F;
        Fri, 16 Apr 2021 14:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618575398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lv0TMcLKA1ayw9GDGqnm7d2eT974/lrFgjYkm021bpI=;
        b=bG5kqsScMLDkWVe2a53aZYTj9LC/4JZ5UMf6kIBaowU+iJ+Qzy+aFFVaW4YJiLOWFj3ApP
        XwXe8iugTI3i5dfiGkdWkN/zv05mQS3u8KDzAqlmgcIyygHZFVgoPtPw/LzZRO3atLL5v/
        S0IkQilfpehjkuuRRKUO9uz8RKDn3xQ=
Date:   Fri, 16 Apr 2021 14:16:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, DaveYoung <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries()
 out-of-bounds access
Message-ID: <20210416121636.GA22348@zn.tnic>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
 <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
 <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
 <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
 <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 02:02:07PM +0200, Mike Galbraith wrote:
> [   15.428011] BUG: KASAN: vmalloc-out-of-bounds in crash_setup_memmap_entries+0x17e/0x3a0
> [   15.428018] Write of size 8 at addr ffffc90000426008 by task kexec/1187
> 
> (gdb) list *crash_setup_memmap_entries+0x17e
> 0xffffffff8107cafe is in crash_setup_memmap_entries (arch/x86/kernel/crash.c:322).
> 317                                      unsigned long long mend)
> 318     {
> 319             unsigned long start, end;
> 320
> 321             cmem->ranges[0].start = mstart;
> 322             cmem->ranges[0].end = mend;
> 323             cmem->nr_ranges = 1;
> 324
> 325             /* Exclude elf header region */
> 326             start = image->arch.elf_load_addr;
> (gdb)
> 
> Append missing struct crash_mem_range to cmem.

This is winning this year's contest for most laconic patch commit
message! :-)

Please be more verbose and structure your commit message like this:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
