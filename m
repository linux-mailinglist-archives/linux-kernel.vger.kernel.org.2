Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F964582DA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 10:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbhKUJ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 04:56:30 -0500
Received: from ixit.cz ([94.230.151.217]:41286 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234495AbhKUJ43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 04:56:29 -0500
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 702DC20064;
        Sun, 21 Nov 2021 10:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1637488400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjsRD3fZ0smLhNsEv4gWgFfjGle4NLMaLlq2XBmcfFU=;
        b=U5Ho6lOf9cm6Vwfugh7tdN2wFeiM77H1WGWA0IC4/Uyn/hpsxkWHBeFM7LCe8eIa7UC2bG
        ALfSG/3uW9xn6EGe8tPEP58lEUgpPcJstn33u9Fqa5MPlKSiwYp19KgF2mUjynBPdN5dTV
        kepKT3gPAILi2Tjo/nfpr34rSqu/BLg=
Date:   Sun, 21 Nov 2021 10:53:13 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] arm64: dts: imx8mq: fix the schema check errors for
 fsl,tmu-calibration
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        ~okias/devicetree@lists.sr.ht, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <P42X2R.2KJI0X4G52WJ1@ixit.cz>
In-Reply-To: <20211121085102.GM31998@dragon>
References: <20211029114050.39520-1-david@ixit.cz>
        <20211121085102.GM31998@dragon>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,

yes, when I get back to working on Linux kernel patches, I'll resend.

David


