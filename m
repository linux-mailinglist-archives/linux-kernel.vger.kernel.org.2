Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24E32A26D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381499AbhCBHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:53:05 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:62415 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1381418AbhCBH34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:29:56 -0500
X-UUID: 17bf90b3794448e5a09c5f2751b37a04-20210302
X-UUID: 17bf90b3794448e5a09c5f2751b37a04-20210302
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <fengquan.chen@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1058035986; Tue, 02 Mar 2021 15:28:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Mar 2021 15:28:29 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Mar 2021 15:28:28 +0800
From:   Fengquan Chen <Fengquan.Chen@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <fengquan.chen@mediatek.com>, <dehui.sun@mediatek.com>,
        Fengquan Chen <Fengquan.Chen@mediatek.com>
Subject: [PATCH] clocksource/drivers/timer-mediatek: optimize systimer irq clear flow on Mediatek Socs
Date:   Tue, 2 Mar 2021 15:28:04 +0800
Message-ID: <1614670085-26229-1-git-send-email-Fengquan.Chen@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4F0E3607ECFC991C1FE455D9024AC4BA0283DB1C04F435AB6898340C7F80F92D2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clocksource/drivers/timer-mediatek: optimize systimer irq clear flow on Mediatek Socs

1)ensure systimer is enabled before clear and disable interrupt, which only
  for systimer in Mediatek Socs.

2)clear any pending timer-irq when shutdown to keep suspend flow clean,
  when use systimer as tick-broadcast timer

Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>

Fengquan Chen (1):
  clocksource/drivers/timer-mediatek: optimize systimer irq clear flow
    on Mediatek Socs

 drivers/clocksource/timer-mediatek.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
1.8.1.1.dirty

