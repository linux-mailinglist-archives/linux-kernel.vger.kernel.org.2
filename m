Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D47423E47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhJFM5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:57:43 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49980
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhJFM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:57:42 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CB91A3F32F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633524949;
        bh=iFs/8t2p0utw/cP9IG0B+N9Nu0IFpPSN+vPgOU+4tTQ=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=mXQtXqmQc/MhgGm99CWV+UJjMAyP1Pz9lEoLBdKN1p4AbJHEphMqCX3+M8qWu7VGV
         tJBpGGqhnbQ3bPyweIOGLd11P82EXIezopKgkjVMr1HUhpE3CJuNKUHFILqa/2kvxP
         DHtt9QcvNqo3mp+sWpijkaX1LBU8562ak6HJRnnGcVW8JO/ajRAsEjJtuSV7HcoVjq
         KauTnu4ei4WXBcuSqfzdiSTfmWgFg7pA0JNk6r9O+rZBwWcRd99yiii4P2dwUG6brQ
         ZPoZMvc7r+Hsm5KeK4QbIJaqeB2+DTafjYwcGQ7QZzAeCpV+UWmFxjq3O4dIBKmtA3
         nhjbA7duM/zkg==
Received: by mail-lf1-f72.google.com with SMTP id g9-20020a0565123b8900b003f33a027130so1888675lfv.18
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 05:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iFs/8t2p0utw/cP9IG0B+N9Nu0IFpPSN+vPgOU+4tTQ=;
        b=0je1JSP9/p5AV3y2DKvq83o25lCzY7P4305QgrWIetR6H1N/9DWv4s4sNyIZ3UQM84
         QW2XAWxpDpxBABQGJuu2xBAuW/lz8pU9/+sZ03Kie5e61rOYTcu+JSFtXC60Ktb0JCZ/
         360Zxr/4tAsUzyrt7B1sd4A41U+hN5s7tYGe5BzrF1OyhCd1cP6GgA3XleLLoJSApMKB
         kpw34VdEc8Q/uD/ZgfcmTsdM9XWOcz79fEVAXp9INyLCtFoZCGdJ574dVw5gam0LmSmZ
         6aCOPx+YIEEtbE5+suElmqg3GaQUWjnm5dqcHdbKibGnvQKB4q95ujIMIQqUVjQ/MmTt
         sfpw==
X-Gm-Message-State: AOAM533/G7KDkQmBW/CeONpkgWAFxc7a16EK+vzEX3pIuKdOBE4XGffU
        AObsOt9lPIyWwr7Tjxkn1N7CfgE9uMVXn/hmxI9CQO6odZFc1u1zjMMT3nl4A+Jto0YLys+bZ0t
        hQVJVe5LyvEYCd5cBvL0OBwjEQWt9DPTsJpll1wNRRg==
X-Received: by 2002:a19:7606:: with SMTP id c6mr8052817lff.658.1633524949326;
        Wed, 06 Oct 2021 05:55:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx63BAEC5N5BPTXxbHx164yFb6F9c4H1IYobwbh/wc690q8zkKLdnBdIXP3X6tArYGLz+pQ4Q==
X-Received: by 2002:a19:7606:: with SMTP id c6mr8052807lff.658.1633524949164;
        Wed, 06 Oct 2021 05:55:49 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i15sm1147603lfc.11.2021.10.06.05.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 05:55:48 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] regulator/mfd/clock: dt-bindings: Samsung S2M
 and S5M to dtschema
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
 <YVxBuEvHVdyDvaGD@sirena.org.uk> <YVxP0+kVxI0xQmQQ@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <41226a6d-999d-b1bb-d6a2-294a9e34d271@canonical.com>
Date:   Wed, 6 Oct 2021 14:55:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVxP0+kVxI0xQmQQ@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2021 15:14, Lee Jones wrote:
> On Tue, 05 Oct 2021, Mark Brown wrote:
> 
>> On Fri, Oct 01, 2021 at 11:40:56AM +0200, Krzysztof Kozlowski wrote:
>>
>>> Merging/dependencies
>>> ====================
>>> 1. Regulator related binding changes depend on first two commits (the
>>>    fixes), because of context.
>>> 2. The mfd bindings depend on clock and regulator bindings.
>>>
>>> The fixes and bindings changes (patches 1-10) should go via the same
>>> tree.  For example regulator or mfd tree.  I propose the regulator tree,
>>> since it will have also one driver change (the fix, first commit).
>>
>> Lee, Stephen, Michael does Krzysztof's plan make sense to you?
> 
> I tend to take cross subsystem patches.  MFD is usually in the centre
> of these scenarios and I have tooling to easily set-up immutable
> branches/pull-requests.
> 
> Always happy to discuss if others have different/better ideas though.
> 

Another alternative is that regulator patches (1-2, 4-6) go via Mark who
later gives you a stable branch/tag to pull. Then the clock and MFD
bindings would go on top via MFD tree.

There is a comment from Rob which I will fix in v3.

Best regards,
Krzysztof
