Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C83374A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhCKNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:49:41 -0500
Received: from gecko.sbs.de ([194.138.37.40]:40052 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233756AbhCKNt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:49:27 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 12BDnIsa002139
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 14:49:18 +0100
Received: from [167.87.35.81] ([167.87.35.81])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 12BDiHqf005503;
        Thu, 11 Mar 2021 14:44:17 +0100
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: Add support for Siemens IOT2050
 boards
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <cover.1615369068.git.jan.kiszka@siemens.com>
 <9bff40f434e5298890e5d139cc36cc46a0ca2d76.1615369068.git.jan.kiszka@siemens.com>
 <20210311131754.i5ewls6hgeitcgre@astonish>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8d076ff1-cdac-941f-e796-a2e6dba792ab@siemens.com>
Date:   Thu, 11 Mar 2021 14:44:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311131754.i5ewls6hgeitcgre@astonish>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.21 14:17, Nishanth Menon wrote:
> On 10:37-20210310, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> +	spidev@0 {
>> +		compatible = "rohm,dh2228fv";
>> +		spi-max-frequency = <20000000>;
>> +		reg = <0>;
> 
> Jan,
> 
> As part of my final sanity checks, I noticed that we missed this: is a checkpatch warning
> 
> WARNING: DT compatible string "rohm,dh2228fv" appears un-documented -- check ./Documentation/devicetree/bindings/
> #629: FILE: arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi:581:
> 		compatible = "rohm,dh2228fv";
> 
> I cannot pick up nodes that are'nt documented as yaml in
> 	Documentation/devicetree
> 
> I know this is irritating to find such nodes that already have previous
> users and the person coming last gets to deal with "new rules".. but
> sorry for catching this so late.
> 
> Here are the options that come to mind:
> 
> option 1) - drop the node and resubmit.
> 
> option 2) - get the documentation into linux master tree and then submit
> the patches.
> 

As you said, I'm not setting a precedence here:

arch/arm/boot/dts/imx28-cfa10049.dts:                   compatible = "rohm,dh2228fv";
arch/arm/boot/dts/rv1108-elgin-r1.dts:          compatible = "rohm,dh2228fv";
arch/arm/boot/dts/socfpga_cyclone5_socdk.dts:           compatible = "rohm,dh2228fv";
drivers/spi/spidev.c:   { .compatible = "rohm,dh2228fv" },

Was just just never documented as binding? Or why is no one allowed to 
use this anymore? What is to be used instead for spidev?

> 
> I think we should just drop the node and resubmit - since this is a more
> intrusive change and I don't have your platform handy, I am going to
> suggest you make a call :(

This breaks userspace here, and we would need to carry that node on top.

BTW, I already brought up the topic internally to get you some boards 
for testing.

> 
> Additionally please install yamlint and dtbs_schema -> run dtbs_check. I
> see more than a few warnings there which may need some closer look.
> 

I've done that and addressed all that I could (former patch 4). We 
import those from k3, and I don't feel confident how to resolve them.
See also v1 of this patch.

Jan

> 
> A full log against linux-next is here: https://pastebin.ubuntu.com/p/qR69h28c5f/
> 
> 
> PS: https://github.com/nmenon/kernel_patch_verify/blob/master/kpv
> 
> I have been using my script to verify with kpv -C -V -n num_patches and
> then digging through the logs.
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
