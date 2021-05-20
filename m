Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0947389EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhETHLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETHLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:11:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC7AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 00:10:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i13so18133408edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jvIi3wJH6aGtwuNj6cLtQE3suQcTsdkLDmCsiPLGm8=;
        b=lkeswFyIFf+61kYjG/yOgV6xPtRoZfGz9caJ5KbHOvbk3TqMXgIHUrsKUdZPRbHj4g
         I2k12rVhOQx08m3fa3uWMf1vDEz1RGJPBAOZryuAiuGOlQBCmGUtAnVErVMPxabt4p+g
         vP39LpOo+gYIxG0BMNPfTxTYMSJwUlJAfqPxwMJT45bP7xv6lmFUhtkc9hTBOlwp/9QV
         p1xjadZJYYoRwhhyAWYu4MDoCYd0nONIqUAwnaGMUPnT88Hbzg9kV/anwCigXP3rEDdY
         uKfoyEcX77gEtAUZXr8RYidIseObno3g1jvuYaFAel3B1Qna/zxGGV1Fv2MEjax0KU98
         PGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jvIi3wJH6aGtwuNj6cLtQE3suQcTsdkLDmCsiPLGm8=;
        b=a/SuZCzRUGXfXZw+dcf2e1RCZNVxRsF0th8TDgXHxqw1E48z3Z2ifOMSxnMwb/jhmE
         9Y+EQbDnTTcSBD2u5DSU9XGbl8amr5+sk8KdGKOnf8lfG6mC+xgBUB41ifrl7kUnm/z6
         cN8dyKTjS22TSoDDaLBSxJgFmxjankLbnpjN36TaXGdUy0yGw4Sl3FhTBT2zc+NnFJu8
         r+xjcYiYRX07XWit/2Jn4aeL/z6MQfOvr99r3UnFgrK04NxWVqNeQqsuOQnHAEAr0GKB
         H8GQyrUPWFVoWOZ+PcX9XBCn2vyA3T+hXFmCInRkIXvsbhHFb99yQeADpBJkaoAhZULy
         pIww==
X-Gm-Message-State: AOAM5310WYmcirRPBgSIqH2CZPseIuVKIgOkNgvDF4a3I3HWPYjeSwOT
        E1CY/Ckzn9rHnOPOAFgDUvzAMok68LBAJkwNS5JJHA==
X-Google-Smtp-Source: ABdhPJzcG/n/D2v9iSrpw0SJ1JZwF3En57iHrHbHnZfIURXmPByQ50o/AXP4jqrnJxvznbhBYhnnu6wLKmwtF3XmOmc=
X-Received: by 2002:aa7:c485:: with SMTP id m5mr3342964edq.230.1621494623130;
 Thu, 20 May 2021 00:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtAbUGO9oAtL8eZ9Pu-_a1wx3y8Tk=pDO3Fh3dEwoRGWg@mail.gmail.com>
 <87mtsqd0c1.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87mtsqd0c1.ffs@nanos.tec.linutronix.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 May 2021 12:40:11 +0530
Message-ID: <CA+G9fYsogFQZSeFyGinZ_EQOEW11cmU5oxuEoDuwyCVNaXv3yA@mail.gmail.com>
Subject: Re: BUG: unable to handle page fault for address - EIP: __kmap_local_page_prot
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        X86 ML <x86@kernel.org>, Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 at 00:20, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, May 19 2021 at 20:38, Naresh Kamboju wrote:
> > While running LTP mm test suite on i386 kernel the following warning and BUG
> > reported on linux next 5.13.0-rc2-next-20210519.
> >
> > The warning is not regression, We have been noticing these warnings often on
> > i386
>
> Noticing? Did you report them?

I have reported this,

https://lore.kernel.org/linux-mm/CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com/

>
> > but kernel BUG: looks to be a new crash.
>
> It's just the consequence of the problem which is pointed out by the
> warning. Fix below.

The below patch did not solve the reported problem.
after applying this patch
CONFIG_HAVE_MOVE_PUD
disappeared from the config.
but still i see WARNING: and BUG: when running LTP mm tests.

Test log link,
FYI,
i386 kernel Image running on x86_64 machine.
https://lkft.validation.linaro.org/scheduler/job/2749690#L10139


> Thanks,
>
>         tglx
> ---
> Subject: x86: Don't enable CONFIG_MOVE_PUD for 32bit and !PAE
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Wed, 19 May 2021 20:37:34 +0200
>
> MOVE_PUD cannot work for 2-level paging obviously.
>
> Fixes: be37c98d1134 ("x86: mremap speedup - Enable HAVE_MOVE_PUD")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -219,7 +219,7 @@ config X86
>         select HAVE_MIXED_BREAKPOINTS_REGS
>         select HAVE_MOD_ARCH_SPECIFIC
>         select HAVE_MOVE_PMD
> -       select HAVE_MOVE_PUD
> +       select HAVE_MOVE_PUD                    if PGTABLE_LEVELS > 2
>         select HAVE_NMI
>         select HAVE_OPTPROBES
>         select HAVE_PCSPKR_PLATFORM

- Naresh
