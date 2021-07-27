Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794693D7E65
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhG0TUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhG0TUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:20:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6847C0613C1;
        Tue, 27 Jul 2021 12:20:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i10so14097429pla.3;
        Tue, 27 Jul 2021 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHziLjjqyxefZtcR6RR5sEm7JWKE/3FDMlOkhJ3+ZIE=;
        b=AsAbov8jJTY0LdVJ0IqoUjLzlw5C3IcPG/I6sbaWk+w9qzgN3F4np8CJDSJV+LLxpQ
         w0MhhB7Gsq00qedbp7PrRPgAXg6OFC2uvywphjGl1/haXG/j7dqR/Nv1nSkVvKkdp3mD
         vQO2e59SdJSoKzwVkVaNq2G6aJ2Lk56ruFLMerIlri/KdJEpP8IHpEGq53My0m+2v4Qr
         gzCr/5xcpjtmkSt+kTY+dpA8fp7lLns92x/38RDIFOyf5YWxFqawZ+xCCKvFfv1PdTUn
         ARI2L3imRmsltR7QRL/dM+QQ8uyFPNupVWzP6gsidFe8xGVc+s/RKI7N9Rk8kTaWmZcF
         b74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHziLjjqyxefZtcR6RR5sEm7JWKE/3FDMlOkhJ3+ZIE=;
        b=CX+6yQ374rIdsg8kW4trghVbxqvNayUQNMBFopFgPv8th7feBiKOkxjFmMx3o/tzUD
         /LhMtFi9ndx5Bski0wg6xenF3s3Z5fxz6gxnzh8+lZWRJn61LZVsU1K6v6we7tg+NocU
         PBFrbFWU9mbbUtrQRBgFkxm50sFoxaklG+HS5T2yynh1j7SMClsFTbxyUaLVUNZufTrK
         GP/tZ4NKDm04PgLMNbVunnsIzUeLq1aH34fgoU5nTG6h3VUH8Tgp06InDBl6aM5ed7aa
         Cl4rOxGYTXgpDt+eBnBOari+7iMXOyn0jLPj1VdOWoXUo4dOBMBlL3z2qonMCChasxZ6
         myvA==
X-Gm-Message-State: AOAM530w6Xnap9DvckKc29aG73tMz/0HGYapzUEzKkausuUlxs/3Ebff
        t90npTnnXqIRpZviCrbjI7k=
X-Google-Smtp-Source: ABdhPJzedmnDBl+aFoSqdhhSe5Uh+m5JBpXhH4WG7Z/970SgV40K1r31Voq+PQE7Z0DJvsYoA2B12Q==
X-Received: by 2002:a17:902:9a92:b029:127:8aab:6a46 with SMTP id w18-20020a1709029a92b02901278aab6a46mr20556299plp.8.1627413614279;
        Tue, 27 Jul 2021 12:20:14 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id f7sm4317096pfc.111.2021.07.27.12.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:20:14 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Benjamin Philip <benjamin.philip495@gmail.com>
Subject: [PATCH 2/4] staging: sm750fb: Rename oCursor to o_cursor in lynxfb_crtc
Date:   Wed, 28 Jul 2021 00:49:51 +0530
Message-Id: <aec911b055687892897feb4899644b9463245f1e.1627413010.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627413010.git.benjamin.philip495@gmail.com>
References: <cover.1627413010.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct lynxfb_crtc has a member named oCursor. This name is
CamelCase and is frowned upon. This commit renames it to o_cursor
and makes the necessary changes for the module to build.

This change also fixes the following checkpatch CHECK:

CHECK: Avoid CamelCase: <oCursor>
137: FILE: sm750.h:137:
+	int oCursor; /* cursor address offset in vidmem */

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/sm750fb/sm750.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 08c1048be541..4093d5e898c6 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -134,7 +134,7 @@ struct lynx_cursor {
 struct lynxfb_crtc {
 	unsigned char __iomem *vCursor; /* virtual address of cursor */
 	unsigned char __iomem *vScreen; /* virtual address of on_screen */
-	int oCursor; /* cursor address offset in vidmem */
+	int o_cursor; /* cursor address offset in vidmem */
 	int o_screen; /* onscreen address offset in vidmem */
 	int channel;/* which channel this crtc stands for*/
 	resource_size_t vidmem_size;/* this view's video memory max size */
-- 
2.31.1

