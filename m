Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF7F3D1FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhGVHlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 03:41:06 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34397 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhGVHlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:41:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C1A65C009F;
        Thu, 22 Jul 2021 04:21:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 22 Jul 2021 04:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=l
        wdFUI+YBXEcZ/jDxkta5gm3PsZd7KMxnxVNOAYa4Fw=; b=iiETPZEG7yXJpgJfH
        2QFCkMgNAFEwkDJB9NWXGwljheR2Kb5jf6BY4Yqo7nyY0LeHLK7t8Kyhnxjbj6jV
        f3Eq9/fQP5NlOhwSA5LWqCMkvlgX23eCpMs5xOu0LIMaAxfJ+duH8KkaI3bwSIPG
        Xdm7jahDoejN2I5wrpBl4ms7ws8tMivTBq7SBAqG7RBNlPTv3NrFI/l2YLk+oPvP
        X4QQNXeXDSburrpgn2zVOIDGuk6PWaMGWSxxL14GLqJcPL3AUTf30teriG039UzY
        o7+ocQMGALe+KB4gkhngc8mEJ4w7LzKMkYIfQr9jH6RO1LbxJpmdOqIFkC+djHZv
        KJsGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=lwdFUI+YBXEcZ/jDxkta5gm3PsZd7KMxnxVNOAYa4
        Fw=; b=qPD4KI8gn+Yyr4gcn/D4SMp7b9tFRrTbblJV/Ut7YoV3fIF7zNxMzz1B1
        8kiL0aacvZqfyEzkZX189LzIPFeDipOt3M6HcALGjSmPXwjk+/xkp6CYoiTGDfRa
        Z3JnIJNG/TD92CVGgVzC+FL9p+msf37KYh6QZNJzHDK0/Dl/sNbatYc9ZgG4aVCs
        y380Om/LjlwFy43Vl0SsiP3CKv5wbqiTZlc2pcJWUpF+4L+f5x3cigNo+eUT/dsJ
        FQT3ugC7tXZVZXOsDZrf8H9rz21+ac4vFvXM58V/Gv0h5At78Hc/nffmeYfibOEq
        2JlOv8TYSodkJHSa4zM2gKa4lD/4A==
X-ME-Sender: <xms:lCr5YMeq2N2XE-czgf6pgtD25N_OHPyog1SkAnC_m1k9QTfsOvhp_Q>
    <xme:lCr5YOOcGWjJSCU-m7FjcoYKnMIHuuV4QAQvcIGPMb5aMsdcl6vjRcTbX0B7anixY
    m1bFCFmkfouNR-Is5Q>
X-ME-Received: <xmr:lCr5YNgWgMggrpASd2ALHLqNLiK9O28LqR-5N1jwEHb0Q6L0RV0-dsWfwO8KHebmRIfTJKtsQPuY-u9IMBeHcWlT7iSxQKYsKU9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeeludeg
    vddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:lCr5YB82ExcsNZSvMZUqjgEQmczjin-pEi19o0CW_ZQM4YT2u2HKyw>
    <xmx:lCr5YIuppRiq1wXyvRPdPs1hvFJ8-nfSwA7mgmNIk_usktH5gJVivQ>
    <xmx:lCr5YIGu5qumhYRAaHPwIpdsXDeDN3dXsSL1dHcoXUKox2oW80mPGA>
    <xmx:lSr5YCX9BZ_PNQBzHRwXLd9W83BCtSLp3rk3DaN3cjcXI0uG-hS_7A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jul 2021 04:21:39 -0400 (EDT)
Date:   Thu, 22 Jul 2021 10:21:37 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: h6: tanix-tx6: Add PIO power
 supplies
Message-ID: <20210722082137.2kgbirwtayq4bl7x@gilmour>
References: <20210721200832.916644-1-jernej.skrabec@gmail.com>
 <20210721200832.916644-2-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210721200832.916644-2-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 21, 2021 at 10:08:31PM +0200, Jernej Skrabec wrote:
> While there is no publicly available schematic of this board, it's not
> hard to determine voltage of GPIO port C, D and G (only ones which can
> be set).
>=20
> Port C and G are used for MMC/SDIO communication, so they use 1.8 V
> power supply. It's not clear if port D is even used, but if it is, it's
> pretty safe to assume it uses 3.3 V power supply. Value read from PIO
> Group Withstand Voltage Mode Select register from within pre-installed
> Android agrees with that assesment.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> index be81330db14f..a1dd8f472cc8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> @@ -32,6 +32,13 @@ hdmi_con_in: endpoint {
>  		};
>  	};
> =20
> +	reg_vcc1v8: vcc1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc1v8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +	};
> +

I appreciate that the other 3.3V regulator has the same issue, but the
node name must reflect the class of the device. Maybe regulator-vcc1v8?

Maxime
