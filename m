Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F854048AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhIIKqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhIIKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:46:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B2C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 03:45:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e4500a512d950ff073124.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4500:a512:d950:ff07:3124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29BA91EC04EC;
        Thu,  9 Sep 2021 12:44:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631184295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2anM/ZbPy6i25eNR9NW1BBBJS1d08PRuyDbsiqAMPTg=;
        b=omGA+tKYR5akh5u03TZoPcZRf9uRod1Dry1cD4AVwHZWZVna0RoWAYD1LcJvUqRiqC1cLJ
        D9qXonE7fj0qOX6F0mPWNKzkWSPZuHOUH6wgETnggIaVhBhcYEKwmZPm2xqRQejsNseZuu
        IbOGiSO13OU0/4M5GVMOmEEe0UdiuyI=
Date:   Thu, 9 Sep 2021 12:44:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Luming Yu <luming.yu@gmail.com>
Cc:     Jinhua Wu <wujinhua@linux.alibaba.com>,
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
        ricardo.neri-calderon@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf: optimize clear page in Intel specified model with
 movq instruction
Message-ID: <YTnlnlY5h/Xom3fn@zn.tnic>
References: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com>
 <YTnWXIB42sCLbM2k@zn.tnic>
 <CAJRGBZyQuQohbf8v3H19zo1mpbvDXrbNVXCJAUpCEmHgmqTYpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJRGBZyQuQohbf8v3H19zo1mpbvDXrbNVXCJAUpCEmHgmqTYpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 06:34:40PM +0800, Luming Yu wrote:
> do you mean jump label would not be replaced to nop when its key is enabled?
> so we could not use it in certain functions?
> I don't understand exactly what "ain't  gonna happen"

It means, you need to use an X86_FEATURE_ bit because I won't accept a
static key.

But do the benchmarks first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
