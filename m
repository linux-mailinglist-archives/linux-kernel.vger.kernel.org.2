Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7DB3FC979
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbhHaOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbhHaOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:16:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B2C06179A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s10so14011991lfr.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++Rs4f7JOpOPm4iAntpiRan10mluJYx8iHbdWicWw8M=;
        b=h5NwXmOzJteq0gWLVmZfN3WIEEch2492GbeIThQE3oUIjKC2vZAFkPFJ1jkAaKeAHH
         DJI3KdnkQFaupKRfAsBJ7WxnFUCoFvYfyW+mVowGq/8ReMcVz718tDSOg7uxOO1FtQ9G
         3IardJ2Lf+wdMJibTKFsuJdIvylE/+UppdKBjh5VD+ptaTTua2m/P8qaM9qZKtIlxiKV
         J9m51HnK98oR9gHmxxe/2wmlaDt/7JUQqBXNqy6JBkp9rFfbVFBPzy+pPpKXLG5tThvO
         5R7yOFINcvDtlcaGEH4S6ELh+2PF19uewAycoujvsN8fhZ5NnjNj5NjuDYAm2hyAqxJs
         t4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++Rs4f7JOpOPm4iAntpiRan10mluJYx8iHbdWicWw8M=;
        b=MG/gTmpDmls6TGHyEZV56ZCVc/bgJ882FfrexOcvqfIA/0jykOwtxy/OsgIlH+I/8F
         At0jLyuMWDGnxFGdTMruAwu+Q/1Cx9xzaXWPCTj0Tar2sB5Bmxt0A+lZ3j/vkhAk8P2n
         OConSsvb5d3G12N9CIYFKQFoWtR9TEjy3CmU9dFjtL07+dARUXdMluGso7ZONjI1GCSR
         tkq3HsdXWaCcVVCUclspmvw+uhsXOfqyVmLdHuCHp/O8PaWPWVAfPYkYSrkOIL8WvNj5
         c15aH3MTK5Wj2Wp0I69OGRBDbNPRK5B+JXgcWYzjwtyCjW0NVM57SdjEEBkyEoQ05nK/
         0lRw==
X-Gm-Message-State: AOAM532kRB6ug8vqUItYdxhdJ3UfZ6CqmWkqrrLGo/fHjY6RntqYmqLd
        NY2kUd/1Er76jkuyekx8pkbjakOXJqtbVA==
X-Google-Smtp-Source: ABdhPJxttmC1NGeHO7CLnQY2WziC1mG5M97QGaW7ORzJW8lZQktRMuK+c7acbG0/YNPi7q2D0tY3TA==
X-Received: by 2002:a05:6512:2307:: with SMTP id o7mr18775362lfu.352.1630419306081;
        Tue, 31 Aug 2021 07:15:06 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i30sm2202187ljb.48.2021.08.31.07.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:15:05 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] fs/ntfs3: Change right headers to bitfunc.c
Date:   Tue, 31 Aug 2021 17:14:31 +0300
Message-Id: <20210831141434.975175-5-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831141434.975175-1-kari.argillander@gmail.com>
References: <20210831141434.975175-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only need linux/types.h for types like u8 etc. So we can remove rest
and help compiler a little bit.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/bitfunc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ntfs3/bitfunc.c b/fs/ntfs3/bitfunc.c
index ce304d40b5e1..bf10e2da5c6e 100644
--- a/fs/ntfs3/bitfunc.c
+++ b/fs/ntfs3/bitfunc.c
@@ -5,13 +5,8 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
-#include <linux/fs.h>
-#include <linux/nls.h>
+#include <linux/types.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 #define BITS_IN_SIZE_T (sizeof(size_t) * 8)
-- 
2.25.1

