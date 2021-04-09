Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5928B35A951
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 01:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhDIXq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 19:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhDIXqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 19:46:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B7FC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 16:46:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l1so3485276plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SVHlr9PFsAmGK4+X1iTgg6ZdMx+ehnrMFUWQE+qDW68=;
        b=eqpKB3KjqIKg8bCrXpgqDgvGD6OtrVps761SKfnm3LqgzUVpBis2S1dNnDiQG1WXjs
         QSsSf787BjZNH+sHBNG4u7GHcflzhqNLZiEiBAnC0wUUUW0WcBBoivNP2M1AwrEi0qXr
         n9/dIHILE0SSUHkvbu3x0JHoqTj3oF8N01sT3b+Iy/ZEzG9lD0TS0qhENJ8wvhZeiKmx
         LEpDhiNsBOSPt9qPYSvSCXbIdHsYEg/NpS5OOBDCeKqLc1im4n31ykjY000SrW6sZR8+
         l2wTkiguiny2s/zc+5Ttub+CVSe9Mko8CQYLR7fZRKX3sCm6cZfJ0J2fHSdbgdHGnGIS
         +7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SVHlr9PFsAmGK4+X1iTgg6ZdMx+ehnrMFUWQE+qDW68=;
        b=QkJea6OO4/8YU4CTA56JJ/1RhmEDhyG/Fe0Pqiqgjhut9Ah3wQXmlzWoWmvNfKe3vV
         H5e6aI3hb2xf48ZAapOjWkMU17294SRSLr0M76YbwRPgUu5+cTrwF4Tu3iexYsjlOYTQ
         HgVGekqL/RRdOLumbzlDyo4EMeDTZkNcmmRODgKNL2B5dmB0/lyJQslO72tFDeUallER
         d6iLzZ9/lfjEMbyOV+44Slq8RPrCTEg/KMishHdjQ/y1JN7yVzOyTsvz/SYWMQ83wIzM
         PSTjygYJtnQvsofS2dUFfON9mYh1dJBsAb1Uw9zGQJF83Zft976wBvh1KvPZ+AgnwWdZ
         rSpw==
X-Gm-Message-State: AOAM5309BNfRozIT6Kqm3EbxfXYC3LE0tEuz6novghqnjFCQqQ/aPB3M
        GJQX0OnPodqYVlW632eUfZY=
X-Google-Smtp-Source: ABdhPJzVU+Orygs2yV5tMEy9uXd4WzHLdQf48nbKmjxhvwz7VtiIIctKHsB4fuXXORy07AaqLBJSHA==
X-Received: by 2002:a17:90a:516:: with SMTP id h22mr15503466pjh.222.1618012000197;
        Fri, 09 Apr 2021 16:46:40 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id w191sm3570429pfd.25.2021.04.09.16.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 16:46:39 -0700 (PDT)
Date:   Sat, 10 Apr 2021 05:16:34 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH] staging: rtl8192e: replace comparison to NULL by bool
Message-ID: <YHDnWpWztxeZospi@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Comparison to NULL can be written as '!...' by replacing it with
simpler form i.e boolean expression. This makes code more readable alternative.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 65eac33aaa5b..476875125e87 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -269,12 +269,12 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 {
 	u8	count;
 
-	if (pTsCommonInfo == NULL)
+	if (!pTsCommonInfo)
 		return;
 
 	memcpy(pTsCommonInfo->Addr, Addr, 6);
 
-	if (pTSPEC != NULL)
+	if (pTSPEC)
 		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC,
 		       sizeof(union tspec_body));
 
@@ -328,7 +328,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 	}
 
 	*ppTS = SearchAdmitTRStream(ieee, Addr, UP, TxRxSelect);
-	if (*ppTS != NULL)
+	if (ppTS)
 		return true;
 
 	if (!bAddNewTs) {
-- 
2.30.2

