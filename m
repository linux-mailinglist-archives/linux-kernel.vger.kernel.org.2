Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE74833EBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhCQIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhCQIyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:54:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27801C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:54:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v11so944948wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1ep4RAOuLpsLyK7c13YsySxBNqK6BBmFhVdnhfjr9A8=;
        b=kbVjdlr56gNt7X0U4NNzNAphXMwon7ggznxDhWnZZ4kGmfPCg6kWlUy25REgbi6ET8
         M3L5aQRoOA1usapyXbO9G2Av6ITaFP9ddwYsiFVT0TJpw3Bf5MYInj9QF98sND8hUWBF
         PaGo+UNFVet02vQsHWJHQC6Ss+VpM65HvKCUjMyqQfPHL0meCeHvJGIsVIypwZgTiHW9
         xYdxfdIWFRa61Zmxb/kN9AaIveL1keVi0FOKoOV9j4HdiMnhWnLyuEVCrcAJe/ZNUZWu
         7nMjyBfiICdSVEl035rQ0qf1Gwr9ri73OvWlGXvuuufDRQRj2HheO+3gTm/BGRyzUqfN
         fB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ep4RAOuLpsLyK7c13YsySxBNqK6BBmFhVdnhfjr9A8=;
        b=pATWU2Sc7JZ6wvyG3XUYGC8DhpNDgN+t4mUo9LYFBVsZISrC9HA3lcFYL++Onwilqd
         Ra+lkTjveIaZjTSlvumV2Xwe8pFPdtQ4t1LhyBOAhtSLIija9KeKBhF6mh2oiJziKxKl
         UX+xW8e15OekzyCK8BCZ3QtMCyM1nNOpFFR51IRNT9wbQJNhtLmORsz3yd8MEUtCsqMt
         YkjJWyzxcM/iL8x5kCfhD8nL94DUdQujYY18qMUs3kacvlzj3qJ0TCf/9vQA3twGttu2
         hUmyS0reBpL9GAcM2uKsHz7VD3fQeOeeuSKBExMIPFhnzv46m86wSCNhNGeZgnIqB3PT
         Ez3g==
X-Gm-Message-State: AOAM533i13jVjI/poMCbD0xZDsxxLmOSXUYEgta+F5BtVqXceaPOfEhM
        e2arkG3P+K74VU010Llh4z3rjC2D+WmaqA==
X-Google-Smtp-Source: ABdhPJwxh1HB2ueQyw/RPGx9iR32jttFoPuAd7ri2XiENH5A1B0vgz0mLsZuP8B+JeZADiwF7MhpzQ==
X-Received: by 2002:a5d:5487:: with SMTP id h7mr3286509wrv.348.1615971285523;
        Wed, 17 Mar 2021 01:54:45 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id p10sm26188538wrw.33.2021.03.17.01.54.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Mar 2021 01:54:44 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: nvmem: use base meta-schema for consumer
 schema
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210316195111.3531755-1-robh@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b91daddf-6162-3679-ff7b-354170e0d0fb@linaro.org>
Date:   Wed, 17 Mar 2021 08:54:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210316195111.3531755-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2021 19:51, Rob Herring wrote:
> Common consumer schemas need to use the base.yaml meta-schema because
> they need to define different constraints (e.g. the type) from what
> users of the common schema need to define (e.g. how many entries).
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini


>   Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml b/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
> index 828e4a1ece41..b1da238c8bcb 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
> @@ -2,7 +2,7 @@
>   %YAML 1.2
>   ---
>   $id: http://devicetree.org/schemas/nvmem/nvmem-consumer.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> +$schema: http://devicetree.org/meta-schemas/base.yaml#
>   
>   title: NVMEM (Non Volatile Memory) Consumer Device Tree Bindings
>   
> 
