Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66754502F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhKOLCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhKOK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:59:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F367C06120A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:34 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so12073741wmz.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kXGWZLNJVRqPQUIGKsTuVje1twJc/fST86hWxvRfcU=;
        b=Xf/T5GTfjhyxkMIJEKkoJ4OjYdh2ehM7gx2ogBT1PEBBPbfuxnZWjXEFgGmLNzA692
         x6UplMXpWBkZWswZzZ6pZ9XHVcCPxpy1EEsEUk3dZuPLR1VXBGhYCO8d17VokDFnLMFG
         jjkeecujHjMUIq/SwDC78SsVYdD5y1pW6ftvPf9pvJLTPeJhhQ01eE/csyWLqzOkXZxk
         QnzVGz1vtB41GF1vMVUSEWkpUiifxCTnP26KcLi3klZUzOE4uYQbFAQJUZ/+OTUOUw8A
         a9mOsGF/TF4/iPp+KRrVrunDjITzCmqCPDFj8kAVq5CSQ+eYQpOEUIW+LTVEt8tozd+Z
         vSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kXGWZLNJVRqPQUIGKsTuVje1twJc/fST86hWxvRfcU=;
        b=sBXFkrXBEhV0PjqxoyhtQaXL+g5IA8CHgLN4RzsNf+TPOqDhq3BTzWCm8HS5Omk7yY
         oWVLaXAm5CWe9wL3/xjSpydp0TTf7izDNymvGUlemK8DaQC427ufSCfvcaYXYFkQFLi7
         a0pju/aqqvvmSmuni4NqG6CLbYox3c8qNbUwSVeT3oijW5a7BevMSIK8rOgOdhHIUpHV
         3qtmfuWAqS6TgDquGjDfQv/eSRoaih1NFGUMPWLS5qsd3vSRRsv9/QktI0EbePjVtQYY
         z3XYxrVfTxhZs4XF4iJw5Ltn93u8Of7me3TLYaI8DcoL5cD1jmfJe7us+cr0zLnJaAoC
         sgcg==
X-Gm-Message-State: AOAM5310JuqMOXEUGXw8Xkdv0JNtjhOWSDk3Ys218fPtdf6wnST9bFi/
        YDDUB/j5rnWWU5xx62YRKO0=
X-Google-Smtp-Source: ABdhPJzacx/myc4TKVhYtHWVCIO8NDAOppxliKOPN6X+iuZrXXJCvR1R133TvPNQFx4Zu6RQRQEkeQ==
X-Received: by 2002:a05:600c:1c07:: with SMTP id j7mr61154096wms.12.1636973793154;
        Mon, 15 Nov 2021 02:56:33 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id d1sm13516532wrz.92.2021.11.15.02.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:56:32 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>
Subject: [PATCH v3 7/8] staging: vt6655: Delete bogus check for `init_count` in AL2230
Date:   Mon, 15 Nov 2021 10:55:48 +0000
Message-Id: <29c758ba58b10bc1da7e864b3a4f377147fc4428.1636729147.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1636729147.git.karolinadrobnik@gmail.com>
References: <cover.1636729147.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary check in `rf_write_wake_prog_syn` in `RF_AL2230S`
switch case. This `if` conditional will never be true as `init_count` is
equal to 17 and can't be bigger than `MISCFIFO_SYNDATASIZE - 0`, which
is equal to 21.

Suggested-by: Mike Rapoport <mike.rapoport@gmail.com>
Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index d4c18d9bfc67..4bfadd85c82c 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -697,8 +697,6 @@ bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
 		 /* Init Reg + Channel Reg (2) */
 		init_count = CB_AL2230_INIT_SEQ + 2;
 		sleep_count = 0;
-		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
-			return false;
 
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
 			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);
-- 
2.30.2

