Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB7C41B348
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbhI1Ptq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241695AbhI1Ptn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:49:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B18E760F44;
        Tue, 28 Sep 2021 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632844083;
        bh=wAnB2cYdIfBLAAsYpcQWeXRp9kCOB1bUVqBkeLSul8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLBoJCqqqNWC/WrowbiMoxzmU1kcuy8U/shXRmXWAZDemjinu9hH6vYYj9V7rZyLG
         WSR+BlSczZZihyNGO/JNdFgsw1F1NXqNo9hWC10KEo3v9C9jbCEd8VorkLRSU4p7Cg
         kxc/xbvmEnF5cHnmR2IXzio5bbgno/piFyMujIFrV+o8X3Rx08sFdnyQsFI7qGCcIz
         +WW/ge4EeQsZSYzv68TWgCc+RrWJVwGqoMSYaZEnLpQbLt/27HTgOX64iRUbmgyev4
         H4UTviU6zK7RA05xmalxvg0D1Fhky4dRRUzkdmBcBqY2UNsENdUyH4sQevXVlE5VG+
         D35yJAnu4eGqQ==
Received: by pali.im (Postfix)
        id 5CFFB7E1; Tue, 28 Sep 2021 17:48:01 +0200 (CEST)
Date:   Tue, 28 Sep 2021 17:48:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     robh+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: marvell: add Globalscale MOCHAbin
Message-ID: <20210928154801.vkdt5qbsm4z7ox4y@pali>
References: <20210923181830.3449602-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923181830.3449602-1-robert.marko@sartura.hr>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 September 2021 20:18:30 Robert Marko wrote:
> +/* SPI-NOR */
> +&cp0_spi1{
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp0_spi1_pins>;
> +
> +	spi-flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <20000000>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "u-boot";
> +				reg = <0x0 0x3e0000>;

For sure U-Boot cannot start at offset zero as this is 64-bit ARM board
which uses at least TF-A firmware, which loads U-Boot.

Also on these mvebu SoCs is executed prior TF-A firmware custom Marvell
initialization code responsible for DDR training.

So on offset zero you cannot flash U-Boot, otherwise board would not be
bootable.

So I would suggest to either define correct offset at which U-Boot
starts or rename this whole partition to something generic, e.g. with
label "firmware". To not expose that on zero offset is stored U-Boot.

Due to how big is this partition I guess it contains concatenation of
various firmware and bootloader parts.

> +				read-only;
> +			};
> +
> +			partition@3e0000 {
> +				label = "hw-info";
> +				reg = <0x3e0000 0x10000>;
> +				read-only;
> +			};
> +
> +			partition@3f0000 {
> +				label = "u-boot-env";
> +				reg = <0x3f0000 0x10000>;
> +			};
> +		};
> +	};
> +};
