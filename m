Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53587314D92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhBIKwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhBIKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:47:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44374C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:46:25 -0800 (PST)
Received: from zn.tnic (p200300ec2f2f38005896b2f9ed512c58.dip0.t-ipconnect.de [IPv6:2003:ec:2f2f:3800:5896:b2f9:ed51:2c58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25E321EC056A;
        Tue,  9 Feb 2021 11:46:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612867583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Unei56clXZHQ5Xap4ehdEmREbfheuAoq1P8ROyril1Y=;
        b=InCdq2yN+u20bpeaCJVeFYY6a633LzD+su3otU9ZIOvh/xa3MGrKlM7pnFnZq61Ag7XSPV
        ZKvXji5ai0pp1NyriR0nRQPUCbwkl67WEfl3I2rE6+0Jl7RjZmXbMqhIEPzzJVfNibxMCA
        2dNOFKmWt1knJdLrMzJFRpoL2Hv8ivU=
Date:   Tue, 9 Feb 2021 11:46:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        x86@kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [kbuild-all] Re: [patch 06/12] x86/entry: Convert system vectors
 to irq stack macro
Message-ID: <20210209104619.GA15191@zn.tnic>
References: <20210204211154.713523041@linutronix.de>
 <202102051148.WIj5O4Ry-lkp@intel.com>
 <YB1SdvRbHMY7IRrY@hirez.programming.kicks-ass.net>
 <ad03c046-3249-8ac2-96af-03b2312454c0@intel.com>
 <20210208141957.GA18227@zn.tnic>
 <536a6b24-fadb-cb2a-8259-dadd3730c6ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <536a6b24-fadb-cb2a-8259-dadd3730c6ce@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:57:09PM +0800, Rong Chen wrote:
> Thanks for the help, how can we identify the patches for tip tree,
> could you please guide us?

I guess something like:

cat patch | ./scripts/get_maintainer.pl -m --no-r --no-l

For a tip patch, it should give, among others:

x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))

which is the tip ML.

You'd need to play with this a bit to see what works best.

Also, I'm wondering if it would make sense to have some special syntax
to let the 0day bot know on which tree to apply the patches after
scraping or to even be able to say: "do not test" when sending just an
example patch which is not supposed to be used anyway and thus you don't
have to waste infra cycles on it.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
