Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA724428EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBH52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:57:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41642
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229970AbhKBH50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:57:26 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9F8183F19B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635839688;
        bh=4Q1Y0BuYXU05+hPK4q6hPb0RF1hAlypHgWsGwPyuE0s=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=W5ugj3bS2Cr6kGAVtpAs6hVRhklsviCnxTPSvjvQFek6pCVjHqJG7sazW7MDJU///
         Hs/+2JdrUwwQ99vim71bIwxApB5lEEFSjVw4PGAohSWcNYAXml8k+DyNIk2Qeeronl
         CA9E8HgKt7L9vPCl0p0uvV2lFrWorv6KtDYQGiXdk6OI7ISOUXbl9o9reVNxyH8SZ3
         ZjIsBcA77SFAPsCsjUtYGz0eNxsrCW0xutqGMNrtVkmKekC0r++aCLfuHSlXgHz/c0
         emSNRdcbisZaxyipmOOUrPsb8n5K5rI8wd8lHaElCrj2GP5KJYuM2+27IXL4tf9Uf0
         FdZywDewx+jmw==
Received: by mail-lf1-f69.google.com with SMTP id l30-20020ac2555e000000b0040017981499so1424542lfk.18
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 00:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4Q1Y0BuYXU05+hPK4q6hPb0RF1hAlypHgWsGwPyuE0s=;
        b=FnybzoC90hcmATDmOgBkp97lWJXs+L660yqQNG+enEMd5lPZrSHhDNP1hs4+hGGEbu
         9A0hapK3yYTl/2/WYBVPOJMTsgona2yhVh2bqVTW8to4UMqJlQg8Kk+aeWDTRthhN9yl
         a+6R/H+GOboUra/Fh2cfwTf/ysMKNm7FGRUxpnvSHhq1moJ1yqSh3sEXKsmF1tDZO7rm
         +nVBeL56aZ/+lDEvt21M/Gz8DTRAZO/CPMqqoBu6f5Zb8fvssGCeK6pkhiljZtRJ7C6P
         RjgRDyRO2iITJmHDTZWp+vnCuSyP+gjAV4GeUJ3dzIsHpLNDqcNWv/pfXZKnD2pECp3R
         4J5Q==
X-Gm-Message-State: AOAM532gXHbwfIxz6TpQ0M8M+PyaUm3lF74MZBqks/va2PhNLvfGgPBm
        bVuSPpMzsjRtkqhk+q581xXtIgkZXW5zwv6vI8u6rgXs+l2T8WRelOgCUFxgUh73sOWumlUzu52
        7w56BeOiqEn0iXOHRCz4BnGs4oE1Etxc4rvynT57g2Q==
X-Received: by 2002:a05:6512:261f:: with SMTP id bt31mr32904700lfb.506.1635839688077;
        Tue, 02 Nov 2021 00:54:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpCtnalkc4ewJgOZ8jNvTqGQeg7JyKY8a/esOKd4OiqAouRCl2gjeeTfihtcGa/3mzNNQClg==
X-Received: by 2002:a05:6512:261f:: with SMTP id bt31mr32904689lfb.506.1635839687935;
        Tue, 02 Nov 2021 00:54:47 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f6sm145791ljk.45.2021.11.02.00.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 00:54:47 -0700 (PDT)
Message-ID: <db17495d-7130-e418-23f7-3c613243fe1c@canonical.com>
Date:   Tue, 2 Nov 2021 08:54:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
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

Looks good, thanks. I'll take it after the merge window.

Best regards,
Krzysztof
