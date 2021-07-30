Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA873DB5AB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbhG3JKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbhG3JKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:10:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F14CC061796
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:10:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gn26so15609529ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PIj0/g+PL56KzxYDwNR9OxXc3IsrpR6H0nAgIpjaVHw=;
        b=f23GaMoyeTU1FKwAcni5rNwzCYWM+R87wB7qPDqk6jkzoObdIGtM07AIweE0AZo9gl
         3uFBaQm2YZHSsoXhGB1BlNkkgMLFUXMnMQiK6s0EgEfIEnVB3HWc63+RouiE1VpmYisU
         M6NAQKHvlzBi11NzNY3bKPtD1X88BO+B0LM8FRQqirWxPRQnXx8TTSfnhu6z1UwE6UEE
         zN3TeDTyGBsUXbgVvDifEGXo0123tWTT4QvXtxXwb64ktKUJInNWKuUfy5eDbGB3WC20
         VP1fkgKZXXyv9g9cT9I6cprUw4T5m5JjvjDB+47vlZsKyMpOEIVhrD/RlJoQjLA5O6YH
         LOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIj0/g+PL56KzxYDwNR9OxXc3IsrpR6H0nAgIpjaVHw=;
        b=jfH2QGjl0X7TfP+5r1UBs8orR5RqI8NEvYWZSZOCNiNNFUOkaLqy95twsPvRdgmH7q
         +AJhVcB1Ad9fO2xme1Cmc8YL8SDzJ757K3nn/8QDC4Ee5t/x80t7t9ihpZ0LpsrNEjrS
         6RlJ5L94rwhAElH9Lh/iY0rGsqyd1Wre+cKPxG04+tBacSJ5sDeCgoGqNCpjYSNcXYPj
         fszGGn6419ZA+f1Jl76kKLBtsgVQRyjvHyFKCoRoe7x+0uaNSSRQPkXQ59IkxE8fpfsd
         Ajcs6JBobPWq19OvHb5lnG9d0gcmJIoWIdSRDaEWuAfcBv9IEqhhxQvhEtyNZz/nn1oC
         9WLw==
X-Gm-Message-State: AOAM533ZgFoDlwXR7dKwKo8+Kr9VUHJsEiGMQpd0kNMxLwlUyXWFuOu+
        uLv3n+A9vKHCGcj9B3lma1x1uCMeHkM=
X-Google-Smtp-Source: ABdhPJxzMNyxmdRD8Q+STTzSEzp0gv42ziBMGvx6ZeiZ9RU4PLZszaIcMtWfWylVi1A2UQNA3p+w2Q==
X-Received: by 2002:a17:906:94cd:: with SMTP id d13mr1680170ejy.158.1627636235722;
        Fri, 30 Jul 2021 02:10:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id da23sm417665edb.34.2021.07.30.02.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:10:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: simplify odm_evm_db_to_percentage()
Date:   Fri, 30 Jul 2021 11:09:48 +0200
Message-Id: <20210730090948.32759-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730090948.32759-1-straube.linux@gmail.com>
References: <20210730090948.32759-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clamp() to simplify odm_evm_db_to_percentage().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
When this driver will be moved to drivers/net/wireless/realtek/rtlwifi
(if that's the plan?) the odm_evm_db_to_percentage() function could be
replaced by the generic version rtl_evm_db_to_percentage() from
drivers/net/wireless/realtek/rtlwifi/stats.c

 drivers/staging/r8188eu/hal/odm_HWConfig.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 51ae02805149..19222c0eddf7 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -80,20 +80,11 @@ static u8 odm_SQ_process_patch_RT_CID_819x_Lenovo(struct odm_dm_struct *dm_odm,
 static u8 odm_evm_db_to_percentage(s8 value)
 {
 	/*  -33dB~0dB to 0%~99% */
-	s8 ret_val;
-
-	ret_val = value;
-
-	if (ret_val >= 0)
-		ret_val = 0;
-	if (ret_val <= -33)
-		ret_val = -33;
-
-	ret_val = 0 - ret_val;
-	ret_val *= 3;
+	s8 ret_val = clamp(-value, 0, 33) * 3;
 
 	if (ret_val == 99)
 		ret_val = 100;
+
 	return ret_val;
 }
 
-- 
2.32.0

