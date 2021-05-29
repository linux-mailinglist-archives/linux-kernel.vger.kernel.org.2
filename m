Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4E394E12
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhE2UE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhE2UEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:15 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D9C061343
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so7001569otk.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bY9Keb33sC+mimztwRsgxrgKeeH1c/Tj3Jkz5KDvqdY=;
        b=l6Rbyw2zQWHa9SImLoXemvoAJQTctmiCJQFZLRjK5eAPzhThCSx9LyO+AROkIc1m5l
         xb8w9tEhsQ7NrQOvM+nELftmnTRpFtu0JV188T1m3cEkx0xoPHf6aKt7Fx40bSQZ0cR4
         WWKsMP2JKsCXCT8v4NiVp85Asul0NyuXIpoPWkrr9wqTnVHcmcIie1S3Xq4L2m0upOHj
         JUlF/pZlJqX9DL92QQCnor5ZGw9nEB2o7oJMQQEICjMZ559N0xGPShWiGEBWqtuG7SB7
         rBQMZGJvRT5Wrv7JCCHDYv00AkEhKqBwvHllO1CZ54wJLYHNqFIZEi1otCQWeh8TsOS9
         GXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bY9Keb33sC+mimztwRsgxrgKeeH1c/Tj3Jkz5KDvqdY=;
        b=DQFvQxnhjJ8h9/1rPPXcS2Bl5uMQpUPwskzKC/2Bx6Bu9oNb6XbIGMhyI4lTiS/ALK
         +pT80flB2ivR4xQxTun8BEczMsl7INFMcCztGARMddh2iA+hCtn+c/Kf40e5UlOmExUA
         fObUY/dCdGW6ENnFcRpRu450wUGL1DwtOOzFRsipua3/uYzoH5U8crcp4Xx02JUXAP5a
         VUR0B42+I8DLIaZN7mUaO7RIozQx23FPbatC+YrsdCxN8qZmkxTBiaaviGfRGCKXMT85
         fjcxBAJVsW53fc6cB6aNt/ungitM+ouScKXMJAGEFRxH1ueBNF8EtrLIg+OhixNJGsIa
         BTvA==
X-Gm-Message-State: AOAM531wdFzoNxL3UX9zNDo9RVuGItoiXjufVOv8qZ/9BrzcTxRIq7gE
        tE+GyTViYn0eTMG8qREFrknsu0MU2bZaTw==
X-Google-Smtp-Source: ABdhPJxkGCUfHG2VzssMMN8V11CV15NHSc2En6Kvv4zlcTi0ORUlHtjUHf3mZMHee5fIz12vcB26yQ==
X-Received: by 2002:a9d:684d:: with SMTP id c13mr5667087oto.201.1622318558322;
        Sat, 29 May 2021 13:02:38 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 24/34] dyndbg: dont show header records in control
Date:   Sat, 29 May 2021 14:00:19 -0600
Message-Id: <20210529200029.205306-25-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

header record pairs are special in that the filename member no longer
points at string data, but back at the data structure.

Theres no reason to expose this in control file, and no reason to even
print a line for the header, since its not part of the interface.

Printing a "# header" line is a decent alternative, but separate.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a7840584b402..9a089b8d2ccd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -995,7 +995,9 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
 	dc = ddebug_site_get(dp);
 
-	if (dc) {
+	if (dc && is_dyndbg_header_pair(dp, dc)) {
+		/* skip output on header */
+	} else if (dc) {
 		seq_printf(m, "%s:%u [%s]%s =%s \"",
 			   trim_prefix(dc->filename), dp->lineno,
 			   iter->table->mod_name, dc->function,
-- 
2.31.1

