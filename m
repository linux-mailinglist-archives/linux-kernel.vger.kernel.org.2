Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240E33E924E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhHKNMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhHKNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:12:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55099C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:12:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so4849158pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=oqVAT1fZFY8H20A00n245GZ21CFKG3ndu8l7YtDUlkA=;
        b=c3niZVMItOqVK669UaCSCYcrmhjnyr40xDDrkcCE1xBHtybONlr+ZCM0yyseQ0nEOc
         Et9QwYK95qiTzAKR9wNzc75vSXuyVX4m5a5PElfxaQOGN+EzY8QF1lU+kBlFBXZRdgoC
         LfEJx+Fq6Hk6Zp8apSqGN3eRIVoTmHEU6U8C6nqKjpAJSja9/oWiR2rbYWMyMOo20fO2
         ccPn1XWyIkzYPzZ8jLkIXCH7QUK/qsSgRbhmehO5SNLSeLZiAK5MQpUNfDdz0/RJtAfJ
         ozujn0rZxWgiVy1tDhD9PYuR329leCYiOEyikbV/qBAXUx44R6mD98MOoIzLhJXd6meF
         tMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oqVAT1fZFY8H20A00n245GZ21CFKG3ndu8l7YtDUlkA=;
        b=ebUR/PDyqg61T6QykC4vVIQ/yOdxvunwVxQBhLOzX7VCTY9wxcCuwIvQEH1gDJRYu7
         vsinKjGVFl48+E7xA6SaKvnqJwyCDCytW63Hk+MYLnwEGvZpwto2BRwtM37Zd3xyaCvL
         xsRKVWAtOEIzWagnvyV5TiiE9QAcZ+EHF2pw5fI/TxdPdPAG9jIL5vXKnr+m4iayrxoX
         ns8jez0LBUhnB2CMFfTBcsIncu27CJTX01x4YvfyPrvvaGIBu07siusP5CwUO1WyPbIu
         6Ual+bHydqyMfZX/YeQLfCugwkfSDq3ZumgjohJcwm1A57ZSqcH+kJA8/mXlndxwLYiM
         vC2Q==
X-Gm-Message-State: AOAM532a5lmJa7xkBwhDaqtS9WSEL+HsACM0NUwTHDMboe0SIZkiNn0v
        24ipPF0F9d95PAnajJ4LQU3NMv8PZIru
X-Google-Smtp-Source: ABdhPJw1eJfQRBYdanca3899CMCLo56OzeErL/dQY1KjEtiJiQDG+O1iHmwhJDYKfn8UN/dV5hHoMQ==
X-Received: by 2002:a62:864b:0:b029:3c7:7197:59fc with SMTP id x72-20020a62864b0000b02903c7719759fcmr30159259pfd.59.1628687544856;
        Wed, 11 Aug 2021 06:12:24 -0700 (PDT)
Received: from localhost.localdomain ([123.231.122.209])
        by smtp.googlemail.com with ESMTPSA id 125sm10541690pfy.17.2021.08.11.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 06:12:24 -0700 (PDT)
From:   "F.A. SULAIMAN" <asha.16@itfac.mrt.ac.lk>
To:     jack@suse.com
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fix array index out of bound exception
Date:   Wed, 11 Aug 2021 18:41:50 +0530
Message-Id: <20210811131150.20282-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>

Array index out of bound exception occurs when the 'part' variable is passed into the freeSpactTable array, 
this can be avoided using pointer arithmetic. 

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 fs/udf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 2f83c1204e20..d330c7162c3a 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2522,7 +2522,7 @@ static unsigned int udf_count_free(struct super_block *sb)
 			sbi->s_lvid_bh->b_data;
 		if (le32_to_cpu(lvid->numOfPartitions) > part) {
 			accum = le32_to_cpu(
-					lvid->freeSpaceTable[part]);
+					(lvid->freeSpaceTable + part));
 			if (accum == 0xFFFFFFFF)
 				accum = 0;
 		}
-- 
2.17.1

