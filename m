Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E87441CAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhKAOfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhKAOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:35:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB409C0613F5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:32:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso8055840wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfxA9nhm1Dx/kkwpIe9uFG+16iITntyVepiTy9U8Klw=;
        b=MhX7lPGREXxIJG7p11NFBd2VhFk6C2/qiM/p0J5CFzwu2LRWDA7F9FBfsO7PrfLXLv
         7G4H9fTFEcLy9E/Hhu3tSMWzUdCvmhfZu2vvUfYARLW+rK+LcwiSKMrsM+ZjRx/Cgvkn
         TG6iKUMcykNqoeJ6sg8wYGV97EqjPPy/H1/VyiF6yXd6qwghXs/pA6zC42EDnvCX7UMe
         +0H28td9yN+elw0UAJNlGGxROb9ULHmHwB1/Zj/vDaKI/poYqvZjAkGzc7sojrEM3AV/
         M2q94QbaD7+Gy+19fcKqZ0ykvXUXbSKdcpTAEXVN8bMWY/IWi20V7Vei3X37Ym2Shcqo
         PNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfxA9nhm1Dx/kkwpIe9uFG+16iITntyVepiTy9U8Klw=;
        b=vE/IQip/5cPQLLD+a6ytTNv59xA5FJWjoTvd2FjR2U3t4iTH+0LBGthbNrLU3eongR
         QpZf/P56XVuhAzyglN2aU1NKZsqheE7oUCRbrJvU9nusnwlEcP+OVDWDzqYx+fl/J4DM
         2Kjmxg7KzZPZIfGeKnOxn0VQajCOSdkD0W/7VKRboItYXWADI6TBBhlJLWMfkY7qSgQN
         vra0Dn3OoVg8fqCQvNg0Yfg7TlesJa5Ta/9djhvxEZWy05Hoda2aYeQ06aeVWpOdZgwo
         caO1W0AvyO4XaS1vu0ZOEkyG8EXEEUhilIdf7Tvz3flQtz2KKG5S2J+mfqM3mjvWgnL4
         7s/g==
X-Gm-Message-State: AOAM531TqU4EP7azsmPNRWUwIaAlZwh4CajlrlRUwpDPwHWj/baQhiZb
        LgwIXE+Q918hG/Et6pD1iK4=
X-Google-Smtp-Source: ABdhPJzZqwsl5DxK8U69mMfGGRIjDCrKbw73/0R1jmeIdjLOuZf/HpewGuj3rf9XdWqy/Jj5qI5u0w==
X-Received: by 2002:a05:600c:3b8f:: with SMTP id n15mr17881716wms.180.1635777145986;
        Mon, 01 Nov 2021 07:32:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id l8sm17157721wry.43.2021.11.01.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:32:25 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 4/8] staging: vt6655: Rewrite conditional in AL7320 initialization
Date:   Mon,  1 Nov 2021 14:32:02 +0000
Message-Id: <814792bedc4f693c0d43f8e1c480f00c5988129a.1635773680.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635773679.git.karolinadrobnik@gmail.com>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use conditional operator to determine which table for AL7320
initialization should be used. Introduce `init_table` variable
to store this value.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index ea74701917e5..e7672da39a82 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -684,6 +684,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 	unsigned short idx = MISCFIFO_SYNDATA_IDX;
 	unsigned char init_count = 0;
 	unsigned char sleep_count = 0;
+	const unsigned long *init_table;
 
 	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
 	switch (rf_type) {
@@ -714,13 +715,10 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
 			return false;
 
-		if (channel <= CB_MAX_CHANNEL_24G) {
-			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, idx++, al7230_init_table[i]);
-		} else {
-			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, idx++, al7230_init_table_a_mode[i]);
-		}
+		init_table = (channel <= CB_MAX_CHANNEL_24G) ?
+			al7230_init_table : al7230_init_table_a_mode;
+		for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
+			MACvSetMISCFifo(priv, idx++, init_table[i]);
 
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table0[channel - 1]);
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table1[channel - 1]);
-- 
2.30.2

