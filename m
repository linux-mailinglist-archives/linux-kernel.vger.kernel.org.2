Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB92639780B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhFAQ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:29:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDBFC061574;
        Tue,  1 Jun 2021 09:28:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d5-20020a17090ab305b02901675357c371so1416976pjr.1;
        Tue, 01 Jun 2021 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=onY0Bzm/Yy5A/f1CLX0jeVRYrAj5qNlVvfF5G7TTJbs=;
        b=DfUAvIA8GeK3CqH2ie/6uKXZ8zmMUApUpZfB0ZlmL4Ba+YNsVgjO0sn3LGzgF32Csh
         Q+coXmRaCjeLry+QyntKLl1pdtJfa07BOIfR5pR06OJzex/vT5+o/oJDk3i8XjN9ArY2
         MCekh8oWTXKXe8EU2c82l07B4s+SEw9rheEAuydZb6pv5LysYlEI1Ej2Vetq8YzN9FlM
         QVFHfdg0Blgw9EmiMp5Kpg8+j4+pCDzQoS/fv2SpzeSitDTMCRqPKLv4FeJyZDE+xG+Y
         KlNiXvSLsCsKStzgFCj2dmp6wZsu3slBryd/FHvj5TH5+U4PxWz+WdOC380bd/siel9F
         hkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=onY0Bzm/Yy5A/f1CLX0jeVRYrAj5qNlVvfF5G7TTJbs=;
        b=XOy0mXUtglg4kh6EtE8pPAxHhdHk5fg4Wt+PiqQ5gROM8oBF2QKTIS5GuJQ81sL8gA
         UrG5XwPU3jQYUmC30mGKGH9QutbnKMwHSUpBZFLGK22ubw8nuPNlECMzdZFT32nhSiBF
         ZnR/jdHyyKCXV2RBXeN3Ln6heftcRWbxbM9cybLHz/WYFBrS39ze5++41W1NvNAdhLR3
         OIStn5ig+fTGfYjgIGhm2wIR974GyGPmZjtTEs1skc5tFraygTmXOi4tc4oClYG/pyRu
         YIGq6tp9gkevOhexmBlBiKNkT+lLCU9WgX3fa/VjT5/hcwv4fTFecKsZZy/uLSixHtPY
         od6A==
X-Gm-Message-State: AOAM531FoMjoND4BVXU9kguwITUK90rPqU9gjy663zICXFzH+YoPA9Lv
        DFNML2CCxZmvKq0gAmB64o8=
X-Google-Smtp-Source: ABdhPJyBlNc9f9ps1g19xb5wZgtGpviu7JHwoP1PU95mn9WKs5JrwHImV8tWzZOm5OLXSCiD2Pr0uw==
X-Received: by 2002:a17:90a:aa94:: with SMTP id l20mr671728pjq.125.1622564886879;
        Tue, 01 Jun 2021 09:28:06 -0700 (PDT)
Received: from [172.30.1.14] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id k38sm14767173pgi.73.2021.06.01.09.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:28:06 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] extcon: sm5502: Add support for SM5504
To:     Stephan Gerhold <stephan@gerhold.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20210531133438.3511-1-stephan@gerhold.net>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <c2964e2c-e606-e529-1ee5-6e9d0a32f8e0@gmail.com>
Date:   Wed, 2 Jun 2021 01:28:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210531133438.3511-1-stephan@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 5. 31. 오후 10:34, Stephan Gerhold wrote:
> This patch series adds support for SM5504 to the existing extcon-sm5502
> driver. SM5502 and SM5504 are fairly similar so support for SM5504 can
> be added with a few simple if statements in the code.
> 
> I also put a few cleanup patches in front and convert the device tree
> bindings to DT schema.
> 
> I tested this patch series on both SM5502 (Samsung Galaxy A5 2015)
> and SM5504 (Samsung Galaxy S4 Mini Value Edition) and it seems to work
> just fine for both.
> 
> ---
> Changes in v2: Fix compile warning in last patch
> v1: https://lore.kernel.org/lkml/20210520112334.129556-1-stephan@gerhold.net/
> 
> Stephan Gerhold (6):
>    extcon: sm5502: Use devm_regmap_add_irq_chip()
>    extcon: sm5502: Implement i2c_driver->probe_new()
>    extcon: sm5502: Drop invalid register write in sm5502_reg_data
>    dt-bindings: extcon: sm5502: Convert to DT schema
>    dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
>    extcon: sm5502: Add support for SM5504
> 
>   .../bindings/extcon/extcon-sm5502.txt         |  21 --
>   .../extcon/siliconmitus,sm5502-muic.yaml      |  52 +++++
>   drivers/extcon/Kconfig                        |   2 +-
>   drivers/extcon/extcon-sm5502.c                | 180 +++++++++++++++---
>   drivers/extcon/extcon-sm5502.h                |  79 ++++++++
>   5 files changed, 282 insertions(+), 52 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-sm5502.txt
>   create mode 100644 Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
> 

Applied patch1-patch3. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
