Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533904132A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhIULgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:36:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40262
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhIULg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:36:26 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 477BB3F30E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632224097;
        bh=3qq/eN4U25uXpOowfjqd2mOALCyRisNs/QeVz3su/sU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=JCYq9Pvyp/J7JyM7sY/K3BGTs5uwveg8bVZYQ/Gf5jnbd5NjxkkC0VtFDsLpFgZk4
         8Sactl8W7kztZ75eOl3GhO8WbEeiYY36IqWJr1n4zJzDi5Lugxlpc7xy1WDLPcCZIE
         /rlmRa+0/T4ZbiGP7CwM1jBu1941wwA1clOuxZWL8mTIO+7I4teufTVKO7zPMUFCA4
         VpYbbvk7x5J1oQu3L0eKTHgtkLCrqVHMHXbkgn9BbL0+5ATtu8IjU9NGmYRYsxJjil
         bx+ohxXZlsS30YZRpS81C919J+TYQwWhOE2o6sSsPZI5DigbBvNux8/FPUMJXZN1nn
         DSfBoQZEbbHEA==
Received: by mail-wr1-f70.google.com with SMTP id j16-20020adfa550000000b0016012acc443so3187321wrb.14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 04:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3qq/eN4U25uXpOowfjqd2mOALCyRisNs/QeVz3su/sU=;
        b=7S28z3G6Ll731HHROG+bQD3PohXUNfXPOJm9tW2rEkuctEpkmF07DOqnpUeW/ljfhL
         /Vcko7CyEbhdZKCYcMhxEmSfds6oK/0gtQF1aD2cCzzA7Vy0ByzDglZ1jXSjCXhl/16w
         4rHOEa78LaUlTAnGhfA2l22f3gw872dZ76gu6ZifPq77cTR9mXxpzaXzVFuodyLzDx37
         4UDrWbIvJfudJLz+oMqNgHyR4KLkCpTh0E3/XCGCBvqQ7vUtIZJN6w+/fhs2K+DDorwA
         6afg4cPunDaaG/fNL/cy1+ITgDBqJdstkwGQ/tCywCSXzrj05PElpiDHgIeY2ahzrMQi
         VCVQ==
X-Gm-Message-State: AOAM530dfujDFRjnfycRPJRQY7wVJg1Icx83OmYdRBNcbC5w87Hx/yvA
        ud+IiEq/+KdYOaVoEhA0UDXzX647SesZ6qUmX06cWeX4KUz+JI/BP5SKYPah+U/0yMqU+8ShzmK
        N9i85R6Rw4+n1C9QGBfuve+wKevlV7uND3hOmXVctUg==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr4218689wmm.57.1632224096967;
        Tue, 21 Sep 2021 04:34:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp02VQL/BqP2bBl5NT9zOKeZStP0pv824t2d6ns4gFKUDtsZcT5G6OGk+kUxEE1DpGLt0jIg==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr4218662wmm.57.1632224096779;
        Tue, 21 Sep 2021 04:34:56 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id y197sm3016215wmc.18.2021.09.21.04.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 04:34:56 -0700 (PDT)
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
Message-ID: <c2ec765c-f881-17ea-3f9c-cf83ea0313f5@canonical.com>
Date:   Tue, 21 Sep 2021 13:34:54 +0200
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

It seems you sent the same patchset twice. I already responded to all
three patches.

Best regards,
Krzysztof
