Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45E41510D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbhIVUIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbhIVUHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEFAC06179A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w17so10318805wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kj8Lo1kIl/gfaBI+0yja43D7hmRydRTP+dO+y8OaOSg=;
        b=Gkzdc2ilOqBOalbt8xX1U3meQHqBHZ7WwbdowIWxU/G3ks+1SVpWrxM/cgsKk9giPb
         MeKKLtnjR7zLnKfEzu4bz120DHdbYUbYJNZDAcZZysqz/hmXZUTf4w0KyZTn7H8xaggB
         dzTHkE/DE+Qok+dokdf/neXNzILhC03F38N62LIOptPJpxb1RqF1CQSjNadWrApEBI7v
         0f24kiUJv8hajXe8v6apKuAh3nx6G8mepeE4yt83h0DSA7tQ6l7QitAghxAUPm5Q06ne
         +hznbiD1dP/cOMDZOM+2cRmHmo9QY7Fs1oOJ+aZmO6UG73Si+ZQmCo9vy3UAeq9iIKel
         EjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kj8Lo1kIl/gfaBI+0yja43D7hmRydRTP+dO+y8OaOSg=;
        b=SA+6Ue7LBAV6uB9+gbukpFm6Rs4qY3CL0ReMYkoyj1RLcSEiBJCgW5Tf/4QF16JGXn
         vabmPywH5SU9JFqBvtK3sgwgvuqqJmxMWpcQVrkpdIuVNMNEJsJrTAJuRfsycNucqY/+
         R5K/5Wt5OR0Aqh1HrSpiSJsYLgL8Nnda8cM75wod1yEZD/5kaJhS/UkygAhcuz2ID2cG
         Iep0LE56tqazQ3q4+6AB3UxJEeLGDgGN/j1NVCXPjE2vvoX6+GM67Q+lKd9G5mTd16jz
         rYieUiceGTB7OuipjzHYVV8umXXsFQBCsXWlfIwZhM0XFKwEEHm7NrRiJxtz1NNklnPp
         /2xA==
X-Gm-Message-State: AOAM532FU0OYcvFcB30+UgRpRRbU4+BsZ1tgPTAgjrI9k8apHbOOPiKJ
        Y8e4ykUInIsNUBl4rqgW3rUGyqFE4rfcOQ==
X-Google-Smtp-Source: ABdhPJxLpsE3BL0pQaxk+wNeLOyWX9eb0vUijgnfkaMJLnr/bZTFcxd6fHvw9hlFPpu9lLSNKPQYig==
X-Received: by 2002:a7b:cd0d:: with SMTP id f13mr12522411wmj.183.1632341150657;
        Wed, 22 Sep 2021 13:05:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 27/47] staging: r8188eu: remove rtw_cbuf_full()
Date:   Wed, 22 Sep 2021 22:04:00 +0200
Message-Id: <20210922200420.9693-28-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_cbuf_full() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/osdep_service.h |  1 -
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 59747822148e..da85a9681c4a 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -292,7 +292,6 @@ struct rtw_cbuf {
 	void *bufs[0];
 };
 
-bool rtw_cbuf_full(struct rtw_cbuf *cbuf);
 bool rtw_cbuf_empty(struct rtw_cbuf *cbuf);
 void *rtw_cbuf_pop(struct rtw_cbuf *cbuf);
 struct rtw_cbuf *rtw_cbuf_alloc(u32 size);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 8b0c8429e836..026c5627736a 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -223,17 +223,6 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
 	kfree(ori);
 }
 
-/**
- * rtw_cbuf_full - test if cbuf is full
- * @cbuf: pointer of struct rtw_cbuf
- *
- * Returns: true if cbuf is full
- */
-inline bool rtw_cbuf_full(struct rtw_cbuf *cbuf)
-{
-	return (cbuf->write == cbuf->read - 1) ? true : false;
-}
-
 /**
  * rtw_cbuf_empty - test if cbuf is empty
  * @cbuf: pointer of struct rtw_cbuf
-- 
2.33.0

