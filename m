Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E440F261
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhIQGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:34:42 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:60418 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbhIQGej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1631860397; x=1663396397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=UFm4lH1VdjgBOuPIWDR8+t74A8qgSRQhFYsN706Pxow=;
  b=QYcb210icU2bH4mfAJsUD54yUJuDcHXBh4iEjP44UiLay4WewcjLLUk4
   So48SciSbiw3nF/NRq/Nk85OOPV9jSPc83/EHmO9LZYGrfygMm8ntygLI
   bGQ5B+M9kwmdNMzX35rG9YfrVOZKypvAQ1Dqi09bEEVjqFx/UV+t3HiE0
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 Sep 2021 23:33:17 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 23:33:17 -0700
Received: from fenglinw-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 16 Sep 2021 23:33:14 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        <quic_fenglinw@quicinc.com>
Subject: [RESEND PATCH v1 2/9] spmi: pmic-arb: do not ack and clear peripheral interrupts in cleanup_irq
Date:   Fri, 17 Sep 2021 14:32:57 +0800
Message-ID: <1631860384-26608-3-git-send-email-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631860384-26608-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1631860384-26608-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>

Currently, cleanup_irq() is invoked when a peripheral's interrupt
fires and there is no mapping present in the interrupt domain of
spmi interrupt controller.

The cleanup_irq clears the arbiter bit, clears the pmic interrupt
and disables it at the pmic in that order. The last disable in
cleanup_irq races with request_irq() in that it stomps over the
enable issued by request_irq. Fix this by not writing to the pmic
in cleanup_irq. The latched bit will be left set in the pmic,
which will not send us more interrupts even if the enable bit
stays enabled.

When a client wants to request an interrupt, use the activate
callback on the irq_domain to clear latched bit. This ensures
that the latched, if set due to the above changes in cleanup_irq
or when the bootloader leaves it set, gets cleaned up, paving way
for upcoming interrupts to trigger.

With this, there is a possibility of unwanted triggering of
interrupt right after the latched bit is cleared - the interrupt
may be left enabled too. To avoid that, clear the enable first
followed by clearing the latched bit in the activate callback.

Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
[collinsd@codeaurora.org: fix merge conflict]
Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/spmi/spmi-pmic-arb.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 295e19f..4d7ad004 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -492,16 +492,6 @@ static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
 	dev_err_ratelimited(&pmic_arb->spmic->dev, "%s apid=%d sid=0x%x per=0x%x irq=%d\n",
 			__func__, apid, sid, per, id);
 	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
-
-	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
-			(per << 8) + QPNPINT_REG_LATCHED_CLR, &irq_mask, 1))
-		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed to ack irq_mask = 0x%x for ppid = %x\n",
-				irq_mask, ppid);
-
-	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
-			       (per << 8) + QPNPINT_REG_EN_CLR, &irq_mask, 1))
-		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed to ack irq_mask = 0x%x for ppid = %x\n",
-				irq_mask, ppid);
 }
 
 static void periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
@@ -667,6 +657,7 @@ static int qpnpint_irq_domain_activate(struct irq_domain *domain,
 	u16 apid = hwirq_to_apid(d->hwirq);
 	u16 sid = hwirq_to_sid(d->hwirq);
 	u16 irq = hwirq_to_irq(d->hwirq);
+	u8 buf;
 
 	if (pmic_arb->apid_data[apid].irq_ee != pmic_arb->ee) {
 		dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u: ee=%u but owner=%u\n",
@@ -675,6 +666,10 @@ static int qpnpint_irq_domain_activate(struct irq_domain *domain,
 		return -ENODEV;
 	}
 
+	buf = BIT(irq);
+	qpnpint_spmi_write(d, QPNPINT_REG_EN_CLR, &buf, 1);
+	qpnpint_spmi_write(d, QPNPINT_REG_LATCHED_CLR, &buf, 1);
+
 	return 0;
 }
 
-- 
2.7.4

