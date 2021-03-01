Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689C0327B67
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhCAKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhCAJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:57:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CA2C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 01:56:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b18so8926742wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 01:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4SEYRWrQ+juBzLbJFqDM30uSTWNRmU6hDeFliq2wUHo=;
        b=FQ+JWgWPtS8FSKxQvEYjaVcUXirRHlY2YxbdnM9skD3AcVzlB3x1+DZS2a2B5NUzvQ
         vA7VWkuJ0PHoSxzUyta34BuXgQTQarTMQK7QvL2V8JezpdyZJwNRUb5rkNekPf4FWtxb
         ih6BnDVzdxJpPzJ0MrcOHHUswx65PHlZeFeDUZ+6lY+tszMr/sp9kP4jmao3+DPIAo2w
         SFpr5kqnpyzdi7xaLtur2LWuZFSa8DyZkNmUk5t39P6M9UuPSieSzFBiuBf6cOzdfSvj
         pljW8X74AaRaxkHQWPviOwfbjmBZ/64ibM3mvvmhPgccKvqpQllhghC1o706M6+oy9FW
         l3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4SEYRWrQ+juBzLbJFqDM30uSTWNRmU6hDeFliq2wUHo=;
        b=As3SOzxJMtXoarM3aCElSN8lUpqrei4hUPxA9G49W5iqrbKLp2lLihXz05A3d13flR
         oghWya0wZizeObs9nWeJxF6PpFZRMQnwJmQIDouCt06kMnGN7QGlRm5PWMrAGN4+wPk/
         ExNf+zqcBpGQ1HQNcy3cXP4m1xA2mvHO8JFGCSkESkXeaU71PXrgK+QHACKZdxXIL/nJ
         QVgsRoSLrCBey4CQ2/YAAyATkYEN+Ug49hDXnSSltK5j9ajmuSIwtKITdmIGRsjT3x8s
         H2h5xlAvWob+EO09MU95HCs5J6vG5q7cfZzYCyv06qMHSas+lH4EGUFd6KtrrQ2w7eKR
         3NVg==
X-Gm-Message-State: AOAM5334H8FydIAMSUKwu7AZ5Kw1dfAvrx84mwr1yuYH5gwLBXpUfm59
        BG3qmO5wD1vnXPtnpwSSCamMBg==
X-Google-Smtp-Source: ABdhPJw2nYS3/toxy/DLdioGnAAf5vsO2DhftUU41PUFzFIX3dwM8yRjxlkfIcCSjfsOcNIGqXbUzA==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr13124231wra.179.1614592607590;
        Mon, 01 Mar 2021 01:56:47 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id p17sm4054219wmq.47.2021.03.01.01.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 01:56:47 -0800 (PST)
Date:   Mon, 1 Mar 2021 09:56:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Robert Jones <rjones@gateworks.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: gateworks-gsc: Constify static struct
 attribute_group
Message-ID: <20210301095645.GG641347@dell>
References: <20210131133644.8834-1-rikard.falkeborn@gmail.com>
 <20210131133644.8834-2-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210131133644.8834-2-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jan 2021, Rikard Falkeborn wrote:

> The only usage of attr_group is to pass its address to
> sysfs_create_group() and sysfs_remove_group(), both which takes pointers
> to const attribute_group structs. Make it const to allow the compiler to
> put it in read-only memory.
> 
> Done with the help of coccinelle.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/mfd/gateworks-gsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

These patches do not seem to be on LKML.

Do you know if they were rejected for some reason?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
