Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC18535FA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352549AbhDNSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbhDNSMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A28FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bx20so23680554edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdEVCrFFwemRGVz8oNJR0sYV8NDQMun9Dnn10s4aLrk=;
        b=T5Jffb63JPVd5H0yM+DB8OtbI31ZzfgIBRp9fcT7nfWp6tb8FNg+hZ0h0U/CvFCFTP
         UU32/JF/zBkzp4sdCgyGbO8tVdQkrqSieOquzuHbLfEQxrfHCw+lXIPgP5bpC0xXQ+KQ
         2iHgJJscQrmwvOtLFb/xZUcPSiL+EYipYKzdiK32DIud48Jc+Uriq7EbVsAi/o0zvdfb
         QNZfF8EdtT/7OjHrZKQ++TNxJNwoXLUJ9Asfu/x5R+Pr6VrmV01PPKaxt9ivn3ApLC9X
         M5/X9kPyaSxRFJDemHQUMkKVzpHQJF0EhpWq6w4Yyl7bjtYjM/9BNgJC1cVR9NEzjZn9
         nRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdEVCrFFwemRGVz8oNJR0sYV8NDQMun9Dnn10s4aLrk=;
        b=SFCgMGkLnMPn0880AkZs7pm9a6ILF7Cyksh5PNWNQYuYBY6zdPzVo+4/0JeMhnqgwG
         VLbky7NvD64NCq9kUrrprj6uVrofvnU9g5y3eZb6bl9haehGV3CudDwAoBZk7JNyV6vx
         rIJXi1OGRwB40RL4t9iNJELFeq9JnMEpaWnNCAWOa6h2rzw0SH2EOxCxmpT2urVwXVRm
         HceegtRkG7d6ytUd9mziMUHotvagaWED+76jTwQ3WMYMTO+nCz7VHyEGqnHKaqMiju8z
         fHqf5LCMnJOLy3IvPgCnRi9DNbWxu6Cvu78LGPrZGcw+MytiBSo7BuIjnNhLIUkDDqwY
         6F+w==
X-Gm-Message-State: AOAM533b6vqUUaIpca6dB7RISS9vT7YGGuYZ5lZcTAeYpXXYXf8fVD5d
        FIJRQU3oMxmzGVE1JqoG1MVVdA==
X-Google-Smtp-Source: ABdhPJzZK1BMaZwOXlSvNJiNdKQ3vu6LUN5MeljFZ+3mC/R1f+ruoi0sqd5K7L6WqjLGqGercAGrgg==
X-Received: by 2002:aa7:d588:: with SMTP id r8mr191546edq.318.1618423911399;
        Wed, 14 Apr 2021 11:11:51 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 16/57] staging: rtl8723bs: core: rtw_sta_mgt: Remove unused variable 'psta'
Date:   Wed, 14 Apr 2021 19:10:48 +0100
Message-Id: <20210414181129.1628598-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c: In function ‘kfree_all_stainfo’:
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c:128:19: warning: variable ‘psta’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ross Schmidt <ross.schm.dev@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 85663182b388a..7b631a6b258a1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -119,7 +119,6 @@ void kfree_all_stainfo(struct sta_priv *pstapriv);
 void kfree_all_stainfo(struct sta_priv *pstapriv)
 {
 	struct list_head	*plist, *phead;
-	struct sta_info *psta = NULL;
 
 	spin_lock_bh(&pstapriv->sta_hash_lock);
 
@@ -127,7 +126,6 @@ void kfree_all_stainfo(struct sta_priv *pstapriv)
 	plist = get_next(phead);
 
 	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, list);
 		plist = get_next(plist);
 	}
 
-- 
2.27.0

