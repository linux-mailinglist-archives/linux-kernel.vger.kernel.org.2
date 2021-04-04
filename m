Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A686353868
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhDDOLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhDDOKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F76C0617A9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x16so8769903wrn.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omO9jbU544MlX2hw1Wy7qunDkzreILEkRU9p4/5TxAg=;
        b=dBXjzkb0tN2RvolgWXitSUBe/HE9FrHZuPVAYafly2kXwy6cciOn3qRvetMvb5HKfS
         jDs3bQXQC1d7nCMKK4kAaXFF2iCC/s94mZRkXsq0uYpHD1KyyY/5ZhAfVUlP3raOPz1U
         D7Bf+CMcedfxVUCAgNJJcxH7jO2VyhG4nUV8bNzJuaZ2bwcBrUSFSre344BIPJLhY95e
         irauH7WJm/D+9wtu9A7RwT0zV6yUtYZhYyXXKxEqa/l8jZmyi0VFb1LIwRluU/EJsz93
         IUscAcYZp7tVrEQ7mGaMSrLv8fUeKsFBXG5yhCE7mtpbfsZeXsJWps+c5c8v7U70foJ+
         q4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omO9jbU544MlX2hw1Wy7qunDkzreILEkRU9p4/5TxAg=;
        b=EkcPmIoqXBWVOrHGxYkEVdLtorfSroCAqG1eB50XUF960ippY2bYBqjisgbSKdINw7
         BZsgH2Qd+g4v27NJGNX6rrChxEgFqXZ+z3m0aAZmy0bLa+nDUFIBKjBpgrpiwqH75FMB
         hnoaYXSMuuBaXXQBjyn3ApHrnHtJQA4MxScE4Txo2YRYc4lfuW28nMtpk/AEjXVSezMH
         GU354Z9APBAsE2H1a3afTEEiJVfKwj0KJ5lL3l5qhwsrETkVqgnc75eogKkQOLidvCjI
         OKphJUoZ+v5JWEvGIuIkPQhnZ1rJVSvKTh/q34PhDogUUZ49TtlOhFxSj4bZEqLkRhEn
         2w7w==
X-Gm-Message-State: AOAM530wSkOvkxpxPZI+l7z/JRWTUMwbly2koi8Vugs5SYAyZ2FuUfZp
        UXy1k5Zloqq5B3+66kuhO4o=
X-Google-Smtp-Source: ABdhPJzRBH5QByWqTC7wvVWLfP9UmPmgTRQPuoinbBjuJIsgfXBPi5EkxQoGY5t3YlQnnvBPT8oRFQ==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr24462110wrt.80.1617545428719;
        Sun, 04 Apr 2021 07:10:28 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id d123sm570106wmd.26.2021.04.04.07.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 23/30] staging: rtl8723bs: fix comparison in if condition in core/rtw_recv.c
Date:   Sun,  4 Apr 2021 16:09:39 +0200
Message-Id: <4b363edbc2da36cb3c63edbcd43e3285754768c9.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit checkpatch issue:

CHECK: Using comparison to false is error prone
27: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:381:
+				if (psecuritypriv->
			bcheck_grpkey == false &&

and fix the same issue in second comparison to true
inside the same if condition
IS_MCAST(prxattrib->ra) == true
			^^^^^^^
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index bf53695f9f7d..eac663119290 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -378,8 +378,8 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			} else {
 				/* mic checked ok */
-				if (psecuritypriv->bcheck_grpkey == false &&
-				    IS_MCAST(prxattrib->ra) == true)
+				if (!psecuritypriv->bcheck_grpkey &&
+				    IS_MCAST(prxattrib->ra))
 					psecuritypriv->bcheck_grpkey = true;
 			}
 		}
-- 
2.20.1

