Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34F2357274
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354388AbhDGQzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:55:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48349 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347854AbhDGQzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:55:39 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUBSj-0004KA-8R
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 16:55:29 +0000
Received: by mail-wr1-f69.google.com with SMTP id u10so5753067wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8tc1z+Zb7AbxJopa6NWnwQSEHNIOQUVlOv43mlLfRg=;
        b=mAjtGfi4oz4HEO3GHctfmCHTy0d8q/qAwLxuZpd4WA+j49s0+NOxHUEbXLenbtzb7u
         hs0Y6kR6NIifGLTD0g+quXRMnVa17VWdGNebyFYfPgUTVNaXu8Z2U4DqI1fTMGTZE34M
         dd0dwl7YLPHIVSTUu0aXMD96IXoBvkiwitOT4miQc1Ye1FnyxfpSvG77zgVvvPZOO5dK
         QVGWDvd4a/BszNYkOdLh7O4MAGccwIOuSzVceSo+s14AgRHspLDKCW9R/L1rWTcxXQHx
         7iIIx/QFxwQwCUMuBroi9FxLPkM7KTF8D2OdS8IcErOVzPFlw36fXoUqUgvZQWo3rl9A
         r/FQ==
X-Gm-Message-State: AOAM5321zco+PJS0ynY3pXKevIxz8ev2n0N3fPmQsayGDh3vil8S+WFd
        PbmL181vbaAkyDdJ8WNoc6h9KMtqHVtiGEl1HQ5roVS0qPWjqRgEfFjoltg9VINxKaNIK8zXGkM
        I525vMRnsOOWOh7Oj0TGH3guQT+63eYwadcELUBb7aA==
X-Received: by 2002:adf:83e3:: with SMTP id 90mr5487450wre.153.1617814529040;
        Wed, 07 Apr 2021 09:55:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwERFh51xp45M2S6ot/dHXjHlp4ZeSuWNqmxrKD8vUxGDYwHLWs5JY0sh/0TZbZQBM0SehJTA==
X-Received: by 2002:adf:83e3:: with SMTP id 90mr5487443wre.153.1617814528921;
        Wed, 07 Apr 2021 09:55:28 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id j30sm44488457wrj.62.2021.04.07.09.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 09:55:28 -0700 (PDT)
Subject: Re: [PATCH] memory: atmel-sdramc: check of_device_get_match_data()
 return value
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210407154447.70540-1-krzysztof.kozlowski@canonical.com>
 <YG3boJNqAoNCBeIB@piout.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <57470934-d2db-a360-8347-4debe5830f7b@canonical.com>
Date:   Wed, 7 Apr 2021 18:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YG3boJNqAoNCBeIB@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2021 18:19, Alexandre Belloni wrote:
> Hi,
> 
> On 07/04/2021 17:44:47+0200, Krzysztof Kozlowski wrote:
>> If the driver is probed, the of_device_get_match_data() should not
>> return NULL, however for sanity check its return value.
>>
> 
> As you say, there is no way this will ever be the case, I don't see the
> point of checking the return value, this adds 12 bytes for nothing...
> 
> Maybe coverity should be fixed as there are many drivers making the same
> (true) assumption and I don't think this is worth the churn.

There are also several drivers having this check. To me an explicit NULL
check is better and more readable than non-obvious assumption that the
of_device_id table contains data for each entry and there is no other
bind method (like for OF+I2C drivers). Even if the case is not real,
this is nice, simple and explicit code.

Best regards,
Krzysztof
