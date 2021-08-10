Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32E13E8451
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhHJUaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhHJUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:30:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A9C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:29:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oa17so9936761pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k9wsqN7YVW74vSpW7e/ejgv7USagZP+TqAT+Y6PYQHY=;
        b=uLhHC4BB4SdqtXeV4nk8oKb2M/EPPK+qS0dWpRp1kk8U+pDB1fzViuhbYBGl3IX04c
         gtPHvtptqrK6J1ZXgpQh9WH3ir8YRql+k03hsoNTHj1SEAw0C4/6pzKFAeWFP3b1r0GA
         P0Grgo6j3P7CmVX6kvog4SK9BjzJy0pEMl9TwdeWD3QHp+/kCX1L5kISAFr9zJxC/5xR
         ajGXf1Iuln/CQyv05+fsCUW35yL/LoLBG07ZDDRHsfjIduPCX9nHQk/USlk03l2caAnE
         zCjEzY7t7a3Q92c40EfqGSQTy1R+b/fSEiD8i1+J86gYA0ep0cGCCM99NM2RCdXtQgoq
         1MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k9wsqN7YVW74vSpW7e/ejgv7USagZP+TqAT+Y6PYQHY=;
        b=ahHT8X9BWgAZsXlITUvHfeiIYSidN+vF2GPyrzQEoJq4I4UsDtc6ihxk/7KD4ThAf6
         O2Nk8QfivEHUgge28pj0ikQQle+fR69fVHP3rVpxFe5DqZIAF99G87vG0kjcoRHTk/EM
         wfckh6Rkt1kKZej5GgSg6t+P42cYMt3ttMm3hsDUHLUkM/dGqKHLPYhea4rpBkJ7qR8B
         U9lz1pW37H+/8iM01y7P5CBWPB4ER9O6f8WQZf7t9jomLvhMCcCyjQkDfQbHpmJw+hYd
         xDvOQWyxEtyfwIIbpEZfKOTWhxKiT9wXFwDwGyZK8YzH/OWOJx4/w/FGFbAopPCMND/1
         m7ZQ==
X-Gm-Message-State: AOAM531DCKnqyu/TdpaZSdgnC7umLmPAcjySKFp4U12CeBukE7PGZMrK
        AAxxXncK5KaO8nTW4otimWY=
X-Google-Smtp-Source: ABdhPJwRkFSelQQu1jRuLdTr7MZ+iU84dCdmsYiR/77wsHUICwrhjerxSHAZmBvF1ZtDjbvnPqX6lw==
X-Received: by 2002:aa7:9254:0:b029:3c9:268e:ae68 with SMTP id 20-20020aa792540000b02903c9268eae68mr19345505pfp.58.1628627379720;
        Tue, 10 Aug 2021 13:29:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id e12sm24697145pfc.214.2021.08.10.13.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 13:29:38 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     hughd@google.com, ying.huang@intel.com, linmiaohe@huawei.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3 linux-next] Revert "mm,shmem: fix a typo in shmem_swapin_page()"
Date:   Tue, 10 Aug 2021 13:29:34 -0700
Message-Id: <20210810202936.2672-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the change about how block layer detects congestion the
justification of commit 8fd2e0b505d1 ("mm: swap: check if swap backing device
is congested or not") doesn't stand anymore, so the commit could be just
reverted in order to solve the race reported by commit 2efa33fc7f6e ("mm/shmem:
fix shmem_swapin() race with swapoff"), so the fix commit and this fix's fix
commit could be reverted as well.

Suggested-by: Hugh Dickins <hughd@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
This revert is for linux-next/-mm tree only since this commit has not
merged into Linus's tree yet.

 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1bea7f50825b..dcc07d14162e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1711,7 +1711,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	/* Prevent swapoff from happening to us. */
 	si = get_swap_device(swap);
 	if (!si) {
-		error = -EINVAL;
+		error = EINVAL;
 		goto failed;
 	}
 	/* Look it up and read it in.. */
-- 
2.26.2

