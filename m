Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5305534557B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCWC31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:29:27 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46449 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229472AbhCWC3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:29:16 -0400
X-UUID: 75cd00b499a84e929a964099f36fc1df-20210323
X-UUID: 75cd00b499a84e929a964099f36fc1df-20210323
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <fengquan.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 221370226; Tue, 23 Mar 2021 10:29:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Mar 2021 10:29:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 10:29:07 +0800
From:   Fengquan Chen <Fengquan.Chen@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <fengquan.chen@mediatek.com>, <dehui.sun@mediatek.com>,
        Fengquan Chen <Fengquan.Chen@mediatek.com>
Subject: [v2, 1/1]Fixes: e3af677607d9(clocksource/drivers/timer-mediatek: optimize systimer irq clear flow on shutdown)
Date:   Tue, 23 Mar 2021 10:29:02 +0800
Message-ID: <1616466543-13387-1-git-send-email-Fengquan.Chen@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AD58978AA397473FFCE90D8123B5F5C94A91E347620E7C30F0A253083E16BE582000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_syst_clkevt_shutdown is called after irq disabled in suspend flow,
clear any pending systimer irq when shutdown to avoid suspend aborted
due to timer irq pending

Also as for systimer in mediatek socs, there must be firstly enable
timer before clear systimer irq

Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>

Fengquan Chen (1):
  [v2, 1/1]Fixes: e3af677607d9(clocksource/drivers/timer-mediatek:
    optimize systimer irq clear flow on shutdown)

 drivers/clocksource/timer-mediatek.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
1.8.1.1.dirty

