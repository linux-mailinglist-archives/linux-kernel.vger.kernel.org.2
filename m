Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2935134CCB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhC2JG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:06:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14178 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhC2IwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:52:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F85qZ4FH2zmbHX;
        Mon, 29 Mar 2021 16:49:46 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.174.187.192) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 16:52:15 +0800
From:   Jingyi Wang <wangjingyi11@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <maz@kernel.org>, <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <wangjingyi11@huawei.com>,
        <yuzenghui@huawei.com>, <zhukeqian1@huawei.com>
Subject: [RFC PATCH 0/3] arm: Some IPI injection optimization
Date:   Mon, 29 Mar 2021 16:52:07 +0800
Message-ID: <20210329085210.11524-1-wangjingyi11@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.192]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series optimize arm IPI injection process by making use of
ICC_SGI1R IRM bit and implementing gic_ipi_send_single().

Jingyi Wang (3):
  irqchip/gic-v3: Make use of ICC_SGI1R IRM bit
  irqchip/gic-v3: Implement gic_ipi_send_single()
  arm/arm64: Use gic_ipi_send_single() to inject single IPI

 arch/arm/kernel/smp.c        | 16 +++++++++++++---
 arch/arm64/kernel/smp.c      | 16 +++++++++++++---
 drivers/irqchip/irq-gic-v3.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 6 deletions(-)

-- 
2.19.1

