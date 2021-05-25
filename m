Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1581F39003A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhEYLoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:44:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48875 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhEYLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:44:08 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llVSG-0006jZ-5U
        for linux-kernel@vger.kernel.org; Tue, 25 May 2021 11:42:36 +0000
Received: by mail-ua1-f71.google.com with SMTP id n10-20020a9f3eca0000b029020c98b1ea68so12969188uaj.18
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 04:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VXjoVJRWk5TrrriWnFtDbtKUT3FPojwGMjJKb1jQu0A=;
        b=Xj11yZffRM3VGpsccMG3tv5K1Bf2ZVXBEQTAl7SJyhyDjtDXXGkBNIfLEK5XT855oV
         q4pDlAA2POoE+Ar1sadSORpvKVMvAtSMqlhAoQWS2jqpP/IHRMpr4jCDlDalSImojqJM
         lxVSbUUVS5itdET5HutxQbrWNzPOwWJmvlw3nBWeQGt3qb7vbQR+06R8K8QBBQgi/Sn7
         F6wietgEkN0NWL75TFXzukoRVz91t/6fAN0lZ1piXfgeAZyO3zc1nmOB+/FzKhCmsD5J
         /mVUjhGLVaIhe1NGnNNfD9XY0Lk6xO1PWaJJqOvxsdhRxyhUkluIPjix4k8VHa2tmWZa
         NieA==
X-Gm-Message-State: AOAM531udGVROPrYSy273o7HoTeH4pNAVQOsZa8a9Yt97Ymz2DdL595w
        mXPo0jzIVNhsES/p9ip9gz8TcPPbC64RYVq2DsyOw5d0YEBAJK4G2jkxk7wgDmW7Yqtt63vaX8Z
        iyZWfGrU+T0gfkVj+eA7zx8HvWXH/guFr/Uu4itxJ4g==
X-Received: by 2002:a67:386:: with SMTP id 128mr25118096vsd.16.1621942955041;
        Tue, 25 May 2021 04:42:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhH2Oy6U2MwqDvTIgHPfHj+dUj4sa4mqqqYZABnajBnsS6pfEVpV2mlZePB62r/vU58NqBIQ==
X-Received: by 2002:a67:386:: with SMTP id 128mr25118092vsd.16.1621942954888;
        Tue, 25 May 2021 04:42:34 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.1])
        by smtp.gmail.com with ESMTPSA id b26sm1555470vsh.23.2021.05.25.04.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 04:42:34 -0700 (PDT)
Subject: Re: [PATCH] nfc: st-nci: remove unnecessary labels
To:     samirweng1979 <samirweng1979@163.com>, davem@davemloft.net
Cc:     linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20210525031254.12196-1-samirweng1979@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <93e67699-a0c4-7fe7-6c38-aeff68a3881f@canonical.com>
Date:   Tue, 25 May 2021 07:42:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525031254.12196-1-samirweng1979@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2021 23:12, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> In some functions, use goto exit statement, which just return r.

This is not parseable. Imperative "use goto" suggest that it's the
change you make.

> and exit label only used once in each funciton, so we use return

Every sentence in English starts with capital letter. They however
cannto start with "and" because it joins two parts of sentences.

s/funciton/use the spellcheck please/

The code looks good, but please spend some time to make the description
understandable. You can also make it very short, to avoid complicated
sentences. Look for examples in Linux kernel how other people wrote it.


Best regards,
Krzysztof
