Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556843DF06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhJ1Kig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJ1Ki3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:38:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ACBC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:36:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 192so3745347wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=57jrsqHmJG3XduSsdkS6puAAy8HJeI7z6m7TmMyYW+g=;
        b=aWiCs+Xn1Hutl4fQQCHwuZkWzIv5Vr9egCcMdniw98K87gxzW27JDelUGRSAxn0Mbh
         s2IAq0xKqJxKEGUJ/f+4mbCInjyFi7ps33WI+IscYACNqsf4s/GytYgHHOpeZUFOhzXp
         8+t5GalbQe3AAEjzvx/qVd8KyJEc68Qi2drTRic6IIc5C+kDU+PgAtoXoUcm838xVL1y
         HNEADG+5mT2xL4ZBDfMddoOwANUxcpXj+Qxk0IcwIMO4SCFSfoWSUp+Cie+rO9ivjqaP
         t+3tUPCZxZhugfNa3P/rQqyKT2wrRKh1/1e7ya03oIGAdM8l2zdXay949h7iPhLF7tET
         R2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=57jrsqHmJG3XduSsdkS6puAAy8HJeI7z6m7TmMyYW+g=;
        b=uoEv9SQS3qJ4f5TsikwmQbWMNQ114cCS5rjKvAd2JSiIJyiUrH+HR9mfajEwLmaSJt
         jHhWHp7Ub3EADyyPGU/kpXwiW9n3OYrVdHofh/IVzr+gjTh1/WrbPnaUlVSQ3OWdazpD
         wvMc9QPl7WE6vVsQc3eYcuaUNqtMk6H/JTmQk2t9tew8UxX8WVqIbKlAo08vIIVyKlay
         Xu/fgL0fKom0wDGrZ4QmcBPBTk0rLnUhPK8/2hD255o8Wqww4t0+q2I3Ov8UhfsqGWNP
         Fe9Dr0jjyN3DDghEh7FuaQXOc+u1KRK8T7ZrcB1Nd8CcYkaRQB1HjLVQYv6BO/xYT6VC
         3Nkg==
X-Gm-Message-State: AOAM531vKkv6ahV+WSzur6IqFB/tO6ETuqAyleWe94fxjS8jysgHR/F7
        wOkQ8DOqU5vakbAKxzHPh+I=
X-Google-Smtp-Source: ABdhPJwbmE95qXKO/Q6XxnsnmOmHOKh171FNsn+WKyRCAfn3dcwM+zmk+ZFI2qAvtzaolXdeVoXMSw==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr3543917wmc.5.1635417361472;
        Thu, 28 Oct 2021 03:36:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id 13sm3768083wrz.38.2021.10.28.03.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:36:01 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 5/7] staging: vt6655: Rewrite conditional in AL7320 initialization
Date:   Thu, 28 Oct 2021 11:35:35 +0100
Message-Id: <948406a3e7d23f1cdf866aa4448d9428bdd32512.1635415820.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635415820.git.karolinadrobnik@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use conditional operator to determine which table for AL7320
initialization should be used. Use `data` temporary value to
store this value.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index afd202ea3356..af4eb7eb8e7d 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -716,13 +716,10 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
 			return false;
 
-		if (channel <= CB_MAX_CHANNEL_24G) {
-			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, idx++, al7230_init_table[i]);
-		} else {
-			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, idx++, al7230_init_table_a_mode[i]);
-		}
+		data = (channel <= CB_MAX_CHANNEL_24G) ?
+			al7230_init_table : al7230_init_table_a_mode;
+		for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
+			MACvSetMISCFifo(priv, idx++, *(data++));
 
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table0[channel - 1]);
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table1[channel - 1]);
-- 
2.30.2

