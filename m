Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86F53DFCDE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhHDIaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbhHDIaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:30:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9BBC061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 01:29:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c16so1244976wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IUj4Ab0V4S7X9wJwpM5ZlBQ/cYJnKu4wbVBWey5twJE=;
        b=vbLsGC7MyMAJ3KtJUo4y2UOex0xxfCB4BT/L9+iu9p1sYdQ5VV51W/s/bonpOvvmja
         NSqlZa7DeXzbI59jABuRayDxsnQVD7CozC9YSjUl1p+ALb+Ny5csYgghewv+qqYQ/xD1
         XiJuSikQaXTy6kRAMcu/9GB4SDA+plht25QILTsg56P6vXpF9NibC9EQ7G4vaCWI6SrT
         Ved3Q6NaNFSoMKR1rsm6HkQrTZQE+bT7s5b+zgaPTFxYqY6gSehfcAbL5reACRtKJuH1
         HeWP9apLa4SfreGhSVihk2z2o0rdsc9ucVoyHA7rNyehm7bLJhpk5krA5gzfRYtFWuKb
         0hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IUj4Ab0V4S7X9wJwpM5ZlBQ/cYJnKu4wbVBWey5twJE=;
        b=nhycGibpynEJbeGwnTlz0N1UaM6RRjnMabfYzrUUmepaQ+BZqlHWXqf72EsLZkUaVl
         sI/A7uB6xRI6KUT+LGfkXtDM1hbZflea062Jj5tYdyRsE8z8bGROgF3h+FjJ9XTLJ3dA
         8q9pYYaAi701zA6HVoGDXOzKaQ8htO4zWCdrzDur2XqlpsylQ8BrplVgnVElpvDypSyj
         hf+4a1E4V2tRCMBk5cJUl7k83k0EaoTKWg8YRdnQUnn6hWBlYgRBt5wwR1Qk1KV13qDC
         JMMAfeQWlhp2KabgJitCBYIgXFoQ1q3cAZRVjTbpjgcYChZ+aqR/LtC3bMxxXmzTAFG8
         wHTg==
X-Gm-Message-State: AOAM532WTcslvoaHxcaj9m5unCM9ReRCex4Yla9020xU9SF0k42GGW/I
        pPT0BdLT6OYNJ4dP81MiIxAcLA==
X-Google-Smtp-Source: ABdhPJyXOVu3cqtGjpfwSvmIS1pkUox/I92zrcpzPn/HG9YS5/ZIz/Iu4mNzGQv5HfHbVjb6NE5X2w==
X-Received: by 2002:adf:82e6:: with SMTP id 93mr27090513wrc.47.1628065790489;
        Wed, 04 Aug 2021 01:29:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id t23sm5273852wmi.32.2021.08.04.01.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 01:29:49 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] nvmem: qfprom: Add binding updates and
 power-domain handling
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rbokka@codeaurora.org,
        dianders@chromium.org
References: <1627627573-32454-1-git-send-email-rnayak@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <476c79ce-2065-602d-8c34-4234fcc53f6d@linaro.org>
Date:   Wed, 4 Aug 2021 09:29:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1627627573-32454-1-git-send-email-rnayak@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/07/2021 07:46, Rajendra Nayak wrote:
> v3:
> * Dropped the description in bindings patch
> * Added a patch to fix ordering in qfprom_disable_fuse_blowing()
> * Fixed devm_add_action_or_reset() order
> 
> v2:
> * pm_runtime calls made unconditionally, should work even without the power-domains property in DT
> * Added the missing pm_runtime_disable() handling
> * DT patch rebased on msm/for-next
> 
> --
> qfprom devices on sc7280 have an additional requirement to vote on a power-domain
> performance state to reliably blow fuses. Add the binding updates and handle this in
> the driver, also add the DT node for sc7280 platform.
> 
> Rajendra Nayak (4):
>    dt-bindings: nvmem: qfprom: Add optional power-domains property
>    nvmem: qfprom: Fix up qfprom_disable_fuse_blowing() ordering
>    nvmem: qfprom: sc7280: Handle the additional power-domains vote

Applied 1-3 patches.

dts patch can go via Bjorn's tree.

--srini
>    arm64: dts: qcom: sc7280: Add qfprom node
> 
>   .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |  3 +++
>   arch/arm64/boot/dts/qcom/sc7280.dtsi               | 13 +++++++++
>   drivers/nvmem/qfprom.c                             | 31 +++++++++++++++++++---
>   3 files changed, 44 insertions(+), 3 deletions(-)
> 
