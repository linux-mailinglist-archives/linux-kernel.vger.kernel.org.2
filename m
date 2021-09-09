Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B21C405DF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbhIIUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 16:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhIIUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 16:23:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0134C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 13:21:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m2so2242146wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtgnYh4+V2MnpDEhOcmk+l7ZYHvGZHXFt+EjfvjuPgU=;
        b=oZVa5hb+/A+juJRocbJEsGIOh2Vgt87Ol5kGD27oTDbndwB14f6+E/NH2o751yPtnM
         DleVf7cYm7aPYU8k3q7vShxcKgduWmi+COnIH+JsDERyAfURxw4me7vYSpe/OaYGSJQQ
         2UfGtvNcavkZj8S1wR0IeXnM6Pec8RwGLNq00IUAFhxPqNz+G2xoCPjXcIrohjcN09Ay
         EUPimfOozhYaYW5pHA7Izb0wixY6/ld6OIG6a1cUBpYThatu6/eTGSx2lW8EaZEHr95z
         PkA2H2lhEfNdyrQ2y2419DmT+kIDN8bSRMhTVknGUuMK7p7MszgCHxqm82rTQ+5Yov6r
         TM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mtgnYh4+V2MnpDEhOcmk+l7ZYHvGZHXFt+EjfvjuPgU=;
        b=cHvOV++lbPRa9m59EUoeFTS1OYq+XqF+9ZxInvGWt1Q6WhxcSXuFKo8CaMagig+2l0
         J5qT9aVl5/eIgYgQR3WUG56CCSswOK4c/bnpGC8y6y3c2SOQRAAAGI0NBuIBs1WZETNX
         ODOP6L9soqgPpuj2xo8C2PdlDAwgiWknb6FBs5g0iG98zRlUfOv9bGe22U3t0qv2cgvF
         sX5LGgbfH6gFJdMwN3iSK0pabLUTcYRk+Ym2aVNS19g5bQHuMFCPri+vT4jSrPgTVr7a
         zMa1UBSvp/vZSu2JoaJdYPIYEC59HDhgGHaARftFsfM8aPCzFj7GXp/g4nEX3o5Yjszm
         TZ1w==
X-Gm-Message-State: AOAM533cQvu1nHyh2fD1C8913iYRjH6/MCV3so+ihhwYaZbcQHgAR5rz
        OKzOCt2h8Fc35Kz6mbtolrQ=
X-Google-Smtp-Source: ABdhPJwdYbEbTikpTjwNLOCMQWyLbZ83iknG0vJnHFYYzkcawvTeQ9xid/+cHX/rxAo2MWQuGcszEQ==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr4805681wmb.139.1631218913461;
        Thu, 09 Sep 2021 13:21:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id n5sm2415620wmd.29.2021.09.09.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:21:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unused macro ROUND
Date:   Thu,  9 Sep 2021 22:21:30 +0200
Message-Id: <20210909202130.28508-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro ROUND is not used in the driver, remove it.
Found with GCC -Wunused-macros.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_security.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 82987255400a..db35f326bbb1 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -1555,16 +1555,3 @@ const u8 rcons[] = {
 	0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1B, 0x36
 	/* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
 };
-
-/**
- * Expand the cipher key into the encryption key schedule.
- *
- * @return	the number of rounds for the given cipher key size.
- */
-#define ROUND(i, d, s) \
-do {									\
-	d##0 = TE0(s##0) ^ TE1(s##1) ^ TE2(s##2) ^ TE3(s##3) ^ rk[4 * i]; \
-	d##1 = TE0(s##1) ^ TE1(s##2) ^ TE2(s##3) ^ TE3(s##0) ^ rk[4 * i + 1]; \
-	d##2 = TE0(s##2) ^ TE1(s##3) ^ TE2(s##0) ^ TE3(s##1) ^ rk[4 * i + 2]; \
-	d##3 = TE0(s##3) ^ TE1(s##0) ^ TE2(s##1) ^ TE3(s##2) ^ rk[4 * i + 3]; \
-} while (0);
-- 
2.33.0

