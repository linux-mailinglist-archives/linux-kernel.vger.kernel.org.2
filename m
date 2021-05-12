Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A673337CB96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 18:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbhELQgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:36:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33403 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbhELPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:44:26 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgr12-0001ox-Mz
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 15:43:16 +0000
Received: by mail-ua1-f69.google.com with SMTP id g10-20020ab039ca0000b02901f7b6d6a473so3180958uaw.17
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9U0ez24YYqRM0bUzj0cJkOD9iTgQukzTFGowhKKRb/U=;
        b=fnUWmEksa3/WC16qWmGOa6R/Tk4PUipg/fuXOiwb3vEUTkrGJ2+k2dl6wunZpHf4HK
         OFyEGBqlWsWMvniYBni2QRsBvZjxdqZ3QPdMLcf1xHuPwfVpd7RdNhwzwHz0YmYD/k6B
         ujh7JDP5xOv3UxRg5UpqKljTIduKy6uSzOQ8UbdZYSgx9JuH7B3q3R/R6JfURlsh95pd
         5BGM4nKVV3/USIj7LXU/i2liaDLkoBs8I0pG4kjkhVPd9fBXnZ+nELxL/Kk9s/3LavGF
         LVchcIka+DM32uNORm/1KmztEp0H8U/4fCPx0N+q1MjfZ1z+6Bfpyr4beh9NApvOtbjH
         L3Og==
X-Gm-Message-State: AOAM533iDGI96qHTA1Clr4EHvWeG77A00oWv0jSGta3DCjOaUrIMOaZK
        I4Dsv8LyKN7JTVryOn2T4Pgk/Mj8sxoyCvl85Dpkys4pvca2AIVhR+kNNZ6IeoDipjmhZoWSiCo
        drgkJjyo/f7mu2w3cjecNm/61EhRVuqeOIPs0pxY1SQ==
X-Received: by 2002:a67:ad03:: with SMTP id t3mr31669271vsl.23.1620834195896;
        Wed, 12 May 2021 08:43:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzirDmtdNmCE1i/o7cAXop5KOBGCC9s59JF+LWGQbuCR2/27ZEYoKsxnLq0Jfq3DW++gYpelg==
X-Received: by 2002:a67:ad03:: with SMTP id t3mr31669254vsl.23.1620834195759;
        Wed, 12 May 2021 08:43:15 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id d12sm31183vsc.8.2021.05.12.08.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 08:43:15 -0700 (PDT)
Subject: Re: [linux-nfc] [PATCH 1/2] MAINTAINERS: nfc: add Krzysztof Kozlowski
 as maintainer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-nfc@lists.01.org
References: <20210512144319.30852-1-krzysztof.kozlowski@canonical.com>
 <961dc9c5-0eb0-586c-5e70-b21ca2f8e6f3@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d498c949-3b1e-edaa-81ed-60573cfb6ee9@canonical.com>
Date:   Wed, 12 May 2021 11:43:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <961dc9c5-0eb0-586c-5e70-b21ca2f8e6f3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2021 11:11, Daniel Lezcano wrote:
> On 12/05/2021 16:43, Krzysztof Kozlowski wrote:
>> The NFC subsystem is orphaned.  I am happy to spend some cycles to
>> review the patches, send pull requests and in general keep the NFC
>> subsystem running.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> ---
>>
>> I admit I don't have big experience in NFC part but this will be nice
>> opportunity to learn something new. 
> 
> NFC has been lost in the limbos since a while. Good to see someone
> volunteering to take care of it.
> 
> May I suggest to create a simple nfc reading program in the 'tools'
> directory (could be a training exercise ;)
> 

Noted, thanks. I also need to get a simple hardware dongle for this....


Best regards,
Krzysztof
