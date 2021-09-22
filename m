Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14AE415113
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbhIVUIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbhIVUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A0AC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so10456278wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUtQ80eiH5Ny+znnv7q3T5DI1EdLRvEuT/LUtb8kDNE=;
        b=iTIEu+YKUEfYOSHb20AqeetMVeufYEdWVS8UDi3o3PCg3igKLH7eKrlZuKxNGgq6MZ
         WVFcF7Alv1Zj+TIsIV1wad80KrRfMNidmAJXyr9BzlcY45X/tMq61wBVOZSr/cxCJa2S
         EFGUlepnjo7R1A/AgTim6erYZi9Jqk5QSVBORrPqlDgpGQvpLBVILkdWfB8chqBH53TO
         45ujpJg9XaZU4RwxzIZ9a5zHbmUP0IlS5ihxcPTdjBYT+OtanZXr6rNzUmgc1MXrlowC
         FyPrGg1f0mCnZsiqPuTepg0+XMBUep6Z4JFqn4HLKcCe5vz3ZS60598y1nU0PXTctkLU
         Tuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUtQ80eiH5Ny+znnv7q3T5DI1EdLRvEuT/LUtb8kDNE=;
        b=0H/nC1a3jctF4o4mQIbZpkIug23T1denmjifahzWw+DRHlqRccKeP3t9eNQtNzFDBC
         w2P/m2NoL82IXs96aXn6783PR1sVNb8uaCJMWZUtoV8ZdOm5tkPLlKPVmDLDDtk5G6gW
         WBT5vE912Dv0KoQtk/D9wqxOlcpt7yXQi8x57W3qi/zReFYw+XZm26lYaHzqYo/WWsmW
         Rnj+LfPajs6H9si44HdFCcCQ/fML4SmK5UbBE5yqmbGJwZb/Gs6bW/DToHFlHV4BaVCz
         64C7HjZQfhEqYm4vE0tjzxAfhLtz5JG/Lf8SJP2F6g4cTassl4nboi8AVqdI1i7/160a
         hWQg==
X-Gm-Message-State: AOAM530nfjKgPvIy2CLeykdGRscqNflrYrW7BH6kbA/mEhmshy7dF7ka
        Sdu+VV2KRG+jV2tB4rWvIqg=
X-Google-Smtp-Source: ABdhPJwdkQ0XoRItndbnuh2j3WpLfFj94ugOzbIAiOfm/nLsSbLb94p0OtdiCQo2re03d4t1VY1Wzg==
X-Received: by 2002:adf:f8cc:: with SMTP id f12mr839226wrq.195.1632341153576;
        Wed, 22 Sep 2021 13:05:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 31/47] staging: r8188eu: remove dump_ies()
Date:   Wed, 22 Sep 2021 22:04:04 +0200
Message-Id: <20210922200420.9693-32-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function dump_ies() is not used, remove it. It is the only user of
the functions dump_{wps,p2p}_ie(), remove these as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 59 --------------------
 drivers/staging/r8188eu/include/ieee80211.h  |  4 --
 2 files changed, 63 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 7dc40d6a5de1..182164e17b3f 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1041,65 +1041,6 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 	DBG_88E("rtw_macaddr_cfg MAC Address  = %pM\n", mac_addr);
 }
 
-void dump_ies(u8 *buf, u32 buf_len)
-{
-	u8 *pos = (u8 *)buf;
-	u8 id, len;
-
-	while (pos - buf <= buf_len) {
-		id = *pos;
-		len = *(pos + 1);
-
-		DBG_88E("%s ID:%u, LEN:%u\n", __func__, id, len);
-		dump_p2p_ie(pos, len);
-		dump_wps_ie(pos, len);
-
-		pos += (2 + len);
-	}
-}
-
-void dump_wps_ie(u8 *ie, u32 ie_len)
-{
-	u8 *pos = (u8 *)ie;
-	u16 id;
-	u16 len;
-	u8 *wps_ie;
-	uint wps_ielen;
-
-	wps_ie = rtw_get_wps_ie(ie, ie_len, NULL, &wps_ielen);
-	if (wps_ie != ie || wps_ielen == 0)
-		return;
-
-	pos += 6;
-	while (pos - ie < ie_len) {
-		id = RTW_GET_BE16(pos);
-		len = RTW_GET_BE16(pos + 2);
-		DBG_88E("%s ID:0x%04x, LEN:%u\n", __func__, id, len);
-		pos += (4 + len);
-	}
-}
-
-void dump_p2p_ie(u8 *ie, u32 ie_len)
-{
-	u8 *pos = (u8 *)ie;
-	u8 id;
-	u16 len;
-	u8 *p2p_ie;
-	uint p2p_ielen;
-
-	p2p_ie = rtw_get_p2p_ie(ie, ie_len, NULL, &p2p_ielen);
-	if (p2p_ie != ie || p2p_ielen == 0)
-		return;
-
-	pos += 6;
-	while (pos - ie < ie_len) {
-		id = *pos;
-		len = get_unaligned_le16(pos + 1);
-		DBG_88E("%s ID:%u, LEN:%u\n", __func__, id, len);
-		pos += (3 + len);
-	}
-}
-
 /**
  * rtw_get_p2p_ie - Search P2P IE from a series of IEs
  * @in_ie: Address of IEs to search
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index c6acb48059f7..09d27a0b6476 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1146,10 +1146,6 @@ u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id,
 	for (ie = (void *)buf; (((u8 *)ie) - ((u8 *)buf) + 1) < buf_len;	\
 		ie = (void *)(((u8 *)ie) + *(((u8 *)ie)+1) + 2))
 
-void dump_ies(u8 *buf, u32 buf_len);
-void dump_wps_ie(u8 *ie, u32 ie_len);
-
-void dump_p2p_ie(u8 *ie, u32 ie_len);
 u8 *rtw_get_p2p_ie(u8 *in_ie, int in_len, u8 *p2p_ie, uint *p2p_ielen);
 u8 *rtw_get_p2p_attr(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id,
 		     u8 *buf_attr, u32 *len_attr);
-- 
2.33.0

