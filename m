Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B14361702
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 03:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbhDPBB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 21:01:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39804 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhDPBB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 21:01:28 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13G110x2122418;
        Thu, 15 Apr 2021 20:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618534860;
        bh=eEjVY+csft1qmwgElx92CwbkqgKDWnD3XGOrvQ5KnYw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=zDpFd+8HXXIWqZACjI6QjbV/9EP7dAAJkyUkBblykgx7mgHdyZEtAArzn2FfARDHD
         h0bKqVPCZAoPX1ewbwn/TGsfKID32OKhK8Y9UnXWsatzqiZp1BFDSe3Byt31aUf3C+
         Udq+TfE4fXMZ6S5DETctbqdvbLCXP8HrUibU6nXA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13G110Nu125483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Apr 2021 20:01:00 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Apr 2021 20:01:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 15 Apr 2021 20:01:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13G1104J125843;
        Thu, 15 Apr 2021 20:01:00 -0500
Date:   Thu, 15 Apr 2021 20:01:00 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>, <s-anna@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2] dt-bindings: mailbox: ti,secure-proxy: Convert to yaml
Message-ID: <20210416010100.y3mbfzvx2i3x5dmz@curliness>
References: <20210413224535.30910-1-nm@ti.com>
 <20210415211731.GA1892348@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210415211731.GA1892348@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:17-20210415, Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml
> > new file mode 100644
> > index 000000000000..08a4837fdfcc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml
[...]
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 100
> > +    items:
> > +      - pattern: "^rx_[0-9]{3}$"
> 
> Need to drop the '-' to make this apply to all entries. Otherwise, it's 
> just the first one.

Aaah.. Thanks. done in v3[1]


[1] https://lore.kernel.org/r/20210416005953.17147-1-nm@ti.com
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
