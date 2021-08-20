Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931813F2BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbhHTMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:12:04 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:38905 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhHTMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:12:02 -0400
Received: by mail-lf1-f51.google.com with SMTP id x27so20163392lfu.5;
        Fri, 20 Aug 2021 05:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qLfZ8/GKcURSHCm2cP8f/aOHmp3T/NRBIyV2qbqgsho=;
        b=snZi6HL0s9MiD4/pJHU7Hv4zRDEDVuTkBpcn5rnNOwOalutVg01XS1x6i9naa7D0Ac
         PVm72l5TrQyJS6vgP9twDYjFZZzSXeUKLWHQiV1zBgPakm6PpoxawptwQteTCSv+V6W4
         hiSmdpvyQiBvXH4lUB3BMKnU9C2OmlaPovUl3Hq4SnyLKiHQ/kUiAUBgrjzW69gy919C
         3skDdoWaLn1mHqg9QZ06d3D408OVoS5KRudB/FYIeLJuxVi0ESIoK46kolFYuGAS8QM9
         1qMDhM2ST7FO0o7+xoCO36+6I7d0lprNMtS6eqiH8jdfTnoQ2p7CxT46tNjVicOvWEFI
         YbxA==
X-Gm-Message-State: AOAM532HqZzCdn2Ph+V3Wj/Mhs9zgyJNp3Z9SrDZVBCZPD9wWRNmtSUZ
        EQ4upv3r38Phzy8EmMYd6sLd2dd7btUAqQ==
X-Google-Smtp-Source: ABdhPJzdItmXLKU18VHjBvGfzWIA9PHiZErOMomaWZB6gTYNPI364He115wXF0a2ueYchqfl53DEBg==
X-Received: by 2002:a05:6512:3767:: with SMTP id z7mr14788004lft.128.1629461483123;
        Fri, 20 Aug 2021 05:11:23 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id bq33sm617016lfb.88.2021.08.20.05.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:11:22 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id g13so20123379lfj.12;
        Fri, 20 Aug 2021 05:11:22 -0700 (PDT)
X-Received: by 2002:a19:f819:: with SMTP id a25mr14506302lff.203.1629461482247;
 Fri, 20 Aug 2021 05:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210820081645.83796-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210820081645.83796-1-krzysztof.kozlowski@canonical.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 20 Aug 2021 20:11:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v66EnW+iO2CPueauRob+b53pNFEuL6LUoSYb09_TN+=_cw@mail.gmail.com>
Message-ID: <CAGb2v66EnW+iO2CPueauRob+b53pNFEuL6LUoSYb09_TN+=_cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: h5: align operating-points
 table name with dtschema
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

On Fri, Aug 20, 2021 at 4:16 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Align the name of operating-points node to dtschema to fix warnings like:
>
>   arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dt.yaml:
>     cpu-opp-table: $nodename:0: 'cpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi
> index b2657201957e..0b6914a165b0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi
> @@ -2,7 +2,7 @@
>  // Copyright (C) 2020 Chen-Yu Tsai <wens@csie.org>
>
>  / {
> -       cpu_opp_table: cpu-opp-table {
> +       cpu_opp_table: opp-table-0 {

Maybe we should just reorder the name? Name it "opp-table-cpu" instead.
That way if and when we add one for the GPU, we don't accidentally
clash on the name.


ChenYu
