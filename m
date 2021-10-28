Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B116943DF05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhJ1Kie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhJ1Ki2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:38:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0F4C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:36:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso777823wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ryVRGAjLsxXO+6wVDsG6ZKxEGX+uqPXEwX9lKO2pYz8=;
        b=oTa74fFIMCJ+x2ePeHlgRabqX0lSx0DtIvQiGY8DPp1l/ybpqDpEkaacD1BSvl9rKj
         9rkIzQKV2A12cQg1fX7IuS3vmpnYg0GLJib6NwOaHSrPdTqbufG78wfxSN6fBpMUBLwk
         iXtzF5vqySnICSmTRBOl0ETw0+HT//jgZo1/p7YLWng3GUXiuc63Pm1XhxO4KiJmL8V+
         Lj3GDpqy4EsY3La1e7Aj6hA9yzs9wlUY7sUe8lrh1WL/sipQ+Mj3LNj59chqSeGqyiXO
         adoY+NZAyqm8JgExediOLtnAr5mVqd+jtibEEcr61BLshlHVBS2GwAz6+rRyQAt7qT66
         Kjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ryVRGAjLsxXO+6wVDsG6ZKxEGX+uqPXEwX9lKO2pYz8=;
        b=P4REsT2e2vZZc+nxhXAYQvSORAhmqD25k6bt9H5xVWU6OfzdGzHGO7/9avPzEnqGaI
         5XofdiVDDtv4rS+FSqXT1mEAkTu/VE3Mfn9BNP/ZbXBy0ODVLQ954k1WeLGUFIo6NsGf
         pJzrmvC1ff4vZswms0Gn2wU7FgVSwtFFV6PzNW1jOLWr0lbQqQMwjRDSfdeL54aRrDp0
         BZh0Q+npHRkGkkBhMpKrq6gbQZbQSYHTCyo7CJlDUvLRbQgkZwBtCUqbRAjRgY7GD9vm
         UOeyIg0WfQdYvCQHbBK44Z7zwAs/SzCAhQgflFByQmjv4bdLXmSEcoUr5pxNqqeoBa1t
         twfA==
X-Gm-Message-State: AOAM530FTRdIllNwrwSCb0yDAlq0qeh5uAejQ8oQYnL4xpeiVbMv2F83
        zqW6zDYnviyjwAzuc14mziShmT6Ae81Le+N4
X-Google-Smtp-Source: ABdhPJwANglesR0yH0tFkE40PA2JedPLehor4ru/Qocl5UtdTFoePTYfby5H/+HXZdSkLf3n7jtehw==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr3624563wmc.153.1635417360026;
        Thu, 28 Oct 2021 03:36:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id 13sm3768083wrz.38.2021.10.28.03.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:35:59 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 4/7] staging: vt6655: Introduce `data` temporary variable
Date:   Thu, 28 Oct 2021 11:35:34 +0100
Message-Id: <dc72a4c3539aed70569f66396ed3b51818bc2aea.1635415820.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635415820.git.karolinadrobnik@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a variable to store initialization tables. Use this variable
in AL2230 initialization.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index ea74701917e5..afd202ea3356 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -684,6 +684,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 	unsigned short idx = MISCFIFO_SYNDATA_IDX;
 	unsigned char init_count = 0;
 	unsigned char sleep_count = 0;
+	const unsigned long *data;
 
 	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
 	switch (rf_type) {
@@ -699,8 +700,9 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
 			return false;
 
+		data = al2230_init_table;
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
-			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);
+			MACvSetMISCFifo(priv, idx++, *(data++));
 
 		MACvSetMISCFifo(priv, idx++, al2230_channel_table0[channel - 1]);
 		MACvSetMISCFifo(priv, idx++, al2230_channel_table1[channel - 1]);
-- 
2.30.2

