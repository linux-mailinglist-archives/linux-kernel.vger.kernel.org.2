Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28CA32C1A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378651AbhCCTXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839012AbhCCTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:02:32 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3A8C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 11:01:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id p1so27018895edy.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 11:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NMwJ8DK6b1fAFZS0vxFzgXgcMgP/7m//JxLvhrVfw5c=;
        b=GeCDkd78tZwSNccn1mt3TnlzxA7PwAc362qQsQXq4v06aiWrEPlcBTXeyI6OYG5nOu
         SpXgXIblAPDdNWcFDBxcH3SfubUH2b5+Pk+E6EE7HIxWsUiApdgDgOU0zizJg2NS8tHR
         Nnhg9QD+2D9rrK0nVwZDxkXfhtOd9xqKcdKTgZinmJmwgj/PU1UQcHRhf0SiSsUSzl85
         QLXzkrW96cuFjFXpB13ggFBcR00Q+t3s4BGHGedLkC2lq/miSDjravxp1DHMnG5jGUWL
         lKlCyTMCvDi2EuoSu7IT5f3Vdbr9ZkW4+rElFDwG4EzqZihAv8ByWnB/ckSIo2mXqD4O
         Cqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NMwJ8DK6b1fAFZS0vxFzgXgcMgP/7m//JxLvhrVfw5c=;
        b=RDry8ciRYke0IewUZwOkPPkZL8wZu9rDrDVNWldJ3wAgcSzzRfW6OJRxt4YndGWgh4
         H5+C4ZJw1SDf9eOMrZJpkgC3+KgXum4so/rf5fQypAZLT1YUhuRC7vyFgQE2xczpsmrP
         JCvHMd+bJSTM4JLXsc/VsXmgJ40DZ3Hl2yWa0pHWPAWLIAOuXgnAiDU9rcKeP5RoJ8aH
         l5tYT8h3mD+NyHp/seTdZeGcoQ3RC9EM0UYR7CZVP/C3iSIzGi92iZErsBW0tuvXcFqt
         1eICwrbfc6Jx+Bnt5we3vmok1EvE1twWwqGEI8cRHv/YEzHyxZTVEHB1NiXZJtBe1X0L
         CXJA==
X-Gm-Message-State: AOAM533Y5038lpQdT2HrT/9FLd524JjUqaaAdjye4uU/qYOxUURggwU1
        O1nPkFGUBLEu5ENLogBOvs4=
X-Google-Smtp-Source: ABdhPJy0MBQZdfOfY3dnR4vqK2uJOGGEW5qivo0aj+f9kdix+FN+zXzdj3krlVTKz2cKdB+lFMhQCw==
X-Received: by 2002:a05:6402:50c6:: with SMTP id h6mr727381edb.117.1614798110712;
        Wed, 03 Mar 2021 11:01:50 -0800 (PST)
Received: from LEGION ([27.255.58.138])
        by smtp.gmail.com with ESMTPSA id q10sm10366388eds.67.2021.03.03.11.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 11:01:49 -0800 (PST)
Date:   Thu, 4 Mar 2021 00:01:46 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     musamaanjum@gmail.com
Subject: [PATCH] afs: remove the unused variable
Message-ID: <20210303190146.GA155680@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a unused variable from a function.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 fs/afs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index af162d7dab5b..cf2b664a68a5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -288,7 +288,6 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
 {
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
 	struct afs_read *fsreq;
-	int ret;
 
 	fsreq = afs_alloc_read(GFP_NOFS);
 	if (!fsreq)
-- 
2.25.1

