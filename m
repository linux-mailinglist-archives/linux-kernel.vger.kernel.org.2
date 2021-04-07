Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E47356C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352326AbhDGMjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352250AbhDGMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7977AC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 05:38:17 -0700 (PDT)
Date:   Wed, 07 Apr 2021 12:38:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dwiwmn1b58GzlWRI4C6p4HiHDkLHiAEfCe7Rj+DInwY=;
        b=clpaDc/DDvLBV868Uni+3CzZ9ha/Xyzr7rEqkfJkGsU/OyPEQHghf4ceK/UJk0AUu7wIsB
        0yH2aGVp6cmvV3cG0LEHkoNlv3p5esOp+QW6KBRRBFWucVy4a+L+OdLDitpuWBf+FcFPf1
        fcJH1pINrpD02jFHkItB8c7nYxqkUhfKjuU/3WF2VoIi3KYjaKpa///rk6ZcITheZROICJ
        MZo2ej2DITU7XFvZW5mY4wdSlUTShBhSBbNZX5dtIs8pDberiC5KB96dMnH+duqAvzqkx1
        r6zXTwJQJ4Nky0zRirFjriEG5JMdpntrsWaV2sHWXvHc7UQ8PaHZP4hHx07BiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dwiwmn1b58GzlWRI4C6p4HiHDkLHiAEfCe7Rj+DInwY=;
        b=V6NED2AgQLBu+ZrUVGGxVvVWk8jCJ/9jwYBv/ALgVQwHxFV7FytFe4Ny/caHNol06FWdP+
        ZyfdzeDTlZDo+zCw==
From:   "irqchip-bot for Rajendra Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: qcom,pdc: Add compatible for sc7280
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <1615787946-26474-1-git-send-email-rnayak@codeaurora.org>
References: <1615787946-26474-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Message-ID: <161779909280.29796.8075280865044578545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5deaa1d7c49151988b0bf919eeea6ad5535a29a2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5deaa1d7c49151988b0bf919eeea6ad5535a29a2
Author:        Rajendra Nayak <rnayak@codeaurora.org>
AuthorDate:    Mon, 15 Mar 2021 11:29:06 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 13:26:00 +01:00

dt-bindings: qcom,pdc: Add compatible for sc7280

Add the compatible string for sc7280 SoC from Qualcomm

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1615787946-26474-1-git-send-email-rnayak@codeaurora.org
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
index e9afb48..98d89e5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -19,6 +19,7 @@ Properties:
 	Value type: <string>
 	Definition: Should contain "qcom,<soc>-pdc" and "qcom,pdc"
 		    - "qcom,sc7180-pdc": For SC7180
+		    - "qcom,sc7280-pdc": For SC7280
 		    - "qcom,sdm845-pdc": For SDM845
 		    - "qcom,sdm8250-pdc": For SM8250
 		    - "qcom,sdm8350-pdc": For SM8350
