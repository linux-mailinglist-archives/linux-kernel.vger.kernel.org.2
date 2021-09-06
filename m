Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A092C4018D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbhIFJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbhIFJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:30:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2381C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 02:29:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n5so8815994wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=8KT0j+y9UG1wLFF91Q2u6K4u89sA/BztK5NzKugntq0=;
        b=abp0ZDooP8qdOaE0H2VpHN+8agL15+qD+lGe740VhTVr0SPyZFJDQaClLFPdAh8kGC
         HI+lQVQ//DS18S7lJEKlJM0nz+Kz4BeEtH8G0HEaFDzTSK/6z6iL2mPhtpAlGrhUz9PL
         66nNV6gpfuEiSxH/Y57WfEk7zChENOcyXCegiQ8qm96mdEcgm8uECBq294qL1WeWq+u1
         MssEnDpvCT/41L5O/Oj/+VN/O8e3j6xjerCzZWI9+7uwNocGDI68I/P4V+nKcTJxfCcU
         enA0h0NAUZUYl1wIxXeUFW2rdlJBRokIGgrg7XDOmnJ8yupBBM+Oeu21In0cZKZtXw3J
         xzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=8KT0j+y9UG1wLFF91Q2u6K4u89sA/BztK5NzKugntq0=;
        b=jXUMyiw25WWekIE2by/PTV/lzPhESXT0/dtL0zBQkNV6alyXP4SGpH3bIQPXrg5FQj
         yLdyJeFyj84GoXuv83sVw3IXF2C1qlo4OIvOu8kvhQa78dyqewabHi0CGhESXC9qJP3Y
         YduF28eSFZeoGV1qsiw6Q3mCkGznuLxPjTOgl77N437Yj/vXtKRLYYxuOXwh5O02+MFO
         tMEB/XxL2E9ZFt5Xx0AFzsJ9s8a5L1oBGtaC7tgRZ5CXTA7gp+TSyZBJmiwMdtpNZLVi
         DWA01dsXM+XrByUnH9C/RP0mTBipcYiru7ZiXuS4qU5TSYLpWji2+JZ1vxTKfuzdnzBy
         yz8g==
X-Gm-Message-State: AOAM532nKM9TL7saRN7FuXGay1RevNKk11BMUXmw3wXgO+Qo18U8+sLn
        dtY64GjvQVjFsqAya+s0ztSQRw==
X-Google-Smtp-Source: ABdhPJyzyMfo+pKTccCBX8HscKDDuZ9cToCN1jiykGwunJAxaOvWcTWgcPa44E359+PcvzgypSHzzg==
X-Received: by 2002:a05:6000:34a:: with SMTP id e10mr12436965wre.421.1630920563248;
        Mon, 06 Sep 2021 02:29:23 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r129sm6646901wmr.7.2021.09.06.02.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 02:29:22 -0700 (PDT)
References: <20210811050941.398360-1-art@khadas.com>
 <64a6a9e1-64de-4b31-9413-cdfd981862de@baylibre.com>
User-agent: mu4e 1.6.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com, Artem Lapkin <email2tema@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
Date:   Mon, 06 Sep 2021 11:25:32 +0200
In-reply-to: <64a6a9e1-64de-4b31-9413-cdfd981862de@baylibre.com>
Message-ID: <1jlf4ayrv1.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 02 Sep 2021 at 15:31, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Hi,
>
> On 11/08/2021 07:09, Artem Lapkin wrote:
>> Add spdifin spdifout spdifout_b nodes for Amlogic SM1 SoCs.
>> 
>> Signed-off-by: Artem Lapkin <art@khadas.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 40 ++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> index 3d8b1f4f2..1efdbb61e 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> @@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
>>  			status = "disabled";
>>  		};
>>  
>> +		spdifin: audio-controller@400 {
>> +			compatible = "amlogic,g12a-spdifin",
>> +			"amlogic,axg-spdifin";
>> +			reg = <0x0 0x400 0x0 0x30>;
>> +			#sound-dai-cells = <0>;
>> +			sound-name-prefix = "SPDIFIN";
>> +			interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
>> +			clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
>> +			<&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
>> +			clock-names = "pclk", "refclk";
>> +			resets = <&clkc_audio AUD_RESET_SPDIFIN>;
>> +			status = "disabled";
>> +		};
>> +
>> +		spdifout: audio-controller@480 {
>> +			compatible = "amlogic,g12a-spdifout",
>> +			"amlogic,axg-spdifout";
>> +			reg = <0x0 0x480 0x0 0x50>;
>> +			#sound-dai-cells = <0>;
>> +			sound-name-prefix = "SPDIFOUT";
>> +			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
>> +			<&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
>> +			clock-names = "pclk", "mclk";
>> +			resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
>> +			status = "disabled";
>> +		};
>> +
>>  		tdmout_a: audio-controller@500 {
>>  			compatible = "amlogic,sm1-tdmout";
>>  			reg = <0x0 0x500 0x0 0x40>;
>> @@ -401,6 +428,19 @@ tdmout_c: audio-controller@580 {
>>  			status = "disabled";
>>  		};
>>  
>> +		spdifout_b: audio-controller@680 {
>> +			compatible = "amlogic,g12a-spdifout",
>> +			"amlogic,axg-spdifout";
>> +			reg = <0x0 0x680 0x0 0x50>;
>> +			#sound-dai-cells = <0>;
>> +			sound-name-prefix = "SPDIFOUT_B";
>> +			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
>> +			<&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
>> +			clock-names = "pclk", "mclk";
>> +			resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
>> +			status = "disabled";
>> +		};
>> +
>>  		toacodec: audio-controller@740 {
>>  			compatible = "amlogic,sm1-toacodec",
>>  				     "amlogic,g12a-toacodec";
>> 
>
> Jerome could you quickly review this ?
>

Just this, without the related card change is not usefull as it won't be
part of the card.

It would be nice to indicate how it was tested ?

AFAIK:
- spdifout b can only be routed to hdmi and dw-hdmi driver does not
  support that yet
- the VIM3 does not have connectors for the spdif (in or out). If it
  requires some extension card, it should be noted somewhere, at least


> Thanks,
> Neil

