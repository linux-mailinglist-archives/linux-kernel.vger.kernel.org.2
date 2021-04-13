Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCEC35D4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbhDMBRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:17:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16904 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbhDMBRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:17:48 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FK72f0g78zjZ2B;
        Tue, 13 Apr 2021 09:15:38 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 09:17:27 +0800
Subject: Re: [RFC PATCH v3 0/3] vfio/hisilicon: add acc live migration driver
To:     <alex.williamson@redhar.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <1618217596-13621-1-git-send-email-liulongfang@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <6bab97f7-c7ed-5837-4b7c-e49770fb9029@huawei.com>
Date:   Tue, 13 Apr 2021 09:17:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1618217596-13621-1-git-send-email-liulongfang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/12 16:53, Longfang Liu wrote:
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
Sorry, Please ignore this patchset due to
the wrong email address, I will resend it.
Thanks
Longfang
