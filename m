Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84240A50B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhINEBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhINEBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:01:18 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C64C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:00:02 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e7so11473102pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qEHypaye/z+CPwffHX2cbHJQDnbTYbtllX3pG1q5k8=;
        b=DHDb3Rz5pFlUo5E6TMp1W2d3w+57XdjU6kNZYgn/XsKV8uTgx9+U4RbAn7PhDGe72j
         VUoBS9Gw75XEkCoT7VfBjbOurpq86+A61KCRBy6q0G3acgmHE9fpa7IHz6vQUioQi8TQ
         AosHKyBrbUeSk1jDTpMYQf0YA/KKCT4UuYv04FKA/Bufra+KN1vrj0DMlQzxVFLwFn+D
         0iPdT9dXlFVodLsdN5zzozfhZSYq06d+DeGWN+KdStiZrhVOx1WLYLF7X1vkZ3LWyFsD
         d2dleXz379uY04BdbD4NUfYgluT80XSkrGshfkEZnP9b8W6ctXBbJnbLp65wUcxvkJk9
         Xq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qEHypaye/z+CPwffHX2cbHJQDnbTYbtllX3pG1q5k8=;
        b=aqt/MwYbNKpKsUZrzDG54jeerwkYvnLWAlD1UucJFQ3QRoZ8C4h39P33257iH7wcAW
         L9EBayIzKo4NG0DldQ/h7jwhjhyFlyKCcetgGwqVB69giCVK2Dax/PGBrIGWAHqnqZI7
         Cj51OfSnZVZ/eb9MRHSrC0uCxqYSZ9zfJNc32/xTG/odaTALJmQTA/9uidlk3pf6dLJg
         IBlBg2IDYcp2JDpRYhbLX2+SN1h9O/4Dnc+CJ4olRVyUO0rQwpGiEosOj4QRlg9mW/wx
         CCVPlb0T4QkY0Jt5Spz1GkCiMgM2n8u4lZ7kcBbqGZSJXHXQv74mIrCwDumPjXEERRrE
         cT7g==
X-Gm-Message-State: AOAM533NPSYhggKMhYcORVo1Gn9tpVn2t2vC1npEOxLLYhZ3BTrT044P
        xQVZGclYJA7XbFvw4iQEFYY=
X-Google-Smtp-Source: ABdhPJwA/1DQWM2pwsnw8lpZOR8vjdeWexZi0opfjU/AZ0DKkZr34MK8Fm9YI/mCO+k8cYHt4cEmzA==
X-Received: by 2002:a05:6a00:1150:b0:40a:78df:8179 with SMTP id b16-20020a056a00115000b0040a78df8179mr2674364pfm.67.1631592001864;
        Mon, 13 Sep 2021 21:00:01 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id d3sm8478994pjc.49.2021.09.13.20.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 21:00:01 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zhangwen@yulong.com, zbestahu@163.com
Subject: [PATCH] erofs: fix compacted_2b if compacted_4b_initial > totalidx
Date:   Tue, 14 Sep 2021 11:59:15 +0800
Message-Id: <20210914035915.1190-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, the whole indexes will only be compacted 4B if
compacted_4b_initial > totalidx. So, the calculated compacted_2b
is worthless for that case. It may waste CPU resources.

No need to update compacted_4b_initial as mkfs since it's used to
fulfill the alignment of the 1st compacted_2b pack and would handle
the case above.

We also need to clarify compacted_4b_end here. It's used for the
last lclusters which aren't fitted in the previous compacted_2b
packs.

Some messages are from Xiang.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/zmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 9fb98d8..aeed404 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -369,7 +369,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (compacted_4b_initial == 32 / 4)
 		compacted_4b_initial = 0;
 
-	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
+	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
+	    compacted_4b_initial <= totalidx) {
 		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
 	else
 		compacted_2b = 0;
-- 
1.9.1

