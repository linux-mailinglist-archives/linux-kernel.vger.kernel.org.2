Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A5339A23C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFCNcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:32:46 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:33441 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhFCNcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:32:45 -0400
Received: by mail-ua1-f48.google.com with SMTP id l12so3327429uai.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvAaVAGl0y3frERkrC2xF1QPHHzd64BdyWGXs3vitYo=;
        b=LFrA7ipPw8u7Gr5bv4drcTnYNuYyrk5BpPvj6XcXmRZhu7MABiO2ytikBdm2Okor2P
         EI6xz2NhrVmlNJoi0FyBR4bYpFSwV0rdGmRhMmaMEdsaC597ZfQTjQYg2MwTdzoNs9vG
         H+e0PzAmcDM0xYEj+P7Mr+kTW3X1Pkc9crm41jgEwxVqgbHrhg7Q/f+nz/w3M9QSl9KS
         hur0ZS3OObN9YONXH8+hUR2w3SyjbFH4K5BsOWJFpnco32pTEkASMWJiR2mtxVjPRov8
         IO1LiAqBSNZ8xlIm9XZ/GvRm2gDhxY6Ouagv6IUFnxbXBke/K/YaG39jdIs/HWXX4yS5
         /D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvAaVAGl0y3frERkrC2xF1QPHHzd64BdyWGXs3vitYo=;
        b=fnHkS3BiTjYnC9sVZjky5Iu4IXgtybmAYc+DK1a+OihAAXuFockWyTUb1wAx9JTqjh
         VjgiZhOniXgTEriOvQp6gKexP29ktsK0KmJV8Gu3cANF96RaVyDnuqmbiXs9UTE1Zwk8
         IAvg2UD2Z8h0iQMiuzsd3bX1eVELLSvFT1bmuOCyJ8IoHvZcfL16UwvH+0Z3IRlXXHg2
         jkaN4SOPO7r7PZcz3AQy5bWKQMT46apFr1KF73L6U2OD+i8c9PfLF2spWeSCZh17gdST
         EWbPKno8382MgCuxsT/rKfc7Q3NXn/RZwpIppxNRNINg0aXNdxNDLr32FI8+auGdVfTc
         1rBQ==
X-Gm-Message-State: AOAM5330enJ8PsmXOwQfY4pyRHdKW6Dd2aKqnaA2n4ywmP8yxguwtflz
        4yxmVS0Rk8DZYG4yYz4jc3vjc1QWMRQZDdv9eYVy9CXZ65M=
X-Google-Smtp-Source: ABdhPJynCdl8YoMPzCi1QkfqCVFUBIlX4aMPGaGe43BPgpWfD5c+anBro0C2OHGpwH6KWNlSFiGs/BlO54JEnBE611E=
X-Received: by 2002:ab0:1464:: with SMTP id c33mr24110473uae.118.1622726985359;
 Thu, 03 Jun 2021 06:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210601141945.4131934-1-zhengyongjun3@huawei.com>
In-Reply-To: <20210601141945.4131934-1-zhengyongjun3@huawei.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Thu, 3 Jun 2021 15:29:35 +0200
Message-ID: <CAH9NwWemTq14Ror4FyqiwGm0vOQB3Er1SShUYiL8eLfdVOPBgw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/etnaviv: Remove unneeded if-null-free check
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 1. Juni 2021 um 16:06 Uhr schrieb Zheng Yongjun
<zhengyongjun3@huawei.com>:
>
> Eliminate the following coccicheck warning:
>
> drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c:84:2-8: WARNING:
> NULL check before some freeing functions is not needed.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
