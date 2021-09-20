Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A184E41279E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 23:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhITVBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 17:01:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35762 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbhITU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:59:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18KKvprO118661;
        Mon, 20 Sep 2021 15:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632171471;
        bh=OAlLenG3KBpsC940vecYGOKh/e9SP3yN0HVVeoPp9Pg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s3/TEeFBahX4ZVwqIXu3D+/5F6swSyeIX5/DpgZLuhSZkNwQP7cM6Wcxc4AzBJqb0
         bM3Rw3mnB5I6O+JijNSeh+V8bZAEfLuh8M1O/ZBcUaeUOEGuSigdKC8lANEv+6b3Pw
         4tmvo6G1nSutDeTbz6tgVVwBCOpcIBmT7wctbhS0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18KKvoVW038268
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 15:57:51 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 15:57:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 15:57:50 -0500
Received: from [10.250.37.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18KKvo9j090764;
        Mon, 20 Sep 2021 15:57:50 -0500
Subject: Re: [PATCH V3] dt-bindings: hwlock: omap: Remove redundant binding
 example
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
References: <20210920123152.32751-1-sinthu.raja@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <cfb1b8eb-327f-1f2b-9939-df06c9d5f692@ti.com>
Date:   Mon, 20 Sep 2021 15:57:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920123152.32751-1-sinthu.raja@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 7:31 AM, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The example includes a board-specific compatible property, this is wrong
> as the example should be board agnostic and should represent the particular
> binding. Also, the file includes two similar examples but with a different
> compatible. So, drop the entire second example
> 
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> 
> ---
> 
> Changes in V3:
> Addressed review comment, that includes adding Suggested By: tag to the 
> commit message
> 
> V2: https://lore.kernel.org/all/20210917170805.5079-1-sinthu.raja@ti.com/
> V1: https://lore.kernel.org/all/20210917094740.18891-1-sinthu.raja@ti.com/
> 
>  .../bindings/hwlock/ti,omap-hwspinlock.yaml   | 33 +------------------
>  1 file changed, 1 insertion(+), 32 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
> index ae1b37dbee75..0a955c7b9706 100644
> --- a/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
> +++ b/Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
> @@ -39,39 +39,8 @@ additionalProperties: false
>  examples:
>  
>    - |
> -    /* OMAP4 SoCs */
> -    hwspinlock: spinlock@4a0f6000 {
> +    spinlock@4a0f6000 {
>          compatible = "ti,omap4-hwspinlock";
>          reg = <0x4a0f6000 0x1000>;
>          #hwlock-cells = <1>;
>      };
> -
> -  - |
> -    / {
> -        /* K3 AM65x SoCs */
> -        model = "Texas Instruments K3 AM654 SoC";
> -        compatible = "ti,am654-evm", "ti,am654";
> -        #address-cells = <2>;
> -        #size-cells = <2>;
> -
> -        bus@100000 {
> -            compatible = "simple-bus";
> -            #address-cells = <2>;
> -            #size-cells = <2>;
> -            ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
> -                     <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>; /* Main NavSS */
> -
> -            bus@30800000 {
> -                compatible = "simple-mfd";
> -                #address-cells = <2>;
> -                #size-cells = <2>;
> -                ranges = <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>;
> -
> -                spinlock@30e00000 {
> -                    compatible = "ti,am654-hwspinlock";
> -                    reg = <0x00 0x30e00000 0x00 0x1000>;
> -                    #hwlock-cells = <1>;
> -                };
> -            };
> -        };
> -    };
> 

