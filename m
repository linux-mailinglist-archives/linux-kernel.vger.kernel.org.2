Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430E23A7D97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFOLx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhFOLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:53:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B9AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:51:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so1832844wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DUdssBykhaGqNR9EKQGhf4t4L3kZCOGDunnhyX0udD8=;
        b=qpXPuGqymCaJnNYje3RjY7Zg5ci1TM7wQtEZiW6ty0w2QnJ/3T9F2Qr50a3LSf/fDy
         LzPrMNZjL2mVpD3m7T8HsDvtkgOeBx4mdDZk+MjC4zRl3nQXOCDx4MpYp59STClmcLm3
         2+8T4lTRDpoR445BcgeLTH5vUVTrayYhBetG4TQ/muQsKIi6C+b6WYYVEsdxa5sX2STo
         rtEhBSGbyAY154DTielOP4ycWviEQTgucaW+o8nYyqGuKolWE4rxc7Gr4IHAt8imTMdo
         kzGFkwYYQqgn5cyio0DKe1R7T31BztBodMFp8IIvMLbgf76V0kHF6tHHVsY+27Y+jyYC
         QRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DUdssBykhaGqNR9EKQGhf4t4L3kZCOGDunnhyX0udD8=;
        b=JvY665/rfMMTfIj7merM9OYTzGHay0s9gDLoNf4EATVra1/XW+euaIywM9TBNfZUWu
         pcxlmRGZouiJTuoAgkdD1AGvk4DtPSJyUetVGVGpm99wV6yDhuws+QNLBhEPoa5/ADsX
         vlptTobWQK4ky7/1XiuT9F2JoWtF7FwnS3YhhVAmlORYiMvlgZjr3T3cZo/P15XFGaqu
         2lfTo0ZM/bbCmE+B7GdZZF7OuS/PWhEKY6fA1o1eN52u4v9WyhlGAvNTPW0Xm0M+ZUiX
         nvFbr1AK7WWbBrnDzaPh/7K+g5x5RpXadnz855MOxHrbwexWH6kQ834q62LI9IUt3L4m
         i4iw==
X-Gm-Message-State: AOAM533yPLW9q/klEHiG1QeI533TToDTrbHdS/PABqST5IbSRPBj86KM
        gf4CdnvfQ45CXNq8h+fzp8JxKg==
X-Google-Smtp-Source: ABdhPJwZk0cvCImavuHwPX5j2nUO72Kw+wZhgL9cMwjR9MYx7ZQsr+0ucwwLh44KiHu0/I9kzSkJXQ==
X-Received: by 2002:a7b:cb95:: with SMTP id m21mr2583439wmi.122.1623757880778;
        Tue, 15 Jun 2021 04:51:20 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id s1sm2031826wmj.8.2021.06.15.04.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:51:20 -0700 (PDT)
Date:   Tue, 15 Jun 2021 12:51:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] mfd: ucb1x00-assabet: use DEVICE_ATTR_RO macro
Message-ID: <YMiUNslHDTgwGoRC@dell>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
 <20210602114339.11223-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114339.11223-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Zhen Lei wrote:

> Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
> the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/ucb1x00-assabet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