On Sun, Nov 21 2021 at 16:51:03 +0800, Shawn Guo <shawnguo@kernel.org> 
wrote:
> On Fri, Oct 29, 2021 at 01:40:49PM +0200, David Heidelberg wrote:
>>  fsl,tmu-calibration is in u32-matrix. Use matching property syntax.
>>  No functional changes. Fixes warnings as:
>>  $ make dtbs_check
>>  ...
>>  arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml: 
>> tmu@30260000: fsl,tmu-calibration:0: Additional items are not 
>> allowed (1, 41, 2, 47, 3, 53, 4, 61, 5, 67, 6, 75, 7, 81, 8, 87, 9, 
>> 95, 10, 103, 11, 111, 65536, 27, 65537, 35, 65538, 43, 65539, 51, 
>> 65540, 59, 65541, 67, 65542, 75, 65543, 85, 65544, 93, 65545, 103, 
>> 65546, 112, 131072, 23, 131073, 35, 131074, 45, 131075, 55, 131076, 
>> 65, 131077, 75, 131078, 87, 131079, 99, 131080, 111, 196608, 21, 
>> 196609, 33, 196610, 45, 196611, 57, 196612, 69, 196613, 83, 196614, 
>> 95, 196615, 113 were unexpected)
>>          From schema: 
>> /home/ubuntu/projects_remote/linux/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
>>  ...
>> 
>>  Signed-off-by: David Heidelberg <david@ixit.cz>
>>  ---
>>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 87 
>> ++++++++++++-----------
>>   1 file changed, 44 insertions(+), 43 deletions(-)
>> 
>>  diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi 
>> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>>  index 972766b67a15..50088b110ad4 100644
>>  --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>>  +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>>  @@ -429,49 +429,50 @@ tmu: tmu@30260000 {
>>   				clocks = <&clk IMX8MQ_CLK_TMU_ROOT>;
>>   				little-endian;
>>   				fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
>>  -				fsl,tmu-calibration = <0x00000000 0x00000023
>>  -						       0x00000001 0x00000029
>>  -						       0x00000002 0x0000002f
>>  -						       0x00000003 0x00000035
>>  -						       0x00000004 0x0000003d
>>  -						       0x00000005 0x00000043
>>  -						       0x00000006 0x0000004b
>>  -						       0x00000007 0x00000051
>>  -						       0x00000008 0x00000057
>>  -						       0x00000009 0x0000005f
>>  -						       0x0000000a 0x00000067
>>  -						       0x0000000b 0x0000006f
>>  -
>>  -						       0x00010000 0x0000001b
>>  -						       0x00010001 0x00000023
>>  -						       0x00010002 0x0000002b
>>  -						       0x00010003 0x00000033
>>  -						       0x00010004 0x0000003b
>>  -						       0x00010005 0x00000043
>>  -						       0x00010006 0x0000004b
>>  -						       0x00010007 0x00000055
>>  -						       0x00010008 0x0000005d
>>  -						       0x00010009 0x00000067
>>  -						       0x0001000a 0x00000070
>>  -
>>  -						       0x00020000 0x00000017
>>  -						       0x00020001 0x00000023
>>  -						       0x00020002 0x0000002d
>>  -						       0x00020003 0x00000037
>>  -						       0x00020004 0x00000041
>>  -						       0x00020005 0x0000004b
>>  -						       0x00020006 0x00000057
>>  -						       0x00020007 0x00000063
>>  -						       0x00020008 0x0000006f
>>  -
>>  -						       0x00030000 0x00000015
>>  -						       0x00030001 0x00000021
>>  -						       0x00030002 0x0000002d
>>  -						       0x00030003 0x00000039
>>  -						       0x00030004 0x00000045
>>  -						       0x00030005 0x00000053
>>  -						       0x00030006 0x0000005f
>>  -						       0x00030007 0x00000071>;
>>  +				fsl,tmu-calibration =
>>  +						<0x00000000 0x00000023>,
>>  +						<0x00000001 0x00000029>,
> 
> Can we keep the indentation like below?
> 
> 	fsl,tmu-calibration = <0x00000000 0x00000023>,
> 			      <0x00000001 0x00000029>,
> 			      ...
> 
> 
> Shawn
> 
>>  +						<0x00000002 0x0000002f>,
>>  +						<0x00000003 0x00000035>,
>>  +						<0x00000004 0x0000003d>,
>>  +						<0x00000005 0x00000043>,
>>  +						<0x00000006 0x0000004b>,
>>  +						<0x00000007 0x00000051>,
>>  +						<0x00000008 0x00000057>,
>>  +						<0x00000009 0x0000005f>,
>>  +						<0x0000000a 0x00000067>,
>>  +						<0x0000000b 0x0000006f>,
>>  +
>>  +						<0x00010000 0x0000001b>,
>>  +						<0x00010001 0x00000023>,
>>  +						<0x00010002 0x0000002b>,
>>  +						<0x00010003 0x00000033>,
>>  +						<0x00010004 0x0000003b>,
>>  +						<0x00010005 0x00000043>,
>>  +						<0x00010006 0x0000004b>,
>>  +						<0x00010007 0x00000055>,
>>  +						<0x00010008 0x0000005d>,
>>  +						<0x00010009 0x00000067>,
>>  +						<0x0001000a 0x00000070>,
>>  +
>>  +						<0x00020000 0x00000017>,
>>  +						<0x00020001 0x00000023>,
>>  +						<0x00020002 0x0000002d>,
>>  +						<0x00020003 0x00000037>,
>>  +						<0x00020004 0x00000041>,
>>  +						<0x00020005 0x0000004b>,
>>  +						<0x00020006 0x00000057>,
>>  +						<0x00020007 0x00000063>,
>>  +						<0x00020008 0x0000006f>,
>>  +
>>  +						<0x00030000 0x00000015>,
>>  +						<0x00030001 0x00000021>,
>>  +						<0x00030002 0x0000002d>,
>>  +						<0x00030003 0x00000039>,
>>  +						<0x00030004 0x00000045>,
>>  +						<0x00030005 0x00000053>,
>>  +						<0x00030006 0x0000005f>,
>>  +						<0x00030007 0x00000071>;
>>   				#thermal-sensor-cells =  <1>;
>>   			};
>> 
>>  --
>>  2.33.0
>> 


