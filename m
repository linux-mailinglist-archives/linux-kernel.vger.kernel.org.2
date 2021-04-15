Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4947361437
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbhDOVgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236043AbhDOVgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618522539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNj4aUxZWko3JIYqOq33KObTtAgWgdktJ6hV/IWuKOk=;
        b=E+fnd88hriT7R1XuDubiFY/z9w5O2cNiq06V0G3dgjKB99yDYS+Q9hT6iEjBdYjC1daOeM
        9uqQlbit8Z9W++mDtywCzeyz+3gHpByBMtVIoN/1AXnoYEmnCYAxw7S7J34uzwaotwfKny
        an1UwSt6DW72B8h/mK8uzPR85ttPMwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-sgmMRhUBOyqJyxpYe6Dhfg-1; Thu, 15 Apr 2021 17:35:36 -0400
X-MC-Unique: sgmMRhUBOyqJyxpYe6Dhfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52C291006C84;
        Thu, 15 Apr 2021 21:35:34 +0000 (UTC)
Received: from redhat.com (ovpn-117-254.rdu2.redhat.com [10.10.117.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A685107D5C0;
        Thu, 15 Apr 2021 21:35:31 +0000 (UTC)
Date:   Thu, 15 Apr 2021 15:35:31 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Tarun Gupta <targupta@nvidia.com>,
        Neo Jia <cjia@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC PATCH 0/3] vfio/hisilicon: add acc live migration driver
Message-ID: <20210415153531.56f6cdf2@redhat.com>
In-Reply-To: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc+ NVIDIA folks both from migration and vfio-pci-core discussion]

On Tue, 13 Apr 2021 11:36:20 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

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
>  drivers/vfio/pci/Kconfig                      |    8 +
>  drivers/vfio/pci/Makefile                     |    1 +
>  drivers/vfio/pci/hisilicon/acc_vf_migration.c | 1337 +++++++++++++++++++++++++
>  drivers/vfio/pci/hisilicon/acc_vf_migration.h |  170 ++++
>  drivers/vfio/pci/vfio_pci.c                   |   11 +
>  drivers/vfio/pci/vfio_pci_private.h           |    9 +
>  6 files changed, 1536 insertions(+)
>  create mode 100644 drivers/vfio/pci/hisilicon/acc_vf_migration.c
>  create mode 100644 drivers/vfio/pci/hisilicon/acc_vf_migration.h
> 

