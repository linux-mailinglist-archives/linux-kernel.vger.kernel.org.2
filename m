Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC96E4028C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbhIGM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:29:40 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37470
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344162AbhIGM3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:29:14 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 083854019A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017686;
        bh=i4ZGHX9mGJzs9Nqqb56NmrxFgegnuQrVd9flgc2QjQE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=CMoA7T5AT3W8FgDwmV59z5a/IP+M42qb0I/519Ep8p8kP2bXKUZ9zWj7kMOFd5zXU
         RsbIWVEnx1lF1HbUZWt2SoNhx8HhZ7jcqytiDsWTvnKYuxybQWhlswXZQ7ZTnFislE
         ndRU5mFqmH863GbGrTHJ6t2FeOV8ktBUFvbu49pmImGxNHBa28P3W4WGxk7kJp5LSJ
         f1IG5wg4F1j9/KPcwTZHeVWo55nPqDdTmtj9zzaYdqLE9lwsZxW2Mg5QyEtyo4ymd7
         jMqtzTbqgLKrYW58xZoqNR9D4T2g3qT6SXrSUe//v+/HL0E8hicUQKp2x5KUfNcgmw
         gWFE6SY519sQA==
Received: by mail-wm1-f72.google.com with SMTP id r4-20020a1c4404000000b002e728beb9fbso1114155wma.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i4ZGHX9mGJzs9Nqqb56NmrxFgegnuQrVd9flgc2QjQE=;
        b=jxbtfZcMsl+gG6qg1PScS1aPFaIicZiVUXFPOYQlA11k2xJgdAf2JQP6Q2gcjnbuhg
         x41ScovjOaUTjh6qKEZTPTSD6Ph2I2dDzSJmtG7n89n4EoZkJhlKP+IjtBqItlfJzk80
         wHJ7hKbKIFtahjNwbNOnxrtZvVClbZb3ci0yV1DJ+YerOqQ3aBYK0r6jwXMGlhMUxntq
         Hibivbg1OG2J5yPNYH/bh3DtJeFmeIg+cQVKQIFvKxYrzHMBNh5cIOui8lnuF4fcTFNH
         Q0dgVJh8bTA9iCWw7FQooLGncwD+Ttwfu188Ng59Afqcpmct1SWrd014OtYaXu3hEjLC
         9KLQ==
X-Gm-Message-State: AOAM533DRWhPX1Ali8LwMVppwkkQ1z2OhetHNdc+qlbKt6NvSwlqbOlu
        tj+eAVogv8e9etbtB1vWPb8z6w/fLAyeTJytszIazsbJVI1RqMHdywvo3Ayln/Op2/dMcXEiSgF
        v6U1/Lf9X+fRkxX6YMdubljW4+YpmUy3mwUNyTGpRRQ==
X-Received: by 2002:adf:9d45:: with SMTP id o5mr18367587wre.226.1631017685246;
        Tue, 07 Sep 2021 05:28:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxLSApf9aQAMF6rcSiRU6Die4JjL+/6CF8DzzLKlDlLHeOBw4SUW1cF3S2JUunqQGD5sLqZQ==
X-Received: by 2002:adf:9d45:: with SMTP id o5mr18367571wre.226.1631017685071;
        Tue, 07 Sep 2021 05:28:05 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id l7sm2333190wmj.9.2021.09.07.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:28:04 -0700 (PDT)
Subject: Re: [PATCH] clk: samsung: exynos4412-isp: Make use of the helper
 function devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210907085107.4203-1-caihuoqing@baidu.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2b378450-4ea5-e30f-750d-9e20bc1d113e@canonical.com>
Date:   Tue, 7 Sep 2021 14:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907085107.4203-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2021 10:51, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/clk/samsung/clk-exynos4412-isp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
