Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3E645FED2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 14:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355100AbhK0NX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 08:23:56 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44068
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354931AbhK0NVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 08:21:55 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D00EA40749
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638019119;
        bh=XlNC1VCy2s9y66a1+PddNrIyqziFzmje/wU1Hvd5Nh0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=efESBC0EAwon/eGEgVisqN6nJDi2sBoysuAFRJDYHKX+fCg+OFpvTcNCZAZFauJRR
         FBsK3IK/MG69S+oFlV2rCsIVz9f712vYs0anwYjaTk5wctDDy48fwUmXp5Wp/Dwnyw
         29CrnIBxm+ZbxubleHn/Q8ffVhbZMItLcTxLfJkk5eftLyZ5UfDcWdWFy4KqE7Dje7
         qB3WO8tVKDQAYr5La06ox6jgVhwxYaV+2cA221hbKpgK5GqFgU1XNp5Hr0Qjk9oqFi
         cMKHHwjtf1hDFwZ53EyDK72W3yiu8Cd/03zvLn8I5yKQpBhXEk2psIveF9JIN1aJl2
         ++gjpJX88Rl/w==
Received: by mail-wm1-f69.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso6697171wmd.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 05:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XlNC1VCy2s9y66a1+PddNrIyqziFzmje/wU1Hvd5Nh0=;
        b=u+HlASVvzTsa8IwBDeTkOiKUQHj7GOTI5p5i1LQo1i+nTfbwGymfBZUaI5VGAXsTly
         rsYyL1rgOCwL/b6tjc8K7iDA8eMpZgjZjgK39HjYXWt6jY5dr/+kOsSijDIgrunyMTre
         xa3CiGSLV+ZiDdBAI7UD9UgLENc/hSXdEjMS1gAUlFaxbjBUOtBdz3s8EqYxuc3jMwRy
         ME3c89VKIhcv4qvv+YCc5yUVm2EDVCP1lYYuJqk1kmLs36pogw1jM5KIDDpn7tfkdzZ2
         vT9/JVGCcX+S3V25rE/LYwZutzcvSn33sNC0XpGDYqPtEXx65VqqdIGQMPgP3QS7wRcu
         dxFA==
X-Gm-Message-State: AOAM533JHw3tw352Jgdfeg28FPozO964a2+8qtBddzYpe/3A2HWokthQ
        h92vhOO8vaHGa3pTzZZUB0yGr/1GGvYQ55PxjBstc1hFzHavMupKzX+Ix5JPmzANL04LLvar5Ek
        z+aBve9wWgMPaMAO/c16B8b61Pwuj3RtxKLGQWx7N+w==
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr23109845wmq.195.1638019119542;
        Sat, 27 Nov 2021 05:18:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzND8ZpYpxyHTPjzGXUg7OxWsPcMAELukJVLJ0LTeNw9xcGhvRvcFGjzAFQKfSCYQJnygsZCA==
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr23109807wmq.195.1638019119359;
        Sat, 27 Nov 2021 05:18:39 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id h27sm15600780wmc.43.2021.11.27.05.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 05:18:39 -0800 (PST)
Message-ID: <c5702c2f-d5ea-b322-f10d-93352979a1a1@canonical.com>
Date:   Sat, 27 Nov 2021 14:18:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/2] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Virag <virag.david003@gmail.com>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211126203641.24005-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211126203641.24005-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 21:36, Sam Protsenko wrote:
> System Register is used to configure system behavior, like USI protocol,
> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
> make it possible to modify SYSREG registers.
> 
> While at it, add also missing PMU and GPIO clocks, which looks necessary
> and might be needed for corresponding Exynos850 features soon.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/dt-bindings/clock/exynos850.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
