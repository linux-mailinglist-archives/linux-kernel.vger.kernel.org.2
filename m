Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DE030F477
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhBDODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbhBDN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:58:07 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63B9C061354
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:56:19 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u14so3625849wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TnVWEPnb0tC+CtpGZvtAeAVG6+q+gfP9B49rEWDxFOc=;
        b=Kj+oZgHxKT6VUnhZC/8QMwgtWDqE6mef8gshXFGyDiZc86ORD77MSog6/pW0o1Kiq7
         PZUtBLL8fr1/9YO+ybmdbnIO7R0zGOD93OP/5/wTeE4s+y4fSu0x+QFXfzthojyF1Jv5
         wj9LtWz82ML+sF3/O14E8fxjbKOEagsq/caQIBXjERXhZxIRPz5Rzrf9oQ29f+UU/SvF
         ckNuBInpHdm0hjdJkwmMChWeGdlQPgoZ9FwgnjTQP+7PDXzm4dKTGZfHAnDpBU2XdPQS
         Mj8s3Z28AkL2Qmkv9WlU0jbQeNSvPbZ2Vk+ubSvfU6HYJs5KIgWZS4aK0s1k8jVIbGLW
         4ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TnVWEPnb0tC+CtpGZvtAeAVG6+q+gfP9B49rEWDxFOc=;
        b=h0kI/8Kerb/NfsDWws8XZRLLYMqvQ/afkquRF5UvqRz4LCFX/swuvKpMQ9uBUxhYrK
         KOt9ZeHKyjSFtMIy9BYs+nRsgSao8+5Solu4eIPZb4CiEVBO4cxN0tk/Dv/6uK9QfF8A
         417r9OjkG4rWq3QyUdVQT9bEBmKe5Z4meVxfc4gfBG803pH41X0cx62AFExFon5dGNOL
         /4i6aaDqxoX9+cjs5AvgtXwUNBlQaktj97lcCqSm0R5Yz7sga6+XKpTm72Kc0XT7rN9e
         w+lnSneCdWP18mszrzAYSit/SygTHrjq17YOOmmkBpiI8uJZYamTHW1WMF3+ohAx3lwz
         q2kw==
X-Gm-Message-State: AOAM5305CjLfVs4g1plIBcWCtnmhVKOAL9xnjykAzFuP/nM0mp7JYGtt
        VLdvNiuXGR7YeWXtiEUSPFgW7Q==
X-Google-Smtp-Source: ABdhPJyR7lU5JUv1D0hoTJ/+0NgUT+/CPRKHhUXCPjJF+cttjIovyhDVjfJQG/ZjTvGd9SKcvOyPTA==
X-Received: by 2002:adf:83a6:: with SMTP id 35mr9420796wre.274.1612446978467;
        Thu, 04 Feb 2021 05:56:18 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m18sm8326823wrx.17.2021.02.04.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 05:56:17 -0800 (PST)
Date:   Thu, 4 Feb 2021 13:56:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 4/5] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
Message-ID: <20210204135616.GL2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120214957.140232-5-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021, Hans de Goede wrote:

> Some Bay Trail systems:
> 1. Use a non CR version of the Bay Trail SoC
> 2. Contain at least 6 interrupt resources so that the
>    platform_get_resource(pdev, IORESOURCE_IRQ, 5) check to workaround
>    non CR systems which list their IPC IRQ at index 0 despite being
>    non CR does not work
> 3. Despite 1. and 2. still have their IPC IRQ at index 0 rather then 5
> 
> Add a DMI quirk table to check for the few known models with this issue,
> so that the right IPC IRQ index is used on these systems.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  sound/soc/intel/common/soc-intel-quirks.h | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
