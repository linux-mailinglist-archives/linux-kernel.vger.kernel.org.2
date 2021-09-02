Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409153FF0FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbhIBQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346201AbhIBQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:16:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90BFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:15:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y6so4594597lje.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRjALdNftKwsFYvx9ZiWNuXDnI9NRb0x5Ps0A/eOJkA=;
        b=jEdXJS6PrnxcHfDViOiiKABde/kpu80rb5ToVqNkw1rDmaJy8LTH1vNtQUqoFJzgoo
         OBXITno1gA+u2Zi8kQ4VEbM4EsHTu2RiRO4gigDZqDfBGmXUyNO3yeR/TCQmTJnMw/8G
         Yk2LpmLIzC81coFE73nh0c0wjCgdG04Kk/4nTpp71CTFTF93bWYGhq6dNWAlf1WcicIr
         UnFwUqKFhrL2t3+0y0ZoswnxRmWPc6pb78tJF97Eo2DH2gT/xrvHf53eahoffcvtxBvb
         pCrgF4lgSUDHAnSIR4ZLDTt+QTXCmPZ0daOk/KKcntoMJ/lIgOi+mXg5eIeQ7xe/ARqT
         DbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRjALdNftKwsFYvx9ZiWNuXDnI9NRb0x5Ps0A/eOJkA=;
        b=nUjvTbRxb8wU5PIlgG3fOqe9lj0XfwbYRUN5zJ+WqfYGkJpy6Is17eNqzPIM+eW9WC
         wbcV5VGmn210/a/YOYT70g8mOzMs0BkOQp59F0X8BG0FcSkGRlHpYpaulU6UVLzCjfmx
         HBLuLhi2nYyEUAP9/RNlMZI9FlUAciGTu3T+Efl+vBYwmrlAGfMK15EGv+LaiQRkqHeH
         mY5eZfwHKvVOaHn+jtbkTmGDz8QT1G/9CG56apfwBAkTCdvW1lHvMvp2LGQfOtEUwfOl
         KmrC/eMNwzIJnlYyqERWJie+3su/CRqhM8ITE9NqA9DlgjSBebYzK+BX3dvOzQWKW6gx
         c8Rg==
X-Gm-Message-State: AOAM531seFsD9/GW/Y2KZGbAzVVcGvGcaTwPwNlfITtyp6uQWKteQVZ4
        wdojMMM7OblFaNiZU43qvIM=
X-Google-Smtp-Source: ABdhPJwykbAvXHcdsJhqJFLi7/hPfjvDFHuvL/zBpPcIp7PcPrMtYXOSBtgLJDjrmvy9UYtDov2sPQ==
X-Received: by 2002:a2e:a28d:: with SMTP id k13mr3046297lja.446.1630599344084;
        Thu, 02 Sep 2021 09:15:44 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m7sm267811ljj.58.2021.09.02.09.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:15:43 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] fs/ntfs3: Change right headers to upcase.c
Date:   Thu,  2 Sep 2021 19:15:26 +0300
Message-Id: <20210902161528.6262-7-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902161528.6262-1-kari.argillander@gmail.com>
References: <20210902161528.6262-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no headers. They will be included through ntfs_fs.c, but that
is not right thing to do. Let's include headers what this file need
straight away.

types.h is needed for __le16, u8 etc.
kernel.h is needed for le16_to_cpu()

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/upcase.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/upcase.c b/fs/ntfs3/upcase.c
index bbeba778237e..b5e8256fd710 100644
--- a/fs/ntfs3/upcase.c
+++ b/fs/ntfs3/upcase.c
@@ -5,13 +5,9 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
-#include <linux/module.h>
-#include <linux/nls.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 static inline u16 upcase_unicode_char(const u16 *upcase, u16 chr)
-- 
2.25.1

