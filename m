Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E86738DC30
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 19:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhEWRcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 13:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhEWRcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 13:32:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55498C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 10:30:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f18so7905434ejq.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBAmfS6PKS/xwLOxXt8MXYcwgBRtrB9cCwZG5JJuWuo=;
        b=pWKJ9jkReUcYGTkJhChBR6VDg/WbBKvuRX/z16/j3OJzUT7QV5da2irclljTNnHfDW
         7IyAhF3jXRAjQNGMGl7jkAzJGvP+Drc8a8zbykIZbFW1H3I43ZyRQ+WS+fva0TJjXZNC
         EXA+2BFugDTNncvJ4VHblEUAE84aHmPrNrZQm0gtvgHDD+8YJCLwkYCTYQeIQldl8jtH
         ks2gLvl7su9vNzsStzatoMujP3UDPWmVOhPWMjG+g/yEdCr+E4y5qxJpNj97r4UzZgls
         7HztFKB8278bVttcRIUlFJj0979wnQRCaTDFKzHSeHVMkPaXj4/uSzu5xyJnj6FQLwab
         3W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hBAmfS6PKS/xwLOxXt8MXYcwgBRtrB9cCwZG5JJuWuo=;
        b=PjXdNYJzqRcuTPABErScoYR0sX59oZl89JVyTLhMgEkfD5MZaZogg8BXYCrr9XyP4d
         vAjie2Q7d37Ebw6lAx+AXUPjcRtMhuYVhW7ZiKQXjAymJ1DD/gzqSgKo+w/fIYC6dlU1
         Oq9FY/vKctRtG38kdz8MfTMK718O1MXAXHOvvtzOLvlHx1Tr/wHsbgzwKAqot1ErYxKt
         8vXD7Px7cCmkQYbKXffmgD0IJbjX1ls6oZDWRNtM0nVd3n7sfZBCHEQP6C80IGHyr+f3
         sYcY/+UYzXEbQrWAkyN7DowuebQA4x6wxi5tHhbpDq+wW0vsMHwk+lmgjLnRSBYhbGQp
         seZg==
X-Gm-Message-State: AOAM533xuCLEyJUIAkcl4OCDge/BoIfQd9nIl1XK2ZdE9GLMtU5BUHS7
        l8sSIBigxCasKFei932FNp4=
X-Google-Smtp-Source: ABdhPJxBrSNb6YX4HaUN4IcxLUpB7KHrFjGRlT8UFmsdkaqU1Em4UJgCBLaohzlC3b8wvowoGKnfVA==
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr19782007eje.7.1621791046757;
        Sun, 23 May 2021 10:30:46 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id d25sm6807650ejd.59.2021.05.23.10.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 10:30:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext.c: Remove set but unused variable
Date:   Sun, 23 May 2021 19:30:42 +0200
Message-Id: <20210523173042.19785-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed set but unused 'reason_code' variable. Issue detected by GCC
running with the warning option -Wunused-but-set-variable. Removed its
use as a storage of the return value of get_unaligned_le16(), which has
been left as is because it has side effects on the argument it takes.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 9fc612fb736f..a13b3ec42bc9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1721,7 +1721,7 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 	struct recv_reorder_ctrl *preorder_ctrl;
 	unsigned char 	*frame_body;
 	unsigned char 	category, action;
-	unsigned short	tid, status, reason_code = 0;
+	unsigned short	tid, status;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->u.hdr.rx_data;
@@ -1791,8 +1791,7 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 				psta->htpriv.candidate_tid_bitmap &=
 					~BIT((frame_body[3] >> 4) & 0xf);
 
-				/* reason_code = frame_body[4] | (frame_body[5] << 8); */
-				reason_code = get_unaligned_le16(&frame_body[4]);
+				get_unaligned_le16(&frame_body[4]);
 			} else if ((frame_body[3] & BIT(3)) == BIT(3)) {
 				tid = (frame_body[3] >> 4) & 0x0F;
 
-- 
2.31.1

