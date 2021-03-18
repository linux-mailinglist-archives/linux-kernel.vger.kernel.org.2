Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D38C3408D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhCRP1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbhCRP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0E6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o16so5988974wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qk3N2Juh65NIKo1kZLZyXGVJDoTpUX4R2Uet89LoEGY=;
        b=P/1orvrTVh4qhw3u7WUXjsXrtOkrIMg/s8hjaNsj1DN8U9vTMlIlkwo3quTHX9W4Fd
         epKDt1QQLcqtQ7ckX7EYupqOCw123J2hTVPmmZSMR/Vshplhi9mt9I0p+7mYRh7vJWCi
         sho4+4cn0awLHHbGEmuaylPaltgxveeo2Ld00Om0BniRNieQTlNu+7+i+B2XHBlLZBYr
         faUZOdt/K9sPbvgJ5jkUnNnuGlRumZ4FHxLWMNGSWwrVk9LmYHC6GxVjE8/SLGptWWvy
         YwBBUs7HRFU+DhbiTyo4jMI2BkHzoCqNOIiR1U0Ve7IjCw1stL7dESd0/Ony3u2lC1eA
         Cb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qk3N2Juh65NIKo1kZLZyXGVJDoTpUX4R2Uet89LoEGY=;
        b=YfCDaWtdDIhf862wPEhhnB/1FuX4jIla0XqHXKsqbbkMEzb2iFvOv64UieBdtBl8tZ
         G4apfLZGCnc+KR7PNJUkGSpAJyRHGuL6wfjBk/4Ky3wmGkipr3wVasSWyyBX0BxuzwCS
         mhTBHv8XvmUNVK3UWSRSPWmKRAd6Qi0eNVOfhY5Avvj14deLlZ5of4O/FFH7ihlx3lGz
         PPnrdE6HSoOcLkVm+YNN/RrJOdDFSH1A78H8DTqqSo59AXwZpFH9gCW23hGiV5FI7h60
         gR5GHIIa5ODPStWdRaOPZAzYXQBcmFVNOZejad31CpQ0ouBhPBNcdz8Piao/jQLvTcN4
         2+Tw==
X-Gm-Message-State: AOAM533q6A3ich4K2IIxS3R5qQz/tQHmdqH9ugffRo4Pk4KUTi4Rf2cu
        CAvHkxJm4tqq1hNC3pU57g4=
X-Google-Smtp-Source: ABdhPJzazPLOu+fP7jzStvns4q7/k0mK4Q8ryC8DYwvTT5/+eBitwccwYgCfKES7eLSeqcHmQaEwaw==
X-Received: by 2002:adf:e34f:: with SMTP id n15mr10318025wrj.224.1616081224214;
        Thu, 18 Mar 2021 08:27:04 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id o11sm3333451wrq.74.2021.03.18.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:27:03 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 08/15] staging: rtl8723bs: remove unnecessary logging in hal/odm.c
Date:   Thu, 18 Mar 2021 16:26:03 +0100
Message-Id: <20210318152610.16758-9-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1109: FILE: drivers/staging/rtl8723bs/hal/odm.c:1109:
+	/* printk("==> %s\n", __func__); */

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index c7607e7d26c5..80c9a95be870 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -1106,8 +1106,6 @@ void odm_RefreshRateAdaptiveMaskCE(struct DM_ODM_T *pDM_Odm)
 		return;
 	}
 
-	/* printk("==> %s\n", __func__); */
-
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		PSTA_INFO_T pstat = pDM_Odm->pODM_StaInfo[i];
 
-- 
2.20.1

