Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681D741329E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhIULgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:36:05 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40238
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhIULgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:36:03 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3730E3F320
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632224074;
        bh=zp2By6sGexWtGpbtuPzQQjvZBN+ptCF/Bgy4OAUD3Kc=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=nbSZ6FCbYI540AoED/pu7UBq5kv2JCsGDasSim1PWfOgMp5FlPNqwX/KzywwD0uf0
         +tzx/sXGSR1YJLyBGDEe+u/n6jShxas+5gb7B+i4nEDlFgc+Xs5wJPpMQki4PAMMlX
         whchkhQz87IbvCwrXjdxBBilsemLzkU448N1sVv13I2TlbgPsvf7GxQfDWNd+KNdrr
         wzgAH+16+ILPRR80D7zBwk2tBxiPW3V8p+XkR2/aE6CgRy7BRnZugvdVmlmH4s9YST
         1AlZ8gof/dX7jfFYr9R3CI3FZPV0KC+G3Z7disaRBcx8zBvJFfB67XQlCeOP4NGwOu
         O0Fhj9+sXOQuQ==
Received: by mail-wr1-f69.google.com with SMTP id h5-20020a5d6885000000b0015e21e37523so8549156wru.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 04:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zp2By6sGexWtGpbtuPzQQjvZBN+ptCF/Bgy4OAUD3Kc=;
        b=dxO8yGOUv3m7BT5WKaaQ53RrjvW1b44w4QNywRFOmhIFbj1P2NbZRZ1QMB2oGtH3ka
         6O/QWg1y58MKPxuEPvqe/Ao6aJPleGd9MKesnFP5Ogh9Ysvo1glKhjvlzw44Zh8JNCKC
         kcGxINGEp3hjv16h0ehqi+w+75Dk59ZIzzXzabKQ9lMQdQIOw+DK9Rl/hMDz++KvhWDx
         rsPFlshcsyZyggn8fBk8uZkNJIAVGb+75JS4ouozV9513iLkxcaf6F3DCB2/jf3rJ8MP
         CFtmn5xdmV9pKG/PettGthpyzVip8j1GjFbkW30/m0V2mzS1G/Q8eEE8cAZjdEJ7DRbw
         i1wg==
X-Gm-Message-State: AOAM530BhkYAGaZVu89unx0plrpx5dGwlB/V13XhARjS8Xkuh0TBGesu
        cJJ6J5GkRC7SsBoGurp/ntC24LPtryPzjRTy2hg1UYEK+7zSKUrJSQQ6dxpZ6sA/W22g5EzxPtX
        Up4X08P9LP4EQ69tQWaDdNJ1mwl48n2DSkG7kLFjHcQ==
X-Received: by 2002:a1c:2313:: with SMTP id j19mr3965531wmj.189.1632224073872;
        Tue, 21 Sep 2021 04:34:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykWXjszEYz06lQKp1hqKp6FQVhmCuATI+PXjITd/ZFG6FW/H9UPP+5M1aavL3U7syPXCMLjw==
X-Received: by 2002:a1c:2313:: with SMTP id j19mr3965511wmj.189.1632224073688;
        Tue, 21 Sep 2021 04:34:33 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id h18sm2630388wmq.23.2021.09.21.04.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 04:34:30 -0700 (PDT)
Subject: Re: [PATCH V1 1/3] dt-bindings: tegra: memory,bpmp-thermal: add SPDX
 license
To:     Bitan Biswas <bbiswas@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        rostedt@goodmis.org, mingo@redhat.com, jassisinghbrar@gmail.com,
        p.zabel@pengutronix.de
Cc:     skomatineni@nvidia.com, broonie@kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210921112716.3007-1-bbiswas@nvidia.com>
 <20210921112716.3007-2-bbiswas@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8c73dbc0-2678-9c9d-dc29-d4bece29fd08@canonical.com>
Date:   Tue, 21 Sep 2021 13:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210921112716.3007-2-bbiswas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2021 13:27, Bitan Biswas wrote:
> Add Dual licensing SPDX license identifier for tegra186,tegra194
> memory and bpmp-thermal headers.
> 
> Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
> ---
>  include/dt-bindings/memory/tegra186-mc.h            | 1 +
>  include/dt-bindings/memory/tegra194-mc.h            | 1 +
>  include/dt-bindings/thermal/tegra186-bpmp-thermal.h | 1 +
>  include/dt-bindings/thermal/tegra194-bpmp-thermal.h | 1 +
>  4 files changed, 4 insertions(+)
> 

Hi,

It seems you sent the same patchset twice.

Best regards,
Krzysztof
