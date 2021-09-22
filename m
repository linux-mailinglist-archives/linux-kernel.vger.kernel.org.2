Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD5415103
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbhIVUHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbhIVUHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B26C061768
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d6so10290073wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBoZB6IPnDzP6Z2VHwZ4zwFC4j+SMIijYS+PLeU5dtg=;
        b=Y/x+r6lD5cYg3h5FLPDTx9DX0jlKGe/N/wPJDdhSBCPN0SmkbCfRytphYqPfGAC1ZK
         Q/YDtpwHbuLSn/xoZgKtJ8n0jBh6O16qId/J/CPUS/mG83PeE78ynkz7g7WZxWhKMBe4
         XWFc1t0zNTX4FyQwl1MJtT0IxyQkva99ngeUsyhfqavq3pmahTrvaV/bqqYz32bvzr/o
         DmyFMmTNW2VClTt9X5YxJ8V8fmt7f1WhJUe6JWhnlHi6bjZ5e+mMCbxSELuv0/AGguWn
         g9fEzH2Q7eqsvQwaqKi4Rhsl3dEXx69JUFxtvtfnyMea+PNv13SoA7lJ1IhPufl08ZIF
         gNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBoZB6IPnDzP6Z2VHwZ4zwFC4j+SMIijYS+PLeU5dtg=;
        b=6XEa6m7Bh/FAVTTW6ANu7WQOvkzKwZit+pGltrHUn7B1kBkdYSWfRJSSL1vwkVopJt
         9sckX2l7oq5rlQowoUsOfM2lA1t2zUFRzRbC0qP+uyUjAgMeyiPY6uT6D83KHfpP/jSL
         QxXZdT/hyq3XE4xBvX+9tjOlwyiDwQic0aAFIOFAIlE3+mTkfK3X3AcExTkVjr/ArANs
         GDP+fvF/w3J1ZlsEG99Ug8pZlieXEVGNojE/SSYAvZjMFgCVMkLHl7SCgqGn1BkGXw49
         WLsSumNkFupGHFCGHXgsLcaghDyD1Bh3ehownbL3BmN+ilLpm7Klx5vmzD9ByEIfoxpm
         R64w==
X-Gm-Message-State: AOAM530qXjg9dRxBJj0ZFBaelX3XSQBYlhvuzcYM5mXW/hjTiLAOFBsQ
        TogI5SD9XGq7F0dzqE+aXfc=
X-Google-Smtp-Source: ABdhPJxhv6/PN/ZF56m2oN3xBpX95/hcpPKNox0zpEkbEleST4iJ9HEJgjk2LtsYXiei5uyiCssFCQ==
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr12528883wmj.155.1632341144012;
        Wed, 22 Sep 2021 13:05:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 19/47] staging: r8188eu: remove rtw_set_802_11_remove_key()
Date:   Wed, 22 Sep 2021 22:03:52 +0200
Message-Id: <20210922200420.9693-20-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_set_802_11_remove_key() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  | 37 -------------------
 .../staging/r8188eu/include/rtw_ioctl_set.h   |  2 -
 2 files changed, 39 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index afa72b21fc0b..219d579a853f 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -492,43 +492,6 @@ u8 rtw_set_802_11_remove_wep(struct adapter *padapter, u32 keyindex)
 	return ret;
 }
 
-u8 rtw_set_802_11_remove_key(struct adapter *padapter, struct ndis_802_11_remove_key *key)
-{
-	u8 *pbssid;
-	struct sta_info *stainfo;
-	u8	bgroup = (key->KeyIndex & 0x4000000) > 0 ? false : true;
-	u8	keyIndex = (u8)key->KeyIndex & 0x03;
-	u8	ret = _SUCCESS;
-
-	if ((key->KeyIndex & 0xbffffffc) > 0) {
-		ret = _FAIL;
-		goto exit;
-	}
-
-	if (bgroup) {
-		/*  clear group key by index */
-
-		memset(&padapter->securitypriv.dot118021XGrpKey[keyIndex], 0, 16);
-
-		/*  \todo Send a H2C Command to Firmware for removing this Key in CAM Entry. */
-	} else {
-		pbssid = get_bssid(&padapter->mlmepriv);
-		stainfo = rtw_get_stainfo(&padapter->stapriv, pbssid);
-		if (stainfo) {
-			/*  clear key by BSSID */
-			memset(&stainfo->dot118021x_UncstKey, 0, 16);
-
-			/*  \todo Send a H2C Command to Firmware for disable this Key in CAM Entry. */
-		} else {
-			ret = _FAIL;
-			goto exit;
-		}
-	}
-exit:
-
-	return ret;
-}
-
 /*
 * rtw_get_cur_max_rate -
 * @adapter: pointer to struct adapter structure
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
index 3f4b4873eb98..6203f49f8bf7 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl_set.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
@@ -20,8 +20,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *adapter,
 				      enum ndis_802_11_network_infra type);
 u8 rtw_set_802_11_remove_wep(struct adapter *adapter, u32 keyindex);
 u8 rtw_set_802_11_ssid(struct adapter *adapt, struct ndis_802_11_ssid *ssid);
-u8 rtw_set_802_11_remove_key(struct adapter *adapt,
-			     struct ndis_802_11_remove_key *key);
 u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
 u16 rtw_get_cur_max_rate(struct adapter *adapter);
 int rtw_set_scan_mode(struct adapter *adapter, enum rt_scan_type scan_mode);
-- 
2.33.0

