Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D0C36D691
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhD1Leo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbhD1Lem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:34:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC3CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:33:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mu3so3037171ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNqCBvfTc2uOfgSlghFo3TISsBCbOPttLe3KTxfSIXw=;
        b=vF1mxLZjy9Jdw9QxXGSMl5pJ59QItWKtIhNN7DTHEZz0NwgJbMkZ1hVqyuARSfAoA2
         MK0Fz1QfyyLfPXPgZntgSbuEm4cq9dsZSwNePMYTgoGG9FYagCoLkYqLZzORcDvyOl9g
         siTjRJ6pD+YaxBkB8SmVlxVkmXoIt9kmRPS4zogc+OGxxvJkRpH8bvr2kK96m12yEHNX
         yinPbhcA69W7UTCYm+w+d2+4n6JbjIM6qmAKyxC1ophpA6Jz5rmo/H7Jx47SM07h/o3t
         8SSpVNS8FLC0SF1T/F6Irj3ugmu2EgRgV0/13Atc5Cx0YMuoVuiRRYgFuvoBLvppjawP
         1vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNqCBvfTc2uOfgSlghFo3TISsBCbOPttLe3KTxfSIXw=;
        b=a53bklXpIN9BUfJRQaU5c8QU/MCTCFbLB+6LFjgc7cTN0mCU7iSJ7Ssti0x4tOGVpv
         6+4S8TpJmHoKdMGXWAgjMBijrcJuRZo+vpDYrmMAuok9bGIr1wICwtJDT7YX3Ojmxtvo
         /iWEWajbeEk1/K+lp0K924+5czDP86fCPX8jO4PAwM96UsJdL40aQUEGV+bwS6FfQlNs
         /e+OmcmQ3KNl+EW6ve2jirXd9WRJOa5JpLhQWAoe9d5ui0ywPKwqru8bZrwcgKn/iBHc
         6ErMhTn0k6rLjBFt26JKsZyXeVPdhy7mICjvXAUVuuougOv1LDbs70XPxEE7709Y9M0g
         BVag==
X-Gm-Message-State: AOAM531WzAMKCbYRr9fTDzGKZyWR2a8SQ5N6Vk6EFJiwPxzejQvNO6Ct
        2T7+pdBoQCFSUutlo2F+XO0=
X-Google-Smtp-Source: ABdhPJxWIlZEw1Kc5Yc+Sk9gMs3YKyTgcqwrxxTnuUIKG8A8G0kjUKWJWakc1C0D0IhZl8OwkQYr6Q==
X-Received: by 2002:a17:906:4d02:: with SMTP id r2mr16801792eju.464.1619609636163;
        Wed, 28 Apr 2021 04:33:56 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id u19sm4677187edy.23.2021.04.28.04.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:33:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH 2/2] staging: rtl8723bs: core: Removed set but unused variable.
Date:   Wed, 28 Apr 2021 13:33:46 +0200
Message-Id: <20210428113346.28305-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210428113346.28305-1-fmdefrancesco@gmail.com>
References: <20210428113346.28305-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed set but unused variable. Issue detected by gcc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a2fdd5ea5fc4..b0d2ba5ed129 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1019,7 +1019,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	u16 capab_info;
 	struct rtw_ieee802_11_elems elems;
 	struct sta_info *pstat;
-	unsigned char 	reassoc, *p, *pos, *wpa_ie;
+	unsigned char 	*p, *pos, *wpa_ie;
 	unsigned char WMM_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
 	int		i, ie_len, wpa_ie_len, left;
 	unsigned char 	supportRate[16];
@@ -1040,10 +1040,8 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 	frame_type = GetFrameSubType(pframe);
 	if (frame_type == WIFI_ASSOCREQ) {
-		reassoc = 0;
 		ie_offset = _ASOCREQ_IE_OFFSET_;
 	} else { /*  WIFI_REASSOCREQ */
-		reassoc = 1;
 		ie_offset = _REASOCREQ_IE_OFFSET_;
 	}
 
-- 
2.31.1

