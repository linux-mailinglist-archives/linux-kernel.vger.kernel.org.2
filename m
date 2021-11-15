Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F0A4505C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbhKONpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:45:49 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27210 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbhKONnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:43:19 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ht9JK2gTJz8vPy;
        Mon, 15 Nov 2021 21:38:41 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 21:40:23 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 21:40:22 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <saravanak@google.com>, <robh+dt@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH Resend 0/2] amba: irq cleanup
Date:   Mon, 15 Nov 2021 21:51:46 +0800
Message-ID: <20211115135148.171786-1-wangkefeng.wang@huawei.com>
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

As the v1 of "amba: Properly handle device probe without IRQ domain"
is merged, some comments[1] from Rob and Saravana is not included,
let's send them separately again.

patch1 has been ACKed by Rob[2].
patch2 is suggested by Saravana.

Resend:
- Rebase on v5.16-rc1
- Fix patch2's build error

[1] https://lore.kernel.org/lkml/20210816074619.177383-1-wangkefeng.wang@huawei.com/
[2] https://lore.kernel.org/linux-arm-kernel/20210827150600.78811-4-wangkefeng.wang@huawei.com/

Resend:
- fix mistakes about patch2

Kefeng Wang (2):
  amba: Kill sysfs attribute file of irq
  amba: Move of_amba_device_decode_irq() into amba_probe()

 drivers/amba/bus.c | 71 ++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 43 deletions(-)

-- 
2.26.2

