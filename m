Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC731378E09
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351242AbhEJNDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349680AbhEJMtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:49:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA386C06125F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:46:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y124-20020a1c32820000b029010c93864955so11075825wmy.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKBDrlhjaJq2ItxNxA+omJE4a0bJoXUFeK6X38y0WSc=;
        b=eK5qcp3lz2fS8EH+Ov3w9RL4H3UfJN5FTMh6RWXtuiq5GwLUtGMvRZIkYZ6uRzlLw6
         VOnT6LuVN7S7palYc98AcrJX50fkUD92GDyOroGgSbejxm4UArgsTl9Ka2F8fRxSBNfc
         jEp0kpMnn5JGZXOHa1BIA35ZxV3N65fauh6pz+XtPh5/NO8+Hr7tyLUI2+laRJirKqSU
         IjzLnJMdxvAoPjLKsMN3dLHRPYT61qAYvGGRqvL/rbNsQy5DyXTnXDYlHpwFRnpOt/lY
         syR6uaHjkmbY4u4ACEpXwIKBG8P29D264+aHZop2dNJL6W9PDgQcGESgIjn9pCxCVbZG
         wSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKBDrlhjaJq2ItxNxA+omJE4a0bJoXUFeK6X38y0WSc=;
        b=H5QXWaj6/IE/1rX7Vu2EL9ga/qrbNi1Sga0vpxPitXf64RLuhj3Re3xip9BZWIQhLR
         162gczS32qgEVm8zovXJLvtKo6KGx2RfWj4laB9uH7ZdK8+6gTvnZywVTqAmCO4XTGy9
         Lvk+Ed8BjXNgasU8qAJ66c5U16v4n/SMhAWFMbQMvEzSYwvaI9jYGdYYTUDhs7+bNn64
         OsYe+ZcBukHTcKlc8l8DHyUBc8xhGIysbQIHCqWI5s8GaX72okQ1Q+gGQpuMhkiHIcjU
         3Mb5mpPIHIg/RFRFBOR3MwKFWX2uHRyQcDBzpKBaOOX/Ni9bDTqB1AAB7rJWDPQgkz0N
         dA8g==
X-Gm-Message-State: AOAM533sONyD+YTcIBqB2TQsJN5U8OTCeXqTwtciLYErGumHflg5vEIp
        DAy0yn6bPLrmGnwaKZ9xntQpLOOK7fnbDQ==
X-Google-Smtp-Source: ABdhPJzd/Hak8k5vvoB6dcR9CDFTPe7gfW8AI0CLWEyoj/Utp74f71YRJ2rT3NAnpbf6vhD/pAzSdg==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr36926162wmg.116.1620650784236;
        Mon, 10 May 2021 05:46:24 -0700 (PDT)
Received: from agape ([5.171.73.3])
        by smtp.gmail.com with ESMTPSA id x4sm25632507wmj.17.2021.05.10.05.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:46:23 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8723bs: move comments to silence 'line too long' warning
Date:   Mon, 10 May 2021 14:46:19 +0200
Message-Id: <cdb37302e4d7618141997229c59467f9d196eccc.1620650484.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620650484.git.fabioaiuto83@gmail.com>
References: <cover.1620650484.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move comments to fix the following post commit hook
checkpatch warnings:

WARNING: line length of 110 exceeds 100 columns
115: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:510:
+					*((__le32 *)crc)
 = ~crc32_le(~0, payload, length);/* modified by Amy*/

WARNING: line length of 110 exceeds 100 columns
124: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:518:
+					*((__le32 *)crc)
 = ~crc32_le(~0, payload, length);/* modified by Amy*/

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index bee1b2e2504e..4d0a86b69f41 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -507,7 +507,8 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = ~crc32_le(~0, payload, length);/* modified by Amy*/
+					/* modified by Amy*/
+					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
 
 					arc4_setkey(&mycontext, rc4key, 16);
 					arc4_crypt(&mycontext, payload, payload, length);
@@ -515,7 +516,9 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 				} else {
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = ~crc32_le(~0, payload, length);/* modified by Amy*/
+					/* modified by Amy*/
+					*((__le32 *)crc) = ~crc32_le(~0, payload, length);
+
 					arc4_setkey(&mycontext, rc4key, 16);
 					arc4_crypt(&mycontext, payload, payload, length);
 					arc4_crypt(&mycontext, payload + length, crc, 4);
-- 
2.20.1

