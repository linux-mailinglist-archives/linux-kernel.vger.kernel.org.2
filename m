Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AAA40D926
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhIPL7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:59:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39452 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbhIPL7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:59:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18GBvuCs083945;
        Thu, 16 Sep 2021 06:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631793476;
        bh=mOU4i/nCDSwk/pjLnX5ytEKK2R6Otmifat5H8NlpkLU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=b/Q8VX4KJ84ym0BSvHQSsz7nC6+mEAFDvEUS6E1jVbUYz3MVhazU1EPOUDKxUlrUL
         Rt3130EuHnYGXD/Yp/g/6CJIqaMyUTsqxeeQIvtX0TKGmRIi/4aIBYunKBa3wuckzE
         LHLNyaNDtqMEFxPANZ5vU1mHA72uk8Vx7FuUMU1w=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18GBvt28015765
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Sep 2021 06:57:55 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 16
 Sep 2021 06:57:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 16 Sep 2021 06:57:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18GBvA0O001999;
        Thu, 16 Sep 2021 06:57:10 -0500
Date:   Thu, 16 Sep 2021 06:57:10 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 15/23] MAINTAINERS: update ti,sci.yaml reference
Message-ID: <20210916115710.wz63pvfjm6gndiup@squid>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
 <271a85356c045155fc92cbfdd4f76594dc789ced.1631785820.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <271a85356c045155fc92cbfdd4f76594dc789ced.1631785820.git.mchehab+huawei@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:55-20210916, Mauro Carvalho Chehab wrote:
> Changeset 5a9652f6994e ("dt-bindings: arm: keystone: Convert ti,sci to json schema")
> renamed: Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> to: Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 5a9652f6994e ("dt-bindings: arm: keystone: Convert ti,sci to json schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


Thanks.

Reviewed-by: Nishanth Menon <nm@ti.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9cf038e2c783..3bc18cfe73a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18546,7 +18546,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
> -F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>  F:	Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
> -- 
> 2.31.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
