Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0F38BD27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 06:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhEUEFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 00:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhEUEFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 00:05:44 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AABC061574;
        Thu, 20 May 2021 21:04:21 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id w1so14411636ybt.1;
        Thu, 20 May 2021 21:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGq5qqdhsu4fbZTN1KN4R8bXwjcBxCAudfPNgsYOJaY=;
        b=eXL5hnouP4KynYCOj5rsf4WIxiufxzSBHFNa68yiakU63CZdHb4/LcbkkAvwXEpVWM
         jKxOjdFrL2rlS2X4lcpLVHmLJTjWKHJNEBTK/ujlF182LLmDua84p9Chl+AJEdiN527V
         LpbF5j/M0xTV+T7MiL5Tqvw2GOcsUP+Uy2YV1LyiLSeJBgDBhc6zV4ij+bi3au+LEgVj
         jEOg5JoBMnTax9KxzujSU5JxRPKL7hBgAnJkZjGmnIyscwP1YnLgvgAL/3ejYoBYYmFd
         s7N2VCq34luVqn23CEqLg1piUmAjD8I9BfsFgYd2bJWkm4FbkXRoPo0ZgWrw5YNeliZv
         qQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGq5qqdhsu4fbZTN1KN4R8bXwjcBxCAudfPNgsYOJaY=;
        b=Y0QOFpyQvjq9MtDkeYLCBg77H5PdUIbtU+kkS6S2DO6lrHrom0DKFW9jduyopSk+yj
         D1jjaJgid2ww7zfn4FBcVH1UEBnD+x0WfbCcFeGXdjMdQ3BtRVoLryFubRSy7L8Lnyxq
         Q4Tf3CgveBF7ON9zeVN7UUGmLyMwbR8RLyVGadnO/wvulFgAGJUfadx9xHgZzABuyvj+
         5K7rsV+fSXLQs6yilQJvNJZi6kGqkZwxTLEfXa93HoD/teIAXSIZTAd8v7papaIQDzMd
         UwdWf4Z0w9Q7BM8HdwncLj8+BXuyAuJfnCmqpz15Vv99M5LhBD0uDL7QT8jiKC9bLIPt
         4drw==
X-Gm-Message-State: AOAM530jEGP3iKAHopJaXC6T1SyWBb9Jc3jfFaGanDuQamwuDz5kYWlh
        DsLBzp91cm6IMaQX11EiSIqQVgIw89lVM8Geges=
X-Google-Smtp-Source: ABdhPJx4rOa+ntWlSp+7Ns1AjCepaDgfPgRkjoRXrA5XXRO+qdETutkJQSSxvPyStaNY007guCvxHukuLv7uv9RmHfA=
X-Received: by 2002:a5b:591:: with SMTP id l17mr11653279ybp.60.1621569860321;
 Thu, 20 May 2021 21:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210407084238.20443-1-apopple@nvidia.com> <20210407084238.20443-9-apopple@nvidia.com>
In-Reply-To: <20210407084238.20443-9-apopple@nvidia.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Fri, 21 May 2021 14:04:08 +1000
Message-ID: <CACAvsv6hKbmHMHmJSxMyij_4Y1v51Zo5NAfLtDyaQyiamtGOLQ@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] nouveau/svm: Implement atomic SVM access
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, ML nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-doc@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        bsingharora@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Christoph Hellwig <hch@infradead.org>, jglisse@redhat.com,
        willy@infradead.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 at 18:43, Alistair Popple <apopple@nvidia.com> wrote:
>
> Some NVIDIA GPUs do not support direct atomic access to system memory
> via PCIe. Instead this must be emulated by granting the GPU exclusive
> access to the memory. This is achieved by replacing CPU page table
> entries with special swap entries that fault on userspace access.
>
> The driver then grants the GPU permission to update the page undergoing
> atomic access via the GPU page tables. When CPU access to the page is
> required a CPU fault is raised which calls into the device driver via
> MMU notifiers to revoke the atomic access. The original page table
> entries are then restored allowing CPU access to proceed.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
The Nouveau bits at least look good to me.

For patches 7/8:
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>

