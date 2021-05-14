Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2024038014E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 02:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhENA6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 20:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhENA6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 20:58:40 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E868C061574;
        Thu, 13 May 2021 17:57:28 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id l21so26712203iob.1;
        Thu, 13 May 2021 17:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=puac9P/1pH2gTjwWoFDjpCGPhH1RSMCtsgJsRORZsps=;
        b=uleaoi7pw6pKKSvyheVtu5WrdsRZupmmjo1QujTNyVGJQ8DgVhO7y4jFYpwCkJIhy2
         68VKEMoj9rYzzCOBLGWHjXSfvisPps5OKm/Jqp9PN5IR9eHiG2WO3QCYVHXMwSzLNd9A
         O0uK2IdzmG6w6ZUgWg0XIor/h80j1JteyuNu5gj+cCHZ6YX9EGGAKryY0N7AcUPnQcIK
         vIdeab3oi0stWuXuAWdv1sQQaa2U/oM1C01bnoAVje+WPnbUZxDSwbt0jDrGDvqpwA1v
         tpqspuZUJ3yxTcLvPcN9YJEahK0dWjqgC/eQ8eTK/DAK7lEatlPwq4qb3xayS5RwgZXG
         5QPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=puac9P/1pH2gTjwWoFDjpCGPhH1RSMCtsgJsRORZsps=;
        b=oKgXSuxl+E/nmVHpnbpaAAbJrCB6CUKEAZy1VuRda2PuquvlfEbNXd9FODyZtiH/R3
         FlsJk9EaEbSZItCPiPSDBs2cAF7qpSl1sy8iDCRUy0bBJw+my2M8gi7hvgIAwnes4W9f
         e9rP+PldMOo45Aaw0qhbms/9LvWCPqkOK0gDLPHkq2EV/rkgQDYXZlF0+Yc1tIHW0e3L
         1Dg67UBqi3lWg7T9DtpxgERRM5ZWSE1zCQ47zk/ouKSURJEWkzOuRYc1tDf77KIKS5BU
         PoSw+cRekYLRHBtw5bTNedFwXeaHK5QtbWp90lXcctQWvI3nfx5tXCpUg8jy/kVoP/wX
         nbqw==
X-Gm-Message-State: AOAM530W2whbjTJ3jPAa81YhXDtu2kqyYf98fI1UuxDfrxsYm9LZazPC
        Au1KEoFbVo1RKGYGflLyXKg=
X-Google-Smtp-Source: ABdhPJwxVFI67Tc3W19dlbyZNc1e3oxlbpVUX3LqDmZg7zTCXURGdjpwQ/MpJv+vQ6Drwqm86KEn+w==
X-Received: by 2002:a6b:7413:: with SMTP id s19mr32097168iog.151.1620953848097;
        Thu, 13 May 2021 17:57:28 -0700 (PDT)
Received: from localhost.localdomain (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id g25sm1981538ion.32.2021.05.13.17.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 17:57:27 -0700 (PDT)
From:   Connor Davis <connojdavis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Connor Davis <connojdavis@gmail.com>, Jann Horn <jannh@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2 1/4] usb: early: Avoid using DbC if already enabled
Date:   Thu, 13 May 2021 18:56:48 -0600
Message-Id: <d160cee9b61c0ec41c2cd5ff9b4e107011d39d8c.1620952511.git.connojdavis@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620950220.git.connojdavis@gmail.com>
References: <cover.1620950220.git.connojdavis@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the debug capability is enabled in early_xdbc_parse_parameter,
and if it is, return with an error. This avoids collisions with whatever
enabled the DbC prior to linux starting.

Signed-off-by: Connor Davis <connojdavis@gmail.com>
---
 drivers/usb/early/xhci-dbc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index be4ecbabdd58..ca67fddc2d36 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -642,6 +642,16 @@ int __init early_xdbc_parse_parameter(char *s)
 	}
 	xdbc.xdbc_reg = (struct xdbc_regs __iomem *)(xdbc.xhci_base + offset);
 
+	if (readl(&xdbc.xdbc_reg->control) & CTRL_DBC_ENABLE) {
+		pr_notice("xhci debug capability already in use\n");
+		early_iounmap(xdbc.xhci_base, xdbc.xhci_length);
+		xdbc.xdbc_reg = NULL;
+		xdbc.xhci_base = NULL;
+		xdbc.xhci_length = 0;
+
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
-- 
2.31.1

