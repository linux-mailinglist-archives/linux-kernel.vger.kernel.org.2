Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8665435D57E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 04:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbhDMC51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 22:57:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16578 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbhDMC5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 22:57:25 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FK9F62RWfz18HpF;
        Tue, 13 Apr 2021 10:54:50 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 10:57:02 +0800
Subject: Re: [RFC PATCH v3 0/3] vfio/hisilicon: add acc live migration driver
To:     <alex.williamson@redhat.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <1618276821-8320-1-git-send-email-liulongfang@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <e5a056e1-2ca0-e6f8-0526-b9c9597e4bc8@huawei.com>
Date:   Tue, 13 Apr 2021 10:57:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1618276821-8320-1-git-send-email-liulongfang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/13 9:20, Longfang Liu wrote:
> The live migration solution relies on the vfio_device_migration_info protocol.
> The structure vfio_device_migration_info is placed at the 0th offset of
> the VFIO_REGION_SUBTYPE_MIGRATION region to get and set VFIO device related
> migration information. Field accesses from this structure are only supported
> at their native width and alignment. Otherwise, the result is undefined and
> vendor drivers should return an error.
> 
> (1).The driver framework is based on vfio_pci_register_dev_region() of vfio-pci,
> and then a new live migration region is added, and the live migration is
> realized through the ops of this region.
> 
> (2).In order to ensure the compatibility of the devices before and after the
> migration, the device compatibility information check will be performed in
> the Pre-copy stage. If the check fails, an error will be returned and the
> source VM will exit the migration function.
> 
> (3).After the compatibility check is passed, it will enter the Stop-and-copy
> stage. At this time, all the live migration data will be copied, and then
> saved to the VF device of the destination, and then the VF device of the
> destination will be started and the VM of the source will be exited.
> 
> Longfang Liu (3):
>   vfio/hisilicon: add acc live migration driver
>   vfio/hisilicon: register the driver to vfio
>   vfio/hisilicom: add debugfs for driver
> 
>  drivers/vfio/pci/Kconfig                      |    9 +
>  drivers/vfio/pci/Makefile                     |    3 +-
>  drivers/vfio/pci/hisilicon/acc_vf_migration.c | 1357 +++++++++++++++++++++++++
>  drivers/vfio/pci/hisilicon/acc_vf_migration.h |  172 ++++
>  drivers/vfio/pci/vfio_pci.c                   |   11 +
>  drivers/vfio/pci/vfio_pci_private.h           |   10 +
>  6 files changed, 1561 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/vfio/pci/hisilicon/acc_vf_migration.c
>  create mode 100644 drivers/vfio/pci/hisilicon/acc_vf_migration.h
> 

Sorry!
Please ignore this patch, I will resend it.
Thanks
Longfang.
