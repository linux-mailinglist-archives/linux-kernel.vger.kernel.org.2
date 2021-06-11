Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50693A4890
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhFKSZO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Jun 2021 14:25:14 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:51094 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFKSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:25:13 -0400
Received: from [192.168.0.2] (unknown [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id F2EDD7A024A;
        Fri, 11 Jun 2021 20:23:13 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: nouveau broken on Riva TNT2 in 5.13.0-rc4: NULL pointer dereference in nouveau_bo_sync_for_device
Date:   Fri, 11 Jun 2021 20:23:10 +0200
User-Agent: KMail/1.9.10
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <202106052143.52488.linux@zary.sk> <d4e5042c-3981-02b0-4b9e-fa2c8e373be4@amd.com> <4b4248d8-b708-3832-7fe3-2a9fd2c2311e@amd.com>
In-Reply-To: <4b4248d8-b708-3832-7fe3-2a9fd2c2311e@amd.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <202106112023.11270.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 June 2021 14:38:18 Christian König wrote:
> 
> Am 10.06.21 um 19:59 schrieb Christian König:
> > Am 10.06.21 um 19:50 schrieb Ondrej Zary:
> >> [SNIP]
> >>> I can't see how this is called from the nouveau code, only 
> >>> possibility I
> >>> see is that it is maybe called through the AGP code somehow.
> >> Yes, you're right:
> >> [   13.192663] Call Trace:
> >> [   13.192678]  dump_stack+0x54/0x68
> >> [   13.192690]  ttm_tt_init+0x11/0x8a [ttm]
> >> [   13.192699]  ttm_agp_tt_create+0x39/0x51 [ttm]
> >> [   13.192840]  nouveau_ttm_tt_create+0x17/0x22 [nouveau]
> >> [   13.192856]  ttm_tt_create+0x78/0x8c [ttm]
> >> [   13.192864]  ttm_bo_handle_move_mem+0x7d/0xca [ttm]
> >> [   13.192873]  ttm_bo_validate+0x92/0xc8 [ttm]
> >> [   13.192883]  ttm_bo_init_reserved+0x216/0x243 [ttm]
> >> [   13.192892]  ttm_bo_init+0x45/0x65 [ttm]
> >> [   13.193018]  ? nouveau_bo_del_io_reserve_lru+0x48/0x48 [nouveau]
> >> [   13.193150]  nouveau_bo_init+0x8c/0x94 [nouveau]
> >> [   13.193273]  ? nouveau_bo_del_io_reserve_lru+0x48/0x48 [nouveau]
> >> [   13.193407]  nouveau_bo_new+0x44/0x57 [nouveau]
> >> [   13.193537]  nouveau_channel_prep+0xa3/0x269 [nouveau]
> >> [   13.193665]  nouveau_channel_new+0x3c/0x5f7 [nouveau]
> >> [   13.193679]  ? slab_free_freelist_hook+0x3b/0xa7
> >> [   13.193686]  ? kfree+0x9e/0x11a
> >> [   13.193781]  ? nvif_object_sclass_put+0xd/0x16 [nouveau]
> >> [   13.193908]  nouveau_drm_device_init+0x2e2/0x646 [nouveau]
> >> [   13.193924]  ? pci_enable_device_flags+0x1e/0xac
> >> [   13.194052]  nouveau_drm_probe+0xeb/0x188 [nouveau]
> >> [   13.194182]  ? nouveau_drm_device_init+0x646/0x646 [nouveau]
> >> [   13.194195]  pci_device_probe+0x89/0xe9
> >> [   13.194205]  really_probe+0x127/0x2a7
> >> [   13.194212]  driver_probe_device+0x5b/0x87
> >> [   13.194219]  device_driver_attach+0x2e/0x41
> >> [   13.194226]  __driver_attach+0x7c/0x83
> >> [   13.194232]  bus_for_each_dev+0x4c/0x66
> >> [   13.194238]  driver_attach+0x14/0x16
> >> [   13.194244]  ? device_driver_attach+0x41/0x41
> >> [   13.194251]  bus_add_driver+0xc5/0x16c
> >> [   13.194258]  driver_register+0x87/0xb9
> >> [   13.194265]  __pci_register_driver+0x38/0x3b
> >> [   13.194271]  ? 0xf0c0d000
> >> [   13.194362]  nouveau_drm_init+0x14c/0x1000 [nouveau]
> >>
> >> How is ttm_dma_tt->dma_address allocated?
> >
> > Mhm, I need to double check how AGP is supposed to work.
> >
> > Since barely anybody is using it these days it is something which 
> > breaks from time to time.
> 
> I have no idea how that ever worked in the first place since AGP isn't 
> supposed to sync between CPU/GPU. Everything is coherent for that case.
> 
> Anyway here is a patch which adds a check to those functions if the 
> dma_address array is allocated in the first place. Please test it.

Thanks, the patch fixes the problem and nouveau now works!
Should be applied to 5.12-stable too (5.11 is affected too but EOL).

It's weird that it worked before.
Looks like dma_address was used uninitialized - it contained some random
crap:
[   12.293304] nouveau_bo_sync_for_device: ttm_dma->dma_address=3e055971 ttm_dma->ttm.num_pages=18
[   12.293321] ttm_dma->dma_address[0]=0x0
[   12.293341] ttm_dma->dma_address[1]=0x0
[   12.293360] ttm_dma->dma_address[2]=0xee728980
[   12.293379] ttm_dma->dma_address[3]=0xed1cb120
[   12.293397] ttm_dma->dma_address[4]=0x12
[   12.293416] ttm_dma->dma_address[5]=0x0
[   12.293434] ttm_dma->dma_address[6]=0x1
[   12.293453] ttm_dma->dma_address[7]=0x0
[   12.293471] ttm_dma->dma_address[8]=0x10000
[   12.293490] ttm_dma->dma_address[9]=0x0
[   12.293510] ttm_dma->dma_address[10]=0x101
[   12.293528] ttm_dma->dma_address[11]=0xee7289ec
[   12.293546] ttm_dma->dma_address[12]=0xee7289ec
[   12.293564] ttm_dma->dma_address[13]=0x0
[   12.293581] ttm_dma->dma_address[14]=0x0
[   12.293599] ttm_dma->dma_address[15]=0x0
[   12.293616] ttm_dma->dma_address[16]=0x0
[   12.293634] ttm_dma->dma_address[17]=0x0
But it did not matter as dma_sync_single_for_device is a no-op here.
When dma_address is properly initialized to NULL, it crashes...

> Thanks,
> Christian.
> 
> >
> > Thanks for the backtrace,
> > Christian.
> >
> >>   I cannot find any assignment
> >> executed (in the working code):
> >>
> >> $ git grep dma_address\ = drivers/gpu/
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c: 
> >> sg->sgl->dma_address = addr;
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: dma_address = 
> >> &dma->dma_address[offset >> PAGE_SHIFT];
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: dma_address = 
> >> (mm_node->start << PAGE_SHIFT) + offset;
> >> drivers/gpu/drm/i915/gvt/scheduler.c:   sg->dma_address = addr;
> >> drivers/gpu/drm/i915/i915_gpu_error.c:  sg->dma_address = it;
> >> drivers/gpu/drm/ttm/ttm_tt.c:   ttm->dma_address = (void *) 
> >> (ttm->ttm.pages + ttm->ttm.num_pages);
> >> drivers/gpu/drm/ttm/ttm_tt.c:   ttm->dma_address = 
> >> kvmalloc_array(ttm->ttm.num_pages,
> >> drivers/gpu/drm/ttm/ttm_tt.c:   ttm_dma->dma_address = NULL;
> >> drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c: viter->dma_address = 
> >> &__vmw_piter_phys_addr;
> >> drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c: viter->dma_address = 
> >> &__vmw_piter_dma_addr;
> >> drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c: viter->dma_address = 
> >> &__vmw_piter_sg_addr;
> >>
> >> The 2 cases in ttm_tt.c are in ttm_dma_tt_alloc_page_directory() and
> >> ttm_sg_tt_alloc_page_directory().
> >> Confirmed by adding printk()s that they're NOT called.
> >>
> >>
> >
> 
> 


-- 
Ondrej Zary
