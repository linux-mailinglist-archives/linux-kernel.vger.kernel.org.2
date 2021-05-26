Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28ED391956
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhEZN6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:58:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58860 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbhEZN55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:57:57 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llu1J-000672-H4
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 13:56:25 +0000
Received: by mail-ua1-f69.google.com with SMTP id x11-20020a9f2f0b0000b029020331a0ba74so796898uaj.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wk3UlUCfkCL6QN9YaFyZimOXVt4iG+84u/Humu+3uZw=;
        b=LLev60v8Jrto5OtFtbyMviDuZ9zdUFt0Pg+urt69R/aUeS5cXvRaxjGo5IDqW/TEjW
         mu2hbyrlOXQ35dufO6bgseN3J402pJEIiUaZqme01NKgsCRMq1G34RW9MSEQhTQgEE8q
         IHKy3NMs4UGqRlUFL++DZssyxQHir24D+ywRNKWBzxCFVcAPy+DSZRV4IneAzdjzvHrN
         tUSi0gEXEd/hSXpsyBbigxUNVsnT/D67PI5KDLanq3AROwhr2Ldi6SIBCTuwYwTYcTWB
         +xu2qmC2KZ31ccVzst/bYG4QUZ4q/Nsk7YEjAVnGiETNBwVOdyKO6fIt4QF57LLF2DRm
         +cCA==
X-Gm-Message-State: AOAM533H6o/jHjD54ceNEt0IbXUjuaVxLZk2LUTrMZyXxlb16cKydnVv
        9JdoNvSI+OX678HTseoloB8XXd68DgCiwnAYFzLmNwgug7LyHZYw4Sa7iNcbg2Ds17RwiY2Ndpl
        AWh7qRvlTAg7MPzulPHOsKoMlzkfpBpvCrM6efnmPLQ==
X-Received: by 2002:a67:b919:: with SMTP id q25mr31366092vsn.17.1622037384734;
        Wed, 26 May 2021 06:56:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxinuLNMn5s0odgmLxRBXmJbtLvoYFepINUvv6jG+v4e1LdZ3aCTN15rHZ6f5RTZ6en80fFWA==
X-Received: by 2002:a67:b919:: with SMTP id q25mr31366076vsn.17.1622037384616;
        Wed, 26 May 2021 06:56:24 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b26sm2113090vsh.23.2021.05.26.06.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 06:56:24 -0700 (PDT)
Subject: Re: [PATCH v2] nfc: st-nci: remove unnecessary labels
To:     samirweng1979 <samirweng1979@163.com>, davem@davemloft.net
Cc:     linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20210526011624.11204-1-samirweng1979@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <dcb14fe3-4907-43f6-d79f-27599f1be249@canonical.com>
Date:   Wed, 26 May 2021 09:56:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526011624.11204-1-samirweng1979@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2021 21:16, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> Some labels are only used once, so we delete them and use the
> return statement instead of the goto statement.
> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
> ---
>  drivers/nfc/st-nci/vendor_cmds.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
