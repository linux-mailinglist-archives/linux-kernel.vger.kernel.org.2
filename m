Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD79637B2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 02:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhELATf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 20:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELATe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 20:19:34 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA543C061574;
        Tue, 11 May 2021 17:18:27 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id c3so18754945ils.5;
        Tue, 11 May 2021 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=puac9P/1pH2gTjwWoFDjpCGPhH1RSMCtsgJsRORZsps=;
        b=KVnhpxSKSgjxFKZXFSiHszto+jk1TG6dHF6KfPOJDxdnW5ABx+HpY3LPhsV0oNEYdU
         oOY2KZnnEdfwyeoTn19rO/DWpWf0O3blIvpZ0JPdzTmItMYHWDFp4hP9TX8JFPXxs8t6
         OEOQhUyyUCvwrEwL+kXIgkSEVJBz+mIgiLVe1X9ca0uYQWF5H9EbzFZ77PHOPnKfdS2Z
         V76FL/tX9xIwhDf+ym/LTIwmGVj2VeuWwJyy+uEOBU9ZlksbvAQo4MmOawNclyzLEnpa
         IjYwCl2dc5uthpQGF5HR1mj1jfG5xvg1/BdoGsFLLYXQzg9LYFdfSxy7fb2uZpVBkOG4
         jyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=puac9P/1pH2gTjwWoFDjpCGPhH1RSMCtsgJsRORZsps=;
        b=eQWSUCo0WvWjrtgaRDWvjbe317hNyd8OyWY9ga/kGaZV3IYovtLp9WHWcd/wa9nsqM
         J1lTMUvQHmMqTDtf3fXV4C+jy7eIi9lfzCSoVv4DsTnNJqMfUzxpMpmTpr9OGngJvJLz
         No6VddlXp6Ol7eqH8pEsLp8dj38ltsKq1f7Gv45OkEosamMoWwaOoZJdP29GuV+N45Mn
         TGt5cUOgIPjZzCHdZEkPm6Pi8YZTjjh6jLegDWUDlArPPvKNsjRCUPZ0/OnVfQePRGj/
         w6JWUY9ZBv8uI4fcLuyPwMFPBhcjUYFKgzJSKkkbkmou0VG86rFEmCGuKLcpHCmf8IIw
         9Lqw==
X-Gm-Message-State: AOAM530H8KB4aZL2O9L274ZnylzLGWPi4f5mKj3b+lKqE/Wifrn4jCEM
        QInLo7Z52rslyaeNg2ckpdU=
X-Google-Smtp-Source: ABdhPJxwBLia0GULiakrQ/ChbOUlE5Y7VdEixYIKRKbmd5BUsUIAgrVrusZYIWrKZfjHhsy2cqSD6Q==
X-Received: by 2002:a05:6e02:20c5:: with SMTP id 5mr28877967ilq.14.1620778707477;
        Tue, 11 May 2021 17:18:27 -0700 (PDT)
Received: from localhost.localdomain (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id v4sm8241490iol.3.2021.05.11.17.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 17:18:27 -0700 (PDT)
From:   Connor Davis <connojdavis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Connor Davis <connojdavis@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Jann Horn <jannh@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: early: Avoid using DbC if already enabled
Date:   Tue, 11 May 2021 18:18:19 -0600
Message-Id: <d160cee9b61c0ec41c2cd5ff9b4e107011d39d8c.1620776161.git.connojdavis@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620776161.git.connojdavis@gmail.com>
References: <cover.1620776161.git.connojdavis@gmail.com>
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

