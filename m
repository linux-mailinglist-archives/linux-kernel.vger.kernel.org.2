Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E283A45EA75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376386AbhKZJiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:38:03 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:32994
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233187AbhKZJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:36:02 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8EDCA3F1B7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637919168;
        bh=g8p9caKWVfezbBLp8CApTokNGzRIolp+56D1QwZhKNQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZWzpkbgF4xQG2cjiQ8BjGjALE30wUJLqexjr6Ymyl/CMADKztcZJo6v6M3ojDhUgK
         kffoXRLVmmo0HGiIkHVqfZHMgEjEoUh4YaescuuuIMPbb/NK4p0Q/1zPClW7Ejpn0T
         G0SlueM/8ER7mYdh87MY893cqYSlzZp/yXvawezSMOUOKnMdUEDRdPn9GjrvHIRe1Y
         Cje+Mygbm6Nho08k9Z6oEU8zjN3/6n41LS4aWq03zGC6J64c+e0CiwnYIpUwj/KBjK
         nRRGCilI9tGOq/CI0wyyfUflaV9ct3b4VfKzc0sNO7wzEvWVVMtjo7Vj8CwBCsf8zd
         BL2O9xsZWaKNw==
Received: by mail-lf1-f72.google.com with SMTP id bi30-20020a0565120e9e00b00415d0e471e0so3935226lfb.19
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g8p9caKWVfezbBLp8CApTokNGzRIolp+56D1QwZhKNQ=;
        b=qnbIcIQhuJevvm+yPcZT1XJjlxBMf/yTovRWXBgkFPuWF1rHOKfnmu3DjJH+IgYleo
         17onbv10x6Nv8rh13anAW9hI66/La0a8SqRVTk/psFJnn6blayhzUvsnsy0ioAddtg0h
         Nbb84cTua571+8kThZchWnQl6DMd/SI7TrpZqMq4KC8HZsCDRJWHZss8zYmflUQRwVeB
         Q53O7g4lJvENXmi51+P70DqTvYYzonHhdou53ADekDxX0iLGeGGIX9PRiJ5qQI10FCUp
         H/HA1nfm46HqJ0GyvN5JMdO0p4fB000wuvxI62WsudXT55UUgKDRn+AsdGv0HN4NqtHQ
         gmUA==
X-Gm-Message-State: AOAM533ddMcPLgLqWmvR0swGAPV/2xa3xXU8BCR5aUEI0zhW2js6JVdc
        NdGstgnliVQQWal2KRwePyHa7OVmwJokfYmFsdQipLjvwqneFhmgG37VJHA4ai5wX7Gms4/i5PO
        4gmqFU1XplgYUvvqRTTw3Y9HRc5cpLmweoexWJvxjVQ==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr30309840ljw.71.1637919168008;
        Fri, 26 Nov 2021 01:32:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0YH7ltvScZXrG5ipSSXYBA/tyIwYumCJjNqwJFxZQQT/vSCsQJ+7cWHw0jjG4LYWatMPr/g==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr30309830ljw.71.1637919167849;
        Fri, 26 Nov 2021 01:32:47 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v2sm453208ljg.46.2021.11.26.01.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 01:32:47 -0800 (PST)
Message-ID: <05cd26eb-8510-d566-7503-c66ac9b54919@canonical.com>
Date:   Fri, 26 Nov 2021 10:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] nfc: fdp: Merge the same judgment
Content-Language: en-US
To:     samirweng1979 <samirweng1979@163.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20211126013130.27112-1-samirweng1979@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211126013130.27112-1-samirweng1979@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 02:31, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> Combine two judgments that return the same value
> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
> ---
>  drivers/nfc/fdp/i2c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
