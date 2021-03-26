Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACA334A3BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCZJJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCZJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:09:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435A5C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x7so4860910wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HpwydgRPtNBzTTMixRFrkkDelxwB2t+/hImIES2Sr8=;
        b=QOH+dAgHT0I/hZdt7uFJLJNDcyTk8W5yVsx4GjbvvSFJYotmsxquNOhfKZ6pSnkGS1
         0MlVxydcGpX7P4GN72MhDkoBWW/RbQpqbJUGZYiz1bh7FKC3rUKkjvplII4R8FrSd5v4
         YGQHqzPsENZvu4H1WIQgnSDm4bOXEk6hF7YK3c0JqsVe7yeHuoTQTPVxbzIF/w8MLhK6
         ohXPu27QGnpDjo7dbx/RnLSJ9y0PI1aXtZsWOOUMONqS/paJiRv0i1m0w/ncFdQDWxl9
         Xa3/WY0OZEZ+ZiGP5cQBQMbVpNrWZxMf5zfnSSYjBrpQhZmULYkAEJPg18q9zCcNCzcg
         EuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HpwydgRPtNBzTTMixRFrkkDelxwB2t+/hImIES2Sr8=;
        b=oh3ej/ssoYIkonSJlm0/1W8gYU3kxrroeU3Q/Sxn8zv7HhCFv8/ybfEn/tY+/ijshO
         hN8vmfZIV8VFs7kX4ndGzOSvPmV4nEZbfgf4a4bE1KiL9m1qFyrTcGO6uOd8LWPEebnx
         4y5rTBpG3eVeSVJdaiLZuCIo0sI0wT9ZhsOlADdLDYzqVzjGXWVnyw759JC8UYRjltEL
         ANd9bsv8IvzLB7G5llrgIKpQHWKtN/AMMQZK57Ju3AFydgYxlgbZINMf8akI+DjbJS8R
         lRckGS4IkUo3U84xteBT1AkbJaQIw2U7n6aLfZSD6SmfBkrj1tx9mXolpDlUE3qJbls6
         cytA==
X-Gm-Message-State: AOAM530yz2pA5OMPtLHiVESZkoj0RddgvIYwlP/RcgdWOzSSarC3wutc
        s5UHszjzFAstmvm8DrLA6Y4=
X-Google-Smtp-Source: ABdhPJxx8vTiOTIdeOFZ3FCzUu9QZuCzrsd6oT67Y5HFl/5BTleFKflhosC/0dOtzRz7Nprn2asPCg==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr13494565wrr.425.1616749784094;
        Fri, 26 Mar 2021 02:09:44 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id n8sm10018835wrm.70.2021.03.26.02.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 02/15] staging: rtl8723bs: put parentheses on macros with complex values in hal/HalBtcOutSrc.h
Date:   Fri, 26 Mar 2021 10:09:09 +0100
Message-Id: <7c734b6d796b369f6a0d23c76daa344c241691b5.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: Macros with complex values should be enclosed in parentheses
152: FILE: drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h:152:
+#define BTC_PRINT(dbgtype, dbgflag, printstr) \
no_printk printstr
--
ERROR: Macros with complex values should be enclosed in parentheses
153: FILE: drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h:153:
+#define BTC_PRINT_F(dbgtype, dbgflag, printstr) \
no_printk printstr
--
ERROR: Macros with complex values should be enclosed in parentheses
154: FILE: drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h:154:
+#define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr) \
no_printk printstr

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index 10c021024b24..1926a1f7a7e5 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -149,9 +149,9 @@ extern u32 		GLBtcDbgType[];
 }
 
 #else
-#define BTC_PRINT(dbgtype, dbgflag, printstr)		 no_printk printstr
-#define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 no_printk printstr
-#define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr) no_printk printstr
+#define BTC_PRINT(dbgtype, dbgflag, printstr)		 (no_printk printstr)
+#define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 (no_printk printstr)
+#define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr) (no_printk printstr)
 #define BTC_PRINT_DATA(dbgtype, dbgflag, _TitleString, _HexData, _HexDataLen) \
 			no_printk("%s %p %zu", _TitleString, _HexData, _HexDataLen)
 #endif
-- 
2.20.1

