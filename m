Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6300C35EF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349951AbhDNIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348355AbhDNINx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:13:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B462C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:13:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h10so22552973edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GhsuBq5hWHWqMz9VB0vGbWTIv4i2oXUpT4Q++cIEJyo=;
        b=mgBF88w8ChCilW+KxQKx5mViDVSDvx5GX/30hPd7tuknx2XCWdjPrqmEiUSv+9F4jn
         00v3AQX/XlGjfhlVaN46W1TXv4O6Ha1Ejtjvnz0wRIaDi1wScbrd9kvMt0xYEipmDc20
         nZo1nsrcicl1Fa7eBCBre5sord+Jdp7EEN34ox6nwTyrEcOrSrAiBeOyK7SiZlGWanEG
         TkblyuJNHvKSjRXl7za4BzBo0AUESBSWeAc3PTcT1TLr/dNhsF9QS7DR8Ac9CfzLtx74
         42zK6JNcpdEVGs7MLzfCSVf/ZoF3ZggsFdwpT6UKVviuWxI/QrnSpg+MxF/UJLbH5tfU
         qQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GhsuBq5hWHWqMz9VB0vGbWTIv4i2oXUpT4Q++cIEJyo=;
        b=YhLyDTdrr3OtaYcOw5fdH6eO3/l58tjpf2AzOh6TwISf1Ex8KhPcVYAQjc1W0G3X6Y
         hf2bbkKOrPnmp1Jula7yc3vicB4agJnFg7Qw6lpHNwU8AhzuvOQup7voRAGubeN1MHZh
         piL2/QAljYGVmlk3oIPDa98H15TLh+V0r4O/k+ZOz1iLcgMg8Jp+ElYC5uPHmXC27xZ8
         iNf7s9lXvS5Arsd8w1Gg2+W49bV4bl5Pw65r7nHF0Um+a0EpV9yqBvH0WcMj0mANrdIB
         TNBvBAJIF29fufm0tZCvGxvWOruwWxdS54Vt7OsuCZuHXG0hJYzVhqY8e1qGNW29TDXU
         CpmA==
X-Gm-Message-State: AOAM530c9lRKzGmhArep2pcQvWMJ2K8hvPApAYUwmFb0CR55+8BReP06
        K8qqrRV4HtkR8RGTkIJ7L8z9UJ1sNkjngA==
X-Google-Smtp-Source: ABdhPJx55ZE9qeoCXhf7lgDjsTCeaF+GvPVokPkYoZP6Ce9ObC4z5caIAG7zyuY1whObVD3cQPVwbA==
X-Received: by 2002:a05:6402:3079:: with SMTP id bs25mr28802425edb.369.1618388009084;
        Wed, 14 Apr 2021 01:13:29 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id gs20sm669392ejc.83.2021.04.14.01.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:13:28 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:13:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: lpc_sch: Partially revert "Add support for
 Intel Quark X1000"
Message-ID: <20210414081326.GC4869@dell>
References: <20210303164944.41962-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303164944.41962-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2021, Andy Shevchenko wrote:

> The IRQ support for SCH GPIO is not specific to the Intel Quark SoC.
> Moreover the IRQ routing is quite interesting there, so while it's
> needs a special support, the driver haven't it anyway yet.
> 
> Due to above remove basically redundant code of IRQ support.
> 
> This reverts commit ec689a8a8155ce8b966bd5d7737a3916f5e48be3.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/lpc_sch.c | 32 ++++++--------------------------
>  1 file changed, 6 insertions(+), 26 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
