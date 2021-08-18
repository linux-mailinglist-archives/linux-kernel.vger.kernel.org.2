Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7813F0CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhHRUmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:42:20 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52068
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhHRUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:42:19 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 52E6E3F044
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629319303;
        bh=UOE20OlnZGDBI1w8hzaIpuPN6xfmK8WguChjFrKnZuU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=AMPMxxlzH93EbqKkvvLs1/DuQFC7yPashajwqCWDTb5Z9STiD2KQD41p3+feaJbPp
         /cavtIUhM2VD1MxPW7G9Pv9TOz0eUjj1uCFo4t/f6c0z0V4e7J1eWINFZGX4DmGZwg
         /V9g9bFGwUVunKivZPtwf+GOK3tvuP0OLH7ybfssKcqx9c51xRFTvCHxFn73IFxyHJ
         xCOGkA/NksndsMW8fZQ6Abiu+eVTqGyJJ3lttmpJQ6IDjMTDMSWp5pOczdmsfKLXsn
         elTPpgn1cjxoz4n6IVIyL+lyUFHLky2PUsVs/GC/3m11yuONC2thZ7mTLXMiewr1Vx
         WFBrpiBsD0KsA==
Received: by mail-ed1-f71.google.com with SMTP id b25-20020a05640202d9b02903be7281a80cso1674146edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UOE20OlnZGDBI1w8hzaIpuPN6xfmK8WguChjFrKnZuU=;
        b=InOUtfxyyHQjwrd6fUFLRJL5N/y4BzbEhPs5KqEP7zUnca0N4tLsITnFMxncNSz/ou
         AHV0FUmTJkNN5H/5hkmPGbGy99OpTGAe9MilWe3QiIplkxuPiURmwolUXEZJPcdOhvdk
         g/+6683Gdj/8YY6xWLpuqoZs2LjKVTDZRqyosZSMaqmh9kLuSMJtpQFX7c2VJKrQREPG
         fpw3ALDKDHTD2iV+SJmeGx7wFo+KAUtKnfYdiz72CE66Jtoaqj2ouIo4ToO9ViD1id+U
         TQ7zs0L32LLUjYUrerJQOv/jc+Dq6T+niYSB0BmLujazm0fl1evX9lA/mBQ13BvgZp1l
         LSHg==
X-Gm-Message-State: AOAM53146KRbSIFpd06EUa9sz+9EUTp59t+f7u7qocF1D2vGXWZigXml
        Ooa2l7hesEUtDdgyy7wzDdY8F0bWX3qpe5divMpVlvBqT2gTsixrdvaQX4EfYISr1vOVouESY8Y
        o8FEohpB6qz3qpAe4wuwH55bZuNPTxMF18x97eWVt6g==
X-Received: by 2002:a17:906:bc81:: with SMTP id lv1mr11590280ejb.393.1629319303109;
        Wed, 18 Aug 2021 13:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuYU3uP7y//yQFosQFGT8VE96LJF4E5eKGo52ons6ugHXq2GC+IHUQY+3g7aV0U22I95MmCg==
X-Received: by 2002:a17:906:bc81:: with SMTP id lv1mr11590254ejb.393.1629319302920;
        Wed, 18 Aug 2021 13:41:42 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id kv4sm360228ejc.35.2021.08.18.13.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 13:41:42 -0700 (PDT)
Subject: Re: [PATCH v3 00/13] MT8195 SMI support
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com,
        Ikjoon Jang <ikjn@chromium.org>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1a160afd-ceeb-04a3-8213-fe781ec18e30@canonical.com>
Date:   Wed, 18 Aug 2021 22:41:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810080859.29511-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2021 10:08, Yong Wu wrote:
> This patchset mainly adds SMI support for mt8195.
> 
> Comparing with the previous version, add two new functions:
> a) add smi sub common
> b) add initial setting for smi-common and smi-larb.
> 
> Change note:
> v3:1) In the dt-binding:
>        a. Change mediatek,smi type from phandle-array to phandle from Rob.
>        b. Add a new bool property (mediatek,smi_sub_common)
>           to indicate if this is smi-sub-common.
>    2) Change the clock using bulk parting.
>       keep the smi-common's has_gals flag. more strict.
>    3) More comment about larb initial setting.
>    4) Add a maintain patch

The patchset looks good to me but I saw now comments from Rob, so I
expect a resend. Therefore there is also time for additional review -
maybe continued by Ikjoon Jang?

If you sent a v4 with fixes rather soon and get ack from Rob, I could
still try to get it into next merge window. After this weekend I won't
be taking patches for this cycle and it will wait for the merge window
to finish.


Best regards,
Krzysztof
