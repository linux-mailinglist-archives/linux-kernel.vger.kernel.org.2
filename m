Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C648337398
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhCKNSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:18:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42148 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhCKNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:18:06 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BDHs9b044916;
        Thu, 11 Mar 2021 07:17:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615468674;
        bh=oebGbjZf1CUZSOme8bgvj9xynU4AedYVMPSzbHOpfgk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dfUepoWa1DnnFpu7YlsrBHQ3qoa401BIeSUHnvJ5vDIfBHYktrLBEN6Upm3uA/Hpp
         RqOBf0z4UQz/5M8lawJMmlNUULwnTRqtpopVrxQZChx54n13mUm34KRPcGcUdVly9/
         NX2vjcG/MN1Wyb8KR7+svkwx8aNN0F59ckSdkAMU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BDHsRA044775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 07:17:54 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 07:17:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 07:17:54 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BDHsPQ124750;
        Thu, 11 Mar 2021 07:17:54 -0600
Date:   Thu, 11 Mar 2021 07:17:54 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: Add support for Siemens IOT2050
 boards
Message-ID: <20210311131754.i5ewls6hgeitcgre@astonish>
References: <cover.1615369068.git.jan.kiszka@siemens.com>
 <9bff40f434e5298890e5d139cc36cc46a0ca2d76.1615369068.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9bff40f434e5298890e5d139cc36cc46a0ca2d76.1615369068.git.jan.kiszka@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:37-20210310, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> +	spidev@0 {
> +		compatible = "rohm,dh2228fv";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;

Jan,

As part of my final sanity checks, I noticed that we missed this: is a checkpatch warning

WARNING: DT compatible string "rohm,dh2228fv" appears un-documented -- check ./Documentation/devicetree/bindings/
#629: FILE: arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi:581:
		compatible = "rohm,dh2228fv";

I cannot pick up nodes that are'nt documented as yaml in
	Documentation/devicetree

I know this is irritating to find such nodes that already have previous
users and the person coming last gets to deal with "new rules".. but
sorry for catching this so late.

Here are the options that come to mind:

option 1) - drop the node and resubmit.

option 2) - get the documentation into linux master tree and then submit
the patches.


I think we should just drop the node and resubmit - since this is a more
intrusive change and I don't have your platform handy, I am going to
suggest you make a call :(

Additionally please install yamlint and dtbs_schema -> run dtbs_check. I
see more than a few warnings there which may need some closer look.


A full log against linux-next is here: https://pastebin.ubuntu.com/p/qR69h28c5f/


PS: https://github.com/nmenon/kernel_patch_verify/blob/master/kpv

I have been using my script to verify with kpv -C -V -n num_patches and
then digging through the logs.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
