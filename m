Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3032D22A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhCDMAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:00:20 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:57169 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbhCDL7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:59:51 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B8AD722234;
        Thu,  4 Mar 2021 12:59:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614859149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4jQxSQc2O+Dp19ZUEJeXtkJeo+b2+R/H3+DatoVNa8=;
        b=iibl/jgxTK3CDY2ohc7hOG1NwWctzi+rRAN8RJYyCXy/RJ16Q0ZOiRckVrOIUFG+vHGK3O
        s0AupfwFidBvPpzjVN5dHNf87dc9lL1Ac9LxBpyWIbq/6DzIykf3Kp4cnOKPs6YNRWN1Vc
        6sXuJxnfQf871vlcZ7De6shCsk8DmvQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Mar 2021 12:59:09 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: add interrupt to Root Complex Event
 Collector
In-Reply-To: <20210304113659.GQ15865@dragon>
References: <20210209005259.29725-1-michael@walle.cc>
 <20210304113659.GQ15865@dragon>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <4d45ac1495eea68aca7d2b85063c2559@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-04 12:37, schrieb Shawn Guo:
> On Tue, Feb 09, 2021 at 01:52:59AM +0100, Michael Walle wrote:
>> The legacy interrupt INT_A is hardwired to the event collector. RCEC 
>> is
>> bascially supported starting with v5.11. Having a correct interrupt, 
>> will
>> make RCEC at least probe correctly.
>> 
>> There are still issues with how RCEC is implemented in the RCiEP on 
>> the
>> LS1028A. RCEC will report an error, but it cannot find the correct
>> subdevice.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi 
>> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> index 262fbad8f0ec..c1f2f402ad53 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> @@ -1114,6 +1114,12 @@
>>  					full-duplex;
>>  				};
>>  			};
>> +
>> +			rcec@1f,0 {
> 
> Just curious how unit-address comes to '1f,0'?

You mean that it's pci dev 1f func 0?
0x00f800 >> 11 == 0x1f

See also:
https://elixir.bootlin.com/linux/v5.12-rc1/source/scripts/dtc/checks.c#L916

-michael

> 
> Shawn
> 
>> +				reg = <0x00f800 0 0 0 0>;
>> +				/* IEP INT_A */
>> +				interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>>  		};
>> 
>>  		rcpm: power-controller@1e34040 {
>> --
>> 2.20.1
>> 
