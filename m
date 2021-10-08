Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED54273CB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 00:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbhJHWdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbhJHWdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:33:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FADC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 15:31:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c4so7054155pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2SslUtgREFqZPZutv1E1PPwo3SH8tGLrCooYjOSvSU=;
        b=ZzZ/oSyVvoCxGioRJePesqRhkD8P2jQXTVcAX0CSI1G9R8HExP9FXtY+XQlKn5YwJQ
         qjt7JjgwliSD9ml2KeVlqUGfztZlit9CnKKQ3SqdIAiUEZRePGUnB/vct3RXKVd5dau0
         gcCGc4KcFgDBUvgeLus8NKt+CpGuNnJGCnc7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2SslUtgREFqZPZutv1E1PPwo3SH8tGLrCooYjOSvSU=;
        b=sEA//4OXSsatruyU2ALU0AvS0qPjq4t0Pgil+ibaO1GIFZKIUBCLZOePaTZ+Ag9PdY
         Jr6/66T/JM1fNrem5PrKerW/64dR1qLZ8zcS2+G/nlo6qMCupCIoT3KVOIxacK/lIUrN
         5fg47U7Nf4BIaWKndDRiSx4Ow0TeMCHiizkdzhYqsN8/df1MiAqb2Yqv/b/3mZf7gy0T
         0Sf+XmqZ9CxuxCmrulLTd/mSMcqPBppLWgY4ddawYBQQgiE6a9nmVuOWGFJfC5oOignK
         e1PAHvB0VuFn8/5Ml/qYZduXkns8Gt+e9WIvSZT4HgvbVOpF1zGe7zFKGYf4KXeliJPc
         OKdw==
X-Gm-Message-State: AOAM5307w0i0AjhS+EQuJsqrFJkNAQPkRmoc7ChoKAR6bY1WT0nE0+fn
        01K0+BsOj4aJQ45VC7hPsWgKfw==
X-Google-Smtp-Source: ABdhPJxUwsepBnEFFQTQHNh7+2nFo7S8tcOEzslFztnMxkYzwYSLSUB/2QlZPi9UFdSP/NdTQY+cSg==
X-Received: by 2002:a17:90a:e547:: with SMTP id ei7mr8195089pjb.169.1633732271765;
        Fri, 08 Oct 2021 15:31:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:2a6d:84fa:761e:91e4])
        by smtp.gmail.com with UTF8SMTPSA id e20sm312867pfc.11.2021.10.08.15.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 15:31:11 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] drm/rockchip: vop: Add timeout for DSP hold
Date:   Fri,  8 Oct 2021 15:31:04 -0700
Message-Id: <20211008153102.1.I2a5dbaaada35023a9703a8db7af501528fbb6e31@changeid>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hardware is malfunctioning (e.g., misconfigured clocks?), we can get
stuck here forever, holding various DRM locks and eventually locking up
the entire system. It's better to complain loudly and move on, than to
lock up the system.

In local tests, this operation takes less than 20ms.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index ba9e14da41b4..b28ea5d6a3e2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -726,7 +726,9 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	spin_unlock(&vop->reg_lock);
 
-	wait_for_completion(&vop->dsp_hold_completion);
+	if (!wait_for_completion_timeout(&vop->dsp_hold_completion,
+					 msecs_to_jiffies(200)))
+		WARN(1, "%s: timed out waiting for DSP hold", crtc->name);
 
 	vop_dsp_hold_valid_irq_disable(vop);
 
-- 
2.33.0.882.g93a45727a2-goog

