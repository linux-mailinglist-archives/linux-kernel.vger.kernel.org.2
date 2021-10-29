Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDC143FF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhJ2PPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhJ2PPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:15:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE5C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:12:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h7so40376177ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbp1RVUWpXxmf6q8wM0Uf1eGImV3WO+nHaJoNI5GzDs=;
        b=mMC4BoJW3hMSmbxyFp6HdSByFD3WUlevp7UGvD8AkSAidA2poPLFA3Tpfw+fe4Nyd1
         rsME8fJqcfF265gVd1pHPe+imgFu7OZEFVsZmNamkeN9h205hCdp5aQsNBEp6+f1UvI/
         CUJgxSS6iWsfh8A85CvH/smVNy0ysNbWo/MZXi3pXVSfcGR6dLbo1AtkZPzQfurV6Wiq
         79dIpAWNut/XA6NUr2ANC6skrSwxEDjmDS6aQSeTNj89amtuF3o5MvgFNRthCA8ABjAp
         7qz4sNtqh46UrFETo1hyMhKBAynodWJSKy0pCb+kpcUGoWCo4JeJUY60tteckS0BTFKe
         jrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbp1RVUWpXxmf6q8wM0Uf1eGImV3WO+nHaJoNI5GzDs=;
        b=jfXa4RdJbNrs7dZeg8h4zDzIYFTR83ImS5vzPibrab1SvjZ1UP9ErQrRgERoSU3kcw
         EUYKuK2xferEme75Larq8CQizmgDTb2h24S7Wtk9IEZIQPQ+dBGVP1NFoe0drpNfFc47
         5RoSSxjzC2el4cHkCCsyoo+RnBpSYxElDlFk8FrIJM0DPoovRRzIhfHlYYxIv5XmjHmz
         +uyuqQo3MzHMPvxxIM8AmatI+HiJemrkJdQ3FbU096viVb05YHMBEE4Qt8G2LF5y1b/A
         RudQttMcWx3b/ybMo7eiMFrSilxrwp849DevinZfl/eYN2uRJP/+lODQ03vIAR10n8Br
         ke+A==
X-Gm-Message-State: AOAM532NFuXbllYNKfpDqNPWShpiSYD+yno/EFANMsXxHs97LpX41/9Q
        1ymurF8dCr+LFZbq4oslHdidg7FUPrGlP0nBGKp0uw==
X-Google-Smtp-Source: ABdhPJzpsDLjJQ/WwdBQ9O4Stwk6wd9Sj4N6byqzYkuACRBh35AKF+UU5XzoJbdDigL/gVr9oD8hf7SibborrPj1Or0=
X-Received: by 2002:a17:907:9858:: with SMTP id jj24mr14491131ejc.505.1635520365217;
 Fri, 29 Oct 2021 08:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211029113023.760421-1-arnd@kernel.org> <9d4e09b4-47dc-ed3c-2b6d-e0d1a081e592@arm.com>
In-Reply-To: <9d4e09b4-47dc-ed3c-2b6d-e0d1a081e592@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 29 Oct 2021 09:12:33 -0600
Message-ID: <CANLsYkw=GKRk=AVWyN7D8f7pNVV1EZ1FJrB+M8jAKigem2Nskg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: export this_cpu_has_cap
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 at 07:31, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Arnd
>
> Thanks for the fix.
>
> On 29/10/2021 12:30, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > It's now used in a coresight driver that can be a loadable module:
> >
> > ERROR: modpost: "this_cpu_has_cap" [drivers/hwtracing/coresight/coresight-trbe.ko] undefined!
> >
> > Fixes: 8a1065127d95 ("coresight: trbe: Add infrastructure for Errata handling")
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Will, Catalin, Mathieu,
>
> Do you have a preference on how this fix can be pulled in ? This may
> be safe to go via coresight tree if it is not too late. Otherwise,
> it could go via the arm64 tree.

All the same to me.  It's in arm64 so I'll let Will and Catalin have
the final word.

>
> Suzuki
>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Not sure if we actually want this to be exported, this is my local
> > workaround for the randconfig build bot.
> > ---
> >   arch/arm64/kernel/cpufeature.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index ecbdff795f5e..beccbcfa7391 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2864,6 +2864,7 @@ bool this_cpu_has_cap(unsigned int n)
> >
> >       return false;
> >   }
> > +EXPORT_SYMBOL(this_cpu_has_cap);
> >
> >   /*
> >    * This helper function is used in a narrow window when,
> >
>
