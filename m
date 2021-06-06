Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1000939CF45
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFFNJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 09:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFFNJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 09:09:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABA9C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 06:07:31 -0700 (PDT)
Date:   Sun, 06 Jun 2021 13:07:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622984850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJRZFEv+WqTaNK8BOKq1zcQD5O3X1Rbkkoo570KSgd0=;
        b=BIndqeWQnnmENeW7hYbTclB7/dqUo+wEbRK84NXEesHhzobivHQfasdCyyA22esJ0DPo1u
        xqT3nfvBqPmknwXA/LWDAkA4UDtaeF8JoN+tM5kpC0PgohKOEu7WgO6YE12x/y8vE1ouse
        Odm4iGn5VPek5YHkdchuctU1Qbb/k1Uw1AMyvJYkK+bwX7RJXcJMnlzjVF49OSH9w00WPd
        3Z1/0STBMmj78cFnTL9UQqnXRBuaBzL9K89ao7MQrLDhT490080QEqRYYKg1T7cRfxxaT0
        q5aaSBtkFHpDDo5/e3Xc7mQKo4TDbJfbe0tGWcrV8l1/LufL7lh3v2PhYIx+Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622984850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJRZFEv+WqTaNK8BOKq1zcQD5O3X1Rbkkoo570KSgd0=;
        b=dnpu7OoeBzfyFqi5nzmzop4wY1u4kb2l6rwPNFZlt/M7wSmBVkRiX/Npr0cROgjoxFcL6N
        lbvngAmWS3xGzECA==
From:   "irqchip-bot for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mbigen: Fix compile warning when
 CONFIG_ACPI is disabled
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210519050455.1693953-1-yangyingliang@huawei.com>
References: <20210519050455.1693953-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <162298484952.29796.11651971445696613807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     c96d6abbec52d6723bef6b50846f40f7fb27e93c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/c96d6abbec52d6723bef6b50846f40f7fb27e93c
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Wed, 19 May 2021 13:04:55 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Jun 2021 13:59:09 +01:00

irqchip/mbigen: Fix compile warning when CONFIG_ACPI is disabled

Fix the following compile warning:

  drivers/irqchip/irq-mbigen.c:372:36: warning: =E2=80=98mbigen_acpi_match=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
   static const struct acpi_device_id mbigen_acpi_match[] =3D {

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210519050455.1693953-1-yangyingliang@huawei=
.com
---
 drivers/irqchip/irq-mbigen.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 2cb45c6..f565317 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -273,6 +273,12 @@ static int mbigen_of_create_domain(struct platform_devic=
e *pdev,
 }
=20
 #ifdef CONFIG_ACPI
+static const struct acpi_device_id mbigen_acpi_match[] =3D {
+	{ "HISI0152", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
+
 static int mbigen_acpi_create_domain(struct platform_device *pdev,
 				     struct mbigen_device *mgn_chip)
 {
@@ -369,12 +375,6 @@ static const struct of_device_id mbigen_of_match[] =3D {
 };
 MODULE_DEVICE_TABLE(of, mbigen_of_match);
=20
-static const struct acpi_device_id mbigen_acpi_match[] =3D {
-	{ "HISI0152", 0 },
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
-
 static struct platform_driver mbigen_platform_driver =3D {
 	.driver =3D {
 		.name		=3D "Hisilicon MBIGEN-V2",
