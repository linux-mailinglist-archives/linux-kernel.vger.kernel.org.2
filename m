Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3294631C6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 08:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBPHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 02:32:07 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:35022 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBPHcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 02:32:04 -0500
Received: by mail-wm1-f53.google.com with SMTP id n10so13460112wmq.0;
        Mon, 15 Feb 2021 23:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xkypD+66j+JEykDAYhgusAW9iuLjXAf+rkAoljhHLHc=;
        b=sQU72nrK6xwyxaH2gx1DH56kTWzlsnD5blu2sg/N0XeobVbtESykB5on4JPhqaRHWL
         AsuFtaLn3LPiOKS4MwPdNzwgIEZ/QQt9IvJ+Kym5taH/2Y/i6yXSrWoXKMASstzRlwA1
         WhozStcCj/FA7NwEOPKrEwbO/dSdLBT3U5T3rDs4Gr3IFEeYqziVYP8ApSujWK27RZmh
         DaybeE/l9B9qHMRxAp0r24GHsqcXnhv7joO70lXCH4tI9HPIUL1hVT5R7pLBVXCfn3kH
         /spcM4R4WuPxAOgF3Ld2hFxANStAXfhYbwq3iq0C372GNLuE2w71P6l7C5hN40cElT30
         Upzg==
X-Gm-Message-State: AOAM533NFm7txP8ysSzldK1i1u8TSHsB+KnErpjgAYwzopMTIr6KyLTd
        sCpXWfcBoltkKA8IxoNbhic=
X-Google-Smtp-Source: ABdhPJwtf7xxwxHb+TZe50BG+Ui9Gg4hfIal9+FHQtbwDPbzChwY23yzFA+XmAY9BiRlRr24mHdKIA==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr2063421wma.132.1613460682574;
        Mon, 15 Feb 2021 23:31:22 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 101sm17597897wrk.4.2021.02.15.23.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 23:31:21 -0800 (PST)
Date:   Tue, 16 Feb 2021 08:31:20 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/25] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <20210216073120.qmlaky43t6uelqc4@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-26-marcan@marcan.st>
 <20210215192906.7k3unuhph5wnkj5g@kozik-lap>
 <9dd4731c-7826-c1f5-3ce4-831d5186d270@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9dd4731c-7826-c1f5-3ce4-831d5186d270@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 01:00:58PM -0800, Randy Dunlap wrote:
> On 2/15/21 11:29 AM, Krzysztof Kozlowski wrote:
> >> diff --git a/arch/arm64/boot/dts/apple/apple-j274.dts b/arch/arm64/boot/dts/apple/apple-j274.dts
> >> new file mode 100644
> >> index 000000000000..9a1be91a2cf0
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/apple/apple-j274.dts
> >> @@ -0,0 +1,41 @@
> >> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > () around licenses, so:
> > (GPL-2.0+ OR MIT)
> 
> Hi,
> When/where does that "() around licenses" apply, please?

Hmm, somehow this pattern got into me but now I checked on the spdx.dev
and the preferred syntax is indeed without (). Skip this comment then.

Best regards,
Krzysztof