>
> ---
>
> v7:
> * Removed magic values for fault access levels
> * Improved readability of fault comparison code
>
> v4:
> * Check that page table entries haven't changed before mapping on the
>   device
> ---
>  drivers/gpu/drm/nouveau/include/nvif/if000c.h |   1 +
>  drivers/gpu/drm/nouveau/nouveau_svm.c         | 126 ++++++++++++++++--
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h |   1 +
>  .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    |   6 +
>  4 files changed, 123 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/include/nvif/if000c.h b/drivers/gpu/drm/nouveau/include/nvif/if000c.h
> index d6dd40f21eed..9c7ff56831c5 100644
> --- a/drivers/gpu/drm/nouveau/include/nvif/if000c.h
> +++ b/drivers/gpu/drm/nouveau/include/nvif/if000c.h
> @@ -77,6 +77,7 @@ struct nvif_vmm_pfnmap_v0 {
>  #define NVIF_VMM_PFNMAP_V0_APER                           0x00000000000000f0ULL
>  #define NVIF_VMM_PFNMAP_V0_HOST                           0x0000000000000000ULL
>  #define NVIF_VMM_PFNMAP_V0_VRAM                           0x0000000000000010ULL
> +#define NVIF_VMM_PFNMAP_V0_A                             0x0000000000000004ULL
>  #define NVIF_VMM_PFNMAP_V0_W                              0x0000000000000002ULL
>  #define NVIF_VMM_PFNMAP_V0_V                              0x0000000000000001ULL
>  #define NVIF_VMM_PFNMAP_V0_NONE                           0x0000000000000000ULL
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index a195e48c9aee..81526d65b4e2 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -35,6 +35,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/sort.h>
>  #include <linux/hmm.h>
> +#include <linux/rmap.h>
>
>  struct nouveau_svm {
>         struct nouveau_drm *drm;
> @@ -67,6 +68,11 @@ struct nouveau_svm {
>         } buffer[1];
>  };
>
> +#define FAULT_ACCESS_READ 0
> +#define FAULT_ACCESS_WRITE 1
> +#define FAULT_ACCESS_ATOMIC 2
> +#define FAULT_ACCESS_PREFETCH 3
> +
>  #define SVM_DBG(s,f,a...) NV_DEBUG((s)->drm, "svm: "f"\n", ##a)
>  #define SVM_ERR(s,f,a...) NV_WARN((s)->drm, "svm: "f"\n", ##a)
>
> @@ -411,6 +417,24 @@ nouveau_svm_fault_cancel_fault(struct nouveau_svm *svm,
>                                       fault->client);
>  }
>
> +static int
> +nouveau_svm_fault_priority(u8 fault)
> +{
> +       switch (fault) {
> +       case FAULT_ACCESS_PREFETCH:
> +               return 0;
> +       case FAULT_ACCESS_READ:
> +               return 1;
> +       case FAULT_ACCESS_WRITE:
> +               return 2;
> +       case FAULT_ACCESS_ATOMIC:
> +               return 3;
> +       default:
> +               WARN_ON_ONCE(1);
> +               return -1;
> +       }
> +}
> +
>  static int
>  nouveau_svm_fault_cmp(const void *a, const void *b)
>  {
> @@ -421,9 +445,8 @@ nouveau_svm_fault_cmp(const void *a, const void *b)
>                 return ret;
>         if ((ret = (s64)fa->addr - fb->addr))
>                 return ret;
> -       /*XXX: atomic? */
> -       return (fa->access == 0 || fa->access == 3) -
> -              (fb->access == 0 || fb->access == 3);
> +       return nouveau_svm_fault_priority(fa->access) -
> +               nouveau_svm_fault_priority(fb->access);
>  }
>
>  static void
> @@ -487,6 +510,10 @@ static bool nouveau_svm_range_invalidate(struct mmu_interval_notifier *mni,
>         struct svm_notifier *sn =
>                 container_of(mni, struct svm_notifier, notifier);
>
> +       if (range->event == MMU_NOTIFY_EXCLUSIVE &&
> +           range->owner == sn->svmm->vmm->cli->drm->dev)
> +               return true;
> +
>         /*
>          * serializes the update to mni->invalidate_seq done by caller and
>          * prevents invalidation of the PTE from progressing while HW is being
> @@ -555,6 +582,71 @@ static void nouveau_hmm_convert_pfn(struct nouveau_drm *drm,
>                 args->p.phys[0] |= NVIF_VMM_PFNMAP_V0_W;
>  }
>
> +static int nouveau_atomic_range_fault(struct nouveau_svmm *svmm,
> +                              struct nouveau_drm *drm,
> +                              struct nouveau_pfnmap_args *args, u32 size,
> +                              struct svm_notifier *notifier)
> +{
> +       unsigned long timeout =
> +               jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +       struct mm_struct *mm = svmm->notifier.mm;
> +       struct page *page;
> +       unsigned long start = args->p.addr;
> +       unsigned long notifier_seq;
> +       int ret = 0;
> +
> +       ret = mmu_interval_notifier_insert(&notifier->notifier, mm,
> +                                       args->p.addr, args->p.size,
> +                                       &nouveau_svm_mni_ops);
> +       if (ret)
> +               return ret;
> +
> +       while (true) {
> +               if (time_after(jiffies, timeout)) {
> +                       ret = -EBUSY;
> +                       goto out;
> +               }
> +
> +               notifier_seq = mmu_interval_read_begin(&notifier->notifier);
> +               mmap_read_lock(mm);
> +               make_device_exclusive_range(mm, start, start + PAGE_SIZE,
> +                                           &page, drm->dev);
> +               mmap_read_unlock(mm);
> +               if (!page) {
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +
> +               mutex_lock(&svmm->mutex);
> +               if (!mmu_interval_read_retry(&notifier->notifier,
> +                                            notifier_seq))
> +                       break;
> +               mutex_unlock(&svmm->mutex);
> +       }
> +
> +       /* Map the page on the GPU. */
> +       args->p.page = 12;
> +       args->p.size = PAGE_SIZE;
> +       args->p.addr = start;
> +       args->p.phys[0] = page_to_phys(page) |
> +               NVIF_VMM_PFNMAP_V0_V |
> +               NVIF_VMM_PFNMAP_V0_W |
> +               NVIF_VMM_PFNMAP_V0_A |
> +               NVIF_VMM_PFNMAP_V0_HOST;
> +
> +       svmm->vmm->vmm.object.client->super = true;
> +       ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, size, NULL);
> +       svmm->vmm->vmm.object.client->super = false;
> +       mutex_unlock(&svmm->mutex);
> +
> +       unlock_page(page);
> +       put_page(page);
> +
> +out:
> +       mmu_interval_notifier_remove(&notifier->notifier);
> +       return ret;
> +}
> +
>  static int nouveau_range_fault(struct nouveau_svmm *svmm,
>                                struct nouveau_drm *drm,
>                                struct nouveau_pfnmap_args *args, u32 size,
> @@ -637,7 +729,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
>         unsigned long hmm_flags;
>         u64 inst, start, limit;
>         int fi, fn;
> -       int replay = 0, ret;
> +       int replay = 0, atomic = 0, ret;
>
>         /* Parse available fault buffer entries into a cache, and update
>          * the GET pointer so HW can reuse the entries.
> @@ -718,12 +810,14 @@ nouveau_svm_fault(struct nvif_notify *notify)
>                 /*
>                  * Determine required permissions based on GPU fault
>                  * access flags.
> -                * XXX: atomic?
>                  */
>                 switch (buffer->fault[fi]->access) {
>                 case 0: /* READ. */
>                         hmm_flags = HMM_PFN_REQ_FAULT;
>                         break;
> +               case 2: /* ATOMIC. */
> +                       atomic = true;
> +                       break;
>                 case 3: /* PREFETCH. */
>                         hmm_flags = 0;
>                         break;
> @@ -739,8 +833,14 @@ nouveau_svm_fault(struct nvif_notify *notify)
>                 }
>
>                 notifier.svmm = svmm;
> -               ret = nouveau_range_fault(svmm, svm->drm, &args.i,
> -                                       sizeof(args), hmm_flags, &notifier);
> +               if (atomic)
> +                       ret = nouveau_atomic_range_fault(svmm, svm->drm,
> +                                                        &args.i, sizeof(args),
> +                                                        &notifier);
> +               else
> +                       ret = nouveau_range_fault(svmm, svm->drm, &args.i,
> +                                                 sizeof(args), hmm_flags,
> +                                                 &notifier);
>                 mmput(mm);
>
>                 limit = args.i.p.addr + args.i.p.size;
> @@ -756,11 +856,15 @@ nouveau_svm_fault(struct nvif_notify *notify)
>                          */
>                         if (buffer->fault[fn]->svmm != svmm ||
>                             buffer->fault[fn]->addr >= limit ||
> -                           (buffer->fault[fi]->access == 0 /* READ. */ &&
> +                           (buffer->fault[fi]->access == FAULT_ACCESS_READ &&
>                              !(args.phys[0] & NVIF_VMM_PFNMAP_V0_V)) ||
> -                           (buffer->fault[fi]->access != 0 /* READ. */ &&
> -                            buffer->fault[fi]->access != 3 /* PREFETCH. */ &&
> -                            !(args.phys[0] & NVIF_VMM_PFNMAP_V0_W)))
> +                           (buffer->fault[fi]->access != FAULT_ACCESS_READ &&
> +                            buffer->fault[fi]->access != FAULT_ACCESS_PREFETCH &&
> +                            !(args.phys[0] & NVIF_VMM_PFNMAP_V0_W)) ||
> +                           (buffer->fault[fi]->access != FAULT_ACCESS_READ &&
> +                            buffer->fault[fi]->access != FAULT_ACCESS_WRITE &&
> +                            buffer->fault[fi]->access != FAULT_ACCESS_PREFETCH &&
> +                            !(args.phys[0] & NVIF_VMM_PFNMAP_V0_A)))
>                                 break;
>                 }
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h
> index a2b179568970..f6188aa9171c 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h
> @@ -178,6 +178,7 @@ void nvkm_vmm_unmap_region(struct nvkm_vmm *, struct nvkm_vma *);
>  #define NVKM_VMM_PFN_APER                                 0x00000000000000f0ULL
>  #define NVKM_VMM_PFN_HOST                                 0x0000000000000000ULL
>  #define NVKM_VMM_PFN_VRAM                                 0x0000000000000010ULL
> +#define NVKM_VMM_PFN_A                                   0x0000000000000004ULL
>  #define NVKM_VMM_PFN_W                                    0x0000000000000002ULL
>  #define NVKM_VMM_PFN_V                                    0x0000000000000001ULL
>  #define NVKM_VMM_PFN_NONE                                 0x0000000000000000ULL
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> index 236db5570771..f02abd9cb4dd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> @@ -88,6 +88,9 @@ gp100_vmm_pgt_pfn(struct nvkm_vmm *vmm, struct nvkm_mmu_pt *pt,
>                 if (!(*map->pfn & NVKM_VMM_PFN_W))
>                         data |= BIT_ULL(6); /* RO. */
>
> +               if (!(*map->pfn & NVKM_VMM_PFN_A))
> +                       data |= BIT_ULL(7); /* Atomic disable. */
> +
>                 if (!(*map->pfn & NVKM_VMM_PFN_VRAM)) {
>                         addr = *map->pfn >> NVKM_VMM_PFN_ADDR_SHIFT;
>                         addr = dma_map_page(dev, pfn_to_page(addr), 0,
> @@ -322,6 +325,9 @@ gp100_vmm_pd0_pfn(struct nvkm_vmm *vmm, struct nvkm_mmu_pt *pt,
>                 if (!(*map->pfn & NVKM_VMM_PFN_W))
>                         data |= BIT_ULL(6); /* RO. */
>
> +               if (!(*map->pfn & NVKM_VMM_PFN_A))
> +                       data |= BIT_ULL(7); /* Atomic disable. */
> +
>                 if (!(*map->pfn & NVKM_VMM_PFN_VRAM)) {
>                         addr = *map->pfn >> NVKM_VMM_PFN_ADDR_SHIFT;
>                         addr = dma_map_page(dev, pfn_to_page(addr), 0,
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
