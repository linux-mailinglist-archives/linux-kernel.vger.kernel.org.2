Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC2D3E33CF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhHGGml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhHGGmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 02:42:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC15C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 23:42:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so21326280pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 23:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dWtD7lWvg6ukiwjgEZEx22lskT3PyFWcdyyNdMYnx0o=;
        b=DhWa8crZziO2TlIBywaSyi6P3fiRzRiCx81AXFfUlBmsJrYOOaNHwX7DmWnb9P/1gu
         mwQ2+iJqKLTkXVWjBQfAU1BZt4jYwMQdc2Ud3uMrvOQiSOVwwByHp5CiXvGZt6T3fl8H
         iNipw0G3W9xNCHcIaA9vkLVykLQ5do7RGzqnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dWtD7lWvg6ukiwjgEZEx22lskT3PyFWcdyyNdMYnx0o=;
        b=Anu2xros6DSmewR63NxmOIJODUpCNyogTLb1Af17xewuI5PcsBi+Pj4mXBixJ1E0ss
         9N9eYoLB2E/qdZAzGgMNSsPP+1PmJkeQsRd/fv6e3Vp8bpaDIx5rhox81Bdd4C81cRQk
         MDXIAZGnYXGyU9EZxNkvxLeG2VlctLjMlYZF8jOr1+0MqQiBgZpzS8U8sYKR8FrOTB6/
         ya37PtsYuA6Sfed7rtt3ppojVZhoh3oA7AjYx9QBIaX1HCtgB5ksvTP+abhdHIkLJrp8
         bNQ0sJxHzkFMNfz2Z44mEaAjp5L3OZUxSXFNk/Nqf9xJ9YebGHDv0mTzDUdQpKFsmpYR
         oM5Q==
X-Gm-Message-State: AOAM530FK734jcoqKsAsWSfdeNufYbBkDxA6nT0i02y2C1vfEYzfHzLX
        id4BU5NOaS/gDfWU4Vj5e9IhZw==
X-Google-Smtp-Source: ABdhPJxcNREsbU1DMDK5mJy0lETd6o+p1t9Os0mLrT+itxLEhJvlZH2+ErJ79gZRR4QBQVL1rYeC9Q==
X-Received: by 2002:a17:902:7208:b029:12c:9c9d:e0bb with SMTP id ba8-20020a1709027208b029012c9c9de0bbmr12144627plb.44.1628318539669;
        Fri, 06 Aug 2021 23:42:19 -0700 (PDT)
Received: from 1d975be6a764 (194-193-55-226.tpgi.com.au. [194.193.55.226])
        by smtp.gmail.com with ESMTPSA id g1sm14315943pgs.23.2021.08.06.23.42.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Aug 2021 23:42:19 -0700 (PDT)
Date:   Sat, 7 Aug 2021 16:42:12 +1000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.10 00/30] 5.10.57-rc1 review
Message-ID: <20210807064207.GA3991@1d975be6a764>
References: <20210806081113.126861800@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806081113.126861800@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:16:38AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.57 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 08 Aug 2021 08:11:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.57-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Run tested on:
- Tiger Lake x86_64
- Radxa ROCK Pi N10 (rk3399pro)

In addition build tested on:
- Allwinner H3
- Allwinner H6
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
-- 
Rudi
