Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B66B4105D3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244823AbhIRJ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244848AbhIRJ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:59:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E20C0613E0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:58:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso11797455wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G3L7UCaBvWad8+27dGs+IVJ3mC7af2HpF3EaDWIxm5w=;
        b=duqVs66A83TsK8E3/YGRQqAq4WCnVULKCjVZjsBs36npCIIXbt6dZUy7PbokWqbzuM
         Ezllb9BrRpvJJA/0P82KKR0jC2Oa1gGH9GPGntXTYsxa/374jffhD7MxrIOEYq3xISwn
         ZVfrYVnesqKATSiTWi7yfo7+rm0ONuRSSHdGzsK8dib1Wkr7UKu4efBqzxQiuQjv7uFM
         qAeNnU+dgtIcEBi800gEj0/0HRkmYfkPTrkMsPF5NsOjdqQpJ4XAHkF0wuaUjBbaWbx5
         JMiFWDzUP1CQRP5nEsmx3AwLha1e+JwAgzZx9TfbQuRIr0cxxBN8cmda92dtlbzQ2y+T
         ASfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3L7UCaBvWad8+27dGs+IVJ3mC7af2HpF3EaDWIxm5w=;
        b=u+saXy8Y5Kk2cMdqaACiITFQg2qQezav2LPr2k6azzcRYJxvGmJ1TNAv1lvtp6lPr8
         hklnujc+jI+Nom1Ro2CMyymfcxBCQuBBWoI8sMD59vG9hV+ZMZwxyp8YZcZppLiDOajM
         PuWLIXc4n0BYb2v066mdPQ8nTUSwq+u5BGu39c26w9nQ9e/mtKKMqmoZm+T6M4XG4Ktc
         Dfq3MOWNmC1ulrLQ86ffb4je9KnocZP56rSUFu5c4NwA9UNO4HYCMxmmm1Sbtvr9GTJv
         KRueSTiJFwfJ5vTfNJPsWgKcdyIeSvNOl7HEVRw7ozw1mwHsIwFn3LzVabl2Qo5JX3zs
         PgaQ==
X-Gm-Message-State: AOAM532ZNCIg2NPIo0Rg8KXGyx4HExO4hC3x6b6Pmc1S8XSQXSDztSAs
        JAlHp8FCkKIIom5P5FHnYRU=
X-Google-Smtp-Source: ABdhPJxhHDNMxpVa0IF16fDZRjZGH4ydTY9Y45cD7TMUUU3PRlnxouDadSXEbvYkcvRQONdbpXBWEA==
X-Received: by 2002:a7b:c107:: with SMTP id w7mr14878939wmi.91.1631959079212;
        Sat, 18 Sep 2021 02:57:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id o26sm13013287wmc.17.2021.09.18.02.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:57:58 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: r8188eu: remove unused struct rf_shadow
Date:   Sat, 18 Sep 2021 11:57:23 +0200
Message-Id: <20210918095727.13591-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918095727.13591-1-straube.linux@gmail.com>
References: <20210918095727.13591-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused struct rf_shadow.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 2fffe42e97c0..2dcfbb008914 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -29,27 +29,6 @@
 #include "../include/drv_types.h"
 #include "../include/rtl8188e_hal.h"
 
-/*---------------------------Define Local Constant---------------------------*/
-/*  Define local structure for debug!!!!! */
-struct rf_shadow {
-	/*  Shadow register value */
-	u32 Value;
-	/*  Compare or not flag */
-	u8 Compare;
-	/*  Record If it had ever modified unpredicted */
-	u8 ErrorOrNot;
-	/*  Recorver Flag */
-	u8 Recorver;
-	/*  */
-	u8 Driver_Write;
-};
-
-/*---------------------------Define Local Constant---------------------------*/
-
-/*------------------------Define global variable-----------------------------*/
-
-/*------------------------Define local variable------------------------------*/
-
 /*-----------------------------------------------------------------------------
  * Function:    PHY_RF6052SetBandwidth()
  *
-- 
2.33.0

