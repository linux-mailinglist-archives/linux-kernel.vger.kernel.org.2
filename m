Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFA311F76
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 19:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhBFSv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 13:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhBFSvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 13:51:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235A3C061756;
        Sat,  6 Feb 2021 10:50:28 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b9so18204292ejy.12;
        Sat, 06 Feb 2021 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyReI/BEuC4BzvSRo5mXE3P7CpFBNp0uOKqtRDtZmz0=;
        b=d7wIQg/kQKPuJEe8XMCa0Omf+k5pPZh+R36O+btiduVd5PhaZ1p+gD2X75swaupmpB
         BXwilOhOTs4C9n73ONx78+2EN+9wzfmnvep2w3n9OjTtf1PqaBOQaFMgE0Qse5edElwF
         1JZMLGTSS9r/mxmz0v+vfEA7L2956FsfV4vN73TOS7SxZ+RVWfFOkWqS7+nb1qQxkkSw
         du3CmRNW2oAix/YkFgEI/5KYBqfy4arjDwkV0PSHiUmlaUM9dlUBxeZh0I1vIIY0ShRw
         Ur5xsv3e9yIuLxgSMZfss940PDX8rmnGnQfMGQAhnk9aCAqOlmJv0hqHJhfAFXQGMB58
         QK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pyReI/BEuC4BzvSRo5mXE3P7CpFBNp0uOKqtRDtZmz0=;
        b=byueTOgp6keEQjiO/ttxyF60mApTQ+e0wCw1lQJgVvl1FVoXzrQXwTRqwj4lsNQl5N
         r7VM30iYFhGFu0MR/SnHOvLDkFGWzaCT1jyqCCkkG3zfL3/8z38uqvG/DiHDJDiuu3SJ
         Y/h5saSM628h5W/91CozTqrH/JOsHFwW0OQEmbc83pFEGwnbGAA+A4/XcDBmC2+pLQDX
         0ULERjKOHFa1NdzN/Cw2w1YjdJqiH6hLBelzjB1sJyCcGSxlBeXcsqhMPPVh+j35Ra+9
         xzT3aG0s9zAk1Txq5JL4W0rttr+fP3SUpgZtauwwFO8fhToRqd+hYYtM4IOdLguq9/K2
         35qA==
X-Gm-Message-State: AOAM532jyXttDMQwws1kdvbRJfV1mUYRKAQjG45EXf/iIT3m3G76qIyl
        TlzUStrMBDCOVUjt5eUX+NBcEaTDows=
X-Google-Smtp-Source: ABdhPJxcZiMzgDmxsI7jNur/RIOnbyFQ+m01RdhWlPqPCprgIJ3m5eJiGBrYBHlEQKvUC3rLb/24lQ==
X-Received: by 2002:a17:907:2897:: with SMTP id em23mr10065424ejc.550.1612637426909;
        Sat, 06 Feb 2021 10:50:26 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cb21sm5890005edb.57.2021.02.06.10.50.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 10:50:26 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] usb: dwc3: of-simple: bail probe if no dwc3 child node
Date:   Sat,  6 Feb 2021 19:50:11 +0100
Message-Id: <20210206185017.1817-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210206185017.1817-1-jbx6244@gmail.com>
References: <20210206185017.1817-1-jbx6244@gmail.com>
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

