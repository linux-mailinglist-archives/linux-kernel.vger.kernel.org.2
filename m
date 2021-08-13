Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7FC3EB75B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbhHMPEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:04:25 -0400
Received: from mail.netline.ch ([148.251.143.180]:47467 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbhHMPEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:04:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id AD1DE20201B;
        Fri, 13 Aug 2021 17:03:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ETYiRXdf4Gu5; Fri, 13 Aug 2021 17:03:51 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch [85.2.99.24])
        by netline-mail3.netline.ch (Postfix) with ESMTPA id A87E120201A;
        Fri, 13 Aug 2021 17:03:50 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.94.2)
        (envelope-from <michel@daenzer.net>)
        id 1mEYir-000Dnl-Sf; Fri, 13 Aug 2021 17:03:49 +0200
To:     zhaoxiao <zhaoxiao@uniontech.com>, airlied@linux.ie
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210813085434.3890-1-zhaoxiao@uniontech.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm: radeon: r600_dma: Replace cpu_to_le32() by
 lower_32_bits()
Message-ID: <54590a79-7047-cd6f-0f54-a005bdc69769@daenzer.net>
Date:   Fri, 13 Aug 2021 17:03:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210813085434.3890-1-zhaoxiao@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-13 10:54 a.m., zhaoxiao wrote:
> This patch fixes the following sparse errors:
> drivers/gpu/drm/radeon/r600_dma.c:247:30: warning: incorrect type in assignment (different base types)
> drivers/gpu/drm/radeon/r600_dma.c:247:30:    expected unsigned int volatile [usertype]
> drivers/gpu/drm/radeon/r600_dma.c:247:30:    got restricted __le32 [usertype]
> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  drivers/gpu/drm/radeon/r600_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/radeon/r600_dma.c b/drivers/gpu/drm/radeon/r600_dma.c
> index fb65e6fb5c4f..a2d0b1edcd22 100644
> --- a/drivers/gpu/drm/radeon/r600_dma.c
> +++ b/drivers/gpu/drm/radeon/r600_dma.c
> @@ -244,7 +244,7 @@ int r600_dma_ring_test(struct radeon_device *rdev,
>  	gpu_addr = rdev->wb.gpu_addr + index;
>  
>  	tmp = 0xCAFEDEAD;
> -	rdev->wb.wb[index/4] = cpu_to_le32(tmp);
> +	rdev->wb.wb[index/4] = lower_32_bits(tmp);
>  
>  	r = radeon_ring_lock(rdev, ring, 4);
>  	if (r) {
> 

Seems better to mark rdev->wb.wb as little endian instead. It's read with le32_to_cpu (with some exceptions which look like bugs), which would result in 0xADEDFECA like this.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
