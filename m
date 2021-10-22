Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC884373F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 10:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhJVIxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 04:53:06 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57670
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232310AbhJVIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:53:05 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0E05440003
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634892647;
        bh=rhThjc69gD8klHJ2HlQUvp1F029DaZ1HD6bgaTLsMRM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=kjRf84sUCnRUZmlj/f8iSgRZmHWoL8cUlihi5tfk9QIP8BxPxeL7QB1pxNqpnBJmc
         Teo7UQHZTJEwest3iYaq07jMqLprxn4Jbj66Z2//e+LcezA46FON5L2uPuQ4bbekh/
         Nn018iHLXBmnHnPsVyCiEAVrtN0ot3QpKGRvQHmLr6bhhH0CSRV5ZpeDYkNyUis6wX
         VyiDFYpzf6zQfFLx0wRNCCjaodolaJrc7AGwjx8iImw6iNiPUxdUw686bi7sGRP/8j
         xmL+3tioqm/6RwGO3Nv+qCjLg/GG5WJhBF5cAuzIDYu9tGPHazkXpBN/cZm3Ae4iRy
         7g0IpQM6oiSlQ==
Received: by mail-lf1-f72.google.com with SMTP id br42-20020a056512402a00b003fd94a74905so1447162lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 01:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rhThjc69gD8klHJ2HlQUvp1F029DaZ1HD6bgaTLsMRM=;
        b=cvtYwGHIBXHk7cEq+m7STKa+x8DLuPNoXt+B2bq6KEWhVPYlasIOVyTx8B9QsSJjtK
         YdxYe2+Nzc0WBFiKjWPIes3s/FE/g8MecI/wC54s/efF7PuuOhyObkQaKQLOdgffA/ET
         RZMtvMKFHyKspMbq9N2MbQdgmwprT9XyLXMlJ6halVrUaMw9OZz8Mok7M15BQY7rZ2+Q
         XExuf8LkqSCPdE/Yfe8x+K6pjfjg/aDtwn5dTP1G59P7Ts3tjELXPqhXw4+vInXtVR2t
         Oylb8YDbVCtupfxX+2QGca8acfSEjbGVtA+zMNSbIE2tBvAciM4vLVBiF83kEwStjoB/
         oGKw==
X-Gm-Message-State: AOAM533PfPTM2S65TQusnPXM6FKinzhbDv5acZrslA+x5BRfOJj9313b
        QagcDuKyNj4VY4x8+fP3P5zyX+IAemqGHcRaQjM8SfsaHoS+dW4ouXsS3Qj1TihZjcpFoZiJZbZ
        CjHJ7IBQKlHe3YH8/TGjYmM8Fq9Trnf/LL/2N4LZi/g==
X-Received: by 2002:a2e:a164:: with SMTP id u4mr11573071ljl.195.1634892646411;
        Fri, 22 Oct 2021 01:50:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7R2BPnrUquhReFpj1fTuRbmb5kq31vlb03XMGyoObg+X2rVNUTOXDvu/rTk7lDl+ktmirmg==
X-Received: by 2002:a2e:a164:: with SMTP id u4mr11573048ljl.195.1634892646143;
        Fri, 22 Oct 2021 01:50:46 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id q24sm673300lfr.138.2021.10.22.01.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 01:50:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: clock: samsung: Document Exynos850
 CMU_APM
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20211021203152.29312-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <59a5cf03-fbf4-7003-4309-e9e5b63112a9@canonical.com>
Date:   Fri, 22 Oct 2021 10:50:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021203152.29312-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2021 22:31, Sam Protsenko wrote:
> CMU_APM generates clocks for APM IP-core (Active Power Management). In
> particular it generates RTC clocks, which are needed to enable rtc-s3c
> driver on Exynos850 SoC.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../clock/samsung,exynos850-clock.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
