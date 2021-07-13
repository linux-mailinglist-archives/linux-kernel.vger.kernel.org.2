Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B4E3C6C14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhGMIkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbhGMIj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:39:59 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD0C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:37:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b10-20020a056a000ccab029032dc5f71f6aso1022111pfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GOSTPm1zw2J0V9+0BqttAvjk4eeZD9TwFHKnYj3BQV4=;
        b=LGeJYTKb9rSrUGzJOCcZE9yAfaWT2TU1shKl8EgFJp0jkgOYhBdRZbahPIBpOran/n
         ZDqxAnsZ0UOqEY+DhgjqAI+OdJhtCI9FKnti6uxqklr1hzNXFfMsZSRxIKTk3yfaNlNA
         HxhsiYMYUezFZUUOcX8qaVVMTfljHXTiWpOp0DJ6mGpHYBVi9XbkTtOJOIbYYbvQjHnl
         Upgd7OSwcV2n3s4MCVqGkqWMuhitHOHeGG1C/Pb86zi+ELD5eSvxbLqO7XQ95wTLQ7WG
         RKBQe5iTlprh0niGRnkMJhFc0Y2U+7vKimwzfrrrqhQmbjK8nV2jyKHz6mtE47m5N/l6
         PWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GOSTPm1zw2J0V9+0BqttAvjk4eeZD9TwFHKnYj3BQV4=;
        b=b80xr6sO5b7zW5SCjqdniVVpKYLYXDYK6TdETnEE5JxLmbXtPFmV1sxo1qFnlR7sJY
         DUd+Mmjf7LBsjDmUtu8ak/yQ7a8mr0VAUmvVTF6ExxDvCptiG9+qbx01ak7IIfU5+TuD
         diGKt334FoqgEB2M6mbX2TzO3nx7LjQd7lk01K1vpKpz8IpHeX/Ab4n3R9ohB/uvALYu
         Zk27AepijWQo10sZDbSBZ1BAy0XErH2YgyDIAoSTr6H363ZgKzVKBDTACrmv8RvgPQHJ
         OhK7q+t9waAvg09mRMs/B8bhtSqtb5oELBj5bJYJSM6h3EBxUqSUEn+KpYNAyKQEY0nL
         TCrg==
X-Gm-Message-State: AOAM533dsczCicGahAB1bwDT44jIxSo8oCNbWvE9veMq+AXQSrPgaH9m
        bVMiWM3WrUbGVyFXlYCBWrrDjUEWARZQ
X-Google-Smtp-Source: ABdhPJyVjMC0P6XFI8tusJgqGWTxuYmxzXeiP4kX0o0Ve6mcdlskXA71zt5G6wm5Vt09KR/2ebihPysmvnj/
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:c4d1:1ac0:e4fe:3d1b])
 (user=apusaka job=sendgmr) by 2002:a17:90a:bc87:: with SMTP id
 x7mr224823pjr.0.1626165429413; Tue, 13 Jul 2021 01:37:09 -0700 (PDT)
Date:   Tue, 13 Jul 2021 16:37:03 +0800
Message-Id: <20210713163641.1.I2b8f2c16fab1ba67167461372a3bdb6817673303@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] Bluetooth: btrtl: Set MSFT opcode for RTL8852
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

RTL8852 support MSFT HCI extension, therefore set the proper MSFT
opcode.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Hilda Wu <hildawu@realtek.com>

---

 drivers/bluetooth/btrtl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index cce0125ec4fd..1f8afa0244d8 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -681,11 +681,15 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		}
 	}
 
-	/* RTL8822CE supports the Microsoft vendor extension and uses 0xFCF0
-	 * for VsMsftOpCode.
+	/* The following chips supports the Microsoft vendor extension,
+	 * therefore set the corresponding VsMsftOpCode.
 	 */
-	if (lmp_subver == RTL_ROM_LMP_8822B)
+	switch (lmp_subver) {
+	case RTL_ROM_LMP_8822B:
+	case RTL_ROM_LMP_8852A:
 		hci_set_msft_opcode(hdev, 0xFCF0);
+		break;
+	}
 
 	return btrtl_dev;
 
-- 
2.32.0.93.g670b81a890-goog

