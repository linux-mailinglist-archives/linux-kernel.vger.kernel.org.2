Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7EC40A8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhINIQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhINIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:16:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E27CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JS9XyKWEu9peOQhroFkD4dSiIRWtHH+3VNvEsw4skCM=; b=Gqti5ZKd7QF32ulr9bxdbXq7oe
        MNN27qwusW3esipiWGBJPop9X8JDhncx+CSq/fl0wv6WIfWMJmmzo5D5ZBf9TOsvgPIrd25iXjrDe
        ok4L84ZpPNbVXseqwSnH76ndQIarR/GL5ERuW1dzjx3govhMJ6VHvCzAzkIBDfG3fIAvvg8DJWX+s
        9MOMNYTFKj9pAEIASAZAsOFlU2WQvLvBvwXmdwH2t37o9H9jWHGEGwRK1eNUrUJaWuYHoH+c5cknt
        K/xD41LgJdGJ0uzQayxvJQbH6Xa7cbBS5chmaZpb8hNL5iX+9E/JAySg4fMCzpUpNie8FUH2l/Zn5
        QUVnmP6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ3aC-0034m2-81; Tue, 14 Sep 2021 08:14:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7145D30026F;
        Tue, 14 Sep 2021 10:14:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B7062C856301; Tue, 14 Sep 2021 10:14:20 +0200 (CEST)
Date:   Tue, 14 Sep 2021 10:14:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH 25/24] x86/traps: Rewrite native_load_gs_index in C code
Message-ID: <YUBZ3J4Jy3x0VDkX@hirez.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210902105052.2842-1-jiangshanlai@gmail.com>
 <bfeb0b12-5b95-46c9-8ea3-6a4a5bf59076@www.fastmail.com>
 <4ecf191a-6642-6d59-cf10-6fe51e261b28@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ecf191a-6642-6d59-cf10-6fe51e261b28@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:04:47AM +0800, Lai Jiangshan wrote:
> I think Peter is still working on reworking the patchset and may be
> including improving this patch.  I'm Okay if this patch is dropped.

No I am not.

I said I have interest, I also said you shouldn't repost after a single
bit of feedback -- there's nothing more annoying than trying to review a
large-ish and complicated series of patches when you get a new version
every other day.

But please do work on it, because I really don't have the bandwidth to
carry this atm.  By now there's been a fair amount of feedback, so a new
version might be appropriate.

I really do think you've got some very good things here. Please work on
it. I will try and review :-)
