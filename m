Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5994E445FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 07:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhKEGVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 02:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhKEGVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:21:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07E1C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 23:19:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w9-20020a17090a1b8900b001a6b3b7ec17so2548832pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 23:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDZclyMW1OfwCQ2QIVDKaMTbcFStYfULLvyCGJDYKoE=;
        b=OQPxcmz8TMYDiF8ncIZYlf4TgeWTH2CKKpHY7FskzsboPCRsjaej+VUFUt3OEF+FtJ
         C1md99EPf3TS4Xz8j1HjswY7iM1CielzC8/EKF1wbMnCWMxBIyDZny7RLTBFnoDtIssu
         Az2bl9dmq48R8JB/USyOUjVjm3MM2xCNi4tdi5MwyisMe3DT/M3UtYe9u15KUFjz0C7o
         /eBMREw/omb7cH5Y1uFXLF+09dlV+YRLsrwiRxeS2x4A1+s90n9DafVDNrPvodqVdaEx
         nb+g6YVElXxLUSKqWUSXHED7TmFVrU3T9DS73y25pqvoczcsrDI5sHsuY1dnAumvZXq0
         xWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDZclyMW1OfwCQ2QIVDKaMTbcFStYfULLvyCGJDYKoE=;
        b=QsP+KICafYH5MxnQbEJMnXX4KzUlgWHdwS1TqMvVYFkGN+hxk2Xz7v2C67e1iL9Ob5
         c9RWlWNnok1GZ3/3lV9fntJVz0v6Bcijxgbqfgiw9QJsuS1suRWT+0OCFsflkjxPohFW
         OMGqErXU8wAGtfnyOE9dfCJVIZEZHOGVCQhc0ijbfIhe4Php6qPSOqhJDV9N//aX7R6/
         gjLl1itmgf23d5upq96OnpxrFdNNYar9LJ1jL9VghnSsjDeO4m8lKXe8ZpmaijT3IDqZ
         SCc6HYVSNI3IJjwZ128dTQaZCoN7aAcYbp7S6ZkRA3g1hbuFZS755eFaH7+FqQbmheeL
         DCKw==
X-Gm-Message-State: AOAM533Q3ieNChfdAjxnFVWIZlTmBhopL81KUpjKrHESxBEO46CMeaNv
        4Q662TqwdLuiazktx3K/Oys=
X-Google-Smtp-Source: ABdhPJwIAbuGkooWbpyDlVfmVmf9tQJ5lMTMFaSezz3966CBzj6MpqV4DrnWu/G+NspNorcwh8EtzA==
X-Received: by 2002:a17:902:c412:b0:141:f716:e192 with SMTP id k18-20020a170902c41200b00141f716e192mr27688079plk.88.1636093142315;
        Thu, 04 Nov 2021 23:19:02 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id q10sm5124959pgn.31.2021.11.04.23.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 23:19:02 -0700 (PDT)
From:   Yang Guang <davidcomponentone@gmail.com>
X-Google-Original-From: Yang Guang <yang.guang5@zte.com.cn>
To:     anton.ivanov@cambridgegreys.com
Cc:     davidcomponentone@gmail.com, jdike@addtoit.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, richard@nod.at,
        yang.guang5@zte.com.cn, zealci@zte.com.cn
Subject: [PATCH v2] um: use swap() to make code cleaner
Date:   Fri,  5 Nov 2021 14:18:50 +0800
Message-Id: <80d5d60030f9f4c0d299e139597f67c562f1d6b2.1636092427.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7f95e669-fba3-32e6-cdb9-41fb415b3b82@cambridgegreys.com>
References: <7f95e669-fba3-32e6-cdb9-41fb415b3b82@cambridgegreys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/um/os-Linux/sigio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9e71794839e8..37d60e72cf26 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2002 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/minmax.h>
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -50,7 +51,7 @@ static struct pollfds all_sigio_fds;
 
 static int write_sigio_thread(void *unused)
 {
-	struct pollfds *fds, tmp;
+	struct pollfds *fds;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
@@ -77,9 +78,7 @@ static int write_sigio_thread(void *unused)
 					       "write_sigio_thread : "
 					       "read on socket failed, "
 					       "err = %d\n", errno);
-				tmp = current_poll;
-				current_poll = next_poll;
-				next_poll = tmp;
+				swap(current_poll, next_poll);
 				respond_fd = sigio_private[1];
 			}
 			else {
-- 
2.30.2

