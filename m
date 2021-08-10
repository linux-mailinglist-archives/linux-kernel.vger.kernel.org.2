Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0344C3E86BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhHJXvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbhHJXvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:51:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7484FC061799
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so679629wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PnowbGgyFz0o3O9tmzMqVdFTTxzq97bhMSS4g0mQmM=;
        b=XaH6a9gVk8AKJdNZHaj3v+zGqxoEMGBvy/ZkcexgAtNK6q0IkRRY7bxZTWzpV3YKt7
         hZLYa74eV3Pqvtfk+yLYlThudFjL4lrHNR8AIF811P4Y7n0z8fZuO+4I73E5X9XhA1Go
         n5t4SpmL6nxxxUEYk54ndE+/F7vAQ8ZqM6rFsZpCFWaALjmXKLfILSXLrggDgtkImTzF
         8ZbDbauFiD1Lzi/7NLcT0SsMCEGH9Ry+YJPVbuKc2mzrhZIqsfRadqolGVus+ySSSJKk
         WxR/RK5/etSl14amrpU8ea8gSOUhMARhPMQagIUFTM8If91gxvl1avJggZzoyIaXQhJh
         sKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PnowbGgyFz0o3O9tmzMqVdFTTxzq97bhMSS4g0mQmM=;
        b=qfOKUTnAM0gaI9/SpGvN5Y7syHrN4xPPe17y5WqBd09JiPsofd+Ptc2b8T++aN+vtz
         xYgdeMR2eMwu2Vzp5NVTdUUqkYt5rGCNPj/45RQSieOiW7Uh7j+BG06I5Nv/aiQ656im
         xJcrknQu/0PhlWbim++kIPaVVky5POeZ585mZZkQ9ruXSNuSl+Z5BekscTUnxTCmHptl
         byUG61CNj6C5tnQuqHbAGE70gqnjKAoG+2W9fRZnG6UszldqzxrmgOUXy8PL0+kC59ER
         6o7RloSVDlit9Mgg3cJF5kBGcLUR98OXDN47usXomhG9Y3HDbTFXi60eJdmUo/1I6LPu
         G8Mg==
X-Gm-Message-State: AOAM532w3WMNZaGpvvlscH/qbL2eGrcYJ+nPgNREIZ2GQMGhyVzWkba2
        YI2DwuhoamC9N/ZPWddn7I2LBbjc4/RjtLbQ4dg=
X-Google-Smtp-Source: ABdhPJw4058de38ifBB1VTshpNABi1nV7pHXqVNu/7rYv2TWDf5BrV5hQB8Z7ZZBFLA86HwQnARAtg==
X-Received: by 2002:a7b:cd86:: with SMTP id y6mr6858733wmj.181.1628639452029;
        Tue, 10 Aug 2021 16:50:52 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id p14sm13881220wro.3.2021.08.10.16.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:50:51 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: r8188eu: remove rtw_mfree_sta_priv_lock function
Date:   Wed, 11 Aug 2021 00:50:43 +0100
Message-Id: <20210810235047.177883-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810235047.177883-1-phil@philpotter.co.uk>
References: <20210810235047.177883-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_mfree_sta_priv_lock function from rtw_sta_mgt.c, as it does
nothing and contains an unused variable.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index c9644a3ecc4e..a74d0741658a 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -127,13 +127,6 @@ inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
 
-static void rtw_mfree_sta_priv_lock(struct sta_priv *pstapriv)
-{
-#ifdef CONFIG_88EU_AP_MODE
-	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
-#endif
-}
-
 u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 {
 	struct list_head *phead, *plist;
@@ -162,8 +155,6 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 		/*===============================*/
 
-		rtw_mfree_sta_priv_lock(pstapriv);
-
 		if (pstapriv->pallocated_stainfo_buf)
 			vfree(pstapriv->pallocated_stainfo_buf);
 		}
-- 
2.31.1

