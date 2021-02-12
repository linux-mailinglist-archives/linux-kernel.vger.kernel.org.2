Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F043198D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 04:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBLDdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 22:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhBLDdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 22:33:44 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8443C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 19:33:03 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u11so4404924plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 19:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+k2EVCWavlGQSSplECmMOLFV14dV8eLZdDl9Lm/0vCU=;
        b=dC5i+gWofwtMMN4P1igX9soRn8hQ5Wbvgq3ing4Gu8mBc+DUFbJUCypx0CdiiPHALc
         vXxTXvKUbY2c+mH0wDwcF2MfLKeaLj9ehhxw6j5xml32aDG7bDd/ylmOzjSrIYUs3W4L
         JEIG0DeVTw2rRBB9uwX52eXtx6CE598bu8aRJ8y5YqG5M7yK/TfcNIaWsQWJW5L68Gl/
         duwKm8FJvNGDnw6DaL0QA2ScS8LqL/GUq4f/rql4v9GliGJkkyGEFvNOVumTfFY+UkKC
         8nRpz5W6HRzFM+2OIx2DXSMaV9UbkoeOK4dxeUjP/vlIpXsAPkzzD54VUK0mA3v2a60w
         mUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+k2EVCWavlGQSSplECmMOLFV14dV8eLZdDl9Lm/0vCU=;
        b=hpLLFi1Ak4EF8vz2003sHZDGFHkS1GKBBazQRQIRMaBKQU4GAEktT0wMPZGGtumir7
         Ly7TGAj5Bhq4SfkL/EPV3A0p0mCdRZNE8JwR7Mh9ckCYbgjlGdGSL9x1k+A07aN432+V
         NLWQT9xhoLJwJyZdv2gqmND0v/7jEEBT92TapT7eLJOP+zFUUL+doDtHUfGwZ6goG8AS
         X14UnZKEeYD8kc1PNA3x7JngpguwJAjQiXcC0S/qCC4SzZJnwVFgtdWmGTV2NSLD6YPy
         78jQpTK7ZbcJG6e+5wz/9Z1n0oFKb7E6cREKt7EtF207ghg3vX94Vj/msKFNeJX7BklJ
         9dGg==
X-Gm-Message-State: AOAM5321OD7zFGp1lryS476eaURLUFttU0JCbXAs+xPKC3O4o+6yWvxO
        2zJQTIX6ROjiyfyxZ2l+yK2OFbi173op+Q==
X-Google-Smtp-Source: ABdhPJyCo1ysklJEzL+xTQk3OXzvJHYJ/bPrpeUbIpxVp0iGJdGssitiBCeQRT6IMgK8AQiVLwaTVA==
X-Received: by 2002:a17:902:6b45:b029:e0:7a3:a8c with SMTP id g5-20020a1709026b45b02900e007a30a8cmr1023503plt.1.1613100783450;
        Thu, 11 Feb 2021 19:33:03 -0800 (PST)
Received: from localhost.localdomain ([116.75.214.250])
        by smtp.gmail.com with ESMTPSA id t21sm7726215pfc.92.2021.02.11.19.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 19:33:03 -0800 (PST)
From:   Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org,
        johannes@sipsolutions.net, kuba@kernel.org, arnd@arndb.de,
        mail@anirudhrb.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wimax: Fix some coding style problem
Date:   Fri, 12 Feb 2021 09:02:56 +0530
Message-Id: <20210212033256.2116-1-hemanshagnihotri27@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes checkpatch error "open brace '{' following struct go on
the same line" in file drivers/staging/wimax/i2400m/rx.c .

Signed-off-by: Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
---
 drivers/staging/wimax/i2400m/rx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/wimax/i2400m/rx.c b/drivers/staging/wimax/i2400m/rx.c
index 5b3a85035f6a..702a1e2fabcd 100644
--- a/drivers/staging/wimax/i2400m/rx.c
+++ b/drivers/staging/wimax/i2400m/rx.c
@@ -485,8 +485,7 @@ struct i2400m_roq_data {
  * store the sequence number (sn) and the cs (packet type) coming from
  * the RX payload header from the device.
  */
-struct i2400m_roq
-{
+struct i2400m_roq {
 	unsigned ws;
 	struct sk_buff_head queue;
 	struct i2400m_roq_log *log;
-- 
2.30.0

