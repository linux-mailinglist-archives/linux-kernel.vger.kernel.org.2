Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552DE36F82C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhD3JyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhD3JyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:54:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294DAC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 02:53:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d14so18099584edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8rYa6uc2lMrcOYnMsUxtzNfzc4dHA6oZT2T6vUtpxM=;
        b=JYCxRRsmeZwUeuImQ6GjgOoTvXLEiyjGQjbjspl0jWf5cuSeF3n7EoVM2d5sASHdBi
         4jOzo5h8eTlE4WyingaYDxYZgRCo0rCoD71a1bQz5dSlQ1lyBtEcroHBHGyLx42C+54F
         ulxS6ja3X9Vf6yLglEQjq3BFxiAGdzz4LYpmHVN3ipiOaSCPW9Mi5SZ1dUsFGauSx9sB
         AO0SC193b/YcT1bFtyQlnLYvUMqz0WMqxguBh0OezzdXpEW9bvO43MuWHO+CdHuwZWTG
         IadOx/DYLxZaGjwfph5p+ru8yUlt8bdvduXcpPmz7mzZrdWS4YoMtkQ1fXFfEaozDtQB
         HJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8rYa6uc2lMrcOYnMsUxtzNfzc4dHA6oZT2T6vUtpxM=;
        b=fMQV6+NrBjPz/ee43MgFypz8UTXuHmty1rsk8PjvGDldHnyObnjQmorqimsM9m0T17
         20oldrlITgvtpB7mXDq/EJuTa+gJuVHvbkgFvcBx72HVgzxHUeHzZ8yzAT0jhxvh2rqx
         rhRg4Mk1OONW1oiWKkXcq9QQRL44LY1EcMQXGW7SYk8vyj57MRihiOUuyDE48szCC91l
         xMQgKGuLjIfvAOsBZQBSTwQEtDAOH8XxMSKeXCNY9Dw2Xowf509PylFUu4h075MYZ/7E
         Qj9Xp+b73tGmHL8AwL15lWirP7VMtNsQ1sdTUiR6SVsmS1i0o9rn3kyTZRb26T1XBIdC
         EUDA==
X-Gm-Message-State: AOAM532JM8+EoHXik0v48gzW8bwVWF8hAXzDCW+ec4ZbrKHHIQtCeGDx
        XpKPEKw+AIH0NR+nIqVTMuI=
X-Google-Smtp-Source: ABdhPJydtdabmCx6hBAui52nCvSWUFHSCHT7XdphNM2V6GUHblMsa0egYvxz2FVyJKbu0EmTnm/itw==
X-Received: by 2002:a05:6402:17fc:: with SMTP id t28mr4833221edy.283.1619776408947;
        Fri, 30 Apr 2021 02:53:28 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id f30sm1626861ejl.62.2021.04.30.02.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 02:53:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2 2/2] staging: rtl8723bs: core: Remove set but unused variable
Date:   Fri, 30 Apr 2021 11:53:19 +0200
Message-Id: <20210430095319.23226-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430095319.23226-1-fmdefrancesco@gmail.com>
References: <20210430095319.23226-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed set but unused variable. Issue detected by gcc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v1: As suggested by Dan Carpenter, removed no more needed 
curly braces around single statement blocks.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a2fdd5ea5fc4..4df03f0a1242 100644
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
@@ -1039,13 +1039,10 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		return _FAIL;
 
 	frame_type = GetFrameSubType(pframe);
-	if (frame_type == WIFI_ASSOCREQ) {
-		reassoc = 0;
+	if (frame_type == WIFI_ASSOCREQ) 
 		ie_offset = _ASOCREQ_IE_OFFSET_;
-	} else { /*  WIFI_REASSOCREQ */
-		reassoc = 1;
+	else /*  WIFI_REASSOCREQ */
 		ie_offset = _REASOCREQ_IE_OFFSET_;
-	}
 
 
 	if (pkt_len < sizeof(struct ieee80211_hdr_3addr) + ie_offset)
-- 
2.31.1

