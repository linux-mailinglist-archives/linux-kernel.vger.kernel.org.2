Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526A63FA972
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 08:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhH2GV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 02:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhH2GV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 02:21:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5B2C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 23:20:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fs6so7350970pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Q/72TZxviiCkwWN8QnZlclMQc+rmLTuqlV6J9W/56aY=;
        b=sf+r7DBnlFt5Zpw82wTMGqkUBgenr2o2QmZrXK7+eSoyMgsB/gWWeRbCEwo7TU4Vex
         JgCU9v3TwSRQ8mQVlND8ZN4wF+Le7SqeX6HN4gXWHRgQpGKf4jVz3p6TUZ1DAS0fVqdU
         xfEHiiMTJGoPHwxSBu2MKfS4GROZdHJJ0jdPouwPDuoBaOD9htpgl/Q/eXGGPrF2jqnV
         0XbZ0VAzLqTibnCnTx1z+E8r6M3dn6rRJub/BOMBQSquDiukvV6Blgv+2qn3kCPQvvw1
         ARG5J9CbO1hI44S9zruW4KVxq5ezIz8vniatIL5zXCTh5tw9JO1sslhrBQafCH3I5+VK
         X4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Q/72TZxviiCkwWN8QnZlclMQc+rmLTuqlV6J9W/56aY=;
        b=YwuyAdRVD3YFxj8vo5wgpPya2zH+mY2mmSws8R2w4dGmZRSn39latFR+6+cRe/qP4o
         L2JslrnWThfIpRX34+Zi+j0eU8Fx7YJvb7uySFCahH1CfMI6+keU441TxHmDArSS35dG
         Ub4W3jg51Aq3A1DU+MOH6FtTtbRGd/RWV7SImH3tl8bhYbiGRHqjlX8SsJptHDMhGDT2
         OdhiAxtMYRyLXq0/prgfD4NAxqV4nVmK3fBIX+bFbXvqbUhuwqHCbsQovnXzg5N1++U9
         mmBRXK+96Y9g3/0OGNsx5mllp1GeHRGDF7hy96oWKhdIke+Gyjw1y4ALeLc4M2h9wvKz
         abMQ==
X-Gm-Message-State: AOAM531P8mi6VqaV26X4QQ+iZHflC14sMHpvsrjPdSocrtebIxlT9Sdz
        5/TzlW9drXXb7HMvaSut3neP+wN1wT4=
X-Google-Smtp-Source: ABdhPJxGNI2aLBh/vHAYvxzY2Z3gU/cJ0ZivsaolkROrZlqdKSSNEUenujlZNnSd/RRlscFVyhPM8A==
X-Received: by 2002:a17:902:b190:b029:12d:487:dddc with SMTP id s16-20020a170902b190b029012d0487dddcmr16321536plr.24.1630218032949;
        Sat, 28 Aug 2021 23:20:32 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id u21sm12639086pgk.57.2021.08.28.23.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 23:20:32 -0700 (PDT)
Date:   Sun, 29 Aug 2021 11:50:27 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v2] staging: r8188eu: core: remove null check before vfree
Message-ID: <YSsnK7Wepn1Dv+oy@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove NULL check. NULL check before freeing function is not needed.
Correct the indentation.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index f6dffed53a60..c3600cb1790a 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -155,9 +155,8 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 		/*===============================*/

-		if (pstapriv->pallocated_stainfo_buf)
-			vfree(pstapriv->pallocated_stainfo_buf);
-		}
+		vfree(pstapriv->pallocated_stainfo_buf);
+	}

 	return _SUCCESS;
 }
--
2.32.0

