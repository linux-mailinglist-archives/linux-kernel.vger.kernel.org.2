Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EB540F493
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbhIQJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhIQJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:14:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B9C061766;
        Fri, 17 Sep 2021 02:12:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m21-20020a17090a859500b00197688449c4so6963535pjn.0;
        Fri, 17 Sep 2021 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1bx5uHHL6FlfRq6JP+/w3u8MNp6sfgydH0tgxJOMHo=;
        b=nORhe60bUPzqB5JFOh+AJ1PWv4zBImjnTbBncLzVM6tTimzBs9PDNwlfJZCMww0IwH
         TMrVxXUP1SsMqDb84c2hjrLQGILlThiplOb+8fAsAQC40u/b7zeeJJu00UmNAlPpNf+2
         IVydlH+/jaY2m4H2UbtVc8grUYR8loiCk3jALFglz3Ut2exYUHEM/MT03dzq5JSLYL4s
         r4o4+pm8+JWoTuegYLPvkE3PhlO8xXp6oTXgtyP/XzhrGIlxC4MmX6ymBqcE3Gsv09p9
         l4zxdkWTEewq2PUJE5hSSXG/QLcDyNKO1FqwDPMr0W04fRwFHFPZ8x+emylNHBRdpQIm
         Dn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1bx5uHHL6FlfRq6JP+/w3u8MNp6sfgydH0tgxJOMHo=;
        b=sdI9xP2xvkx4vL7FaOzZyjA7ClKiBeODWvsdMNRzZnBEFGQqAUY6k03C07LhMjrLia
         BMrq7ghO9iSSdzCL82gMx+GSdWEcwFMLC0VwGHIArs7uOzfP8OlP2OZxmyY7PYBg9XTn
         4wqACOA8mw5iBIQYKsz5KpYs3v+UuIdQWYBy3u+ooByZv50BLsdPcIvJfaLGoR3ZDaFs
         vMPvp2H09l46Y24JGqU9zG9FEbDTyeZGo4vlqldNwaDSGVLJDKIaBx93Kkdph8o7g8FF
         8m2JCgx6E7LoBjPBh8Yg5iBTGm38A6pHVwMvvLXMV7cYcyNx5UslmdvXDcvflN8hxAbv
         PW2A==
X-Gm-Message-State: AOAM532+QUxwhw7IgqQKTb4Ro8g7xbPlRTrrlPFrf7FPgQ70khweDIAn
        cQaH76AovrNsw/8MxqycdJw=
X-Google-Smtp-Source: ABdhPJx6zNVayeQJBv7jSiAMoD9Z6H6ldSBP8MdTQGW6ETgLPaNDnST4Jy6apaRTJxCgvJUBOlLXvA==
X-Received: by 2002:a17:90a:352:: with SMTP id 18mr11120223pjf.116.1631869974138;
        Fri, 17 Sep 2021 02:12:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h4sm5981757pjc.28.2021.09.17.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:12:53 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, lv.ruyi@zte.com.cn,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] clk: mediatek: remove duplicate include
Date:   Fri, 17 Sep 2021 09:12:47 +0000
Message-Id: <20210917091247.231305-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Remove all but the first include of dt-bindings/clock/mt8195-clk.h
from clk-mt8195-imp_iic_wrap.c,and maintain alphabetic order in the
include list.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
index 0e2ac0a30aa0..261610509e39 100644
--- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -3,13 +3,12 @@
 // Copyright (c) 2021 MediaTek Inc.
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
-#include "clk-gate.h"
-#include "clk-mtk.h"
-
-#include <dt-bindings/clock/mt8195-clk.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
 #include <dt-bindings/clock/mt8195-clk.h>
 
 static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
-- 
2.25.1

