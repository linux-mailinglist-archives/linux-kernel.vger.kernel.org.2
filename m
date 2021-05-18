Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E65387F80
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351498AbhERSX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351491AbhERSXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:23:25 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E349C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:22:07 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c3so10644986oic.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lwrIoW2lSRUJf5Z1ZUlUd98G/lIIVYnq9HYhLMGCnE=;
        b=VK1H0xbC+hmShEr/90GDKJeRcHQ5ynMeAqpl/+BYJ5D/dzWzVAvEkTRTJsYa6mLQ5p
         p65hoIaZpltD1X+GVZaS0eymN3Bfuli9Jlt+htsUqLB/FuDRa0xhMATxu0vBETS3JGQ8
         k9VsNBW3ziOaucDwNJNzWMZ+3XHlYFok6IZlB1dAZtACfVZ2Au2m6XbgURQpKLiQKndG
         gw2Y1O17+WLp4pE8g0jLHbNGsJ6SN11JGwUmToFFWrPRKV4XiqjUWXZ0e/dhvpYIrorh
         cyUAxi+Ly5lnpTU42mwUdOOBuMLoYpI7y1uTSP6esQ+e47+E238pE7sBvYbxVUgpF59q
         9ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lwrIoW2lSRUJf5Z1ZUlUd98G/lIIVYnq9HYhLMGCnE=;
        b=STlyS40pjv2+Lb+50Uac5An1w3mPNpnQz+rrcdMUQa1Y7HTDsSV7Ugq44xqapAI8PE
         EIXeDs508EhnXJsddww2XiQYwpKROi8Xuw+fmrsQXt/2EN/6Vu+iEvGClgJk7MygnMy4
         9tR4Wj8R8RJwYvtVs2aLaUZo+mspNmBEjFvkzlHBjtX0lFvAp6v4WBoPPUNXDOu1cqj4
         bRS3Y1+p4aLAw5SZrNajvWCasqq+PbzkKFDT6+bUywniR2k0hS8jJNGE4wM7F2JKVJ4C
         +/M+SLHkUmrqlvNMifYKioO70YMdjFV2XZipunF9IUBoEl/yI0LIfelCvLVE/Vv3Qm28
         rVLA==
X-Gm-Message-State: AOAM5335IB7BP5X7GFXOBLm53CK2F3bhsc4shqyBVsHNZV3rFGMjesEO
        j4CZI/OGsX7vIg56+ZOlnPPUTS8BQ8jyXuZpiRA5PQ==
X-Google-Smtp-Source: ABdhPJyoQGf9KTZHwH5+RCP4kmrohAOrHDqxKargrh7nz6UOc0WrI6lWmbj6xtIerHe0YR//cV3e/MNBBpGJoC3ZqDg=
X-Received: by 2002:a05:6808:8e5:: with SMTP id d5mr3585859oic.141.1621362126885;
 Tue, 18 May 2021 11:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <CANcMJZDOMZVj6WVEe+7b--Rwkdg1-WVFfHkVm4KR-ykS4LxQFQ@mail.gmail.com>
 <878s4cv20v.wl-maz@kernel.org> <20210518093211.GA82842@C02TD0UTHF1T.local> <20210518095904.GB82842@C02TD0UTHF1T.local>
In-Reply-To: <20210518095904.GB82842@C02TD0UTHF1T.local>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 18 May 2021 11:21:55 -0700
Message-ID: <CALAqxLXzvZ++1eCtSiuxpSxA=-M86JWj_+FbRbvq1mDkgq-hMw@mail.gmail.com>
Subject: Re: REGRESSION: kernel BUG at arch/arm64/kernel/alternative.c:157!
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 2:59 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Adding Mark Brown and Mazahiro Yamada.
>
> It looks like there's a dependency issue where assembly files don't get rebuilt
> when a generated header they depend upon is rebuilt, and from commit:
>
>   0c6c2d3615efb7c2 ("arm64: Generate cpucaps.h")
>
> ... we can have stale objects with old cpucap values.


Thanks for confirming! I've also verified that things do get back to
booting ok w/ v5.13-rc2 after a make clean, so it does seem like some
sort of dependency, which explains the inconsistent bisection.

thanks
-john
