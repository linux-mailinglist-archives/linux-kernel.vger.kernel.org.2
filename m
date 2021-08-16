Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00B93ECF95
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhHPHnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:43:53 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13327 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhHPHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:43:50 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gp5k821jPz7yyv;
        Mon, 16 Aug 2021 15:43:12 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:43:12 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:43:12 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/3] amba: Properly handle device probe without IRQ domain
Date:   Mon, 16 Aug 2021 15:46:16 +0800
Message-ID: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 and 2 make some cleanup, and patch 3 use of_irq_get() instead of 
irq_of_parse_and_map() to get irq number, return -EPROBE_DEFER if the irq
domain is not yet created, amba_device_add() will properly to handle the
no IRQ domain issue via deferred probe.

Kefeng Wang (3):
  amba: Drop unused functions about APB/AHB devices add
  Revert "ARM: amba: make use of -1 IRQs warn"
  amba: Properly handle device probe without IRQ domain

 drivers/amba/bus.c       | 100 ++++++++++-----------------------------
 drivers/of/platform.c    |   6 +--
 include/linux/amba/bus.h |  18 -------
 3 files changed, 27 insertions(+), 97 deletions(-)

-- 
2.26.2

