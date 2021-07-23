Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003943D3CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhGWPIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:08:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33348 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235472AbhGWPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:08:10 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NFlc19019262;
        Fri, 23 Jul 2021 17:48:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=qRGG2i9Lrz9yXza6u0c0FNllWgMq1WbeZtqIwyy2/Go=;
 b=RW4bLVnkejOvfzx744xMBFRMn6Zx6my+ih8tRlSRcJ9mn9YF9z6oKKp1IqoNdRjAFg/k
 Pav4Qj5K+/rOrbXGNm56segpb+CQIer+Nmo23XjomsuWoh9N7mulMrKvM/XeVelffY8+
 EzzycuXLP9LX1CZRQVFsG9xJRP2DxM4jDAxgw9FvByQp2AQrnlUQ5GHVuMcL0AZ1UAkp
 8F6oY18NO/Z44F1nAUcrFy4/asHTTJ+vNNVsxk6I8zecF3ZHXt+cxYSXrjvAIPnRriPS
 qjkBYIiF1VgOaVyBfrj5ou290ZPQ4k9wDTQTPW6aH1QsA1xNwxFaZarZ+u72rhoLmDb2 qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39yt68a4w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 17:48:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF61310002A;
        Fri, 23 Jul 2021 17:48:39 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B026C22A6D5;
        Fri, 23 Jul 2021 17:48:39 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Jul
 2021 17:48:39 +0200
Subject: Re: [PATCH] MAINTAINERS: Update Benjamin Gaignard maintainer status
To:     Arnd Bergmann <arnd@arndb.de>
References: <20210706163033.795805-1-benjamin.gaignard@collabora.com>
CC:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        <linux-kernel@vger.kernel.org>,
        Philippe CORNU <philippe.cornu@st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <a1df40c2-f414-56e9-2e42-83e28ad54cee@foss.st.com>
Date:   Fri, 23 Jul 2021 17:48:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706163033.795805-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_08:2021-07-23,2021-07-23 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd

On 7/6/21 6:30 PM, Benjamin Gaignard wrote:
> Update Benjamin Gaignard address and remove it from no more maintained
> drivers.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

How to handle this kind of patch ? Do I take it or do you take it 
directly through arm-soc tree ?

regards
Alex

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
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/media/stih-cec.txt
>   F:	drivers/media/cec/platform/sti/
> 

