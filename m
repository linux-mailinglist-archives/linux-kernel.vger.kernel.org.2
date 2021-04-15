Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6D360B93
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhDOOOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:14:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52784 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhDOON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:13:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13FEDMS4080848;
        Thu, 15 Apr 2021 09:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618496002;
        bh=5YT4Chv8mcz9fg6kjX7nJNPI+VOiKdBSqrEsz1/Lbd4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZxRZGOZIgQZ6xsENZGmqYsFwRhtOzaIrZ2JPiEJY5Qh6sLUON28GkgRT1zzJQxmZo
         B8H+YjnHkNJ6i8TcmRBWLVLkA+klPikfZvEpuF1/ylf2/XIsHEiPsT6tKUfWmOmFwe
         qur5gz0xJ5YgQ+LLnWPjK6Ig0MSYqQlm2UVaQ0jc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13FEDMLN057555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Apr 2021 09:13:22 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Apr 2021 09:13:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 15 Apr 2021 09:13:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13FEDL52023697;
        Thu, 15 Apr 2021 09:13:21 -0500
Date:   Thu, 15 Apr 2021 09:13:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: mailbox: ti,message-manager: Convert to yaml
Message-ID: <20210415141321.fbzzjgwpavoggpqh@endless>
References: <20210414002721.23638-1-nm@ti.com>
 <e649b712-071b-0287-a1bc-2de422806619@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e649b712-071b-0287-a1bc-2de422806619@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:32-20210415, Lokesh Vutla wrote:
> [..snip..]
> 
> > diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml b/Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml
> > new file mode 100644
> > index 000000000000..4987e803ac37
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/ti,message-manager.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mailbox/ti,message-manager.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments' Message Manager Driver
> 
> Driver is not the right word here. Can you change it to node?


Indeed, thanks. v2 incoming. I also noticed a commit message typo while
at it.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
