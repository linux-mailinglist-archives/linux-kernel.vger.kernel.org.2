Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030AA367EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhDVKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:47:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59777 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhDVKrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:47:22 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZWr8-000688-IM
        for linux-kernel@vger.kernel.org; Thu, 22 Apr 2021 10:46:46 +0000
Received: by mail-wr1-f72.google.com with SMTP id j16-20020adfd2100000b02901022328749eso13605178wrh.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ChgsWVHouphJpIEvBcUP4TDV1Lb1Y7MqOzirYiGZuls=;
        b=p8HE4rlizKR7zyr3L3vcS1JtxDlO7tWbc8q0cmKHkuemhKvumk/VQgNKQg4ZUKxE91
         whO27UKIPOjGGlkdYG35EO1Y9TIwcZ92bgJkPqZfTtL1wIFCP01plZmkgAFqTKZtK75g
         tZ+4eBLtGsaJ5MDGlpObsWn/yIP79CAL9QcNM0qv/8OEo8qtvPBX6HHp7O4tmzvk9hXF
         CD5BOyi0jycklME2d08MxUaWeexnAoZLsUuNMM0j1FX0hf6iEjGZu2DsmqN9AS+v+pRu
         sTypijS9yIieSIvDGQss3zuH4dp9vtaVsD7cBPTg4P92CUFj1dc+c7oW1VQNSatUQ9PU
         BmFQ==
X-Gm-Message-State: AOAM532NnUn6wti5KqRO7EywsuoelWfPoGGkO9/SeMM6WFEZeUaHCVOw
        VjAdJc5oRmDqGB9WX0XVpAOpeNKClOFvO6CUGmuVO2KB12MQunPBkd7u73hUi/1u2kevJzSSnds
        2Hh2r90QLSlrts+cfI/AdAR2+J3PV9RgKCrLs0Twy0A==
X-Received: by 2002:a7b:c454:: with SMTP id l20mr14904429wmi.65.1619088406368;
        Thu, 22 Apr 2021 03:46:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwriIvSyixOuWHVrmtzdeZk8A0gu9EIEm+2/cX2GME4GssfKx9dIbuacbeZx9u7Rg6czj93yA==
X-Received: by 2002:a7b:c454:: with SMTP id l20mr14904416wmi.65.1619088406202;
        Thu, 22 Apr 2021 03:46:46 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id h17sm2936241wru.67.2021.04.22.03.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 03:46:44 -0700 (PDT)
Subject: Re: [PATCH v2] hwrng: exynos - Fix runtime PM imbalance on error
To:     =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Bart=c5=82omiej_=c5=bbolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20210422104145eucas1p17f46c95b72f3568761a9f7911bf072e1@eucas1p1.samsung.com>
 <20210422104141.17668-1-l.stelmach@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <bc20ae4c-3e62-7b07-506c-ce8d90f65754@canonical.com>
Date:   Thu, 22 Apr 2021 12:46:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210422104141.17668-1-l.stelmach@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2021 12:41, Łukasz Stelmach wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a pairing decrement is needed
> on the error handling path to keep the counter balanced.

It's exactly the same as Dinghao's patch:
https://lore.kernel.org/linux-samsung-soc/20200522011659.26727-1-dinghao.liu@zju.edu.cn/
which you reviewed. It has even the same commit msg
(although it's difficult to be creative here).

I think it's better to resend his patch instead.



Best regards,
Krzysztof
