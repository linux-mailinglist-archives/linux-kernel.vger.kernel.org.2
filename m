Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720C53F2BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbhHTMHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:07:02 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:41788 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbhHTMHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:07:02 -0400
Received: by mail-lf1-f49.google.com with SMTP id y34so20108801lfa.8;
        Fri, 20 Aug 2021 05:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=67mrbeynTpURtFY8gyP0ws8OzeKxI+eTxfHxy4dGBl4=;
        b=gNM9SxvPCFAPT0wUb1x5qz4S0thvGDjwtYbZ9D18hvP/dzyPUZCIom4wunYMftK+N5
         uwLPD0uH2PPcZuFK5dTgbudauooGocR9luo870/FRw9wI+juD1D24IpRuCnpa5fm5/ip
         gd9OsNcsZQvCJUgdoFBWfYYtVz3v7uUR/wnNXCyNZ5qFa+L5t6b3KN+95webvLFxFnUh
         BQTthhcvk+o1JAKydTFtcaN693WodZ6BQQFCG/7RbDDA2uqTtrDVz4wP6rEGOj/fEV2k
         K7JltZxyS+PWTm6tlkNVjAV41CHaiem/g9fI7YUhZiTPRHU/UBhvGTokrO+IAD3/PB35
         9o5A==
X-Gm-Message-State: AOAM531qCGUzCN9ZCM9WwoksI3nUdgCwvj9WndjFCmwqAjwPB2+TdK+h
        +ie+S4EQtVYb+5jyjTioZ1oxAWzzxJA=
X-Google-Smtp-Source: ABdhPJzEJWh4uHudU2RgJzVuRmqV0l1nluL0nC+I/2fAmHIWps0zpAnV0vsi8JONOgVoswY/xMy4Sg==
X-Received: by 2002:a05:6512:3b85:: with SMTP id g5mr6010772lfv.368.1629461182994;
        Fri, 20 Aug 2021 05:06:22 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id c5sm506198lji.67.2021.08.20.05.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:06:22 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id i28so16927022ljm.7;
        Fri, 20 Aug 2021 05:06:22 -0700 (PDT)
X-Received: by 2002:a2e:b708:: with SMTP id j8mr15452490ljo.488.1629461182570;
 Fri, 20 Aug 2021 05:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210820081645.83796-1-krzysztof.kozlowski@canonical.com> <20210820081710.83908-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210820081710.83908-1-krzysztof.kozlowski@canonical.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 20 Aug 2021 20:06:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Mx76p0G4nsfAtdLOuzj462Ok1BkqRTgT1BD1ndDqVwA@mail.gmail.com>
Message-ID: <CAGb2v66Mx76p0G4nsfAtdLOuzj462Ok1BkqRTgT1BD1ndDqVwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: align thermal zone node names
 with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 4:17 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Align the name of thermal zone node to dtschema to fix warnings like:
>
>   arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dt.yaml:
>     thermal-zones: 'cpu-thermal-zone', 'ddr-thermal-zone', 'gpu-thermal-zone' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
