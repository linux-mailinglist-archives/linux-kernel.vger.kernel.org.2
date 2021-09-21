Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B164135E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhIUPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:12:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9749 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhIUPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:12:17 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HDPwc6l7MzWMJR;
        Tue, 21 Sep 2021 23:09:36 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 23:10:45 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 23:10:45 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        <gregkh@linuxfoundation.org>, <kamal@canonical.com>,
        <pbonzini@redhat.com>, <sgarzare@redhat.com>,
        <stefanha@redhat.com>, <vkuznets@redhat.com>,
        <ne-devel-upstream@amazon.com>,
        "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v2 0/4] merge contiguous physical memory regions
Date:   Tue, 21 Sep 2021 23:10:35 +0800
Message-ID: <20210921151039.1502-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

This patchset try to merge the contiguous physical memory regions when
set user memory regions, you can see message in PATCH 1 for details.
Please review when you free, thank!

Changes v1 -> v2:
  - update the commit message as Andra's suggestion  [Andra]
  - remove TODO completely in ne_set_user_memory_region_ioctl  [Andra]
  - extract the physical memory regions setup into individual
    function
  - add kunit tests  [Andra]

Longpeng(Mike) (4):
  nitro_enclaves: merge contiguous physical memory regions
  nitro_enclaves: sanity check the physical region during setting
  nitro_enclaves: add test framework for the misc functionality
  nitro_enclaves: add kunit tests for physical contiguous region merging

 drivers/virt/nitro_enclaves/Kconfig        |   8 ++
 drivers/virt/nitro_enclaves/ne_misc_dev.c  | 160 ++++++++++++++++++++---------
 drivers/virt/nitro_enclaves/ne_misc_test.c |  63 ++++++++++++
 3 files changed, 182 insertions(+), 49 deletions(-)
 create mode 100644 drivers/virt/nitro_enclaves/ne_misc_test.c

-- 
1.8.3.1

