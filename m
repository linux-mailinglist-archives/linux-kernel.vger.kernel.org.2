Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0588B452F37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhKPKig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:38:36 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56734
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234256AbhKPKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:38:09 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 01FF53F32D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637058912;
        bh=RiDE8XXvbEJD12cizRsQR7WHmOv+p0GSx9+K53KWmuU=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=PF2Xi565pIVMpHhbqWAIzd/0scqkdX5acQ7a9UMVY0EMM1TPgRvIzzE7DpnvFB6mH
         E2fH2O8gLBYRnZcvIeDhukjmbCC9I1RkHlJI3/SNTmDnVYIdaHyL1WcQ3kXvm6y+QP
         E8rtMdKGdNlOkyeuFfeLiMbj/3hEsmSpQNaCkDFGPz8sXx2gJNt5o4n3FDMkdFWD9h
         g/OIGuIcbW0BAIGoIEOH7uMAzri+wwLcsTT27ebgecUlUq+5KKD3TTsQG+OlOmQ8/k
         a+FoVhGDSgOv6KOCeFSDa83IBNBUzCzNSDsP5e+EkcXkgQYjFu65M3y5TPy8PRUfRw
         5nPTK2rCQY8cA==
Received: by mail-lj1-f197.google.com with SMTP id q13-20020a2e750d000000b00218c953d0b8so6078693ljc.21
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RiDE8XXvbEJD12cizRsQR7WHmOv+p0GSx9+K53KWmuU=;
        b=GQRBTp95Z6RMDrJG7gV6HnzDSbDsItXwz/hs/XI+HpB24tXOrTcUtQAp7OZXmdma/f
         o4skUK9Mz3jf9c/IBZCwiR9X1PYpBFCgO04wMtU4c20notOIktOmjkN1R7lcihSFnUDV
         3eDLvnjKm15iujlUCvKYXBOVBZlJ6mPTmj1VkbB5KUAmo3QaGhmq70WtQvDVH/huDGrJ
         HB+ouWWwcE7LoXduh6NL6iP7gNruL9WtoyJU8M/b+MIakcZI42AsRQCFf8CnOAhiX0Vj
         kinQy7Qcgv/wQ1UEawaY7VkXGAhvaaVzbqtY/DT5N+gl1kYo7kNBDiZFXHHN2lHTZIdq
         E3kg==
X-Gm-Message-State: AOAM531q9g+2AhAVlxGpCQO6qG/H+nXglwoGDaPVDMgOY3TkBPcCUz/y
        AfL96OoalFI9T09XpxKEh6uyj1zucvcc6nGVaLjUl4md4wlMfk14D9/B3Tl8W79+dKIq/1DcWAR
        lUN58KbvLrhQVVVL8qzOVerO3GuYIKo+iI80zlJPW8Q==
X-Received: by 2002:ac2:4ad0:: with SMTP id m16mr5736888lfp.29.1637058911334;
        Tue, 16 Nov 2021 02:35:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwSo0x9s6yBf2L1c3SFhk3EKtwdZI+SJJfsF8Gjd3qbkGSH9A8xJa+C2h3zY2e+7KIvujJHA==
X-Received: by 2002:ac2:4ad0:: with SMTP id m16mr5736873lfp.29.1637058911184;
        Tue, 16 Nov 2021 02:35:11 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id z12sm1719295lfs.101.2021.11.16.02.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:35:10 -0800 (PST)
Message-ID: <65f0586d-ac95-3907-9458-3e17f600ca09@canonical.com>
Date:   Tue, 16 Nov 2021 11:35:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 2/2] memory: fsl_ifc: populate child devices without
 relying on simple-bus
Content-Language: en-US
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211015005707.1996-1-leoyang.li@nxp.com>
 <20211015005707.1996-3-leoyang.li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211015005707.1996-3-leoyang.li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2021 02:57, Li Yang wrote:
> After we update the binding to not use simple-bus compatible for the
> controller, we need the driver to populate the child devices explicitly.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/memory/fsl_ifc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
> index d062c2f8250f..ef2092fa90d9 100644
> --- a/drivers/memory/fsl_ifc.c
> +++ b/drivers/memory/fsl_ifc.c
> @@ -88,6 +88,7 @@ static int fsl_ifc_ctrl_remove(struct platform_device *dev)
>  {
>  	struct fsl_ifc_ctrl *ctrl = dev_get_drvdata(&dev->dev);
>  
> +	of_platform_depopulate(&dev->dev);
>  	free_irq(ctrl->nand_irq, ctrl);
>  	free_irq(ctrl->irq, ctrl);
>  
> @@ -285,6 +286,12 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
>  		}
>  	}
>  
> +	/* legacy dts may still use "simple-bus" compatible */
> +	ret = of_platform_populate(dev->dev.of_node, NULL, NULL,
> +					&dev->dev);
> +	if (ret)
> +		goto err_nandirq;
> +

This one does not apply. Please rebase.

Best regards,
Krzysztof
