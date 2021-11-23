Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DD045A814
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhKWQjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:39:12 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:41889 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbhKWQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:38:17 -0500
Received: by mail-io1-f53.google.com with SMTP id y16so28665635ioc.8;
        Tue, 23 Nov 2021 08:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=L+wT8ZVIvUW7LbdAd258WQWbKmsU54AD2qUyaW0yHWs=;
        b=qWIBId1rS713btu5SINLfeWcFIuqmhWNxbOEUsiaGOQI91brenA5ATFYGzwTadblIs
         DEOzJ1PKGUvo6ixp+G9wlPWFJ2yndZfVY3vcnuMig61xYZ5BP/L6cL5CJ9/fyj9+ooFq
         8e0tA0OOjhAbiYFrDF8TI8PZRh7cEeUBWFY/vpXOi5U2fQ67zKLxH+4GeST0NlBvy8RX
         0C5koYCOGepc8HWLMR6aLPgwrqbwS3J0sFDzL6IYwJ/tiorfYfXc8yfjyUnd14IIePY8
         12yQEAsXYpdOYdGaaRU4/SNQKz8zaFF+KnD60lD7Ix+9YrNqkgtGQizHi1/dnRVzWJGi
         LlIg==
X-Gm-Message-State: AOAM530T37AGxaJ7BAk7UhRO5LqzndOUwG0h8MLeTc3061tYF34ZtfrD
        S6Z8aFFDy78TH8On6jOGkA==
X-Google-Smtp-Source: ABdhPJyQBPu5DjU807Y7rKr+WqMhNBwFzOESYmvnIx6qfZZBopTYE7H8kZ1Ck5Wqc55lHBOpRNlIJg==
X-Received: by 2002:a05:6602:1513:: with SMTP id g19mr7141385iow.31.1637685309326;
        Tue, 23 Nov 2021 08:35:09 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x15sm9270605ill.20.2021.11.23.08.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:35:08 -0800 (PST)
Received: (nullmailer pid 3442926 invoked by uid 1000);
        Tue, 23 Nov 2021 16:34:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     fabrice.gasnier@foss.st.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        arnaud.pouliquen@foss.st.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211119144551.7577-3-olivier.moysan@foss.st.com>
References: <20211119144551.7577-1-olivier.moysan@foss.st.com> <20211119144551.7577-3-olivier.moysan@foss.st.com>
Subject: Re: [PATCH 2/9] ASoC: dt-bindings: stm32: i2s: add audio-graph-card port
Date:   Tue, 23 Nov 2021 09:34:29 -0700
Message-Id: <1637685269.721768.3442925.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 15:45:44 +0100, Olivier Moysan wrote:
> The STM2 I2S DAI can be connected via the audio-graph-card.
> Add port entry into the bindings.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1557189


audio-controller@4000b000: 'port' does not match any of the regexes: '^port@[0-9]', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/stm32mp157a-dk1.dt.yaml
	arch/arm/boot/dts/stm32mp157c-dk2.dt.yaml

