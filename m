Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0965C3FC976
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhHaOP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhHaOP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:15:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0991C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id l10so4624167lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yMkLlmv5/TYkf4BDKhvB3k+BZ2DNbH/dnmnkTPG5Eg=;
        b=XsZpAJGok0L+zUBAAOe8pQGLHuB/oIBExrj8p4hgDbzRt2hfGoXeE7NQIjBGpWlHJs
         qbePsxD2CcfrVSRP5eXRrB4E2cuYEZH67KsWFz6kjQAMHm258eYuUr+FY1YYFmi1sKkc
         MDOaehjucKby4J0LOI1qPcE8aI5fN228pkNuzuHLRboTVF0xLYToNd68ctOKoibKp7Ru
         l766sf+9zN56hG64LbskSAkGYjxoCf302Cb6KnoyvtOtIs/1IoqnxNFNj1auxNHwCmCx
         unaGpTmd+Ik5lsrBtEZAr9CfsknQDyjQA2lf+Ko6rsu4dhE7UmbLb+P0a4aRo61Cxiky
         0Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yMkLlmv5/TYkf4BDKhvB3k+BZ2DNbH/dnmnkTPG5Eg=;
        b=T6mIVRrY4sMyLRnjdRfCXsNdZV28T5z6g3KNGMV/EYNjchpnQotNu/4olDFvZ7DJa0
         mUARSMvC8xnmkmhnQf9tYgmaVyNHuwxu5LZtrUSM93CP4rZyD8VEaLX4T74k6GaDOSeQ
         tWXbxo6Eu87Hq2EUaKLEiLTrg7rkRMQ1Q8DpmfvX99/xXN1+Sk3JFjVrNUr5scLgkxRa
         CoqFg2CgnPwTZACpGQXxDPEdCp8HYzfYcBmAXJiggYXnRTeWzTEV6xT/4n+TziY3Qbxz
         IaBWkqYCL2L5ETStAZFdPx8Ks2uMRiSd3Ubc7iiUdXqexyqK0DuFLFiRS55uVECZYN6L
         ZA/Q==
X-Gm-Message-State: AOAM533gWHxS070qUApHS9xmpW3Xr8xpmgQZT5TEH2MqMvM+ifI0Kvtn
        gW4Q+OF8Vzncjtk8lLWL/Ws=
X-Google-Smtp-Source: ABdhPJykUHnWUDIBgYZvJaPTGXq3+KuNzmIMelooQlqR/YD7HGBAPnL7Eq7v/3+gLktwbD6mjKvXsg==
X-Received: by 2002:ac2:5d65:: with SMTP id h5mr23049324lft.477.1630419301206;
        Tue, 31 Aug 2021 07:15:01 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i30sm2202187ljb.48.2021.08.31.07.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:15:00 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] fs/ntfs3: Add missing header files to ntfs.h
Date:   Tue, 31 Aug 2021 17:14:28 +0300
Message-Id: <20210831141434.975175-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831141434.975175-1-kari.argillander@gmail.com>
References: <20210831141434.975175-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not have header files at all in this file. Add following headers
and there is also explanation which for it was added. Note that
explanation might not be complete, but it just proofs it is needed.

<linux/blkdev.h> // SECTOR_SHIFT
<linux/build_bug.h> // static_assert()
<linux/kernel.h> // cpu_to_le64, cpu_to_le32, ALIGN
<linux/stddef.h> // offsetof()
<linux/string.h> // memcmp()
<linux/types.h> //__le32, __le16

"debug.h" // PtrOffset(), Add2Ptr()

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/ntfs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 0fd7bffb98d4..778be353ffe6 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -10,6 +10,15 @@
 #ifndef _LINUX_NTFS3_NTFS_H
 #define _LINUX_NTFS3_NTFS_H
 
+#include <linux/blkdev.h>
+#include <linux/build_bug.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "debug.h"
+
 /* TODO: Check 4K MFT record and 512 bytes cluster. */
 
 /* Activate this define to use binary search in indexes. */
-- 
2.25.1

