Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2848365A93
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhDTNua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:50:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58610 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhDTNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:50:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13KDnjhu055822;
        Tue, 20 Apr 2021 08:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618926585;
        bh=DlY94KcUjSjfa5F5pLvVGHRmAzsJj7II9oSDZ4C16SU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=FOzjTK52xqZ/QUccPx0AO5co7vkYq1n6PPNEntyHC6zTV2z9/ThE6WOuwDCIz+l15
         c49U2KVhwDBHL0NU4DrvMrhbMQ4DTzVrB7BM1+7qfwNI9ZpP5VkmBU4d/RTsK6CvSa
         P+1CsmoGLRLhUefIyxRnB2EZiV2keA8eKHBGCkMk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13KDnjT4122421
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Apr 2021 08:49:45 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Apr 2021 08:49:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Apr 2021 08:49:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13KDni2a040776;
        Tue, 20 Apr 2021 08:49:44 -0500
Date:   Tue, 20 Apr 2021 08:49:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: arm: firmware: Convert linaro,optee-tz to
 json schema
Message-ID: <20210420134944.g6isz36xonsclg5g@reburial>
References: <20210416222518.15801-1-nm@ti.com>
 <CAHUa44GZenrwVWRZW6BKB8cktfXvktJ4OCF0AgPKanYGV01m5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHUa44GZenrwVWRZW6BKB8cktfXvktJ4OCF0AgPKanYGV01m5g@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:32-20210420, Jens Wiklander wrote:
[...]
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > new file mode 100644
> > index 000000000000..6513b5ac8b2c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/firmware/linaro,optee-tz.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> 
> Are these links supposed to work?

I have'nt seen any of them work.. and I think it was intentional. I am
guessing that someday, eventually it might, typically the path beyond
devicetree.org is either in [1] or [2].

[1] https://github.com/devicetree-org/dt-schema
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings
[...]
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
