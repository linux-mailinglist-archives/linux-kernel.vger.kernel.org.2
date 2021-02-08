Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A4313558
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhBHOh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:37:59 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:42924 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhBHOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:10:29 -0500
Received: by mail-ed1-f46.google.com with SMTP id z22so18166863edb.9;
        Mon, 08 Feb 2021 06:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dpsm0bZ/m5A29PuyUa9YgWYc5KvB/3XFGrUZ84aiJKo=;
        b=XizILjWQR4ch6g02yA82rn4OzhutL0MO9jjNW7fdsmedC0Y2KsEH+9XsuVGF72h5LL
         74JeuyMR2vGDw89OrV6sshPZfuFBka9vlUJAYic9y/QlIOeaWuJY+HlREp1Y7BlBV6jG
         GPspbWYY4PVeyrC02/ecPy7DvtSTpVhHyYRpfFQ16lrxItoRAQr1RlAc2D9Ve8Au6oXB
         P+/0PN4SgBdHNhJpIeOdX61dhELAd+Z7B+Q6t5xjky15k04VmgBPJHgqZq5NZLI5CU+y
         0mgnsFm8WNTpi0bQU1nANR07lDjjT7UT+ndB/3d+FlLYUzRoifO9sx+kkyLG3Ghu6nsb
         BfDg==
X-Gm-Message-State: AOAM533SkJ7rDhDlFtEyR4/59jXlFo+5RIkq3o7jxKiEHW+LYqAmyavo
        lVKYJl7FJDCUbXutGM+WO0w=
X-Google-Smtp-Source: ABdhPJxJgjyUVcgZee6nEDFRRuYlz/OidRSQugEVbVNByIwI8706zUs9/SHjl4cdx+kipf9ri78zmQ==
X-Received: by 2002:aa7:ce96:: with SMTP id y22mr17236639edv.369.1612793386884;
        Mon, 08 Feb 2021 06:09:46 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id hy24sm8230648ejc.40.2021.02.08.06.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:09:44 -0800 (PST)
Date:   Mon, 8 Feb 2021 15:09:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, kernel@puri.sm, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH 4/5] arm64: dts: librem5: protect some partitions of the
 nor-flash
Message-ID: <20210208140943.6dewq4b3dmaxh7ia@kozik-lap>
References: <20210208131527.24463-1-martin.kepplinger@puri.sm>
 <20210208131527.24463-5-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210208131527.24463-5-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 02:15:26PM +0100, Martin Kepplinger wrote:
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
> index c2bbbdeb93e3..9867e2a50008 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -258,6 +258,22 @@
>  		compatible = "jedec,spi-nor";
>  		reg = <0>;
>  		spi-max-frequency = <1000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;

One empty line here.

> +		partition@0x00000000 {

Wrong unit names. Compile dtses with W=1.

> +			label = "protected0";
> +			reg = <0x00000000 0x00030000>;

Get rid of leading 0000 - it makes it less readable.

Best regards,
Krzysztof
