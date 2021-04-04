Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21E353863
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhDDOK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhDDOKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12987C06178C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k8so8784462wrc.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9W8PbQLkq/rfbEk2baDBFEd4Rx3S1AqPsnjoKp+jho=;
        b=C8oIZlVfHlHfpOWSNZAExRurGEx/nNZ62GzajCrd965cp5mOPivKyAdtE+kPtu+kAv
         ERbktcg4LABxE+UxNcGVrbbHPzNxQb7mawIvj41soFiEIakbgSBlszCrnRR81zTpzye9
         oKslgdnahAd2JfuTXGLhcYdzCNxPI9JJNaTsFPQtu7JpVS4IKlwdda8znJ72dCnJc3yU
         jmLS7Hx4uODnZtWsK9R84XvLUVv5YAzbL098ildLQFKl53zQ6EpXZkEq1VIIT+y6PYvD
         hsPnugr8/h0WiEV3/Xg94lCL/DG4bp3/dttkWvH9WqtylvznfUiIKJjWNJUdWWblk0PR
         zQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9W8PbQLkq/rfbEk2baDBFEd4Rx3S1AqPsnjoKp+jho=;
        b=dX9j/WZMEHhrIAJ54JY3CEutu9zBj93jajCHGkOwZiIDL0GQPmkl44O/olf7sHwpSN
         3a1lDYIhzjBzYDiXWwOtcV0vddru8g8+G0gacELfmC/sctyHyM3dD4gZrDetkP3HJ9nX
         +X2MLleWou7UqM6g5jIdBaAwmlYAckNIMlx+5Ycd2IaaOAZ8JWJOoYvYZHU5HU753akl
         1ieQTaitcSirTeD4inSlVV5+eekmCh1Gdzy8k6dFH5Abe3oYK8WCeS49I6GK/2uuFFR9
         eIfni8mAcOfevUNvJiwLw9wySiGtUQG95+cBMFsuqNBockCB51ydL9Cy0fNufVmk8U3g
         tjSw==
X-Gm-Message-State: AOAM533607SkB9KMJgf25XZSi2klBNBnu/DL1kXazBUubtAPzxc0WyUK
        T3ksk/lpEFbpqCwjC3I/dcc=
X-Google-Smtp-Source: ABdhPJwIMrZwOtwAP1QO0WXL8O54sGT4F/O0GjmcOofZeKf/yEgGHzIrPZmpiseohNw8oy41Y/8Fkw==
X-Received: by 2002:adf:f908:: with SMTP id b8mr24179364wrr.184.1617545416896;
        Sun, 04 Apr 2021 07:10:16 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id m14sm19861467wmi.27.2021.04.04.07.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 16/30] staging: rtl8723bs: tidy up some error handling in core/rtw_mlme.c
Date:   Sun,  4 Apr 2021 16:09:32 +0200
Message-Id: <6affc9dd905f7c94a93bbd0fa706bc9026103c2e.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the RT_TRACE() output is not useful so we want to delete it. In this case
there is no cleanup for rtw_cleanbss_cmd() required or even possible. I've
deleted the RT_TRACE() output and added a goto unlock to show
that we can't continue if rtw_createbss_cmd() fails.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index e8a39519fed8..e6bced0269b1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -815,6 +815,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				if (rtw_select_and_join_from_scanned_queue(pmlmepriv) == _SUCCESS) {
 					_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 				} else {
+					u8 ret = _SUCCESS;
 					struct wlan_bssid_ex    *pdev_network = &(adapter->registrypriv.dev_network);
 					u8 *pibss = adapter->registrypriv.dev_network.MacAddress;
 
@@ -828,10 +829,11 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
-					if (rtw_createbss_cmd(adapter) != _SUCCESS)
-						;
-
 					pmlmepriv->to_join = false;
+
+					ret = rtw_createbss_cmd(adapter);
+					if (ret != _SUCCESS)
+						goto unlock;
 				}
 			}
 		} else {
@@ -877,7 +879,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	}
 
 	/* DBG_871X("scan complete in %dms\n", jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time)); */
-
+unlock:
 	spin_unlock_bh(&pmlmepriv->lock);
 
 	rtw_os_xmit_schedule(adapter);
@@ -1564,6 +1566,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 		rtw_free_stainfo(adapter,  psta);
 
 		if (adapter->stapriv.asoc_sta_count == 1) {/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
+			u8 ret = _SUCCESS;
 			/* rtw_indicate_disconnect(adapter);removed@20091105 */
 			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 			/* free old ibss network */
@@ -1591,12 +1594,14 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 				_clr_fwstate_(pmlmepriv, WIFI_ADHOC_STATE);
 			}
 
-			if (rtw_createbss_cmd(adapter) != _SUCCESS)
-				;
+			ret = rtw_createbss_cmd(adapter);
+			if (ret != _SUCCESS)
+				goto unlock;
 		}
 
 	}
 
+unlock:
 	spin_unlock_bh(&pmlmepriv->lock);
 }
 
-- 
2.20.1

