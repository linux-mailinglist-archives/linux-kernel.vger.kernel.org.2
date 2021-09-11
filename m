Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48023407547
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 08:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhIKGFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 02:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhIKGE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 02:04:58 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE507C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 23:03:46 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso5438431otu.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 23:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=UgmN2EKt/DWd47bpDffgHi1pS1L5lavVM0pPz8CK090=;
        b=vCfaQUquVMJLez8VluIXcmYq5CLLVqmr1dQOTPDIhd8I0yzMvs/JDiTFM98UYBxGUg
         DmHIxnz3QosYOqpRiQam+j70L3Lxba4McNaPDLEBE3VXz4TIUCNcawZeYhvlVxqbsbRv
         lMN/RaHrHe+kX3gktUvbMxTWwU+BpbsRxeMOoXifPg/HuZ0+byhEeVdZYt0kh23EVtI7
         tWeE/1HuwOLvIsRTzEktWh9cRzGU0uX9aIv8ctVZ6HBFyP8WLaunpUUvCWa5Kl1xshVX
         BeMZC09He9qcH1BubqxyLr+0+8dD6TQHJRLQ+rbnbglcN64lvpUAw+n17xrHXDsjxp3v
         PL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=UgmN2EKt/DWd47bpDffgHi1pS1L5lavVM0pPz8CK090=;
        b=GzvB1LsHAsJ1IAvvfVoUu5Trkc0t7DkjgyX7r35+1VxHwYyMgMk57qWLujrBL5/n7n
         oEXNtm1GvMFFcB++3+xpLsRfheTjMevp6AAgux3NLaZD/6YKXPtl+r619yO0ZuJgo5j+
         IPYT/OgOcJRMrOSsUbC86Y5P2Al6zp+b1OfBXOCySQFCdRHplPkQfDUmiKm8K2UZfQOZ
         5A/ObV540Py7OAMO1BgKZPKpWqagBq4ZyTsQ3XbhPdftcuCe185P4SLHiDzCk/80WmCU
         sIvtFRXqcFUAmQ82y6+MQPZQ3YOSBblNS4VAuze+2sKmWd92d4t1OHC2wjeyv92b8aub
         pWoA==
X-Gm-Message-State: AOAM5323T63LqJ+PPsec+mUaD1HY1Y+woaQyGDGJBCA5VP5FbFSAncnu
        zhGt/eZWu8+Z1tHR3OSP/ze5fw==
X-Google-Smtp-Source: ABdhPJyRd0MIgayPgtVMdjDX8fX/kgXfIi474riYVHdu4gfC5dHSDQoTnGlH2JNIcxGY+lSY1ozCcA==
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr1126032otn.5.1631340224967;
        Fri, 10 Sep 2021 23:03:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id bf6sm247447oib.0.2021.09.10.23.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 23:03:44 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:03:44 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Sep 2021 21:53:28 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: defconfig: enable BLK_DEV_NVME
In-Reply-To: <20210812081027.9242-1-heinrich.schuchardt@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, xypron.glpk@gmx.de,
        ardb@kernel.org, sagar.kadam@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        heinrich.schuchardt@canonical.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heinrich.schuchardt@canonical.com
Message-ID: <mhng-b162953f-839f-40e9-a643-34eef24ce8b4@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 01:10:26 PDT (-0700), heinrich.schuchardt@canonical.com wrote:
> NVMe is a non-volatile storage media attached via PCIe.
> As NVMe has much higher throughput than other block devices like
> SATA it is a must have for RISC-V. Enable CONFIG_BLK_DEV_NVME.
>
> The HiFive Unmatched is a board providing M.2 slots for NVMe drives.
> Enable CONFIG_PCIE_FU740.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> resent on Palmer's request due to non-matching e-mail addresses
> https://lore.kernel.org/linux-riscv/20210726112511.78350-1-xypron.glpk@gmx.de/
> ---
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 1f2be234b11c..393bf3843e5c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -39,10 +39,12 @@ CONFIG_PCI=y
>  CONFIG_PCIEPORTBUS=y
>  CONFIG_PCI_HOST_GENERIC=y
>  CONFIG_PCIE_XILINX=y
> +CONFIG_PCIE_FU740=y
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_VIRTIO_BLK=y
> +CONFIG_BLK_DEV_NVME=m
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_BLK_DEV_SR=y
>  CONFIG_SCSI_VIRTIO=y

Thanks, these are on for-next.
