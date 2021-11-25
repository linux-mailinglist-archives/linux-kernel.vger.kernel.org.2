Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F0845E27D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351042AbhKYVbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:31:41 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:45784 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243078AbhKYV3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:29:38 -0500
Received: by mail-oi1-f180.google.com with SMTP id 7so14873073oip.12;
        Thu, 25 Nov 2021 13:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Irmkz+2IkREM42YOJmVlq/heQU408FIz6tCFuZLCU8s=;
        b=Kp5deXf1ygD9Siof4TQuDygMajSUp+ybyQEdvcWv9AdSdxRBSUjjiRl2yWrnf8DXjR
         e1lhmj3IRuKOGVIzPshRXn38bIKadscVH4V2YBentVfShgshYmV02llkP2gbHy85FfU1
         APBLFIhKCUtarrAVJkwGIYmrrcXu9sdacnF1+EnOG27u5qb0UkG/nuBc7GRILz0hne29
         3GXikgP8pzUl8RMB/WYeaRGG5Hwvp53dfNHd9YzgOKaodW0osZ3EZsUMSckJ/5jnoonM
         SOC4W4OyoOYNbRNwbjozK8+4CcIByPq/DmbAGxkAtIFwUegGlIgWtIz4mjklwVhxAURQ
         WKug==
X-Gm-Message-State: AOAM532hUhUX9Ka1Al5H2Fytq9k01AvipiViOM/uEloD63je27nmlJ3A
        RDKU6pmNsB6LZ8q4Btz20A==
X-Google-Smtp-Source: ABdhPJyEIeYGx4xMc1J7Gwjxw4a3IIrOE4Xx6LFo3WAtPewKP4oi94Bvlm37BYHDgo8Y45xaFqR2Wg==
X-Received: by 2002:a05:6808:3d2:: with SMTP id o18mr18848517oie.14.1637875586898;
        Thu, 25 Nov 2021 13:26:26 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p14sm670414oov.0.2021.11.25.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 13:26:26 -0800 (PST)
Received: (nullmailer pid 2858319 invoked by uid 1000);
        Thu, 25 Nov 2021 21:26:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        fabrice.gasnier@foss.st.com, alain.volmat@foss.st.com,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        amelie.delaunay@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org, arnaud.pouliquen@foss.st.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211125144053.774-2-olivier.moysan@foss.st.com>
References: <20211125144053.774-1-olivier.moysan@foss.st.com> <20211125144053.774-2-olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: stm32: i2s: add audio-graph-card port
Date:   Thu, 25 Nov 2021 14:26:02 -0700
Message-Id: <1637875562.357461.2858318.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 15:40:50 +0100, Olivier Moysan wrote:
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

Full log is available here: https://patchwork.ozlabs.org/patch/1559750


audio-controller@4000b000: 'port' does not match any of the regexes: '^port@[0-9]', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/stm32mp157a-dk1.dt.yaml
	arch/arm/boot/dts/stm32mp157c-dk2.dt.yaml

