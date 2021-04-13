Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E858735E90A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347388AbhDMWcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:32:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41146 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhDMWce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:32:34 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13DMW4qj061599;
        Tue, 13 Apr 2021 17:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618353124;
        bh=g3Uj5oKoRetQcqjIjTP9fZPMWn8RjY1mygO0kmVEe2U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DjMsAHimnLQQeFEtybspxkITnTt4MlMOexQmGLVtKNVh9HBeJceQSsNE+oAtwkzdJ
         OpnZ188Qf52IX0njVnUXycsUD6vAiNgXVi1G2qUlJSv/jI+sWbhweBDQAc85ev7Kp6
         1m+C3iynfpLAtFtQovY/w+8vmp8dzypuIM2jHrXM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13DMW4pn057401
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Apr 2021 17:32:04 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Apr 2021 17:32:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Apr 2021 17:32:04 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13DMW3kj008151;
        Tue, 13 Apr 2021 17:32:03 -0500
Date:   Tue, 13 Apr 2021 17:32:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <s-anna@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: mailbox: ti,secure-proxy: Convert to yaml
Message-ID: <20210413223203.fracjesde642msmv@blaspheme>
References: <20210413171230.5872-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210413171230.5872-1-nm@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:12-20210413, Nishanth Menon wrote:
[...]
> +properties:
> +  $nodename:
> +    pattern: "^mailbox@[0-9a-f]+$"
> +
> +  compatible:
> +    const: ti,am654-secure-proxy
> +
> +  "#mbox-cells":
> +    const: 1
> +
> +  reg-names:
> +    items:
> +      - const: target_data
> +      - const: rt
> +      - const: scfg
> +
> +  reg:
> +    minItems: 3
> +
> +  interrupt-names:
> +    minItems: 1
> +    description:
> +      Contains the interrupt name information for the Rx interrupt path for
> +      secure proxy.
> +
> +  interrupts:
> +    minItems: 1
> +    description:
> +      Contains the interrupt information for the Rx interrupt path for secure


I think I can strengthen it quite a bit here. let me post a v2 further
that has lesser information loss in the conversion and checks are
stronger.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
