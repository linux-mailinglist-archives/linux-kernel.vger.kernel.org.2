Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F43F429E05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhJLGw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhJLGwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:52:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56062C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 23:50:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ns7-20020a17090b250700b001a0937b87b7so1296165pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LTrTHuQcE5X0GZaJWB7dzuWRxtcvz+ODkGE4fuF1p7s=;
        b=G5+N+tJAqKu5LQcBEHcawzqJnwWtsVhonnU6iFxrZPCxCaeEN/CiwsX1X4wYRpfLV9
         DhVDxF/7JQQ6X5npDUv3COWJkSu6ypdp9MHzR9474mHEI1zpx6HrmjG1rlLDWqPzI0Pw
         uL/5mDZmQiKGX/aqTXAY3mPhDHw9bO7aAIfNhqk/M82+A2+gdBJDlKKvknEBCTubUTPG
         EMu35vhTGFZ1Wfi+i2MUsQ0otsiVd/eTe5rHQoh1F7ktWDR2T5oY4Yo6pA8RiWmkCdbI
         yFtP2DL1i8XsbSDnU4mdIe037mUzJGxy5s0FM3S2Hz7mXMmf21oSlUuon0B5PrlO4g8R
         GNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LTrTHuQcE5X0GZaJWB7dzuWRxtcvz+ODkGE4fuF1p7s=;
        b=UT9v1mnykjKNdHnhqI1Jkxdm7v1eN5wyTaE+CJavpJa4QudCyInqMf++u+DvFrfPwC
         oy0dJXPfA5odjyL96IvIm3++9PtbT2f2+8BCUX7Bu97/Z+6yOUxyvmkEGbDwKp0MlMGH
         YU4Xe6rxO6lXUI8WmLRpQpsN+ZppLtUeolKc/wubiCqlYL4vA9wSytXc8OjbzfI4vWMN
         UoBQm05yDG+mMPVQQX4l2bV6zHXN9LesbqUfdm2HXGzvhYZb3tyfKN9SZjKT1uAwvOBV
         00ZwOGioGIld0dOhWNYv/zNIlP1ZXiBYSPURb9Lo+cdLvlpsngOAihBprLeTg1L8UQYk
         9l5A==
X-Gm-Message-State: AOAM530ncz08pM85/KAZ8cYVbXHy93GaUM5ZaZsaf2r1TTjigG4RjKDT
        kVGn65UdX7tVh7bM1rXeO9k=
X-Google-Smtp-Source: ABdhPJzvBpeTD1FeA3OdeUQ5vq4e1ALbuf/HKBqdwBlfDgjSc+qigG8xFX7b1FQPrM45CWX8SZyjgw==
X-Received: by 2002:a17:902:8209:b0:13e:3408:43ba with SMTP id x9-20020a170902820900b0013e340843bamr28631567pln.66.1634021422903;
        Mon, 11 Oct 2021 23:50:22 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id q16sm1290147pgt.60.2021.10.11.23.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 23:50:22 -0700 (PDT)
From:   davidcomponentone@gmail.com
To:     jdike@addtoit.com
Cc:     joe@perches.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, davidcomponentone@gmail.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] Fix application of sizeof to pointer
Date:   Tue, 12 Oct 2021 14:50:06 +0800
Message-Id: <17910246df3f6ea3b2ae790af543eefbcefe49a5.1634021064.git.davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
"./arch/um/drivers/virt-pci.c:192:20-26:
ERROR: application of sizeof to pointer"
Using the "sizeof(buf->data)" to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 arch/um/drivers/virt-pci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c08066633023..9333edd71604 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -187,9 +187,8 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		return ~0ULL;
 
 	buf = get_cpu_var(um_pci_msg_bufs);
-	data = buf->data;
 
-	memset(data, 0xff, sizeof(data));
+	memset(buf->data, 0xff, sizeof(buf->data));
 
 	switch (size) {
 	case 1:
@@ -204,22 +203,22 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		goto out;
 	}
 
-	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
+	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, buf->data, 8))
 		goto out;
 
 	switch (size) {
 	case 1:
-		ret = data[0];
+		ret = buf->data[0];
 		break;
 	case 2:
-		ret = le16_to_cpup((void *)data);
+		ret = le16_to_cpup((void *)buf->data);
 		break;
 	case 4:
-		ret = le32_to_cpup((void *)data);
+		ret = le32_to_cpup((void *)buf->data);
 		break;
 #ifdef CONFIG_64BIT
 	case 8:
-		ret = le64_to_cpup((void *)data);
+		ret = le64_to_cpup((void *)buf->data);
 		break;
 #endif
 	default:
-- 
2.30.2

