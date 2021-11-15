Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05F4502F9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbhKOLDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhKOK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:59:35 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A3AC06120B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 133so13551969wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6ScGOJ/e281bRFCu1alGcsoPejcNgEmuskLsXMgrhc=;
        b=ME2KWhE9/71i8bOEJU86D4qI+zuz17TfidjYS6Omf3NwphGBEEe04zBCDeTM/Ge2KB
         vqFp1GBVJ4TZ2tevuYnrv2kO6cA2qT/xQD6M6g+mPSV1aIURrl7Q8r9GqKauFdrrrFvx
         Tq1bJPp8tXa0bZ58eMygfBo52i39umf3ENBOmpkIONpEWDSYw8BqejAK4L25oE92uXDt
         xlK63t62YNtS+iwky0H3D1ZGX6EIHNqgoPnrEE9dHxq80b0yERrKP8ks5tOB0AOufz6b
         TOVd0l3QAZo3HaHxQLQK9i5aca6mWlNE0QUCQ3KeV5DDVlDi8gVhvJK88DdnHIkrYjay
         9aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6ScGOJ/e281bRFCu1alGcsoPejcNgEmuskLsXMgrhc=;
        b=v4WWRt34rN0CWuKWBOtaEtdWhEZFp0rGYGXSsokS8IgGjN3cgSG0ObO3QXBrATbilb
         SyK7hcArixMJBhtxeQJTOkAl3J1RKkX5fqukOKVqRhLjJijzwEzgc9G6AlmngoT4nPki
         v8c6E1/Z+RaOrLEIvwQAGe3y+hStLMDpxCoMr759HQHzdUS8G+VSzaEbyIbuS053bA9I
         p2e4mqdd18/bcdsJgV0QOQbcReAHc48Kt7X3C9qpLff74oUbqr+5NYKxQ2bRS9thi8eW
         w43Y312mZRpQ561fHi8OMrn63+obu1rMAZKwO2hgDCJfVwzgNtuX2ZAPWciz5rlktR2B
         ofCQ==
X-Gm-Message-State: AOAM532E1agI1Ey0GKxvOH99HnLvcDah/5D+fytCwpjxd9d6j46RO07r
        Rq5ZDgQqHKdxCkc7pDGeLmQ=
X-Google-Smtp-Source: ABdhPJys+m6m/BTsFe6eNaf4M62rlqtg04v5J9jDrBye3GAFgpFKaegSRR16jqlhqg4CZvXhrjBkIg==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr42132678wmq.117.1636973794669;
        Mon, 15 Nov 2021 02:56:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id d1sm13516532wrz.92.2021.11.15.02.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:56:34 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>
Subject: [PATCH v3 8/8] staging: vt6655: Delete bogus check for `init_count` in AL7230
Date:   Mon, 15 Nov 2021 10:55:49 +0000
Message-Id: <e10d2278975116e03a699260f2259f9ab87501a5.1636729147.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1636729147.git.karolinadrobnik@gmail.com>
References: <cover.1636729147.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary check in `rf_write_wake_prog_syn` in `RF_AIROHA7230`
switch case. This `if` conditional will never be true as `init_count` is
equal to 18 and can't be bigger than `MISCFIFO_SYNDATASIZE - 0`, which
is equal to 21.

Suggested-by: Mike Rapoport <mike.rapoport@gmail.com>
Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 4bfadd85c82c..8513fc565b1a 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -710,8 +710,6 @@ bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
 		 /* Init Reg + Channel Reg (3) */
 		init_count = CB_AL7230_INIT_SEQ + 3;
 		sleep_count = 0;
-		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
-			return false;
 
 		init_table = (channel <= CB_MAX_CHANNEL_24G) ?
 			al7230_init_table : al7230_init_table_a_mode;
-- 
2.30.2

