Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F926441CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhKAOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbhKAOfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:35:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C8C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:32:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z200so12602369wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQqahKTGy/MjzWPjPgHv9G3Dq9AQliR92JEsevc2x1Y=;
        b=nE28LLhF3UnGHnDj48x/XzJJMVEJCxwyGRf2cmDGJqjSnuRt7grKqgiOnoqF8n0Fpq
         oA/BHmbaCPyX0CCRmfZ9Ce8C0xY7GH9diteX7/7Ok1fYP/WkxdSy+lXx2ePqR64O8N86
         ArX8bvlVZYKx/Gsq+8gzKS0z6Td3X6Nl0aiZk2pdHzsXYKisVP7dY12N8FdGq8fY2Ib1
         HoPYQO33UwPCgJDkU3EdiM33zQ7H5J3pnkh1BN5EyqMoWVFZhUU3ZDwe7PEYBiWtbg/Y
         BRpiKyJ/9jBQ9Cf17VJCcTlIb6UPxhWU+Q74Ka9nSzukmaXhrdqDgR8mPLa+Yt7S24ZU
         4twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQqahKTGy/MjzWPjPgHv9G3Dq9AQliR92JEsevc2x1Y=;
        b=yT3OEU+zr7u4p4AFdtHg9o5efK3tpWOAAxXTGGr9u8g4Db7SSE5YW2vEsNT6lzwwX8
         WGFcUya0No01foWt3xoCbJoPI4EhdlLLeY+Jlg8C49bxINZw16c/7GKT9lwRHlXoeGdO
         PJDq8iMCFUod0qLs6he9vA1tDCmRSKIK1f1UmINNjqSDACoKqVCCJF4b/GZX0XZIFjBM
         1gZx26ytANMS6KrpSBwlf4LoCT6MclWRm0sepaQzu5Y8qxY7joCwhqYKLW7XinO9EwRH
         PVqbRdvJfs/AxIMoeMcEguOSB6JLfwDr7dUkZ8Cp0KtU2FoYHf1slIMVJFPKPKB4+sZO
         g47A==
X-Gm-Message-State: AOAM532XJg/HKdkS8N3J6mWjkLpdfBa70OpC3hQjivZG7LA+JoHvEe/S
        iN/7gf8TjN5+6hU2+ylTofvur4ri8MqxEg==
X-Google-Smtp-Source: ABdhPJxqeOqeGYw1A4CrmHtKB2njReHmBW3FSIK1wmeKnNAwvVTzoJmPb0kWReVK5R60Em5CavuS6Q==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr9092639wmc.39.1635777151495;
        Mon, 01 Nov 2021 07:32:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id l8sm17157721wry.43.2021.11.01.07.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:32:31 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>
Subject: [PATCH v2 8/8] staging: vt6655: Delete bogus check for `init_count` in AL7230
Date:   Mon,  1 Nov 2021 14:32:06 +0000
Message-Id: <ef1cc739e6b3e00c0ff138f25d1b9eb4d27e7763.1635773681.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635773679.git.karolinadrobnik@gmail.com>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary check in `rf_write_wake_prog_syn` in `RF_AIROHA7230`
switch case. This `if` conditional will never be true as `init_count` is
equal to 19 and can't be bigger than `MISCFIFO_SYNDATASIZE - 0`, which
is equal to 21.

Suggested-by: Mike Rapoport <mike.rapoport@gmail.com>
Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index a150f1df3824..653f72c7ce5b 100644
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

