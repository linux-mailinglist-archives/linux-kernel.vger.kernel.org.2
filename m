Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115173CFC44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhGTNr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:47:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55324 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbhGTNdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:33:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16KEDbRn089496;
        Tue, 20 Jul 2021 09:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626790417;
        bh=iiYeMeyFkrKOch2McMFiTZRBVD68ZbhGYOg+JJfCxuw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZBWJ0R4ELhDtxzGEWOwO3tMwTCPzOiue4Wwr2Z19xjCvDG1UYq75fcVZsmiAQ6//Q
         fXcCg79kI8XZ10q4cyhOMOUHsPqoANFEV7W0FYB/OG3v86tKjrIMZTwlHF3+OCJFyI
         P8I1NMF2c6PeEh1Urr85TeKCO2ifFyAfMFBBVUL0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16KEDbuu115074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jul 2021 09:13:37 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 09:13:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Jul 2021 09:13:36 -0500
Received: from [10.250.234.142] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16KEDWI6098672;
        Tue, 20 Jul 2021 09:13:33 -0500
Subject: Re: [PATCH] dt-bindings: mtd: spi-nand: Convert to DT schema format
To:     Rob Herring <robh@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210718004125.733-1-a-nandan@ti.com>
 <1626702448.437777.1811203.nullmailer@robh.at.kernel.org>
From:   "Nandan, Apurva" <a-nandan@ti.com>
Message-ID: <18c17c21-82de-32d5-912b-3158a037ec8c@ti.com>
Date:   Tue, 20 Jul 2021 19:43:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1626702448.437777.1811203.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19-Jul-21 7:17 PM, Rob Herring wrote:
> On Sun, 18 Jul 2021 00:41:25 +0000, Apurva Nandan wrote:
>> Convert spi-nand.txt binding to YAML format with an added example.
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>  .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
>>  .../devicetree/bindings/mtd/spi-nand.yaml     | 74 +++++++++++++++++++
>>  2 files changed, 74 insertions(+), 5 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
>>  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml: spi-flash@1: $nodename:0: 'spi-flash@1' does not match '^flash(@.*)?$'

I propose to change the nodename in snps,dw-apb-ssi.yaml from
'spi-flash@1' to 'flash@1', making it similar to the convention followed
by jedec,spi-nor.yaml. Currently, there is no user of snps,dw-apb-ssi
with a spi-nand as child node, so let's make the node name uniform
across different types of flashes i.e. 'flash@*'. What do you suggest?

> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml: spi-flash@1: 'rx-sample-delay-ns' does not match any of the regexes: '^otp(-[0-9]+)?$', '^partition@', 'pinctrl-[0-9]+'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> \ndoc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1506558
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Yes, yamllint was not installed. I will correct them and send as v2.

Thanks,
Apurva Nandan
