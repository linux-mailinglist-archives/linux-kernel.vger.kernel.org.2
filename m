Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6343C44514C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 10:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhKDJr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:47:27 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:30921 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhKDJr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:47:26 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HlJX00y5Pzcb8K;
        Thu,  4 Nov 2021 17:40:00 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 17:44:39 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 17:44:38 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>, <saravanak@google.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/2] amba: some cleanup
Date:   Thu, 4 Nov 2021 17:56:41 +0800
Message-ID: <20211104095643.180429-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

[1] https://lore.kernel.org/lkml/20210816074619.177383-1-wangkefeng.wang@huawei.com/
[2] https://lore.kernel.org/linux-arm-kernel/20210827150600.78811-4-wangkefeng.wang@huawei.com/

Kefeng Wang (2):
  amba: Kill sysfs attribute file of irq
  amba: Move of_amba_device_decode_irq() into amba_probe()

 drivers/amba/bus.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

-- 
2.26.2

