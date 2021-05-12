Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E16037BC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhELLtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:49:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55341 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhELLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:49:07 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgnLL-0007XC-37
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 11:47:59 +0000
Received: by mail-vs1-f72.google.com with SMTP id f5-20020a67e0850000b0290226ef8b7beaso11025898vsl.17
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sN7PtoHpAWooHK+Hak2qRw9IZrK7ofjQa8fGIcLObj0=;
        b=tw40slnYYwROM/NLgV6AVMskcQSRsefW8N6f+++NMFQRGNIWHQxvAw3ThMGP4RNtLs
         lpg01mZeC/EZsIZTD2/q6aUCpCTlzxA6bwMWdN+kVjeJktwRla45O6rESBLd5y4+pzil
         uaQzwNf91KyIGTTjAOAZBUBtOkZS30+6ES5/0Xw6m13Y3i+BGrNl7fLoRb1OlYnp7NlD
         vBp893JAT8tFcnMKjJmO7Pfi9qN1suepkSOASVN2ECe0lyVo9L4c4zDHy8+9cA7KwN0+
         +LlpVSzQxEhneAZwUjkN5BZxpyfXIgeZPwqt5bl3RGf9I1UIaJXNQ2wVRc2+YOnAfHcu
         DP5w==
X-Gm-Message-State: AOAM533GhsMdtPsm6hQ6vHeOPRzjzDXy5cD+R3wRVnl+/UUTfCd+MTpX
        J5vFcoutMBYXUxvBPeo4YUO0jS9QOG4nmYDZ2T5qUH8abW9CcJMFLUUJvat18v6REnTnD3bhpjJ
        f+0GtGW/gs6JZjwvzpCI05ybVvrdO+g85MZFyVbIsTw==
X-Received: by 2002:a67:f711:: with SMTP id m17mr30783347vso.48.1620820077541;
        Wed, 12 May 2021 04:47:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwksI2M5eF6imGkWUMuv300ZLIoqSlW1tFTiuy4A0nPCinGiT3xU2/fyB/FUwODB95ZTVpBBw==
X-Received: by 2002:a67:f711:: with SMTP id m17mr30783336vso.48.1620820077401;
        Wed, 12 May 2021 04:47:57 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id h129sm2811832vkb.36.2021.05.12.04.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 04:47:56 -0700 (PDT)
Subject: Re: [PATCH -next] memory: da8xx-ddrctl: add missing
 MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>
Cc:     linux-kernel@vger.kernel.org
References: <1620788887-14812-1-git-send-email-zou_wei@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ddb6a020-1a76-c91c-23d3-754641cb3af0@canonical.com>
Date:   Wed, 12 May 2021 07:47:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1620788887-14812-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2021 23:08, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Thanks for the patch. Can you confirm that driver can be built as module?

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>

Please make the reports public. This is open source work and public
collaboration.


Best regards,
Krzysztof
