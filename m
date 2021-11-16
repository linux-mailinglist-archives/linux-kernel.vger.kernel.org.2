Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E9D452E28
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhKPJmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:42:17 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47936 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhKPJmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:42:12 -0500
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mmuvh-00039f-KB; Tue, 16 Nov 2021 10:39:05 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Yash Shah <yash.shah@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Cc:     Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Name gpio lines.
Date:   Tue, 16 Nov 2021 10:39:04 +0100
Message-ID: <11612716.TMCrJ2abzX@diego>
In-Reply-To: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Am Dienstag, 16. November 2021, 01:52:56 CET schrieb Vincent Pelletier:
> Follow the pin descriptions given in the version 3 of the board schematics.
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

when sending a patch series with "git format-patch -6" and friends will
automcatically generate x/y additions like "[PATCH 1/6]" and so on.

Please try to keep them around when sending, as automated tools for patch
handling like "b4", stumble when they encounter a patch series without them.

In this case a

	b4 am f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com

[first patch in the series]
will actually only retrieve the last patch

	"[PATCH] riscv: dts: sifive unmatched: Link the tmp451 with its power supply."

as it thinks it's a new version of the first one.


Thanks
Heiko

> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 4f66919215f6..305a086e5207 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -245,4 +245,8 @@ &pwm1 {
>  
>  &gpio {
>  	status = "okay";
> +	gpio-line-names = "J29.1", "PMICNTB", "PMICSHDN", "J8.1", "J8.3",
> +		"PCIe_PWREN", "THERM", "UBRDG_RSTN", "PCIe_PERSTN",
> +		"ULPI_RSTN", "J8.2", "UHUB_RSTN", "GEMGXL_RST", "J8.4",
> +		"EN_VDD_SD", "SD_CD";
>  };
> 




