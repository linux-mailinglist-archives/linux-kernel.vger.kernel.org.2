Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E373631F991
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBSMrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBSMrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:47:18 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE40C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 04:46:38 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o38so4096116pgm.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 04:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YkZDMVGrlUJLCFKpd9BRaJN7THmPouUukWsL1qSWh00=;
        b=ZAr00k28nhJo35OjjDhJShjbohzdpQeLWSTOGrHRNT8/3CxJJqVL5TWBe5+LxxS0LV
         Opewj4T+01iFZkuaxfy8bnGlALSkZjq7Sj23KkP4+VNj8KvR36VL1Fn1S8ZP1A6NOctl
         CoAcBTcB4b59frmLLPYoZhzK49LIrEEDLWk7bOV4HJY0hV0dVlys5WrK/sUS88kjtPFS
         A55gi/sLmE75394KRbtgwacw6Ka+XygpY78xmN/GYSqpHwrRuOsmngQjEMHQBX4dzSQ9
         30a9AfD3TJhzRv5Rr0b1vPUSLhbLu8hVqRXk2QTfO/uD/XhfHAGXEQYLAmt7h+E31Q+y
         /d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YkZDMVGrlUJLCFKpd9BRaJN7THmPouUukWsL1qSWh00=;
        b=VC/1iP1e8EoD97doqzUGYFlTC88WurW0MFgU9bYYt0D5FjUf0jLaXhxxA8zlEjj2sh
         MznkTgnlHo9Hf9xc5Td+1wneAkMjZKcUL9C3luL1OAGNwrXQongh6JNp79E12uQPeFgJ
         owJ6rzJPM5CAIntHJlXYOddpAt9oyRqnLNM8BXBU27pxtbLzEdSLSzouMzCBj4nhqwiU
         T1OLZvUtQ6GJQF4XIf/wIuh1c2uEZuLD3koJT0iDKOv0vCk5iMyHjdgO6GAs6+J+YUPH
         LDYJAwEy16LOISi6bVtPMOWepDT7Oc4FDYuCIAq3T6DBx13aV0mBbrKvvFyIs9eXItg6
         arWA==
X-Gm-Message-State: AOAM533/7PV29Vz2dHrUb68od/sBaCdr9xMmA0bV1e+C5kdc5cAkok1t
        P/AL5NEzUQXyC4i0SD7d7sY=
X-Google-Smtp-Source: ABdhPJwKBlT5r1XHfPoHONyzJhCpMsOp9bX1SAXFgA8YCTmuMmasE7onpIFI4FG09qLvk02boE/33Q==
X-Received: by 2002:a63:2359:: with SMTP id u25mr8585546pgm.304.1613738797774;
        Fri, 19 Feb 2021 04:46:37 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id v185sm9558088pfb.125.2021.02.19.04.46.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 04:46:37 -0800 (PST)
From:   jiahao <jiahao243@gmail.com>
X-Google-Original-From: jiahao <jiahao@xiaomi.com>
To:     jaegeuk@kernel.org, chao@kernel.org, jiahao@xiaomi.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs/checkpoint: fix a spacing coding style
Date:   Fri, 19 Feb 2021 20:46:32 +0800
Message-Id: <1613738792-14778-1-git-send-email-jiahao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a space before the plus.

Signed-off-by: jiahao <jiahao@xiaomi.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 897edb7..26dbefd 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1456,7 +1456,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			orphan_blocks);
 
 	if (__remain_node_summaries(cpc->reason))
-		ckpt->cp_pack_total_block_count = cpu_to_le32(F2FS_CP_PACKS+
+		ckpt->cp_pack_total_block_count = cpu_to_le32(F2FS_CP_PACKS +
 				cp_payload_blks + data_sum_blocks +
 				orphan_blocks + NR_CURSEG_NODE_TYPE);
 	else
-- 
2.7.4

