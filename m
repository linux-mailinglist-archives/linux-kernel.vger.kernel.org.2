Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C61E36FCC3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhD3Oq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhD3Opm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42806C061350
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y7so6760740ejj.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACO+R08CoyLCjvDMxXLNgD1Yym9DyLgjQx6IL72eiqo=;
        b=ocEkSnt1xRxERdJb6RqywUM0s63yy7RUipSN3iA3L2FpfMdusWHFh0ty839Ub5schM
         1dZ7di3cFygAx/fJjCOl6Sq3ZO8qiUhNQK2yP9a7LwFRJ4Kf5Hgj9gCQbkrAKbDUZpab
         QgBVxZC6SnJILYVm+pluJP6VAoXQxrC37dCKiKyfYsO/b96rczLf33R0FcK+K9D8xyoO
         rgPxTjaTz8NEdzTEqDujbK3m5EEtjGMcRJY4qF0/XKyYsFZhOs98tBeoYdlmJT46cdzA
         uG7HW/E6j3v+2Bp3ZU5RxXQy9rm/s9zWJSfHr7ms3Y333uvBywiZzSXPGqtrpdLsxlD/
         MT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACO+R08CoyLCjvDMxXLNgD1Yym9DyLgjQx6IL72eiqo=;
        b=WWF6uZgOuNw5D1XkYtudMmuezN7O56BzfMRosmu7sEY8eqVyi4XaR0pqe4puA1xQvy
         SOfnQmrWqsk3ewwUZNP2NthHr7OMuCUChkcGkJoEwVgzdhCorzz28cHNFAxsP6ODcrVq
         yGe/04E6a/GUxrgWY6crn/NkczAnCIwtrSsj6t3Ro32lseqq9B4zwgb39Gq4Dhd2dkNP
         CALc/2+m+Y9LD0+QR5MhX8fIJqxwZqmNSWK/H4AdH0Oss+ewR7KnIGg2Snqo009bM8Yg
         D4FnctzB/ByQ39quzAi1kedCvwykt1x3PmRtuB8xQ+I5Y1v4gLD0i20rR75KsNuPURcB
         ekBg==
X-Gm-Message-State: AOAM533ncnYBzFY4jSYWsxpNBNaVNefR7oKpyFgdDPzyo1XCjh41+waO
        bX5wgDAIERY7+pGoMPq1MZTsOLSwFcE=
X-Google-Smtp-Source: ABdhPJyzFLjtYzogS9E6jpp4fhbusewpqxLRg9JWqwHkde0c0UprUGv/RwjESNrSTf2Ad+q3IXp5Sg==
X-Received: by 2002:a17:906:1dd3:: with SMTP id v19mr4696425ejh.4.1619793887824;
        Fri, 30 Apr 2021 07:44:47 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id x20sm1404347edd.58.2021.04.30.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/43] staging: rtl8723bs: remove braces around single statement in if block
Date:   Fri, 30 Apr 2021 16:43:52 +0200
Message-Id: <c8a29e711f071926b0aec7dcfda970e3225219d2.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkatch issue:

WARNING: braces {} are not necessary for single statement blocks
21: FILE: drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c:609:
+				if (!bBtHsOn) {
 					algorithm =
		BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
 				}

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 57579d7eab71..911d753e51f6 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -606,9 +606,9 @@ static u8 halbtc8723b1ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bPanExist &&
 				pBtLinkInfo->bA2dpExist
 			) {
-				if (!bBtHsOn) {
+				if (!bBtHsOn)
 					algorithm = BT_8723B_1ANT_COEX_ALGO_PANEDR_HID;
-				}
+
 			}
 		}
 	}
-- 
2.20.1

