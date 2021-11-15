Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5B4505E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhKONr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:47:59 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60756
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236509AbhKONov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:44:51 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 07F013F1AA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636983707;
        bh=/crzo/v4ld5BEDfJ8Uo+M835ZXZd3qKocB73IxuyYag=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Dz/MQU5MNlLrX8UXIAysv2DogSYKfR0WLcWJJxFsjRANIgd9HmomBx3E8UxKyScOF
         zk7olao5IVAgmtFuYMRPD/vwz3+NJMV2Rjz0Bk2RkrEGjCyv/s911I2VNY0hgUFwwE
         +MZMWEjICj/qzaee/32fzLNOFEIQeFfu6oK4SUF6TKbqDC7ze8C9GXBBabYJFyDuyd
         nM1WIBbs0Ra+w1wbb01FarNhzaIWLZfSWZiVVSnDZnMoV4MJsK9hKkHkZhMojIod4a
         PcX77wLOh1qR+UDBvI9GZlDRT5djISECrVYqHSTTkRel7XVlR3mDlSwoushoAcRJ7O
         tHKJlXkYHA4qg==
Received: by mail-lf1-f69.google.com with SMTP id b23-20020a0565120b9700b00403a044bfcdso5628595lfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/crzo/v4ld5BEDfJ8Uo+M835ZXZd3qKocB73IxuyYag=;
        b=LpVohTYdAy2rs3Z9zw2N54xu3+9uqn+uVxntaJUyphBW6kkxndppKwcrxbaPvORvlN
         FaJ1x9FJaY6uHUSkf1Qjjgxsw64wcebL7E++/n/QS4tDUzWXpoqwarG1nYOigt8P85AC
         zTQLnDNUcC4qe7agDHT+1WReRKolvvIuZjNoi5erMVor+fuFVV5JnvWoY+nj+E2VrskK
         gttxVHEYhQ90W1DDEx6CSDMGSYbmqKxr68CCT7ZzzeEdkJwR5/obpKlKgKEVUlBwfIqr
         SzjLVGNXIhWo4T9lz6uH6vhkpKsX3EIXf22ZjuBH5iXmJqakFV3PcHJXUwigSgZPUuB4
         Ed+Q==
X-Gm-Message-State: AOAM533qWSXHI6ciwmMaj59EtiYDq0A36TNKokcGfd9eb4uIfsgCSycA
        dTVVQb/tFtTOCkypiUDWJnmeueb/97I8ZNQDWQoCOPT7/ER/8uiEeI7T+LYE59pKldzSwULreU5
        T86kNhObepFdt841667/nZrUO3c+lwJDRq71otgnSYA==
X-Received: by 2002:a05:6512:3da9:: with SMTP id k41mr32512243lfv.563.1636983706524;
        Mon, 15 Nov 2021 05:41:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRQMDstg8dLIIEjdGyEDf7+Sl/Yt+pOKzoyRmGgG1oEXkeCKyoa+57U0GH175XKG1BSyoNcg==
X-Received: by 2002:a05:6512:3da9:: with SMTP id k41mr32512230lfv.563.1636983706338;
        Mon, 15 Nov 2021 05:41:46 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id z2sm1427005lfu.94.2021.11.15.05.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 05:41:46 -0800 (PST)
Message-ID: <a7b50036-732d-53cf-4b8c-84c7c760b9fc@canonical.com>
Date:   Mon, 15 Nov 2021 14:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] samsung: exynos-chipid: add Exynos7885 SoC support
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211101004853.55810-1-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211101004853.55810-1-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2021 01:48, David Virag wrote:
> Exynos 7885 has product id "0xE7885000". Add this id to the ids with
> the name.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Removed correction for weird revision bit based on vendor kernel
>   - Rebased on top of
>     https://lore.kernel.org/linux-samsung-soc/20211031205212.59505-1-krzysztof.kozlowski@canonical.com/T/#u
>     Apply it on top of that patch.
> 
>  drivers/soc/samsung/exynos-chipid.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> index baf3afc69d79..2746d05936d3 100644
> --- a/drivers/soc/samsung/exynos-chipid.c
> +++ b/drivers/soc/samsung/exynos-chipid.c
> @@ -57,6 +57,7 @@ static const struct exynos_soc_id {
>  	{ "EXYNOS5800", 0xE5422000 },
>  	{ "EXYNOS7420", 0xE7420000 },
>  	/* Compatible with: samsung,exynos850-chipid */
> +	{ "EXYNOS7885", 0xE7885000 },
>  	{ "EXYNOS850", 0xE3830000 },
>  	{ "EXYNOSAUTOV9", 0xAAA80000 },
>  };
> 
Applied with fixed title. Please use prefix matching history (git log
--oneline).

Best regards,
Krzysztof
