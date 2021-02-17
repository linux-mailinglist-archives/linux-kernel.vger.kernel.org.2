Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38A431D8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhBQL5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:57:46 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:46886 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhBQLxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:53:33 -0500
Received: by mail-ej1-f42.google.com with SMTP id ly28so1666025ejb.13;
        Wed, 17 Feb 2021 03:53:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tpzgM7DwrHm/I77e3idiEKwStb99IJkjqQ/VL9hmTWo=;
        b=Vg+pXxDjYxSP09AhCDW74eaLJaR7Yv+Z61cJXgYwX5Vm38WLubHgVMOSwPZt8bCuj4
         1AI3IOGZYeoTkoGz4B4VgWbJlPjEkMspNCvbMnN55B6eywDBtuxhoVR7mvMfZxnPTbj6
         sRUtuVZUbVwI6iuptRf0b1x7xI4rWjek77tD1i+mnOumXmC1BneslT0Rsnm92zj7PVbX
         Xwrv7EV4Z4dz/oLlkRySDmEhk8b0KZI5qsVOorXHFJpX0SqurRDUsnH7hOgn9OqgyK/L
         9qYOqmulVMr9ZbAJ/8DTjAX0dHOYTjNnKV2DeB0dIABk5NOOvEmwtcsG4PilftpUQBQt
         2uFg==
X-Gm-Message-State: AOAM532sMqeqM/PQRLHmblS+MkvDMGhrvHo3J8qJL/0kHsT4pxfb+uKo
        fCdLcfUZP676QookGUnPV4A=
X-Google-Smtp-Source: ABdhPJw06of3Fmyf6zbfkdm6PQ8KqMgb8iuOWXimYxThESWkgIlvy6rYUgIt1Zk0SnvDVIieydKISQ==
X-Received: by 2002:a17:907:aa9:: with SMTP id bz9mr24376522ejc.528.1613562771138;
        Wed, 17 Feb 2021 03:52:51 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z2sm898600ejd.44.2021.02.17.03.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:52:50 -0800 (PST)
Date:   Wed, 17 Feb 2021 12:52:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH v2 4/5] arm64: dts: librem5: protect some partitions of
 the nor-flash
Message-ID: <20210217115248.7t5b64jorzfzbd7h@kozik-lap>
References: <20210217111944.1416-1-martin.kepplinger@puri.sm>
 <20210217111944.1416-5-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217111944.1416-5-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 12:19:43PM +0100, Martin Kepplinger wrote:
> From: Angus Ainslie <angus@akkea.ca>
> 
> These sections should be read only as they contain important data.
> 
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  .../arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index c2bbbdeb93e3..3c0462f81b3a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -258,6 +258,22 @@
>  		compatible = "jedec,spi-nor";
>  		reg = <0>;
>  		spi-max-frequency = <1000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;

Still a line break here is needed.

> +		partition@0 {
> +			label = "protected0";
> +			reg = <0x00000000 0x00030000>;
> +			read-only;
> +		};
> +		partition@30000 {
> +			label = "protected1";
> +			reg = <0x00030000 0x00010000>;

Drop the leading 0 in address and size. I saw some DTS using it but it's
not the common format. All nodes don't lead with 0 so why partitions are
different?

Best regards,
Krzysztof
