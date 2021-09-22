Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA2415100
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbhIVUH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbhIVUHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF4BC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t7so10279978wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zdg0ApDj4T40ceOwnYh8jnghOBBg9kMORnILNtCiL9U=;
        b=Rla5l0Yxy4lbAhh6y+O1KYmWzVSaCfdlrdJ/OWwwupp31cjx+/EjnFbGmTEvmjq1i9
         R87GJ3hLHH8g9kQZztyikIksGfMHACWQNRpg3Dr/rP5ytEyqTZFOmJiirvB10Wm1hA87
         TRolSYs4eW+h2Lk6bQrGT9bBGMgqTKmg1Z0OEXggHNMzX9JBk0ypLqVScuRGjbqD/ORP
         dGVFGbI81OGPxbj1D0WjkRZDlWVThV98Ln83kdjnrOP/WtVbamPG5PnNJDT7uaUe1Gma
         oUlF6k4aJeFr4ti6CWIBTlA92eMe69u78n4yIWJ9jvK+7LjZLzBNvIQgtwNCii3VdgnZ
         7k4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zdg0ApDj4T40ceOwnYh8jnghOBBg9kMORnILNtCiL9U=;
        b=yD6r9qcpl3CqGI+42Xy99So53AnBlkc1py6cEg2pwtjyhIlKdDwiBeJFxlwAkMpo+V
         lrEILf+EQRdfH6e7EtvyjG5U0UX5qTsTRNuAk/ZksMLOnY0w5Js9CZ7r+QJGbmWJZkcs
         VaYMXw2u+Bto8rN+VWrSkMdAemzx29OgNV3TzomGUWa+0Ew1Q9YN9HGeWMT07Q8efrOA
         uJQOdLlbhjdGCzxnBM7TqZGnpDjG3W2sB+mujcZie5xg3Ef1noIbnZvlt7BOC1mrRd1m
         NzAGPVdlQFqr5Vnt4EAowmWr1LytTp/7KGVhBkEc2dP9Gek+QhINOqs9PW1dwIWJyZqM
         8ruQ==
X-Gm-Message-State: AOAM530ZLGN7815zD6398F0yS+rbAnjBBinRqJE+4UPddFVJUPnvtYeC
        am/6BBDUovmK+9Cv7O7Tbuo=
X-Google-Smtp-Source: ABdhPJzuDBrdXSgertbvORZzAVOIt3mC6Rd0p132EE4uLSvZWDC5IeDVvPCCESdOgxjfKSZvbTflAA==
X-Received: by 2002:a05:6000:1a52:: with SMTP id t18mr871746wry.21.1632341137711;
        Wed, 22 Sep 2021 13:05:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 14/47] staging: r8188eu: remove issue_probereq_p2p_ex()
Date:   Wed, 22 Sep 2021 22:03:47 +0200
Message-Id: <20210922200420.9693-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function issue_probereq_p2p_ex() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 37 -------------------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 -
 2 files changed, 39 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index c35ca002b63f..905e7f0b83d1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3690,43 +3690,6 @@ inline void issue_probereq_p2p(struct adapter *adapter, u8 *da)
 	_issue_probereq_p2p(adapter, da, false);
 }
 
-int issue_probereq_p2p_ex(struct adapter *adapter, u8 *da, int try_cnt, int wait_ms)
-{
-	int ret;
-	int i = 0;
-	u32 start = jiffies;
-
-	do {
-		ret = _issue_probereq_p2p(adapter, da, wait_ms > 0);
-
-		i++;
-
-		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
-			break;
-
-		if (i < try_cnt && wait_ms > 0 && ret == _FAIL)
-			msleep(wait_ms);
-	} while ((i < try_cnt) && ((ret == _FAIL) || (wait_ms == 0)));
-
-	if (ret != _FAIL) {
-		ret = _SUCCESS;
-		goto exit;
-	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(adapter), da, rtw_get_oper_ch(adapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
-		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(adapter), rtw_get_oper_ch(adapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt, rtw_get_passing_time_ms(start));
-	}
-exit:
-	return ret;
-}
-
 static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 {
 	struct adapter *adapter = recv_frame->adapter;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 89020f828e08..5b307ad3afa5 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -541,8 +541,6 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid,
 				 u8 ussidlen, u8 *pdev_raddr);
 void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr);
 void issue_probereq_p2p(struct adapter *padapter, u8 *da);
-int issue_probereq_p2p_ex(struct adapter *adapter, u8 *da, int try_cnt,
-			  int wait_ms);
 void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr,
 				   u8 dialogToken, u8 success);
 void issue_p2p_invitation_request(struct adapter *padapter, u8* raddr);
-- 
2.33.0

