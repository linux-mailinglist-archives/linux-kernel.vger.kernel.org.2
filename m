Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8F358997
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhDHQWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:22:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35959 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhDHQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:22:08 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUXPo-00055c-4f
        for linux-kernel@vger.kernel.org; Thu, 08 Apr 2021 16:21:56 +0000
Received: by mail-wr1-f70.google.com with SMTP id e9so1211859wrg.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9mniXimsxRbXR5uC0L5WVy4JZkTyuKDjQ5Fp74xwm0=;
        b=O5It233Ulu9G4cPPVZjaaIgfZB4Z/LE6jiU0TK6nr2eKlSAEWUecq9e5KEhZ1paxt9
         q8dev6W+y8YpC5gPQSiXV3n69RTRVmspg4YJA4Fts8OQ6VNe5tKRQ1+GL6OT/a/cvFhY
         I9Il5drgYAH2p8KAjHLyN198NYTKu1P2mm6PXeMfpyl4bxfhaCSZ+eLnH/6QQRafiU45
         v4RtiDR4WuZyxlaRSPReaXR2pzc5RxzgxQ53zAFLdRFzWZVxKjl0DLIML7CSpLD+E+Pk
         4C4oK+bJs9SCPOCsrPS+i4Zjj/wMUplgO2FyqIOX49DfRtN2Xv6EdNrzCkrhUQd/d7Uw
         7NEw==
X-Gm-Message-State: AOAM530IIxxZT2wcUy+jFMyChxBuv0Y2yS5FQkn/YC1aN2n7hkAOZOhN
        m4PAQ0szhmTGuq/1aCs0x++qdIzkqc8DDL5DbRD/X97Jy/jSfP3ny3NZgS4qM3hn0Hx6mWczRug
        roZTkFH+10LgLtr6rOwhrGBRW5XySR00km83gDKWxAQ==
X-Received: by 2002:adf:a703:: with SMTP id c3mr12682389wrd.72.1617898915302;
        Thu, 08 Apr 2021 09:21:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx85JGaBfMcW8iSqNB+8yrW6b15Le1JKi24IwDgmyt4YYURPyZi/eFCaTQYOx8+u6H0Y9nHAQ==
X-Received: by 2002:adf:a703:: with SMTP id c3mr12682357wrd.72.1617898915096;
        Thu, 08 Apr 2021 09:21:55 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id r5sm10950737wrx.87.2021.04.08.09.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 09:21:54 -0700 (PDT)
Subject: Re: [PATCH -next] clk: samsung: Remove redundant dev_err calls
To:     Chen Hui <clare.chenhui@huawei.com>, s.nawrocki@samsung.com,
        tomasz.figa@gmail.com, cw00.choi@samsung.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210408134856.207305-1-clare.chenhui@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <38c703df-2bfc-6492-ab2f-344ffc2647a1@canonical.com>
Date:   Thu, 8 Apr 2021 18:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210408134856.207305-1-clare.chenhui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2021 15:48, Chen Hui wrote:
> There is error message within devm_ioremap_resource
> already, so remove the dev_err calls to avoid redundant
> error messages.
> 
> Signed-off-by: Chen Hui <clare.chenhui@huawei.com>
> ---
>  drivers/clk/samsung/clk-exynos4412-isp.c | 4 +---
>  drivers/clk/samsung/clk-s5pv210-audss.c  | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
