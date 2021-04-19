Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D933364670
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbhDSOur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:50:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47574 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbhDSOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:50:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13JEo6Zb015049;
        Mon, 19 Apr 2021 09:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618843806;
        bh=ADQ0RSQetq2WAGPxcXPK7Ft1yLeNW7b6Jvk0MZ/3yjM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DAY3f+S0fgHzwx5/e3eR+7ecG7JmTz8Xjv7aZXKAwyV4uTJyued+9VBeivNMoQU/f
         HnuHDmsuX/FwTxWsCPUAmkotRh6SQlMmkwIC1eBukUZc97y5fMoAIm3QUH0vGzqfIx
         Ak6+78KvIsL/rTFJ6JgJVb6Dmeafo1mNP4hPRCd0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13JEo6TN076519
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Apr 2021 09:50:06 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Apr 2021 09:50:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 19 Apr 2021 09:50:06 -0500
Received: from [10.250.33.21] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13JEo6T5034030;
        Mon, 19 Apr 2021 09:50:06 -0500
Subject: Re: [PATCH] ARM: dts: keystone-k2g: Rename message-manager node
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210414001926.20002-1-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <e52fe654-a9b7-ca49-d501-1dd01159c787@ti.com>
Date:   Mon, 19 Apr 2021 09:50:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210414001926.20002-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 7:19 PM, Nishanth Menon wrote:
> Rename message-manager instance node name to be better aligned with
> current style of device tree nodes for mailboxes.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
> 
> Santosh:
> - This is'nt critical to queue up for 5.13-rc1 window, but just getting
>   it out of the way. I noticed it as I was converting the binding to
>   yaml. (patch for yaml conversion for the node follows)
> 
>  arch/arm/boot/dts/keystone-k2g.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
> index 05a75019275e..e5c813b5556d 100644
> --- a/arch/arm/boot/dts/keystone-k2g.dtsi
> +++ b/arch/arm/boot/dts/keystone-k2g.dtsi
> @@ -242,7 +242,7 @@ dsp0: dsp@10800000 {
>  			status = "disabled";
>  		};
>  
> -		msgmgr: msgmgr@2a00000 {
> +		msgmgr: mailbox@2a00000 {
>  			compatible = "ti,k2g-message-manager";
>  			#mbox-cells = <2>;
>  			reg-names = "queue_proxy_region",
> 

