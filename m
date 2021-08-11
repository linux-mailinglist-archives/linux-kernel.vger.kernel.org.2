Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5980C3E8E58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbhHKKRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbhHKKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:17:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D29FC06179B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 03:16:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c9so2273595wri.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QkTUsJOuJycgvCvVleJLaIEduhW7RAY2bQUVOScyrFI=;
        b=Nf1VSnynydfaMZSB216yWP4P1OdCKB+S1LmuPYkO+eHp9qpajyZ4W7bLq6DH2YAYmU
         JZQVzBj/sK4Ewto1xfSP5VnhVJS2HmE2pkkquBsaIsnhYCUo/KP77yraeCtVmAK4cqSG
         8ESjI9q3tdEyKQ3Ud2YUQyPXrMvqL7RYlqyyD+E2/pyBk9fjeK4fhizufz0JQzEmSiyo
         K5MJopq8FqxtzhqQPOnnG6zDEaFBGPLFier9JCy4m6nWcofCy1xM4wm8hLgPPajA+Og6
         3HP6Hccx4plzWhHOP0YdXU51rhWzkW7SlBtnNBgQd9dI7owCEivn1xDFB0aoXe9QTdzP
         WxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QkTUsJOuJycgvCvVleJLaIEduhW7RAY2bQUVOScyrFI=;
        b=uAEVBDBFYOdnMBWPraGuQPEUQDvc8SfAOoQ04k4Hf70OEDLLrCKaEsBSlRLbSgxSag
         g2v+oEOPfzPLJVWswcbXT/Reo0KGZxJBqj+zb0Ugqc8mhCH8K+ChV+2JyOZr3nUVNFxi
         wYOqq0rXDicFXM1ROA2QWDdInvZXEoG+RCEzoO6kfx4Hbt62bB0qE5eSDiLRNgL/B4yr
         1drWSyMTz6yp8Pj9etfd7146CnRRpewC4KftljYedX7I3nWDzyZ6V/gq2m8bSDj4KV3Y
         K4/UPo7lhfCm9/SrYH5+mHiweACK6Gvn83MfGkmdyk+5Qf7mxXY8TO9aZ1IrskjF3l6o
         cQTA==
X-Gm-Message-State: AOAM533Yao5V9SQbesyjdj+tkMN1h9zEJKlFmxVWLpCDxUUkM+t4+GhG
        Z1j3+qbQRuN5p7AnIANPG9SJLVt7q+lIRg==
X-Google-Smtp-Source: ABdhPJySUBrqn0QsktqHoA1e9pMnVVrv0q96QUkOlWaZhRoWe+QvJIt/0auZmajPjNQ1Pz9HV6C28g==
X-Received: by 2002:a5d:58ce:: with SMTP id o14mr16881662wrf.319.1628677010435;
        Wed, 11 Aug 2021 03:16:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id w9sm23215785wmc.19.2021.08.11.03.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 03:16:50 -0700 (PDT)
Subject: Re: [PATCH V1 1/4] bindings: nvmem: introduce "reverse-data" property
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
 <20210810073510.18218-2-qiangqing.zhang@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6e3f6881-929d-1663-58f1-39bf35069175@linaro.org>
Date:   Wed, 11 Aug 2021 11:16:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810073510.18218-2-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/2021 08:35, Joakim Zhang wrote:
> Introduce "reverse-data" property for nvmem provider to reverse buffer.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>   Documentation/devicetree/bindings/nvmem/nvmem.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index b8dc3d2b6e92..bc745083fc64 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -61,6 +61,11 @@ patternProperties:
>                 description:
>                   Size in bit within the address range specified by reg.
>   
> +      reverse-data:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Reverse the data that read from the storage device.
> +

This new property is only going to solve one of the reverse order issue 
here.
If I remember correctly we have mac-address stored in various formats 
ex: from old thread I can see

Type 1: Octets in ASCII without delimiters. (Swapped/non-Swapped)
Type 2: Octets in ASCII with delimiters like (":", ",", ".", "-"... so 
on) (Swapped/non-Swapped)
Type 3: Is the one which stores mac address in Type1/2 but this has to 
be incremented to be used on other instances of eth.
Type 4: Octets as bytes/u8, swapped/non-swapped

I think its right time to consider adding compatibles to nvmem-cells to 
be able to specify encoding information and handle post processing.


Lets see what Rob would say on this approach.


--srini

>       required:
>         - reg
>   
> 
