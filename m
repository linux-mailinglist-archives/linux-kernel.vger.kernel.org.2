Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E4234B7A3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhC0O0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhC0OZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:25:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08048C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j9so6653995wrx.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ByK1DDWOjUpsfElsdflbL+PD9t10A+tmGzJVFXAUHaI=;
        b=OfHe15yhUIenZybF99TmN/6y3i3G1hTzgRfS7MkqZEm/p8/tZUnCstQ0Bm1SqneQAt
         baSl9EJoo5OWc0sVl6KJsdwDlrQi4MZ/Fm1wFZU6hLOvcu8yNLov4nkx01w8H0uyJpFt
         8ddsHGIVrfiwOoXSl5X3K/AQ+jNsp2ya2kC/hehqCU4Wxia7ST8p67wAcOFz2oIiNMdw
         yftOhKCmp3RtDwBsLHyRc9TCbWrdVJY3CY10ckKvONCm9McEA/jd+5jr4/0t9/ZZ9MUx
         zIVYhvd1Qtnt0nT0kRZb8hZHxiRz4XNioTHeCfywsNUgEkfaIOX6SokgZU3jskjZ5G04
         tP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByK1DDWOjUpsfElsdflbL+PD9t10A+tmGzJVFXAUHaI=;
        b=N4tewJUF18wuGGwa7LeoSOLIWBe9g02yQ/7L3pfypsnSwDbo0djkUhtbFquB4dZmt0
         67Y7qipcuVeYCqJj0MROZpTnYiu+hqNWo8q8QPP8sBX7FnKNc05ZK92dcq0Ye9GcdQxl
         qy/81P1X13DsiZjkUfcboprHbA3BlAGjtOIg/6+lW4JroiS4YXEtTqsOpYc7fb+eMqPG
         Wgwvstrnatv8vFdM2RC9hoTBF+by4WJRHCkoY4jJ876LRrtIGs8HdpL7rjwhQ4wl23ZS
         KCWVlQonh4LTJeuutQFTtyWuRxKYZs+FyYVGU0iFQmj2Po/z+KT2VjJz0GHS6mOuz3E9
         Hsmw==
X-Gm-Message-State: AOAM533wHnA1IGpWpesWYhZY2S33EhjwMNo6wriWu0nUOg3Fc2yV1ST6
        c8jIqXxCCUjj/pXWet5gsYA=
X-Google-Smtp-Source: ABdhPJy3Tzz84P8Xb+QCT4eMVCZ8eilAi9o/73a57QAl8uBz/A5ZzAU0anra/AM3Gfj+J4rdXixFSQ==
X-Received: by 2002:a05:6000:10c3:: with SMTP id b3mr19448506wrx.96.1616855125814;
        Sat, 27 Mar 2021 07:25:25 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id u23sm16707567wmn.26.2021.03.27.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:25:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 20/20] staging: rtl8723bs: remove unused macros in include/drv_types.c
Date:   Sat, 27 Mar 2021 15:24:19 +0100
Message-Id: <b405202e5bace2098dd7c787297f700cc1c030e0.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove declarations of unused macros

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 7eb59a16d00e..a454a6390537 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -266,11 +266,6 @@ struct cam_entry_cache {
 	u8 key[16];
 };
 
-#define KEY_FMT "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
-#define KEY_ARG(x) ((u8 *)(x))[0], ((u8 *)(x))[1], ((u8 *)(x))[2], ((u8 *)(x))[3], ((u8 *)(x))[4], ((u8 *)(x))[5], \
-	((u8 *)(x))[6], ((u8 *)(x))[7], ((u8 *)(x))[8], ((u8 *)(x))[9], ((u8 *)(x))[10], ((u8 *)(x))[11], \
-	((u8 *)(x))[12], ((u8 *)(x))[13], ((u8 *)(x))[14], ((u8 *)(x))[15]
-
 struct dvobj_priv {
 	/*-------- below is common data --------*/
 	struct adapter *if1; /* PRIMARY_ADAPTER */
-- 
2.20.1

