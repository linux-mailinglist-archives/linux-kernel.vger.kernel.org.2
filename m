Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D564745D5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347768AbhKYIBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhKYH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:59:52 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453CC06175C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:55:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so7155170pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tt7CTudKpMFSkG19xv8hy7yzl4VFey99q/8a7qTJXu4=;
        b=MeqBlBKvfzm++TfjeBG1gv707qZGBZRQ+ccrsigFPhKevfbW7uIC1D9rMl5So+94F+
         nGIjVh/7wRv37+voJ/drKPVKy9lJxhryFyKHr33Fj6t0IwhPzsrDKjdViSMSeBRqIYY3
         kd/BdsilrRzbEchPFjufkhRHqwFIZiK6s1wLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tt7CTudKpMFSkG19xv8hy7yzl4VFey99q/8a7qTJXu4=;
        b=MZlTU9pbQ3QYUFIAEddzi2KP8h1urVk+56nBqteNp1zs1xZNnFZobyK6BNlbqzOZIu
         grIAiZQzV/i3mRW1+i4JlUUfRqxT4aniii+0RJhdJAb7LbsCLmVg2o7+a60c2NW6x4Ik
         B0RavL21q8oOPg001Z5FrwSDTn8JhCeiiwbmB6B24I/jU8TMoXvLte0TK7ayj9o3EvqD
         nMtVGPKuBp/A55KfYX/LX4nehnVpvP8W5NamkCZznQqKMH5N3E9VqUHSWpJK3cqWDW4u
         snTGh1MkRQ1GMwsNRDVsyNwT53zcGZQkAGnMIo6h7i1inV2YRO3YGufoPnN9ebWBoP60
         lHEQ==
X-Gm-Message-State: AOAM530IRAaHam1GdhZM4k27pJKZ+4NHrLH+YcMKKrJXNnaWFA/up3iV
        05P6utxhaev4tPYn7YpODHMlLA==
X-Google-Smtp-Source: ABdhPJxC8P446pZOzZRlPjf8zPAlQ9IG0y8RJWoGwNz2cN5Yvl7rI9+wI2SvuIVGQERBFIs2d9Ztog==
X-Received: by 2002:a17:902:8505:b0:142:892d:918 with SMTP id bj5-20020a170902850500b00142892d0918mr27986426plb.39.1637826942711;
        Wed, 24 Nov 2021 23:55:42 -0800 (PST)
Received: from 246c77d6bb15 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id z10sm2218018pfh.106.2021.11.24.23.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 23:55:42 -0800 (PST)
Date:   Thu, 25 Nov 2021 07:55:35 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.15 000/279] 5.15.5-rc1 review
Message-ID: <20211125075535.GA738@246c77d6bb15>
References: <20211124115718.776172708@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124115718.776172708@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 12:54:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.5 release.
> There are 279 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 26 Nov 2021 11:56:36 +0000.
> Anything received after that time might be too late.

Hi Greg,

Looking good.

Run tested on:
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition build tested on:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
-- 
Rudi
