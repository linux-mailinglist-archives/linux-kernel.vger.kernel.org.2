Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B30416591
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbhIWTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:01:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47346 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhIWTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:01:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18NIx6kg010807;
        Thu, 23 Sep 2021 13:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632423546;
        bh=8FiQ79nvdAQVZ3eveOp9w7xiAk/Itwx8l0UKnlfYlmA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=e7qCP915ren9z/q/L9tgu8Vs16nvaLUsLjq0sVTkqwUcRNBbKvlB7sEeNdaoA92eu
         RB1u9rsFDnGrwAAgfz7Xt5XA4cuwKPfeAUomnAa6PIXckGjEZMGIGG4p5+la3Xx7mQ
         qO+Q46S7Ti0lQxki4/iTQlX5J3+snw9n36EPxSvY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18NIx6NA045820
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Sep 2021 13:59:06 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Sep 2021 13:59:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Sep 2021 13:59:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18NIx5BM002948;
        Thu, 23 Sep 2021 13:59:05 -0500
Date:   Fri, 24 Sep 2021 00:29:04 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <dinguyen@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <tn@semihalf.com>,
        <ka@semihalf.com>, <jam@semihalf.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH 1/3] dt-bindings: mtd: spi-nor: add n25q00 schema
Message-ID: <20210923185902.6wgkuz4jcelcawrq@ti.com>
References: <20210920124141.1166544-1-pan@semihalf.com>
 <20210920124141.1166544-2-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210920124141.1166544-2-pan@semihalf.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tudor

On 20/09/21 02:41PM, Paweł Anikiel wrote:
> Add schema for the n25q00 NOR flash memory.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index ed590d7c6e37..efb3c5e05c5a 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -18,7 +18,7 @@ properties:
>        - items:
>            - pattern: "^((((micron|spansion|st),)?\
>                (m25p(40|80|16|32|64|128)|\
> -              n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
> +              n25q(00|32b|064|128a11|128a13|256a|512a|164k)))|\

IIUC this is supposed to only be for legacy/old flashes that started out 
using flash-specific compatibles. Any new flashes should simply use 
jedec,spi-nor unless there is a legitimate reason to do so.

Until you justify that reason,

Nacked-by: Pratyush Yadav <p.yadav@ti.com>

>                atmel,at25df(321a|641|081a)|\
>                everspin,mr25h(10|40|128|256)|\
>                (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|\
> -- 
> 2.25.1

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
