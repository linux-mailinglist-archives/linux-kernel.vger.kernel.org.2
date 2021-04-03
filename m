Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE8353335
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhDCJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbhDCJOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2225C06178C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e18so6533589wrt.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiJoR8904MIgGOKq2Ok4ZImHav3PFuYk8B2LeKcrr24=;
        b=B60Ly4RVxkdIhVjuJcoy47WPeYTRe18jBZU5eSSCbq6rtdtYm3dXa95A3EGqh4v9KU
         DMA73lQunAzBAgf7IZtcKmRoJp9197Q1IHRTaAJJRhzFa2jVxmw6kU9p8S6U59KYVaCr
         j/oIa2RBsVrcbW1AbIT2LdAm1ZyI4XgnleIqFKKsNsQAtEIoV8Cxplf5nM/1eFPKoo9o
         ug3I0SKmK0YIXvB1Tcx1i5b+5dtTlX0dWXOn6MRx50VO45IjR6ddDhbuwym7U6tl0yga
         qHt4RQc/f8IS4lHzOA3lFm+wA3+kgZP7qEB16wXX2aNzddHJE42Am1cquOdQV1c209XK
         cTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiJoR8904MIgGOKq2Ok4ZImHav3PFuYk8B2LeKcrr24=;
        b=ADbsTEGV/j/eJhYMq7SnFm6AFWZyZUKNaFbtBlCYMU9ObGlEtecGu0C49xWM9nMM8+
         4faRAfmSGM2qNs/bhEIRqPqp4b28qWCqaPWO0qF/uq9SrYepFP1o5hMsQNXvH9nIjOx2
         /LBs0czBD9yPzc66O8UGxm8uViRdSxF/TM/XN9Ka0757T2DpNoo58zBgG3eOt9FHHHz0
         rm4WjhBgTnrHtIR0JP053Qrr4qTC9Q7Ty34c2alK/wUkxMX4h0f3yI8Ratjv8MDDVB82
         xCBWq4EH1Bb4QqDbTLttuHNVh5dbdifR6ZrhHSRefNQHaSI+4u12ARMcm57F2ae+/3Tr
         DIrw==
X-Gm-Message-State: AOAM533OUds/imQd/8icmRjs22ZpOXmnHWINmWQVWf6oOBcRWppz0ECH
        nv3GuahUT6JEq/A8MNMmEVc=
X-Google-Smtp-Source: ABdhPJwc5Ag3BvWkx0B9nSoPWVXXQ7rwNXeQJkDBzgwi9ie37pi/sR9RiOo+QWLGOWJ1p0+5oGbjjA==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr19640431wrn.352.1617441279707;
        Sat, 03 Apr 2021 02:14:39 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id n1sm22335076wro.36.2021.04.03.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        David Carpenter <dan.carpenter@oracle.org>
Subject: [PATCH v3 16/30] staging: rtl8723bs: tidy up some error handling in core/rtw_mlme.c
Date:   Sat,  3 Apr 2021 11:13:38 +0200
Message-Id: <d8ad88bef77430107f8593091770b6a514b6f0e2.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the RT_TRACE() output is not useful so we want to delete it. In this case
there is no cleanup for rtw_cleanbss_cmd() required or even possible. I've
deleted the RT_TRACE() output and added a goto unlock to show
that we can't continue if rtw_createbss_cmd() fails.

Suggested-by: David Carpenter <dan.carpenter@oracle.org>
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

