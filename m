Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959713A77D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhFOHTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:19:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48928 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOHTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:19:42 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lt3KM-0004Ms-4b
        for linux-kernel@vger.kernel.org; Tue, 15 Jun 2021 07:17:38 +0000
Received: by mail-ed1-f72.google.com with SMTP id z5-20020a05640235c5b0290393974bcf7eso13072826edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e/PGUSSpRwJWtOH4gYs4F2atjkd8/9rJ+b2AcY5oXpY=;
        b=OkxVf5qsnOErTq0gjjXbbXG80d0itAnBgg4hxPcMJzIbW8prbKtSgosLAcKFz7qdJy
         80mOI28nT+LwHe8Q9MxG3VRC5rk/np00qubdbklT6TXPWnAhekWEtuFx9q7+RSQG06CN
         tZ143t+1iEivPiZ7+vq/rOmY6dd0mIY2pOpKUesrvpCxpf48oJaX+tjSedO/P5KIsTtj
         JZ6wb7I50ae5YxgvmnNOrJ30gGtgu7sYJ+QAErP+mPniEWtVk7BJUWIMir1H7hIiHr8L
         7OIq2ZICVsOzqCFZhQGlYg8EELO5NH/Ch32DAoGYj/VStV9eiJCPN6hqBFaSN0TVWlIG
         ulag==
X-Gm-Message-State: AOAM530h/n142E6igaRMHngQmpzt8QZKE0hNmFb64T0/F7yGeGawSUf8
        ToVRxKaJZrMn6RI+C9NjSlvEs4gXnwWND1d0HFM2FvJwjMvgjlHk9VZNZmnn3/Elu7ZM9L+wAXI
        5pBY6eDtVUn/hz07e/67dcL7WjryewAYNv+sY9JiKjg==
X-Received: by 2002:aa7:c983:: with SMTP id c3mr21129860edt.58.1623741457510;
        Tue, 15 Jun 2021 00:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0PXWMekssI+Wot2EYeDEnefKlmFz9PWFpU7VvbROKRhq9a7DccSGxXH8ArVcWKBS7xmM1lQ==
X-Received: by 2002:aa7:c983:: with SMTP id c3mr21129853edt.58.1623741457398;
        Tue, 15 Jun 2021 00:17:37 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id f23sm9279588ejb.101.2021.06.15.00.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 00:17:37 -0700 (PDT)
Subject: Re: [PATCH] NFC: nxp-nci: remove unnecessary labels
To:     samirweng1979 <samirweng1979@163.com>, charles.gorand@effinnov.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20210615015256.13944-1-samirweng1979@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6129efc3-fe4f-8b09-22cd-3d17354e1c7a@canonical.com>
Date:   Tue, 15 Jun 2021 09:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615015256.13944-1-samirweng1979@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2021 03:52, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> Some labels are meaningless, so we delete them and use the
> return statement instead of the goto statement.
> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
> ---
>  drivers/nfc/nxp-nci/core.c | 39 +++++++++++++--------------------------
>  1 file changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/nfc/nxp-nci/core.c b/drivers/nfc/nxp-nci/core.c
> index a0ce95a..2b0c723 100644
> --- a/drivers/nfc/nxp-nci/core.c
> +++ b/drivers/nfc/nxp-nci/core.c
> @@ -70,21 +70,16 @@ static int nxp_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
>  	struct nxp_nci_info *info = nci_get_drvdata(ndev);
>  	int r;
>  
> -	if (!info->phy_ops->write) {
> -		r = -ENOTSUPP;
> -		goto send_exit;
> -	}
> +	if (!info->phy_ops->write)
> +		return -EOPNOTSUPP;

You changed ENOTSUPP into EOPNOTSUPP, which unrelated to the patch. Make
it a separate patch with its own explanation.


Best regards,
Krzysztof
