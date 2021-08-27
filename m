Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3B53F9B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245358AbhH0PDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:03:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9373 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH0PDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:03:01 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gx2rk6Cvlz8vJg;
        Fri, 27 Aug 2021 22:57:58 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 23:02:09 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 23:02:08 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <saravanak@google.com>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/4] amba: Properly handle device probe without IRQ domain
Date:   Fri, 27 Aug 2021 23:05:56 +0800
Message-ID: <20210827150600.78811-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1~3 make some cleanup, and patch 4 use of_irq_get() instead of 
irq_of_parse_and_map() to get irq number, return -EPROBE_DEFER if the irq
domain is not yet created, and move irq obtain into amba_probe, the driver 
defer probe will properly to handle this error.

V2:
- add new patch to kill irq sysfs file, suggested by Rob.
- move irq obtain from amba_device_add() to amba_probe(), suggested by Saravana.
  (As Saravana said, it will use a new mechanism to deal with the defer probe
   when amba device add and drop the amba specific deferring code, see[1])
- add Rob Reviewed-by to patch 1/2, no patch4 due to patch4 is changed

[1] https://lore.kernel.org/lkml/20210304195101.3843496-1-saravanak@google.com/

Kefeng Wang (4):
  amba: Drop unused functions about APB/AHB devices add
  Revert "ARM: amba: make use of -1 IRQs warn"
  amba: Kill sysfs attribute file of irq
  amba: Properly handle device probe without IRQ domain

 drivers/amba/bus.c       | 120 ++++++++++-----------------------------
 drivers/of/platform.c    |   6 +-
 include/linux/amba/bus.h |  18 ------
 3 files changed, 30 insertions(+), 114 deletions(-)

-- 
2.18.0.huawei.25

