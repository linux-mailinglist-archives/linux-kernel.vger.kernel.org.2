Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8D3F4B46
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhHWNCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:02:17 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59550
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232574AbhHWNCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:02:16 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6963E4075D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629723686;
        bh=bXkGCqtvY0F/OQ6BUe/BzGmpK94bPbWfXt2pwHY+QOA=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=mn+0ynLct6gx6ycqQ2EigmzJtdoG5En6fvQimbRRM8R1PhjA2BJsHiMfdBUh68aYF
         VluTY398+NqJmgSUTgrkd9l+JMycnlCuzKGe7nWHA5CcVXKURklH7YbbiY51n90LFH
         MZW1Gnr5QWErvdtPeH3EcZnc7PN8q9jx/k4AqEtD11rzg0Bipefn/Rayjg4ZPCDfQo
         149/wZdODGSdSP6QuYoDqk8KB5YekXfi2W4ywXavG9PudV4qKxNubNFa9Z0BnjIikp
         DjM37DHh/jDx2gN3Wf05R//x6bs2Vi/2uiZb0awOUrMzEAxxKNOLFQ8HsdpxRd3/V0
         b9wy3dXPnkuZA==
Received: by mail-ej1-f71.google.com with SMTP id gb24-20020a170907961800b005c158d37301so4656778ejc.17
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 06:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bXkGCqtvY0F/OQ6BUe/BzGmpK94bPbWfXt2pwHY+QOA=;
        b=s5GhccGpf+hQR9CJuaVy9fYgTYRnzAVe1e4QxTZ/ileWelsLin2q654PKc7yt+8CYR
         ciijkK2XY6eJlwRislSYztruwZPa53r2V34AfIUUFXRbn294xbWIDAXbLu+4ce/25c09
         uWKBRg7hf4c5YSvhK8PyHTgZoMquNWf9lYdZZlE2Hy0WN4sR2Qg1+rR4cfxgg3wYQq9G
         fnNh+CbM9A2aqtKCZV8gOwtDxi6fIwJNX/zdht4bTWLqgLM/zZ21VnT7i6SpL26Ct+JC
         sRVNMmtWAKpxtLMhv4ESN7HPv+ZpcXSCMa+l747ZVDvJmlqCOGvlGRLmaG7ClUDMIAkD
         PKCg==
X-Gm-Message-State: AOAM530wBPo7ZZ/sKjkjF3L4459WTB0GUAmIHWljHuAqyZ24m1+edxaY
        3f/dfWXjO4LqvKSerHp6V5LKFKxAQh7u/tDn/aHLetcZV/3/gBQNpeMWBxQ11+R+APAmcXhWSxB
        /lOFPEVuR7F2VS7f2ylMzmy4E7zMqgtdqxXOTYvoP2g==
X-Received: by 2002:a05:6402:215:: with SMTP id t21mr37335825edv.68.1629723686116;
        Mon, 23 Aug 2021 06:01:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVe1yRG3pXDBmm8bDXRAT26QFNnhpDQ2os313ngE5+KPCq92HjYwBYYguRX4mqHao+kcopvQ==
X-Received: by 2002:a05:6402:215:: with SMTP id t21mr37335812edv.68.1629723685961;
        Mon, 23 Aug 2021 06:01:25 -0700 (PDT)
Received: from [192.168.0.101] ([79.98.114.219])
        by smtp.gmail.com with ESMTPSA id j22sm7579280ejt.11.2021.08.23.06.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 06:01:25 -0700 (PDT)
Subject: Re: [PATCH] arm64: defconfig: drop obsolete ARCH_* configs
To:     Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        wanghaibin.wang@huawei.com, Arnd Bergmann <arnd@arndb.de>
References: <20210821030519.127-1-yuzenghui@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <39c2b2f9-4de2-8e7d-2135-96f1dab750e0@canonical.com>
Date:   Mon, 23 Aug 2021 15:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210821030519.127-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2021 05:05, Zenghui Yu wrote:
> Per commit 4a9a1a5602d8 ("arm64: socfpga: merge Agilex and N5X into
> ARCH_INTEL_SOCFPGA") and commit 89d4f98ae90d ("ARM: remove zte zx
> platform"), they can be dropped from defconfig now.
> 
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  arch/arm64/configs/defconfig | 3 ---
>  1 file changed, 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
