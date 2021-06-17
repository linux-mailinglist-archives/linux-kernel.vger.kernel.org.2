Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFA23AAD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhFQHRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:17:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQHRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:17:52 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623914144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZqqfG/eTk866hHwRZlpV3RdZpBCWJ386ibcttBrr1E=;
        b=K+UHlU0c4oSXoFrwmumGobUlcMgs/WNJoCJle/rMgcM15/d2oIN0VR7aPws1gby+CsxkIj
        F/jBTLGcgaTvLNeHImWnGjLl3v5hfkhRUKI/ZpUoXeBCKe6wJiUvtYZq+6mNDIaTyXiiTp
        wFQckO4DrfWzC8yhKKlb/zl1042B3wfaGByGrup7h9VFZ8avAhlsHHgFYjsDUEXXEythqG
        +CqrpxCcEG4CGdnk1I9Y+udFOAbLFXLfrh+NyLIvlaYz9MmPdpvrH0TMNZOmiPc/xmAAZV
        UQR8mHUw1lSYTjdjc9qtmsNW3z7+MYLeIJu9lkZNtaM/0IO7xZts3X22aYjaeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623914144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZqqfG/eTk866hHwRZlpV3RdZpBCWJ386ibcttBrr1E=;
        b=9qo1p3yVXq5EubqGQFWsRj69tT5N6c495F5UlraGu0DlQRVSwfnHpBwi7QYmy4AfOuSIYF
        vCy93498oJ94JMAQ==
To:     "Liang\, Kan" <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 32/52] x86/fpu/xstate: Sanitize handling of independent features
In-Reply-To: <7309d6fa-dd25-ac31-7b05-d88f59d18213@linux.intel.com>
References: <20210614154408.673478623@linutronix.de> <20210614155356.961460910@linutronix.de> <7309d6fa-dd25-ac31-7b05-d88f59d18213@linux.intel.com>
Date:   Thu, 17 Jun 2021 09:15:44 +0200
Message-ID: <87zgvpezbz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16 2021 at 16:04, Kan Liang wrote:
> On 6/14/2021 11:44 AM, Thomas Gleixner wrote:
>>   	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
>>   }
>
> I tested the LBR Xsave feature on a Alder Lake machine. It looks good.
>
> However, when I did other CPU hotplug test, it gave me an Oops.

Sigh. Yes. I know where this comes from. Brilliant crap that.

Thanks,

        tglx
