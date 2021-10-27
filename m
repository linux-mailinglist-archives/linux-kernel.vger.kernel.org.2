Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0DB43CE52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbhJ0QLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbhJ0QL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:11:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85768C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:09:02 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s3so3579581ild.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=uER/nNyzqjkZUffE1EOgclTHd/4X5D8gQ4iPUJk3S1c=;
        b=iJdaqrbPSzb24NEcTO++4OhQn9tPDw54F9iXhvtbj/6Kc7NpXQFPVYWr6KGTNm/zRL
         bRgTo3OHOvxMsFSt/jariYPeMF/pIKpUJeGyAiQrwBBbUIg7geEVeb0XLrezAxQuCiO/
         //7teXlfQmfAPk7++uImejWM/AzFtckU4zDbtkpaRk2dFWi3Cdb1S+v0+DB6zNJ4/8pC
         WQgTTluyUeBWd8A4fm8kY+kir2w+laZx2ZfK//fGKhEvxjNBxjJPzGthGe//EWHSQ0oA
         Q81z6bQUACAPCBz5RazHnlpvICvr59jDKqmQbZ1RX8iUP9oRy64QzlzdjkIqwDxHosgQ
         Zgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uER/nNyzqjkZUffE1EOgclTHd/4X5D8gQ4iPUJk3S1c=;
        b=nX+MsIzRqImarj2SsneWlNRckg9gNCyh+53jfTfq+gnNt2mNqULnDU4PEWYBifx2m+
         O1gehDZVA80wW/2HzlpDXnDXaAbgeBj5hsIFA59USY7YiQKcXpgrurrpFODNrxOL0LXG
         W9/MEf/irZSO3Y6VRlLkjkWFzGLyW0rk4bw6bzuSSS8g3dUdE9gVnLPKx0bsp7DOf44i
         sDNkQFiohPeeh4TPB2dn8KFCzNdBH5zaHQpfAF1SbUKQLkid0JL/J5Yi5nXyC19kSDKf
         dc7FMn4MMIG8UHcKE7x/D2hkOeJphC5a0u8kzxN2Zt6OBNFCanV/J5I0fHBlzGS9XJ5N
         XL+g==
X-Gm-Message-State: AOAM530tIgFzl9nCzIUZRde7CW0uLM72roqB27+rRqrVeraTcAcZwwvZ
        gYSOSUzoNpLXcX1YktG+Fh1J7t+TYy19M31pKx1kAFZq/V0=
X-Google-Smtp-Source: ABdhPJy7avNz37kjKvFCNYMd3Z0vuXPj41lIP9oXLnSPB9jPfC60oepcMec1+LDHIP/K+Q7WDxN8wrUbrNX1g7YkO1M=
X-Received: by 2002:a05:6e02:1d8b:: with SMTP id h11mr14550029ila.274.1635350941877;
 Wed, 27 Oct 2021 09:09:01 -0700 (PDT)
MIME-Version: 1.0
From:   Marshall Midden <marshallmidden@gmail.com>
Date:   Wed, 27 Oct 2021 11:08:51 -0500
Message-ID: <CAD2CkAWjS8=kKwEEN4cgVNjyFORUibzEiCUA-X+SMtbo0JoMmA@mail.gmail.com>
Subject: v5.15-rc7 AMD no kernel dump, spews "scsi_dma_map failed: request for
 36 bytes!"
To:     logang@deltatee.com, joro@8bytes.org, will@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5.15-rc7 AMD no kernel dump, spews "scsi_dma_map failed: request for 36 bytes!"

With v5.15-rc (1 through 7), AMD processor kernel crash dumps do not occur,
instead spews:
        "scsci_dma_map failed: request for 36 bytes!"
Works on Intel machines, and in v5.14.0 (and v5.14.14) - as well as previous
kernels (down to v5.3.x.)
git bisect torvalds repository shows: dabb16f67215918c48cf3ff1fc4bc36ca421da2b
Reverse patch to tag v5.15-rc7 allows kernel crash dumps to occur/happen.

Extra details in github repository:
    https://github.com/marshallmidden/m4.git
    Directory AMD-cdrash-2021-10-27
        Z.config.2021-10-27_10-27-15
        Z.dabb16f67215918c48cf3ff1fc4bc36ca421da2b
        Z.df-fstab
        Z.dmesg.2021-10-27_10-26-34
        Z.lspci-vmmD.2021-10-27_10-29-58
        rpviewer(5).png

Reproduce via:
    echo c > /proc/sysrq-trigger

