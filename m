Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB035386A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhDDOLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhDDOKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2829FC061794
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a6so2763458wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wv9UQx8pFx9EKn1LAk5Wrb1T9ZM1NP2AqUIoiI8Ejp0=;
        b=u6vfMqCI2MtUyeqLsgxkpUQzbF+w+I1CB9FeeQP+NYympvJxX+YAzIqcW4KRxiyjHt
         s9aCSIcFiJogB8HfX1FRKATNm7Y1BgzDxUCDElq/jJ8x8D5o5brdKfA3L5qqnDP5fDtH
         c3oNyTmutIJOV1N02AENrcnniCnSbaioqBMbToyHl7PQi4laEQ/OHXMCN/+7GFyXdU77
         nf+Y4rS7XWO+c2ChbmHxrLr8wluzonIg7IP3BdDBDTWhFUx7sxytHpdTxCfAWSe9bAi7
         /F/UO92MGJ6+RrOVnRECdJHdbgUk15/Ompqd52ZOujBegBSD1vzRpTCinnyYBmduodhq
         Bi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wv9UQx8pFx9EKn1LAk5Wrb1T9ZM1NP2AqUIoiI8Ejp0=;
        b=OBveOyVfQVXtLZph0YgzdoYoFVQ1iE2bN5UvtBdoi8jL6+2XBtM5G9sjHypgfgCTzB
         MA0S18JQXeqj+FxWQzrnEACPJFsAKwmO7H1ZqOCU1lLlrHkHYzkTumFVH7m32nRmGDbl
         Olw1ThZNMjV9YGm09MWjvDmfbth6G5wvHYgV/KtAq6kplxxg0IL6qUw4amvFS+7trfxR
         zHeUAAms+dUeT3RIfNsLeC7+mmLbxI3T3H8B6C9bMJ3YW6iyMw18kPRqVsaygjIrTUos
         0n6rnYbSkxAhxFom4lvnYbXKzwruZYWW9jX3QhN7YlAzCEpi4KeNVpRk9aHrRQR11YM7
         S2IA==
X-Gm-Message-State: AOAM532KU1uJfFHk+5XS/bUYSq6+oOkmQIWepHk7/8wf3O4ksTJr6rlQ
        QUNEgeqOzTLtOjw66npBT1w=
X-Google-Smtp-Source: ABdhPJySK3lhlaYVHenCUv2Qf/NKI9TvLcB//ndFIcbcHb47S+/O7bRCnv6Rqz90V8aet1hNU+CQLQ==
X-Received: by 2002:adf:f7cc:: with SMTP id a12mr24871522wrq.54.1617545425339;
        Sun, 04 Apr 2021 07:10:25 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id k16sm11320479wro.11.2021.04.04.07.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 21/30] staging: rtl8723bs: split long line in core/rtw_recv.c
Date:   Sun,  4 Apr 2021 16:09:37 +0200
Message-Id: <ac256752eddba7678e8305cb5e560969dec482de.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issue:

WARNING: line length of 113 exceeds 100 columns
110: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:381:
+				if ((psecuritypriv->bcheck_grpkey
	 == false) && (IS_MCAST(prxattrib->ra) == true))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 953351f896c3..c8a13d733c98 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -378,7 +378,8 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			} else {
 				/* mic checked ok */
-				if ((psecuritypriv->bcheck_grpkey == false) && (IS_MCAST(prxattrib->ra) == true))
+				if ((psecuritypriv->bcheck_grpkey == false) &&
+				    (IS_MCAST(prxattrib->ra) == true))
 					psecuritypriv->bcheck_grpkey = true;
 			}
 		}
-- 
2.20.1

