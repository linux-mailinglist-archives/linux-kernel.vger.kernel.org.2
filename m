Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F773A1DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 22:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhFIUCI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 16:02:08 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:42590 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhFIUCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:02:07 -0400
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id B87917A025C;
        Wed,  9 Jun 2021 22:00:10 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: nouveau broken on Riva TNT2 in 5.13.0-rc4: NULL pointer dereference in nouveau_bo_sync_for_device
Date:   Wed, 9 Jun 2021 22:00:07 +0200
User-Agent: KMail/1.9.10
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <202106052143.52488.linux@zary.sk> <202106090910.51188.linux@zary.sk> <762c1044-6e3a-48fc-95e4-1730b6ef2a2e@amd.com>
In-Reply-To: <762c1044-6e3a-48fc-95e4-1730b6ef2a2e@amd.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <202106092200.08088.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 June 2021 11:21:05 Christian König wrote:
> Am 09.06.21 um 09:10 schrieb Ondrej Zary:
> > On Wednesday 09 June 2021, Christian König wrote:
> >> Am 09.06.21 um 08:57 schrieb Ondrej Zary:
> >>> [SNIP]
> >>>> Thanks for the heads up. So the problem with my patch is already fixed,
> >>>> isn't it?
> >>> The NULL pointer dereference in nouveau_bo_wr16 introduced in
> >>> 141b15e59175aa174ca1f7596188bd15a7ca17ba was fixed by
> >>> aea656b0d05ec5b8ed5beb2f94c4dd42ea834e9d.
> >>>
> >>> That's the bug I hit when bisecting the original problem:
> >>> NULL pointer dereference in nouveau_bo_sync_for_device
> >>> It's caused by:
> >>> # first bad commit: [e34b8feeaa4b65725b25f49c9b08a0f8707e8e86] drm/ttm: merge ttm_dma_tt back into ttm_tt
> >> Good that I've asked :)
> >>
> >> Ok that's a bit strange. e34b8feeaa4b65725b25f49c9b08a0f8707e8e86 was
> >> created mostly automated.
> >>
> >> Do you have the original backtrace of that NULL pointer deref once more?
> > The original backtrace is here: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2021%2F6%2F5%2F350&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Ce905b6bd2aa842ace15508d92b15b96d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637588195000729460%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=zFqheBbJcOHtYgqG%2Fs63AT1dwuk4REmUDJWHvzaLAlc%3D&amp;reserved=0
> 
> And the problem is that ttm_dma->dma_address is NULL, right? Mhm, I 
> don't see how that can happen since nouveau is using ttm_sg_tt_init().
> 
> Apart from that what nouveau does here is rather questionable since you 
> need a coherent architecture for most things anyway, but that's not what 
> we are trying to fix here.
> 
> Can you try to narrow down if ttm_sg_tt_init is called before calling 
> this function for the tt object in question?

ttm_sg_tt_init is not called:
[   12.150124] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
[   12.150133] nouveau 0000:01:00.0: DRM: GART: 128 MiB
[   12.150143] nouveau 0000:01:00.0: DRM: BMP version 5.6
[   12.150151] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
[   12.151362] ttm_tt_init
[   12.151370] ttm_tt_init_fields
[   12.151374] ttm_tt_alloc_page_directory
[   12.151615] BUG: kernel NULL pointer dereference, address: 00000000



-- 
Ondrej Zary
