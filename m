Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69E359EF1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhDIMkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhDIMk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:40:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A0CC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:40:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mh7so8397123ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2hUyBNJx1Jb8VgZ6GiR+mEMvZYh2PnrFc9dZsVatss=;
        b=o97L5+nXsRkEGqo/gschV+ZNhsHbj613yxVG0O7vPFD8m44gdvr+SrDg7Cm6dWPWdL
         QDiJbhb0Vuxcvv1zXc1zp5dKji5NzqnUzHODogk8gZrnuu1tos+pQ7Nd04Ag6ZMByFeY
         GWFXJZrwwGgvq9jfADV9CAxKOSzUYiWFG+ghzrxS5gCA7wxzpJvt/AV/bigmy8iFv9nH
         ZLNOrmqTc/gsTvoSZFed1kq4OISMoZJQZDB0/Aamk0jZ4bxMpHPzXj/xTfvGhWZqX64u
         +CTUXEQrDcsseQLRUC/LctDc9DXcJxT1b+Km6RJtcMiheSLDQ5fuBGLA2zsMAUAjoZzr
         KFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2hUyBNJx1Jb8VgZ6GiR+mEMvZYh2PnrFc9dZsVatss=;
        b=BNuxwsthhyHst0jPz/krfNZCQyi7jUcN4373Fglr05v/8I/2Xb8H1NXmteCgzRfyJT
         MnL10s33l/qZE979/BQ87H/VHDICDYYCs9MPaQuAZFr1aj1UHJRmQUNMeVr1nYSKArkx
         ebcLjYgym+jtVxYsHWFVbWY1m08rfoqq93M/nzQwyjLz8OaZM6GgEv4Z/gqloaMHw8V0
         SpqZiMMPwUIObmzyUbAQSztGVJw+GoCJEHSnfqNGZFgxP63xLy68WZosANo1OXmqUGgz
         878VvX1cOiyLXyc9ZXUgH+cyvl6hfjtmMt6eprosGj/vJR0sFemGHKdxbDCw9iA66vfZ
         +kxw==
X-Gm-Message-State: AOAM532QW+wNGeDYxPct0FR2nCwdfivbbgSI/ti1yPtucVqACB8LHVw/
        wcFalYvCRibhLgS1Oq8A3Y9zN8NnhLdhhw==
X-Google-Smtp-Source: ABdhPJySvH9U/9b1caQCa4KS+OHt8wFa30UCV2Q//AIy+i7A5VcqT0/PNz+HzLMlO7JuejUzyw01SQ==
X-Received: by 2002:a17:906:eb49:: with SMTP id mc9mr6583329ejb.67.1617972013081;
        Fri, 09 Apr 2021 05:40:13 -0700 (PDT)
Received: from agape ([151.43.204.41])
        by smtp.gmail.com with ESMTPSA id jo12sm1169167ejb.52.2021.04.09.05.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:40:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: remove MSG_8192C macro definitions
Date:   Fri,  9 Apr 2021 14:40:03 +0200
Message-Id: <97f38f269e8dabb3dd7464d49022a62cd9773657.1617971593.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617971592.git.fabioaiuto83@gmail.com>
References: <cover.1617971592.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete MSG_8192C macro definitions.

MSG_8192C is a private trace mechanism macro and is deactivated.
(i.e. the default behaviour is _do nothing_)
The only way to activate it is to manually define a debug
symbol.

So just remove it.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 4c159c1a0747..65e1d9bd7099 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -131,7 +131,6 @@
 	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
-#define MSG_8192C(x, ...) do {} while (0)
 #define DBG_8192C(x, ...) do {} while (0)
 #define DBG_871X_LEVEL(x, ...) do {} while (0)
 
@@ -196,11 +195,6 @@
 
 #ifdef DEBUG
 #if	defined(_dbgdump)
-	#undef MSG_8192C
-	#define MSG_8192C(...)     do {\
-		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
-	} while (0)
-
 	#undef DBG_8192C
 	#define DBG_8192C(...)     do {\
 		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
-- 
2.20.1

