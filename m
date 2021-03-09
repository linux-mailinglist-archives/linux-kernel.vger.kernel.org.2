Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA5733304B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhCIUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhCIUvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:51:13 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827CFC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 12:51:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h10so23137981edl.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 12:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+LXPS2g/C2kk8K3V/x2NSnGympAYYgTq9AwkJ/pVJg=;
        b=K1IwR7nekABeEPYTpc4sfCNOmMmM69FNHkZxRzFj0qH5RZWU9XImYZzmlE0RnWRh03
         F0CTTqCA0DSvbgqIBvUzbrZXpvHL1YQJEs9xGLp83Z5EbjgQjwPiEVTTuLNLmFa9QNmh
         PhaCKqXzEEY5ATbSploSh7okQTotlAOa7D8ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+LXPS2g/C2kk8K3V/x2NSnGympAYYgTq9AwkJ/pVJg=;
        b=Mu17gjKeo/2dsuFvnLSlfTQ74YoNYwDLs1y8XI9lJQ/fCgQSGC+keRHPp279tzrzKx
         S99cSm+IjnciTLb2UsK6wv9fIKTBOfSomT58Tv3s5So140c9HCIu5ctuliVBMOy8HabR
         U88FwQjf8mrrg9rHwpE3Av7RaDp/nOc2knVUJ6r0sIw1j2mf0me12QNiDHmVWTAlVFRt
         ONaFNWS6AJNTto6lF6Hfw+aSKw/Q/2MOVQytNxY9aqIJgS3KIMJpWaRTK1jplP+UYAWq
         pHgvBRPy8SHaOekaHUX/YQ+nw9cjYiAY4nOXHIjov9cLtvc5KQ7X8Ymiaw+XtIgNOXg7
         y8Yg==
X-Gm-Message-State: AOAM530kLkoy9liBBBR2qrNmDR+wyt669EKeTKilPpRDbC05pLfVcHoO
        EL9Mei3p38b4w3NI7/CUzBXq4Q==
X-Google-Smtp-Source: ABdhPJxnRoBhZTMo7aEzAdv4A87Pfu3GiwuHUGUxLoppCuiln29NC3PVmEVw94505C+/DTTrS7jsCQ==
X-Received: by 2002:aa7:c6da:: with SMTP id b26mr6426641eds.254.1615323072076;
        Tue, 09 Mar 2021 12:51:12 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id mc10sm8861190ejb.56.2021.03.09.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 12:51:11 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 2/2] media: videobuf2: Exit promptly if size = 0
Date:   Tue,  9 Mar 2021 21:51:08 +0100
Message-Id: <20210309205108.997166-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210309205108.997166-1-ribalda@chromium.org>
References: <20210309205108.997166-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exit as soon as possible if a driver wants to allocate a buffer of
size 0, and print a warning to help fixing the issue.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 030e48218687..c5b06a509566 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -105,7 +105,7 @@ static void *vb2_dma_sg_alloc(struct device *dev, unsigned long dma_attrs,
 	int ret;
 	int num_pages;
 
-	if (WARN_ON(!dev))
+	if (WARN_ON(!dev) || WARN_ON(!size))
 		return ERR_PTR(-EINVAL);
 
 	buf = kzalloc(sizeof *buf, GFP_KERNEL);
-- 
2.30.1.766.gb4fecdf3b7-goog

