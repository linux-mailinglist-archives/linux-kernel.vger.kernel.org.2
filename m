Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461DA445CA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 00:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhKDXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhKDXcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 19:32:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B2C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 16:30:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d12so11622675lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwKpNt7ymTVCYOYWKlB8RE2BRmpgEI+Zd0SnTr489iM=;
        b=aeCLODg8lQVcApwUPT8C1pmcAbVwwb/el05kFi7evy79R6sHu2k++aDajKhhITDEFC
         KuzahGktT5SEBgkJK9HRi2MNjfOSNVqv/SkTA47KIiA1RFmxhpnNRVTBCMuHNEsexeaf
         NkRwDEBBgXLJ4BImz+E96ODpQL7Iy2+03Ewh7mD9bFQJpUG9O1++zDAmHb3Qi9JAwc1x
         OkHsY/E+k8cO2L9acTaKJ1IyIhZguoYv+oorD+66/CLSQl+buh53vFV5tItoavsh1JY1
         qqqpbOjrsNfOfip8THdpy+ZPLnFwWa5uV/hyxt+P6KYV+8+CsWMGRGpJx8rnG51z7RK0
         ebFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwKpNt7ymTVCYOYWKlB8RE2BRmpgEI+Zd0SnTr489iM=;
        b=wM7gCkj64QiWIHg58oAJvHoIWLfs1LbRDn1m34pmK1YrqcvvV6kUPHSFwSFxHLvysG
         p79dC3PFJmEZ5N+kIUuZ+7Yp/K2GehJKX4wXq3o5wcNEHfwes8biQL3qj/WjyxIhnGny
         JgKGIdFToirA0kAjOkF/1UOoxWqsTlqDQVs78rjQqii7Awd4bAA8m3pvrSwh384uiBSI
         NnWzaY+yMvPuulMo1f/YaIlGXOSW1Of/QCOVqjBeIUhvkC7AWWGK0RKJUT1t5vDAMzEj
         Fc1B9wyRhINVpMtcQNKrezq8wT5jBllAMPun47QylpzHFLUUSW9maaCX0yPib7whDtGM
         YeEg==
X-Gm-Message-State: AOAM531QXquX9h34Fanig4DUOmO41iO8U5TOS/HNrS4O39JWcdwaVhjn
        v6nW/wnzpGZboxT4j1UaDwdfC7sKlQszDsADioV+uQ==
X-Google-Smtp-Source: ABdhPJzXujdnfYIpOoFeoMfQqcklk8MTvBKtdbpyFrShxWjlxGSrEJuTo3PT16+HpGWZfgfDULuP9PSuDOT1t1Sih3I=
X-Received: by 2002:a05:6512:b29:: with SMTP id w41mr49675962lfu.240.1636068598804;
 Thu, 04 Nov 2021 16:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211104215923.719785-1-nathan@kernel.org>
In-Reply-To: <20211104215923.719785-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Nov 2021 16:29:46 -0700
Message-ID: <CAKwvOdnBv8LcxvVYJKacL7eUXAoGVfnQp7TAL_r+P8V0WcOq1Q@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: hcd_queue: Fix use of floating point literal
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 2:59 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> A new commit in LLVM causes an error on the use of 'long double' when
> '-mno-x87' is used, which the kernel does through an alias,
> '-mno-80387' (see the LLVM commit below for more details around why it
> does this).
>
>  drivers/usb/dwc2/hcd_queue.c:1744:25: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
>                          delay = ktime_set(0, DWC2_RETRY_WAIT_DELAY);
>                                              ^
>  drivers/usb/dwc2/hcd_queue.c:62:34: note: expanded from macro 'DWC2_RETRY_WAIT_DELAY'
>  #define DWC2_RETRY_WAIT_DELAY (1 * 1E6L)
>                                  ^
>  1 error generated.
>
> This happens due to the use of a 'long double' literal. The 'E6' part of
> '1E6L' causes the literal to be a 'double' then the 'L' suffix promotes
> it to 'long double'.
>
> There is no visible reason for a floating point value in this driver, as
> the value is only used as a parameter to a function that expects an
> integer type.  Use USEC_PER_SEC, which is the same integer value as
> '1E6L', to avoid changing functionality but fix the error.
>
> Fixes: 6ed30a7d8ec2 ("usb: dwc2: host: use hrtimer for NAK retries")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1497
> Link: https://github.com/llvm/llvm-project/commit/a8083d42b1c346e21623a1d36d1f0cadd7801d83
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/usb/dwc2/hcd_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
> index 89a788326c56..bdf1927e1be1 100644
> --- a/drivers/usb/dwc2/hcd_queue.c
> +++ b/drivers/usb/dwc2/hcd_queue.c
> @@ -59,7 +59,7 @@
>  #define DWC2_UNRESERVE_DELAY (msecs_to_jiffies(5))
>
>  /* If we get a NAK, wait this long before retrying */
> -#define DWC2_RETRY_WAIT_DELAY (1 * 1E6L)
> +#define DWC2_RETRY_WAIT_DELAY (1 * USEC_PER_SEC)
>
>  /**
>   * dwc2_periodic_channel_available() - Checks that a channel is available for a
>
> base-commit: d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
> --
> 2.34.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
