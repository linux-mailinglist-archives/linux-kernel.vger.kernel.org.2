Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94478360B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhDOODG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:03:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34352 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhDOODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:03:03 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13FE2XuY111840;
        Thu, 15 Apr 2021 09:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618495353;
        bh=kppgSo6J3ZDCelEateUO3XXvXeiliwjlCKeOL7fbejk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=umb5N3Gze/EY8rl0i8TD5N2FvBpGOEgdZqBi5ma99sP/Ftrg2GUSo6H791nPFOHaZ
         m5xOOA6VWPG8+osn2TzG5mMS8ceKY8AUxzonhUzZoJsmACzJj7dbUEZSEsZY3V7IjH
         ImYCeXXoACrK1Q4Tc4iqVLdteLrG9N56dfZpjZ6s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13FE2Wce024179
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Apr 2021 09:02:33 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Apr 2021 09:02:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 15 Apr 2021 09:02:32 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13FE2Tcv124197;
        Thu, 15 Apr 2021 09:02:30 -0500
Subject: Re: [PATCH] dt-bindings: mailbox: ti,message-manager: Convert to yaml
To:     Nishanth Menon <nm@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210414002721.23638-1-nm@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <e649b712-071b-0287-a1bc-2de422806619@ti.com>
Date:   Thu, 15 Apr 2021 19:32:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210414002721.23638-1-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[..snip..]

> diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml b/Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml
> new file mode 100644
> index 000000000000..4987e803ac37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/ti,message-manager.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' Message Manager Driver

Driver is not the right word here. Can you change it to node?

Thanks and regards,
Lokesh

