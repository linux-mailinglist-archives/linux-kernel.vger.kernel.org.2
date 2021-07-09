Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D02C3C2384
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhGIMl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:41:27 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:46195 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231472AbhGIMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:41:26 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169CbnBI018342;
        Fri, 9 Jul 2021 14:38:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ur+Vf9OwO1YuqjU0KxtHrWV91OHFXR/DMg2GFchF+cs=;
 b=ELUEGHrcfT2zf/Y7kbuSQ/PfQn7OlxbM6uBDoJl87LvBsxi/ycjhmVnJOYRbWAgwi9A1
 WuK9hoGAEHclKSNggWLLehUn+qqNTR5Qit457zlUqQlThuoK+/PBEjOExVdFFmIKsh2p
 dY5OJxbTbsleBXUWqJV15Ur7TysPaF4GlCmIrtuX0dNUK1x1Jg0nQl5DsCmRuoGcdGsm
 w1uDS7d0u/Sz6sRGbgKbHCdL68OZzb0Daw46jP+C7sBW/DBvXmTJVRx/h3s1d0IDDGrM
 1qrsw3E3ivSuUER6zrnGrZ59XP4en3TZkCV6VujobwJ9R+uC1JGUvo6Flq6Q38y2IhvX Dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39pe94tsat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 14:38:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C6E0110002A;
        Fri,  9 Jul 2021 14:38:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8B2942238DD;
        Fri,  9 Jul 2021 14:38:40 +0200 (CEST)
Received: from lmecxl0993.lme.st.com (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Jul
 2021 14:38:40 +0200
Subject: Re: [PATCH] MAINTAINERS: Update Benjamin Gaignard maintainer status
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        <linux-kernel@vger.kernel.org>
References: <20210706163033.795805-1-benjamin.gaignard@collabora.com>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
Message-ID: <a198aace-cdeb-1832-e510-2abfa9426a2f@foss.st.com>
Date:   Fri, 9 Jul 2021 14:38:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706163033.795805-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_05:2021-07-09,2021-07-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/21 6:30 PM, Benjamin Gaignard wrote:
> Update Benjamin Gaignard address and remove it from no more maintained
> drivers.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>   MAINTAINERS | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c5ee008301a6..c6356cd0446a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5460,7 +5460,7 @@ F:	tools/testing/selftests/dma/
>   
>   DMA-BUF HEAPS FRAMEWORK
>   M:	Sumit Semwal <sumit.semwal@linaro.org>
> -R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
> +R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
>   R:	Liam Mark <lmark@codeaurora.org>
>   R:	Laura Abbott <labbott@redhat.com>
>   R:	Brian Starkey <Brian.Starkey@arm.com>
> @@ -6141,7 +6141,6 @@ F:	Documentation/devicetree/bindings/display/rockchip/
>   F:	drivers/gpu/drm/rockchip/
>   
>   DRM DRIVERS FOR STI
> -M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git git://anongit.freedesktop.org/drm/drm-misc
> @@ -6151,7 +6150,6 @@ F:	drivers/gpu/drm/sti
>   DRM DRIVERS FOR STM
>   M:	Yannick Fertre <yannick.fertre@foss.st.com>
>   M:	Philippe Cornu <philippe.cornu@foss.st.com>
> -M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git git://anongit.freedesktop.org/drm/drm-misc
> @@ -17453,7 +17451,6 @@ F:	Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
>   F:	sound/soc/sti/
>   
>   STI CEC DRIVER
> -M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>

Hi Benjamin,

And above all, a very *big thank you*! You have been an experienced and 
inspiring maintainer all these years.

For DRM DRIVERS FOR STI, DRM DRIVERS FOR STM and STI CEC DRIVER:
Reviewed-by: Philippe Cornu <philippe.cornu@foss.st.com>

Note: We will send soon new names for DRM DRIVERS FOR STI and STI CEC 
DRIVER.

Many thanks
Philippe :-)


>   S:	Maintained
>   F:	Documentation/devicetree/bindings/media/stih-cec.txt
>   F:	drivers/media/cec/platform/sti/
> 
