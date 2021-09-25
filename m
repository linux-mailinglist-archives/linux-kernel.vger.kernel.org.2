Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5EC418456
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhIYURg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:17:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44468 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhIYURe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:17:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18PKFurT114280;
        Sat, 25 Sep 2021 15:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632600956;
        bh=vhOb8Imis7G2/SIzVntcXOVpm7P3QGYOTbJMtvjTyNI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tC+Q0opVDkQM/zTFTq1emTHxk0AVmsph2u0Pa2S5eDkqPXwOKQqGOVw8P2abH6qBO
         W9gt7PiJuOb+f6I2ugGjPVtc1/5WHam+T1f43JJv67BVHFAu3KR0VJ8GAWKaNa4qUx
         cg6cJFXAJjiIW5ng7Wzll52o7zT2lMHkxUr60qj4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18PKFusv072509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 25 Sep 2021 15:15:56 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 25
 Sep 2021 15:15:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 25 Sep 2021 15:15:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18PKFtWk090044;
        Sat, 25 Sep 2021 15:15:55 -0500
Date:   Sat, 25 Sep 2021 15:15:55 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Add Vignesh to TI K3 platform maintainership
Message-ID: <20210925201555.4eht5rn7ylytht4k@unseeing>
References: <20210915121308.26795-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210915121308.26795-1-nm@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07:13-20210915, Nishanth Menon wrote:
> Add Vignesh to TI K3 platform maintainership. We will rotate roles for
> each kernel version to help spread the work load a little better.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eeb4c70b3d5b..21d44498674e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2712,6 +2712,7 @@ F:	drivers/power/reset/keystone-reset.c
>  
>  ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE
>  M:	Nishanth Menon <nm@ti.com>
> +M:	Vignesh Raghavendra <vigneshr@ti.com>
>  M:	Tero Kristo <kristo@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
> -- 
> 2.32.0
> 


Tero: Any chance of getting your ack?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