git bisect of linux from torvalds repository shows:
    commit dabb16f67215918c48cf3ff1fc4bc36ca421da2b
    Author: Logan Gunthorpe <logang@deltatee.com>
    Date:   Thu Jul 29 14:15:22 2021 -0600

    iommu/dma: return error code from iommu_dma_map_sg()

    Return appropriate error codes EINVAL or ENOMEM from
    iommup_dma_map_sg(). If lower level code returns ENOMEM, then we
    return it, other errors are coalesced into EINVAL.

    iommu_dma_map_sg_swiotlb() returns -EIO as its an unknown error
    from a call that returns DMA_MAPPING_ERROR.

    Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
    Cc: Joerg Roedel <joro@8bytes.org>
    Cc: Will Deacon <will@kernel.org>
    Signed-off-by: Christoph Hellwig <hch@lst.de>
------------------------------------------------------------------------------
[root@parsec torvalds-linux]# awk -f scripts/ver_linux
    Linux parsec 5.15.0-rc4+ #22 SMP Tue Oct 26 18:50:50 CDT 2021
x86_64 x86_64 x86_64 GNU/Linux

    GNU C                       11.1.0
    GNU Make                    3.82
    Binutils                    2.36.1
    Util-linux                  2.23.2
    Mount                       2.23.2
    Module-init-tools           20
    E2fsprogs                   1.42.9
    Xfsprogs                    4.5.0
    Quota-tools                 4.01
    Nfs-utils                   1.3.0
    Bison                       3.0.4
    Flex                        2.5.37
    Linux C++ Library           6.0.19
    Linux C Library             2.17
    Dynamic linker (ldd)        2.17
    Procps                      3.3.10
    Net-tools                   2.10
    Kbd                         1.15.5
    Console-tools               1.15.5
    Sh-utils                    8.22
    Udev                        219
    Modules Loaded              iscsi_target_mod qla2xxx
target_core_file target_core_iblock target_core_mod target_core_pscsi
tcm_fc tcm_loop tcm_qla2xxx

[root@parsec torvalds-linux]# perl scripts/get_maintainer.pl -f
drivers/iommu/dma-iommu.c
    Joerg Roedel <joro@8bytes.org> (maintainer:IOMMU DRIVERS)
    Will Deacon <will@kernel.org> (maintainer:IOMMU DRIVERS)
    iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS)
    linux-kernel@vger.kernel.org (open list)
------------------------------------------------------------------------------
commit dabb16f67215918c48cf3ff1fc4bc36ca421da2b
Author: Logan Gunthorpe <logang@deltatee.com>
Date:   Thu Jul 29 14:15:22 2021 -0600

    iommu/dma: return error code from iommu_dma_map_sg()

    Return appropriate error codes EINVAL or ENOMEM from
    iommup_dma_map_sg(). If lower level code returns ENOMEM, then we
    return it, other errors are coalesced into EINVAL.

    iommu_dma_map_sg_swiotlb() returns -EIO as its an unknown error
    from a call that returns DMA_MAPPING_ERROR.

    Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
    Cc: Joerg Roedel <joro@8bytes.org>
    Cc: Will Deacon <will@kernel.org>
    Signed-off-by: Christoph Hellwig <hch@lst.de>

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 98ba927..168434c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -972,7 +972,7 @@ static int iommu_dma_map_sg_swiotlb(struct device
*dev, struct scatterlist *sg,

 out_unmap:
        iommu_dma_unmap_sg_swiotlb(dev, sg, i, dir, attrs |
DMA_ATTR_SKIP_CPU_SYNC);
-       return 0;
+       return -EIO;
 }

 /*
@@ -993,11 +993,13 @@ static int iommu_dma_map_sg(struct device *dev,
struct scatterlist *sg,
        dma_addr_t iova;
        size_t iova_len = 0;
        unsigned long mask = dma_get_seg_boundary(dev);
+       ssize_t ret;
        int i;

-       if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
-           iommu_deferred_attach(dev, domain))
-               return 0;
+       if (static_branch_unlikely(&iommu_deferred_attach_enabled)) {
+               ret = iommu_deferred_attach(dev, domain);
+               goto out;
+       }

        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
                iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
@@ -1045,14 +1047,17 @@ static int iommu_dma_map_sg(struct device
*dev, struct scatterlist *sg,
        }

        iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
-       if (!iova)
+       if (!iova) {
+               ret = -ENOMEM;
                goto out_restore_sg;
+       }

        /*
         * We'll leave any physical concatenation to the IOMMU driver's
         * implementation - it knows better than we do.
         */
-       if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
+       ret = iommu_map_sg_atomic(domain, iova, sg, nents, prot);
+       if (ret < iova_len)
                goto out_free_iova;

        return __finalise_sg(dev, sg, nents, iova);
@@ -1061,7 +1066,10 @@ static int iommu_dma_map_sg(struct device *dev,
struct scatterlist *sg,
        iommu_dma_free_iova(cookie, iova, iova_len, NULL);
 out_restore_sg:
        __invalidate_sg(sg, nents);
-       return 0;
+out:
+       if (ret != -ENOMEM)
+               return -EINVAL;
+       return ret;
 }

  static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
