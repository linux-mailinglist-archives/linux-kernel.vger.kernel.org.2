Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B989361C01
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhDPIn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:43:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58638 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbhDPIn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:43:57 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lXK4a-0005Cd-3Z
        for linux-kernel@vger.kernel.org; Fri, 16 Apr 2021 08:43:32 +0000
Received: by mail-ed1-f71.google.com with SMTP id d27-20020a50f69b0000b02903827b61b783so6659567edn.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dczrN2wjxG8CRedmsosMiP+zmp+MC7et/DZAPKA0m/M=;
        b=pOjNKq1fj3XxjdG2kCZ1kLPVyM2WFPEw0E2z3sG57/045xsqCkiMd+RadpPpJ7xJ9P
         du2NYw/pqZShTaWhN0vnFtWtDc4cKK1pMQmg9hPd5iErGjxCK+yE/LmAOXzO+PCQQ2p7
         sKXhCSvroY95xczeONdCcXhH2WaTXI6OK9qERHjSjKPsHGJlN+ZjpRqgk0bfQvtOrPwP
         zCd2j1TnzovLHfzephIkorLRpBktlPl4DsubeapwAoGLRzLUxOclDwNgx2ElZAmeoZ4X
         gglCyXtV2h3MlrJP91D2FawVr9iHKKCYluH2OVG+R7+5AC8y9ri1S0SMupv50kQsTZBu
         ZY4Q==
X-Gm-Message-State: AOAM530BzvMwd8cwKLhMfobC6mxpZLGIh9ltYR+KccfY+LHE3/EOEHah
        bZcqO6qy4VDmzLzhZwoRpOXmdcd1/1w0gLsy2Lyy6yAYgbY5lETNWOXED0lKgpOjYevEso+imwH
        bKmagfE8FPbO5hZfAWiySe1q9RsV2XvjyvtQqjB8Vqw==
X-Received: by 2002:a17:906:8a79:: with SMTP id hy25mr7415338ejc.461.1618562611632;
        Fri, 16 Apr 2021 01:43:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq8REYrZ+M/vj05xONGOZ/EahxZUVAKE4qQBCHxzTHw4tD7mODHw/KFGa+peSTEdk6Wm/21g==
X-Received: by 2002:a17:906:8a79:: with SMTP id hy25mr7415326ejc.461.1618562611449;
        Fri, 16 Apr 2021 01:43:31 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id he38sm1093921ejc.76.2021.04.16.01.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:43:30 -0700 (PDT)
Subject: Re: [PATCH] extcon: maxim: Fix missing IRQF_ONESHOT as only threaded
 handler
To:     zhuguangqing83@gmail.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210415113648.21660-1-zhuguangqing83@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <28b4db83-1381-f3aa-614b-08c065d4d409@canonical.com>
Date:   Fri, 16 Apr 2021 10:43:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415113648.21660-1-zhuguangqing83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2021 13:36, zhuguangqing83@gmail.com wrote:
> From: Guangqing Zhu <zhuguangqing83@gmail.com>
> 
> Coccinelle noticed:
>   1. drivers/extcon/extcon-max14577.c:699:8-33: ERROR: Threaded IRQ with
> no primary handler requested without IRQF_ONESHOT
>   2. drivers/extcon/extcon-max77693.c:1143:8-33: ERROR: Threaded IRQ with
> no primary handler requested without IRQF_ONESHOT
>   3. drivers/extcon/extcon-max77843.c:907:8-33: ERROR: Threaded IRQ with
> no primary handler requested without IRQF_ONESHOT
>   4. drivers/extcon/extcon-max8997.c:665:8-28: ERROR: Threaded IRQ with
> no primary handler requested without IRQF_ONESHOT
> 
> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> ---
>  drivers/extcon/extcon-max14577.c | 2 +-
>  drivers/extcon/extcon-max77693.c | 2 +-
>  drivers/extcon/extcon-max77843.c | 3 ++-
>  drivers/extcon/extcon-max8997.c  | 2 +-
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
> index ace523924e58..af15a9e00ee9 100644
> --- a/drivers/extcon/extcon-max14577.c
> +++ b/drivers/extcon/extcon-max14577.c
> @@ -698,7 +698,7 @@ static int max14577_muic_probe(struct platform_device *pdev)
>  
>  		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
>  				max14577_muic_irq_handler,
> -				IRQF_NO_SUSPEND,
> +				IRQF_NO_SUSPEND | IRQF_ONESHOT,

The same with all other patches for IRQF_ONESHOT which are send recently:
1. On what board did you test it?
2. Is this just blind patch from Coccinelle without investigation
whether it is needed (hint: it's not needed here, it does not use
default primary handler).
3. If you think otherwise, please explain.

Best regards,
Krzysztof
