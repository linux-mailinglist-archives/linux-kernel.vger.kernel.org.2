Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1930B08C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhBATmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhBATmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:42:00 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC7C061756;
        Mon,  1 Feb 2021 11:41:20 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d2so20304831edz.3;
        Mon, 01 Feb 2021 11:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DUZ2th2akMgZXbhWAwF/Rtcar/hbaUZaN5WHosC7d0E=;
        b=FpMiGYgOnjuHnqzhenAl+dL9jsvG4qjBPhjQSn+4DFsiE1JbaMcJ2J0lfmBzrmPWyc
         XBubKNA99rgSNCJNCFgCQF/aUeqgBiofpmcFXgs85iB4Kl/ypAXEpUl4IQlsYgDBozLJ
         KOD1XWL+irKNEUnIVqrefzUD452xosSNYvblX9/TkeeIBEscfzcm1suUMnVfduZ1hbIe
         M8de96kFqguI2YJR3kgUyBKTKUEnpum/+sufyBS8qq1R5SWeIGX9Nd4w5B6cJlIiCaLE
         7yEJqpRkMkPrVe4CitED5PDO+gogW9+AiU4GZVvrqN1ZH6R/Hx3OK6JHKmAjz7LhDdW+
         jn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DUZ2th2akMgZXbhWAwF/Rtcar/hbaUZaN5WHosC7d0E=;
        b=TWHTys6CjIiyK+qlPu4e6F2fRTsL1fummRwWZjKNLhNQ3w9RTfLgWAHMGmlukk26I/
         6ecsE94K5qzkVBHuXBpdG9P7SX1HEkw7eUJG+GMzj3AxVE5pUsuOvsEJ7o3avJBGv8fG
         DFbbf8hPopQBAXiHASjd2QXdh9tnL2f8EPlCgEswJFyH8eE2Q4Plg8eKaWOI5Sr6LCeq
         bVjL+DKIEOM9wrA1UAOzboEaeCgp/w/U1tFQ1t9Q2RHw7jPTHCwAGlrz1LNqvjpV+VYX
         /ngTAaYES3p6e64q68prtNZuiLeBkSuG39eexJ1SvVtp7lNn8EZssEUDOcE6odbIvHTg
         ymDw==
X-Gm-Message-State: AOAM530tFVGVirgnjZ/fsdTUU0t6T2n+DuFUfWiGltckyLbEiMyjPe7N
        bI0C1gqqzU5NNQfAonfjK8A=
X-Google-Smtp-Source: ABdhPJwUQXBgh7rOTE/IACXYOLiBGDAt4h5HEasE30HrnMCW6UEC67IVNg1/Tdp65F3x0MVLj/nOZA==
X-Received: by 2002:a50:e04d:: with SMTP id g13mr7090744edl.358.1612208479118;
        Mon, 01 Feb 2021 11:41:19 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id du6sm6702799ejc.78.2021.02.01.11.41.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:41:18 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] usb: dwc3: of-simple: add compatible for rk3328
Date:   Mon,  1 Feb 2021 20:41:03 +0100
Message-Id: <20210201194105.32673-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210201194105.32673-1-jbx6244@gmail.com>
References: <20210201194105.32673-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

Add a compatible to be hooked into by the Rockchip rk3328 device tree.

The rk3399 compatible cannot be reused because the rk3328 SoCs may
require a specialized driver in the future and old device trees must
remain compatible with newer kernels.

Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e62ecd22b..93bc34328 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -171,6 +171,7 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 };
 
 static const struct of_device_id of_dwc3_simple_match[] = {
+	{ .compatible = "rockchip,rk3328-dwc3" },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
-- 
2.11.0

