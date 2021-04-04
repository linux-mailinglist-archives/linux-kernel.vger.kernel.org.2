Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C8C353840
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 15:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhDDN0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 09:26:41 -0400
Received: from smtp30.i.mail.ru ([94.100.177.90]:54618 "EHLO smtp30.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229762AbhDDN0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 09:26:40 -0400
X-Greylist: delayed 29476 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Apr 2021 09:26:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bk.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=LETLziB89uAsZr/rmV4CuXtr79aw/vQw4ui4/Ykg9Uc=;
        b=glPOtMyTc1maVspYGvt5XkL3G4zmZSsitREZFcdOBFwOP1dMkj6uFUmlt1tFBgfEjEvE87XHnVAEa1nzjMeZRJY2dDCUuyVSurpwCi6PpTsen2eX2c5dP+CYiArZrb40h394HAkVLmMdYUkjaItCSP+Kn2CdscWzBQK4c8VO5ss=;
Received: by smtp30.i.mail.ru with esmtpa (envelope-from <dev.dragon@bk.ru>)
        id 1lT2lt-0005U2-6l; Sun, 04 Apr 2021 16:26:33 +0300
From:   dev.dragon@bk.ru
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dmitrii Wolf <dev.dragon@bk.ru>
Subject: [PATCH] Staging: rtl8192u: ieee80211: fixed a trailing statements of condition.
Date:   Sun,  4 Apr 2021 16:26:14 +0300
Message-Id: <20210404132613.5464-1-dev.dragon@bk.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp30.i.mail.ru; auth=pass smtp.auth=dev.dragon@bk.ru smtp.mailfrom=dev.dragon@bk.ru
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9ED7173E37F4E32947A0146560F8BA709E798FFD99D1B1662182A05F5380850403967E96E3DE147F8331AD8EC2CB116954496268119EDB3AD14DD9F9E918497C5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70EEC24FFE855BCBBC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7A3295C83650092F9EA1F7E6F0F101C67CDEEF6D7F21E0D1D174C73DBBBFC7664701A8C483038278B45BC77A840DD08DAC7F7CB36A5DC4E70389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C06CDB2E15ACB7FB748941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6F657401E1635F1D7CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C224929E57CDFA355096D76E601842F6C81A12EF20D2F80756B5F7E9C4E3C761E06A776E601842F6C81A127C277FBC8AE2E8B00B2ECFB950381B23AA81AA40904B5D9DBF02ECDB25306B2201CA6A4E26CD07C3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE493B89ED3C7A6281781AD05CC21270DE0F1C4224003CC83647689D4C264860C145E
X-B7AD71C0: 2623F767319EFA42AC98609FCEE262F9192335DD689A58EBAE0174B7F1092AFBF63472D858672956A8BD931D03E43403
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975C16EE06F5A270FE6A004883401E3217AA749839F795C915209C2B6934AE262D3EE7EAB7254005DCED246B04B1A760E0861E0A4E2319210D9B64D260DF9561598F01A9E91200F654B01098AAFFB0A1231D8E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D342E8FEDBD32DECB6DCE105F9E184D158104676EC26861AE2B017C6C7D7991F9E4213AF6172ED321DC1D7E09C32AA3244C1E4426A78A9BC1B2A183BDA071234B61250262A5EE9971B0927AC6DF5659F194
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt47dm/981n61iGJGd7Ky2w==
X-Mailru-Sender: 3A338A78718AEC5AA85B3E7661095C1E3A251DAE66DFBBCB3DCDCC9E291E8445BCBED4EBA2EB499A3833C6AC539110AEA432B8CD90067B65A6C5C4E98768B51D7AA22088860DD9FF5CDEF9E650933936342CD0BA774DB6A9AE208404248635DF
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitrii Wolf <dev.dragon@bk.ru>

Fixed a coding style issue.

Signed-off-by: Dmitrii Wolf <dev.dragon@bk.ru>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 690b664df8fa..29a6ce20e2bd 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2048,12 +2048,12 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 	/* if xmit available, just xmit it immediately, else just insert it to the wait queue */
 	for (i = 0; i < txb->nr_frags; i++) {
 #ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
-		if ((skb_queue_len(&ieee->skb_drv_aggQ[queue_index]) != 0) ||
+		if ((skb_queue_len(&ieee->skb_drv_aggQ[queue_index]) != 0)
 #else
-		if ((skb_queue_len(&ieee->skb_waitQ[queue_index]) != 0) ||
+		if ((skb_queue_len(&ieee->skb_waitQ[queue_index]) != 0)
 #endif
-		    (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) || \
-		    (ieee->queue_stop)) {
+		 || (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) \
+		 || (ieee->queue_stop)) {
 			/* insert the skb packet to the wait queue */
 			/* as for the completion function, it does not need
 			 * to check it any more.
-- 
2.25.1

