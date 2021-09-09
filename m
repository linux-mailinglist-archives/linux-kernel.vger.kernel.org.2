Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC347404929
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhIILU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbhIILUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:20:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1943BC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jaJtesKRoklJVXwdW7zAa8t5N8UFqBRttpPsWpVpM7g=; b=uhx3f9eb+kolwaPTJucGoaE3Pf
        pd0A6KagGUUL6kDPgjRDektEPVSPC/l1BWXWUEKn6bVwJVgcQpLiHibbBNifPocAHa0KbmdEW2qbK
        HLf/c/QuUf2U2CN7/NBaSCxMXTipKGAO8614nGkr1woOkUiI1If/mDfW6ws/JzpGigNorOkDKg6ZW
        4znqyoukhoSPH9jB3+/0vFS1IcepZOyyp5m0p6DCGzwHJcPoJbxvbmJUuCyXg0R9yuF2mHnpn801a
        JEMV+B6bHcHyhwdGYWN8nGHSim2XWXdTny2TCZ7pACKVf6uz3TPvECH6Asi1fM1p2MiigRC9qM9JR
        5mHFbDuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOI4F-009ktt-Ie; Thu, 09 Sep 2021 11:18:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7DF2300047;
        Thu,  9 Sep 2021 13:18:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 980E820C0903F; Thu,  9 Sep 2021 13:18:06 +0200 (CEST)
Date:   Thu, 9 Sep 2021 13:18:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luming Yu <luming.yu@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Jinhua Wu <wujinhua@linux.alibaba.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        zelin.deng@linux.alibaba.com, jiayu.ni@linux.alibaba.com,
        Andi Kleen <ak@linux.intel.com>,
        Luming Yu <luming.yu@intel.com>, fan.du@intel.com,
        artie.ding@linux.alibaba.com, "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        pawan.kumar.gupta@linux.intel.com,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        ricardo.neri-calderon@linux.intel.com
Subject: Re: [PATCH] perf: optimize clear page in Intel specified model with
 movq instruction
Message-ID: <YTntbmpzuVVYmyax@hirez.programming.kicks-ass.net>
References: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com>
 <YTnWXIB42sCLbM2k@zn.tnic>
 <CAJRGBZyQuQohbf8v3H19zo1mpbvDXrbNVXCJAUpCEmHgmqTYpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJRGBZyQuQohbf8v3H19zo1mpbvDXrbNVXCJAUpCEmHgmqTYpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 06:34:40PM +0800, Luming Yu wrote:

> do you mean jump label would not be replaced to nop when its key is enabled?
> so we could not use it in certain functions?

But why add a jump label when you can make that alternative DTRT ?

