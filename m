Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F03E3190
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 00:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245486AbhHFWN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 18:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhHFWNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 18:13:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B53C0613CF;
        Fri,  6 Aug 2021 15:13:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso7065431wmp.1;
        Fri, 06 Aug 2021 15:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MwkPdmSVqFf0U29VqiGUo990SLi1yES6UWHs7zA7Im4=;
        b=jO8QswNBVJGHgpRYrK6EeX0qgkq4CkvlD6XUbhJAYfpa3I343FZlDp8a0RzF/M1oA+
         +db1CDzDWmmZFjyFwVE2Sa9ZzFpoRIxOuR9ticPQPKYBKqrcpXg2EqXeoEATlbL/M3dx
         3pRSQjUdQ3kbP4M39Oz+xXKUSulSComrNAOQuvAxFAqRkVol/oGGnzzycpm50U7rE9K5
         9qizz7sul3w0mMTZXGI4jlA8erZmIa1VD0Wn+6Jhwe899R9S5py2kr1DQzfySAdN8wpa
         Sf9btNz0KOGGC/QwmNuhr7Xfk9adDk/7ve6QPIQDQqe0Ozer6JR7sPjah8gTx2tmk5ay
         Do7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MwkPdmSVqFf0U29VqiGUo990SLi1yES6UWHs7zA7Im4=;
        b=Wyq4cweYP4fiSkZMWBQgr/9Q2U6P7U3ndFgaflJ4k3wOycrlR7JZTQ0WN4cj+a/7D8
         9qYm8p6zr0Mu4Sl2jARsKM1yVsfb6JASoR+qA3tJnkk9hRVwEwdgLy80MKdHMf+AuSzf
         tdSOQIysWfed0VS2cqxLXYC7PHyiHF54zXPhD1YWqV4fTl2FFtXieSfUiQTr33d7Ln+t
         BK6Dt1GgXgn+Ki4r48WdI92qMx8kQGMHIpKnjYGuirR1L1dRoOnwiiEf0UsxtRmKBH5g
         z/MBQsVGD7Zga/lIjn6e9X1qypppx22bVu1JxrD2HjHlG55JRZn5eaCKvt73PcSG13r1
         IItg==
X-Gm-Message-State: AOAM532Rdv0FEeyFeS9UmetRrTxUXHUIIUw8CUXnIT7dpEt2Jzyy2pWW
        biPs9+g8y3OmDvuPlhIDn8lygj2FCj0=
X-Google-Smtp-Source: ABdhPJxNNnwlSjdalr6tAMyxSJ0JaPvBNnftvbyqAOYnnuKCH1g5wxNC/e/CRN0e15btbFwh1OrxEA==
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr23141432wmb.12.1628288016719;
        Fri, 06 Aug 2021 15:13:36 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id q5sm11102953wrx.33.2021.08.06.15.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 15:13:35 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] platform/x86/intel: int3472: Use y instead of objs
 in Makefile
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
References: <20210806154951.4564-1-andriy.shevchenko@linux.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <fdf5b050-2c8d-f3f1-f8bd-0dbc616c9bc6@gmail.com>
Date:   Fri, 6 Aug 2021 23:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806154951.4564-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 06/08/2021 16:49, Andy Shevchenko wrote:
> The 'objs' is for user space tools, for the kernel modules
> we should use 'y'.


Oops, now you mention it I remember you saying that for the cio2-bridge
code too - thanks.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Reviewed-by: Daniel Scally <djrscally@gmail.com>

> ---
>  drivers/platform/x86/intel/int3472/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel/int3472/Makefile b/drivers/platform/x86/intel/int3472/Makefile
> index 48bd97f0a04e..2362e04db18d 100644
> --- a/drivers/platform/x86/intel/int3472/Makefile
> +++ b/drivers/platform/x86/intel/int3472/Makefile
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_INTEL_SKL_INT3472)		+= intel_skl_int3472.o
> -intel_skl_int3472-objs			:= intel_skl_int3472_common.o \
> +intel_skl_int3472-y			:= intel_skl_int3472_common.o \
>  					   intel_skl_int3472_discrete.o \
>  					   intel_skl_int3472_tps68470.o \
>  					   intel_skl_int3472_clk_and_regulator.o
