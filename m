Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9222320BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 17:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhBUQ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 11:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBUQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 11:56:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE4EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 08:55:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t9so1957726pjl.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 08:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TxLEcBDcYYILUa2C/hQiAA9t0RBtkVX/Sk351cYtXMc=;
        b=Ukd2Ew+Bf1mihEfVjpSed2YfDivIw4gmw64++ecbGcve9pQvuc2JYSSwgV1PaUdkCV
         IeWt5rNqFvXZauQt7lE3B8viC+0USwG/u/eSGKwg1ADh3I2uwGTFac7H/P/IFinc8t2U
         sj/3SrWHyfaAHGb7GF41dVcVi/URAldbdocKyuyzmsjG+qeqHf0JziqT/8Ol5jpOjW0O
         dIHNFpVPzeCsApONp/+usLfjGQtaz/UjDP610IHL8HP4o0HxOCbv4xCCKguTl9CLiQGZ
         AF+1houY8fvGqHxrrKAcBYMNgZu6LnHcxDRf2S+IDGYxWLkR+sfCtW4mtnWHdGmppKYT
         WOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TxLEcBDcYYILUa2C/hQiAA9t0RBtkVX/Sk351cYtXMc=;
        b=eUIF+J+QBBnxgrGEbDMP0t4gvxCYDcvxcJbsHtuMluKJEg1zzNTjNkHsY48lzomzSD
         Yypzkv8eZ91x6YtsEOmu8evsRfCQFssZwaNdQGAo0UJDCRYzg5JXRij0RJ2ISX2HZUGV
         sS11sKVIeOFEOSjKQxLgG9rAqM40JAlT1k6czNvfqO6cW/qKjWCpkBDoyA8tOYIE9/36
         HDN/CpLqLUFjOIlNIi9Gif1htjIGGzyfyxs7IwX73HkQlmSu1zAegpGsQHE+1lSLUsrU
         Vwe3Po8tkvvlqRLPBPmxERCWKNeh1eI05C8GYpAOiZuqwQwIacCRST3Zx8vB42n/4iqZ
         0/tg==
X-Gm-Message-State: AOAM5331VMk9M8rj18MCPmdyXGs/wsCWCTuzALFCryX/EqP1VLzGWP8c
        tQgIvfE6i/USLAWHChev7Rk=
X-Google-Smtp-Source: ABdhPJwnGaSqQxwFCMF1wnOMukq0CpSBjqWYe74ly3niwpn5ZL/JGgtx6EDfBpSTOXv18Amg9oA1Dw==
X-Received: by 2002:a17:902:7448:b029:e3:b56e:6db2 with SMTP id e8-20020a1709027448b02900e3b56e6db2mr14775831plt.0.1613926530950;
        Sun, 21 Feb 2021 08:55:30 -0800 (PST)
Received: from localhost.localdomain ([49.36.150.103])
        by smtp.gmail.com with ESMTPSA id w13sm18412324pjg.0.2021.02.21.08.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 08:55:30 -0800 (PST)
From:   Amrit Khera <amritkhera98@gmail.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org, arnd@arndb.de,
        johannes@sipsolutions.net, kuba@kernel.org, mail@anirudhrb.com,
        memxor@gmail.com, rdunlap@infradead.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Amrit Khera <amritkhera98@gmail.com>
Subject: [PATCH v2] staging: wimax: Fix block comment style issue in stack.c
Date:   Sun, 21 Feb 2021 22:07:59 +0530
Message-Id: <20210221163758.2996-1-amritkhera98@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch warning for "Block comments
use * on subsequent lines".

Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
---
 Changes in v2:
 - Removed the comment entirely, as suggested by Greg KH <gregkh@linuxfoundation.org>

 drivers/staging/wimax/stack.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/wimax/stack.c b/drivers/staging/wimax/stack.c
index ace24a6dfd2d..345a022810ef 100644
--- a/drivers/staging/wimax/stack.c
+++ b/drivers/staging/wimax/stack.c
@@ -57,17 +57,7 @@ MODULE_PARM_DESC(debug,
 
 /*
  * Authoritative source for the RE_STATE_CHANGE attribute policy
- *
- * We don't really use it here, but /me likes to keep the definition
- * close to where the data is generated.
  */
-/*
-static const struct nla_policy wimax_gnl_re_status_change[WIMAX_GNL_ATTR_MAX + 1] = {
-	[WIMAX_GNL_STCH_STATE_OLD] = { .type = NLA_U8 },
-	[WIMAX_GNL_STCH_STATE_NEW] = { .type = NLA_U8 },
-};
-*/
-
 
 /*
  * Allocate a Report State Change message
-- 
2.20.1

