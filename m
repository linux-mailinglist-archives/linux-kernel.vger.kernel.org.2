Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922EB315A88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhBJADj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhBIUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:37:00 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B514C0611C0;
        Tue,  9 Feb 2021 11:24:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s5so25371035edw.8;
        Tue, 09 Feb 2021 11:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyReI/BEuC4BzvSRo5mXE3P7CpFBNp0uOKqtRDtZmz0=;
        b=YJPjb0dS96lYDOexjOydBEkgbTkDbxwnkeUSHVABRARJeOksmXglyDYD2RqyVw3O2E
         t+EVY/HYTcyuQPEAkxjsWudzToJR098RylZVaKH1Of8kbjRGDnhUfN64E81gKOABvlTN
         BPs/t2qVYxNAG2t7UXIasMOM9q+jQDV4jJrw72K7hdOKuZAdn7uHWPmj+kh8XogAP30L
         SHqKpYLguNlitYOH2Ih4GBSHsujJDoOn8KvJ19oO+GMVUp5V2bjf6t8a85fd+zJhhlTp
         bMNFWbKlGIOe1EmF9QeWKZXkz1AiCvIGuhtWnq35HOS2ukzxBa+E7DK/Dl2kle/gS8gh
         cVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pyReI/BEuC4BzvSRo5mXE3P7CpFBNp0uOKqtRDtZmz0=;
        b=hrjZcO390JwyQnP8IiAhI16GQSyfjKY33nLiuhfAZfwASQruohg81zvgtHRMiP9mOQ
         6WsynAGLuG8CX32qbcJdt3Wl1RcU0wHtwybQfAef/5ul8Myt6dJiAvsPWMOrjGqRxEwO
         Z1a7DZ+fM4AwKjEqlMpwFtWQPaP7jYHKtZh8hVPh7jVifhos3mykzPYI9vZkRnpnnszi
         e3cHZ3T0EKITOjjAOPyQ7A+99Ibto59Fty9MqGFPN5SqokQI41Q5tFqnw5moyN7MP+y1
         gBf7j74jMCqUfuFwyMD0CD62QeC5R/dqIlcnv/ZgUgTM7Gk1qU2Qi7TkOOC8NNgl5FIG
         IPxw==
X-Gm-Message-State: AOAM533fqwsCLhCT9TaefCZxpqc7S4aRl/WZQLZb4F7KQTVHQ9c5GvF5
        xu85LtEDO5HvbnaAPEfXMtvX7bq3scw=
X-Google-Smtp-Source: ABdhPJz+bOuBJ3/9q6WA9aKGxDaFG4ToV8V9ky4ts+krOYiuFJikzdaJMlOuwtuQTxx8Th0zBx7T9A==
X-Received: by 2002:a05:6402:104b:: with SMTP id e11mr22202102edu.367.1612898639910;
        Tue, 09 Feb 2021 11:23:59 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w3sm11075779eja.52.2021.02.09.11.23.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:23:59 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/8] usb: dwc3: of-simple: bail probe if no dwc3 child node
Date:   Tue,  9 Feb 2021 20:23:44 +0100
Message-Id: <20210209192350.7130-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210209192350.7130-1-jbx6244@gmail.com>
References: <20210209192350.7130-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some of the dwc3-of-simple compatible SoCs we
don't want to bind this driver to a dwc3 node,
but bind that node to the 'snps,dwc3' driver instead.
The kernel has no logic to decide which driver to bind
to if there are 2 matching drivers, so bail probe if no
dwc3 child node.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e62ecd22b..347b4d384 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -38,6 +38,10 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 
 	int			ret;
 
+	/* Bail probe if no dwc3 child node. */
+	if (!of_get_compatible_child(dev->of_node, "snps,dwc3"))
+		return -ENODEV;
+
 	simple = devm_kzalloc(dev, sizeof(*simple), GFP_KERNEL);
 	if (!simple)
 		return -ENOMEM;
-- 
2.11.0

