Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF53DCE6E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 02:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhHBAzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 20:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhHBAza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 20:55:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB98C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 17:55:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id cb3so6142552ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 17:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksajpnsjJzPlnTGdprn7ElzDNq6N2TCOP+6qf/O43zw=;
        b=iN+YJH9WVXFJF82gYEqnQ0Z2Lp2scoDpO018/OJfQaGSejCiXf39lYREjmVD642jWV
         P0HSiTYTStjzbYaRr4372O39f19spQq4qWyHx51/+sRBlJQd1mXbqPzL8pbCim98NmJu
         wxPPcXDqiASQ50HnZWycIzT9tD9h9US2cClrshjK+hzRWiIZ3ea5n9E869agebFcbXiW
         8vd+ShUR2V7yfbqgvk3/JYFu3MiwxCgo6/GoxUQi59NqmuKFx2KUItEcuhLR05BXOX2n
         CnfO72oUdwOXStgHjMwmlRprEg6Me4x11h6xjWGZJTHg8SePAN9mZKe4B6I5UbVi/Xcm
         WYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksajpnsjJzPlnTGdprn7ElzDNq6N2TCOP+6qf/O43zw=;
        b=OiKuGzRN3C4wN9oVVDfYotWONs3wrDLFUXjvn/4Xd3wcBy4BlB9hXvIq280ZXMJeSj
         vYfuiGrhogTvyFTw9UAs4jQbUZ35kZdS/nw2KakGugvb3nFQu1NwS/fQp/78J5ksCkq+
         vXU2ihB0ARvyxS66Qr8IOMlKSueCL2HtvCLGu9JuKHu8RVRfqFHNynvmlm0wWHvFTSIA
         sPl8VWHHSO8UfnvDXDJCmZ8Xq2zxHod0EvkEOtqR6btxmPaDAgzqc/QfVvKnFh2XS+Jr
         3brtKPEEfmReem0mWl+Ej54zrayQiKKfcp9xLDU9NApqizuvBxH3k/7MFmuwIHsyxr3O
         S4+w==
X-Gm-Message-State: AOAM532MkjKAmiF8bqQYm80UpjVZ8qcV/vDJBTtA7tuTGXR7qDnpFTD6
        wtZh2N/woP2C4YcCSAx/Ll2etfNL2Jc=
X-Google-Smtp-Source: ABdhPJzI0jlYSuZH4DXXc/6divlLMe1Z6vgDAfJeBvZBwr+fxeKbNseWF3NzpiwRf2l5Ej2LOs/dHQ==
X-Received: by 2002:a17:906:31d4:: with SMTP id f20mr12776750ejf.383.1627865720521;
        Sun, 01 Aug 2021 17:55:20 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id b17sm620123edd.27.2021.08.01.17.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 17:55:20 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: core: Remove rtw_mfree_all_stainfo()
Date:   Mon,  2 Aug 2021 02:55:17 +0200
Message-Id: <20210802005517.12815-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_mfree_all_stainfo() and the only line of code that calls
it. This function simply takes a spinlock and iterates over a list 
with no purpose. That iteration has no side effects.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index feaf39fddf7c..dae845ace2ef 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -161,34 +161,12 @@ void rtw_mfree_stainfo(struct sta_info *psta)
 
 }
 
-/*  this function is used to free the memory of lock || sema for all stainfos */
-void rtw_mfree_all_stainfo(struct sta_priv *pstapriv);
-void rtw_mfree_all_stainfo(struct sta_priv *pstapriv)
-{
-	struct list_head *plist, *phead;
-	struct sta_info *psta = NULL;
-
-	spin_lock_bh(&pstapriv->sta_hash_lock);
-
-	phead = get_list_head(&pstapriv->free_sta_queue);
-	plist = phead->next;
-
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, list);
-		plist = plist->next;
-	}
-
-	spin_unlock_bh(&pstapriv->sta_hash_lock);
-}
-
 static void rtw_mfree_sta_priv_lock(struct sta_priv *pstapriv)
 {
 #ifdef CONFIG_88EU_AP_MODE
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 #endif
 
-	 rtw_mfree_all_stainfo(pstapriv); /* be done before free sta_hash_lock */
-
 	_rtw_spinlock_free(&pstapriv->free_sta_queue.lock);
 
 	_rtw_spinlock_free(&pstapriv->sta_hash_lock);
-- 
2.32.0

