Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C051039194B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhEZN5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:57:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58852 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhEZN5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:57:35 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llu0x-00065U-95
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 13:56:03 +0000
Received: by mail-ua1-f71.google.com with SMTP id o7-20020ab01e870000b029020d37e3e144so824240uak.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gZn8h8gkilkZaN7gS01tsrUP7HzVUTqYj/r9HNxu8z0=;
        b=EVHA4OZo7C//aZzcjCslPrP6Y0SAJyWdN+P/rx6cvaxUj7f6oBfY7TpvJis7NPtt3f
         vQguNwF9MGb7fDclBBN47h63ohAW2lQc6abifjI7+UBEPmmxtsnGvSSYbq8PsDfzlSR8
         q+SDam2lG2TklNRldWL9MfeLPvV3pozgPbua3OtKQqchPfseicCswVjj7PlPNPznLIAm
         QILphMIXSbFXyuskhUWlOqmVztfWp2f/T0suIZ7580CBLkZHnrhQaS6QKim07sTfcHS/
         UFWSM9+DrT4KcG3gxWzunIK8m/rgp1qsCP+SUDnHXjYCEmf9PisyNuX+9FV95xWPAwNr
         m87w==
X-Gm-Message-State: AOAM533KhirZg06XitGGRJVrBH0P7mDvvJXVxj1g/M6ApL0B5iHgwPcz
        qdtBNUY2bDkfiaUZKPn0iTrFEb8LaoITTMMfE9m735liL4GTUXRRaVH502Ku9Q0eo3P0qzvjVn8
        dox99yJkOlFpwa0hnb5uGX8SYBAHyj8IU46bJrg/0Sw==
X-Received: by 2002:ab0:14ce:: with SMTP id f14mr32867637uae.50.1622037362157;
        Wed, 26 May 2021 06:56:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJtF7d3KZ3MenrDN2pRpX/m5oT/p1wrFd4tXmL69qgbesK0af5Jah5586fDe1vLhqceDDxUw==
X-Received: by 2002:ab0:14ce:: with SMTP id f14mr32867618uae.50.1622037362034;
        Wed, 26 May 2021 06:56:02 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id f6sm2100014vsh.31.2021.05.26.06.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 06:56:01 -0700 (PDT)
Subject: Re: [PATCH v2] nfc: st95hf: remove unnecessary assignment and label
To:     samirweng1979 <samirweng1979@163.com>, davem@davemloft.net,
        dinghao.liu@zju.edu.cn
Cc:     linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20210526005651.12652-1-samirweng1979@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1aecd37b-88e8-e00d-d0b1-2fd989514c19@canonical.com>
Date:   Wed, 26 May 2021 09:56:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526005651.12652-1-samirweng1979@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2021 20:56, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> In function st95hf_in_send_cmd, the variable rc is assigned then goto
> error label, which just returns rc, so we use return to replace it.
> Since error label only used once in the function, so we remove error label.
> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
> ---
>  drivers/nfc/st95hf/core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
