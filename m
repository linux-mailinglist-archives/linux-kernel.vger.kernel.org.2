Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AEE3FF0FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346236AbhIBQQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346178AbhIBQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:16:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEFAC0613C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:15:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id i28so4562806ljm.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++Rs4f7JOpOPm4iAntpiRan10mluJYx8iHbdWicWw8M=;
        b=lEC14+y5MiLjkIUDIA2aZUjMbnz6dvZO52nHKgNzDkFETP2iVyZoFwQsjB5NmqvRre
         n6F9tnkjgSSrpe8PyAp1MhNtSJVTOYPLAPkVADGjN+EuP4Iordj3bk4ZdXBHvEgDlhBy
         FPCipU6dZst3qjlckJ5jEAfwqqbgl09Dac9q2mxDzOL+Om1mc1buwUETYz3ojLIng0w4
         tSIDuoO9c7SEyZXxiPXbVkOUoIEnopTao8lDPqfx8zPO2yZXswF5+ur/qzrva3E11+gU
         DDanPcPZb9L8EMxOOLJMw6L98ZmTbKRHRQ9NsRJ/L60LVe0bP56Tcs405Ii/Kn9FMjIa
         yrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++Rs4f7JOpOPm4iAntpiRan10mluJYx8iHbdWicWw8M=;
        b=A4k+YJ0T8Yx074rytNs2iBLUhX64d/A66A81qoJKiV6W6QE09bPTiSYvmtXI6/P6Ga
         2uEqm42cLOosRPJydypI/zS+Ex5P9k4e262d5cZdfoU074/V+YxVVe3Z0QZeTsVf/jCS
         eVtq/wOp1c/WSPNCN84U231Qus38LcyAWGFvB1easkfXgeLEBxgBt1qQJvgId1L1aCIk
         PXz16Bi+KGoT5G389c1Bi2sGT6oujypFho9KOhCRSlMqxlJtpBIgT4JegPCB/0whiLMT
         icU79dfMgZrnH6Y6I0QI5oQ1PMoHO0YVhIOhtWUuiURbuh7/YOpztkbDz9UMmM0032qw
         m0Mw==
X-Gm-Message-State: AOAM531ADxyqXy3oTALDzgBVv5GvnoIB6yZr/f7j8/MDndSVX1wIyrnw
        Ooo3hVFxRX6kSpuphwsgkP8=
X-Google-Smtp-Source: ABdhPJycVEvJnZNItacO3IVPlGR0gX+Jltw3xrnwKv+ySkTFpTK5XwaxRfCPnp7nXAJnTG4ocW2T2w==
X-Received: by 2002:a05:651c:1029:: with SMTP id w9mr3312741ljm.202.1630599342193;
        Thu, 02 Sep 2021 09:15:42 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m7sm267811ljj.58.2021.09.02.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:15:41 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] fs/ntfs3: Change right headers to bitfunc.c
Date:   Thu,  2 Sep 2021 19:15:25 +0300
Message-Id: <20210902161528.6262-6-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902161528.6262-1-kari.argillander@gmail.com>
References: <20210902161528.6262-1-kari.argillander@gmail.com>
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

