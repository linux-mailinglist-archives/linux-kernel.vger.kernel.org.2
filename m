Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8938161D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 07:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhEOF1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 01:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbhEOF1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 01:27:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB7CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 22:26:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d89-20020a25a3620000b02904dc8d0450c6so1936395ybi.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 22:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9DF04rOCeHkRBnGvVrvy5486e1pnEBJx9358rosv750=;
        b=U1qTy4ublZpoVBevSo9WkGfX5ri6UbgL8LYDs4apASEjNn77OhCF3EM2Or3A8t5pJh
         Y3/m3AdHvbXxt1rhLzU2wP68PZ5yH/K+3dbqArMZwixNQ2ARlSnKy1GEG1A3wM+e9ke3
         qKo4N6szR+2xuGsVRC2zs5pDiGYIf8OvosdHrAswPD4+YEWhNU6eJUGtoUscq4nxsSbd
         SsTZjFUVQ6vp4jP2pxWWbpMAhGl3r6b9f/6c7Y6A0f4Bk713qff03eSe9R64QAgPfPWJ
         zqsLMlk1qCZAUZ2KnnRF8Aw5B/SS17zpSMjbNj5R4mSWuhIAVaQFQy8D2q3+EfnQSR29
         qbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9DF04rOCeHkRBnGvVrvy5486e1pnEBJx9358rosv750=;
        b=J1CR2fvodyfKo+GAYpUUJW0+yk92bBsPw/TWlzcSYddfF4gZKANvS/je/R0o7LylQz
         EYPp3cbsJigCYZr36hjqogka6QMWDU4hVGPw7MSRZ5lxOXYJFXiWxcEIrgBXMVIGsZgp
         5zypO85cHzj1PJVts/c6AolnN22cGztRcZX3pr5sOGxdKQJVYODnYlfoj+YG9Zh4XhwV
         xj3Iz35AeA32NWjWUi5bl+f1w3ToW+50PNSxaWGCjSEL683hgAZVKXJ8xwwfMCkJ1Jek
         cB1m/RcyO6rOH71fxH4SmAiu/cTE9v1CUeD3433J03B0bpMpUL65AOOx/qFV3Pdyh3OQ
         lVww==
X-Gm-Message-State: AOAM5312cDU3Yv8n3Qre6CPLPvL4Ci4vukRzL48mPwBFqxHXJVfEm7uH
        SU0QHCpfd2MenNN2WjslQIQKxh8HUYo=
X-Google-Smtp-Source: ABdhPJz6iwDbt1K67xL/c2DC1KuisaHDuoZlC2HrbvEtdEY001TLs8SorvVYZV1H0BIU2eEo1t9Gpa3+BHo=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:6bd1:251e:e226:7071])
 (user=badhri job=sendgmr) by 2002:a25:414f:: with SMTP id o76mr66454577yba.383.1621056384861;
 Fri, 14 May 2021 22:26:24 -0700 (PDT)
Date:   Fri, 14 May 2021 22:26:13 -0700
In-Reply-To: <20210515052613.3261340-1-badhri@google.com>
Message-Id: <20210515052613.3261340-4-badhri@google.com>
Mime-Version: 1.0
References: <20210515052613.3261340-1-badhri@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v1 4/4] usb: typec: tcpci: Implement callback for apply_rc
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>, stable@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APPLY RC is defined as ROLE_CONTROL.CC1 != ROLE_CONTROL.CC2 and
POWER_CONTROL.AutodischargeDisconnect is 0. When ROLE_CONTROL.CC1 ==
ROLE_CONTROL.CC2, set the other CC to OPEN.

Fixes: f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 25b480752266..34b5095cc84f 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -115,6 +115,32 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
 	return 0;
 }
 
+int tcpci_apply_rc(struct tcpc_dev *tcpc, enum typec_cc_status cc, enum typec_cc_polarity polarity)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(tcpci->regmap, TCPC_ROLE_CTRL, &reg);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * APPLY_RC state is when ROLE_CONTROL.CC1 != ROLE_CONTROL.CC2 and vbus autodischarge on
+	 * disconnect is disabled. Bail out when ROLE_CONTROL.CC1 != ROLE_CONTROL.CC2.
+	 */
+	if (((reg & (TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT)) >>
+	     TCPC_ROLE_CTRL_CC2_SHIFT) !=
+	    ((reg & (TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT)) >>
+	     TCPC_ROLE_CTRL_CC1_SHIFT))
+		return 0;
+
+	return regmap_update_bits(tcpci->regmap, TCPC_ROLE_CTRL, polarity == TYPEC_POLARITY_CC1 ?
+				  TCPC_ROLE_CTRL_CC2_MASK << TCPC_ROLE_CTRL_CC2_SHIFT :
+				  TCPC_ROLE_CTRL_CC1_MASK << TCPC_ROLE_CTRL_CC1_SHIFT,
+				  TCPC_ROLE_CTRL_CC_OPEN);
+}
+
 static int tcpci_start_toggling(struct tcpc_dev *tcpc,
 				enum typec_port_type port_type,
 				enum typec_cc_status cc)
@@ -728,6 +754,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.get_vbus = tcpci_get_vbus;
 	tcpci->tcpc.set_vbus = tcpci_set_vbus;
 	tcpci->tcpc.set_cc = tcpci_set_cc;
+	tcpci->tcpc.apply_rc = tcpci_apply_rc;
 	tcpci->tcpc.get_cc = tcpci_get_cc;
 	tcpci->tcpc.set_polarity = tcpci_set_polarity;
 	tcpci->tcpc.set_vconn = tcpci_set_vconn;
-- 
2.31.1.751.gd2f1c929bd-goog

