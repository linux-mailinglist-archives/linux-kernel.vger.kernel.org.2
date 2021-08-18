Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33053F0ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhHRXt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhHRXtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:49:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2071CC0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:49:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h13so6117547wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u2ZJqznXmuhrlSqufTd57Yc8JlZbuqOPMN7Hgt6psyk=;
        b=qdImYatvHktofiASKYB8ZneV6fQ4ZcsLLgeItM7Qmf81hFciU2vSwHHHLaxAzgpQGd
         +4e2BdupyvLtoCjOcOaM2bK83+UCo3A+xvFi0cCry0eaxwEJoaQfEtbDdTXNbX2ObWA8
         341xZL3wAsUJFrvdATgMqokN870l16INMjHjD7KJjmcMRFLs4zdK0kk1y1tNB6M98w6D
         FbwbsZGgm49jkidzkYZNEkg+FgpT0IxS/O/dlVSszTx8PEUjQLDwIbLnUFK5Kj5Xdy0l
         dgq43UtKd3EH7dXdpQZH0fKxZ8y7kMVldun+OjVYejZoQuScjnF9Ll4Pv1JM9Y1sC9Gf
         um/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u2ZJqznXmuhrlSqufTd57Yc8JlZbuqOPMN7Hgt6psyk=;
        b=SArBQdFyQtVjeVnqccwaaqw6/mJc//dL064TF+mlwfGpQXTUImXXa9Tva3P3tiwpwM
         IrfnkT7gxh1NhBoxoXK9oyyKw42AYDOOLM7eQ8Pag4IuxlMSCM07FGVdfGpUGaoN5BZz
         UY0ucn4OE2OD8VSWxm/D5ZyxW6TGQL3NxO9f+UkzWFg4p38Q+NfWtTLHvnZCEk//g8nI
         6pkIiijIgi6o/Lj8z0nUs+kbZhSjadu4Ck90o13BT6GnjoL2bXTEL51BEMOH/bQkFfQ0
         0noQEKeNP9h99u+XwD6XrkJ+OuCQUTsrADGJXAQOMXHEfaLCX+2hjczR6mHtxf3qDwRx
         z/hw==
X-Gm-Message-State: AOAM531cs5y983C3raLGVmv+lZygu2VRhvv/qWrHkssjGI+hl1B2fA+S
        ejErUEMN00HNYW6u0BapTiGWZw==
X-Google-Smtp-Source: ABdhPJzXIdFIWaf/YtSDVKUp4W6cG5E/aLEMvMdgpLcIscjLvy4X9I7ZS23z8ai+Z7FqIpOBf8UgZA==
X-Received: by 2002:a5d:610f:: with SMTP id v15mr70861wrt.415.1629330539788;
        Wed, 18 Aug 2021 16:48:59 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1205916wrt.77.2021.08.18.16.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:48:59 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 6/7] staging: r8188eu: remove function _rtw_zvmalloc
Date:   Thu, 19 Aug 2021 00:48:52 +0100
Message-Id: <20210818234853.208448-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234853.208448-1-phil@philpotter.co.uk>
References: <20210818234853.208448-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the function _rtw_zvmalloc from os_dep/osdep_service.c, as this
function is now unused and is just an inline wrapper around vmalloc
which zeroes out the memory. All previous callers have been converted to
use vzalloc. Also remove the declaration from include/osdep_service.h.

It is considered generally bad practice to declare functions as inline in
the majority of cases, as not only can this qualifier be ignored by the
compiler but the compiler generally makes good decisions about inlining
anyway.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/osdep_service.h | 1 -
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index dba7a7bec9d1..bda435ca9d08 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -171,7 +171,6 @@ extern unsigned char WPA_TKIP_CIPHER[4];
 extern unsigned char RSN_TKIP_CIPHER[4];
 
 #define rtw_update_mem_stat(flag, sz) do {} while (0)
-u8 *_rtw_zvmalloc(u32 sz);
 
 void *rtw_malloc2d(int h, int w, int size);
 
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 8a797bfcb7f5..95ac6086370b 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -36,15 +36,6 @@ u32 rtw_atoi(u8 *s)
 	return num;
 }
 
-inline u8 *_rtw_zvmalloc(u32 sz)
-{
-	u8	*pbuf;
-	pbuf = vmalloc(sz);
-	if (pbuf)
-		memset(pbuf, 0, sz);
-	return pbuf;
-}
-
 void *rtw_malloc2d(int h, int w, int size)
 {
 	int j;
-- 
2.31.1

