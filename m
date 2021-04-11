Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66B35B3FA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 14:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhDKMDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:03:36 -0400
Received: from smtp43.i.mail.ru ([94.100.177.103]:60002 "EHLO smtp43.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKMDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bk.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=OX7oViJaye4+NSKx+dD+o/4HXfIftGoE89IQBR2hOl4=;
        b=3Fz6LpfnLP8bHMtelyecSi/KFxjH/02RjR9a3exNO17h0n1H1/7+jrmD+HA/c7CVDugwXYTrvXPHKmy5+JMp7Ifu/ET3qPp7w05qDeb86E3L6jT50e9X3d9eDe/eYu+5piHAwN1oWvS84foH4Lk3h+quVR+7JsXPZ+AaU3esrf4=;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <dev.dragon@bk.ru>)
        id 1lVYo9-0004M8-Hv; Sun, 11 Apr 2021 15:03:17 +0300
From:   dev.dragon@bk.ru
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dmitrii Wolf <dev.dragon@bk.ru>
Subject: [PATCH] Staging: rtl8192u: ieee80211: remove odd backslash.
Date:   Sun, 11 Apr 2021 15:03:02 +0300
Message-Id: <20210411120301.6549-1-dev.dragon@bk.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp43.i.mail.ru; auth=pass smtp.auth=dev.dragon@bk.ru smtp.mailfrom=dev.dragon@bk.ru
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD92FFCB8E6708E7480B1C8842CE613979723F2FB4628545A35182A05F53808504064D3C9AB43714E7D21A4BAF7F1AA778DA0BDDD8068BB3330BC2CDE020D117FFF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE741A8F2705CF52F55EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E6006D770ADD73CF8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2FD8056875BFF59827A3F96AFEBBEFD1A8CCF7685675CC1A7D2E47CDBA5A96583C09775C1D3CA48CF90BCC82C2C62A6D1117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7A6779F98BF527B7A9FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE7C9E58C0C906532AED32BA5DBAC0009BE395957E7521B51C20BC6067A898B09E4090A508E0FED62991661749BA6B97735E232626130FC3433CD04E86FAF290E2D7E9C4E3C761E06A71DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C30588DA8EF868BA5E35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975CE44850EFB5864EA2D0AAFB0E09F388DA74D721AEEC26A4319C2B6934AE262D3EE7EAB7254005DCED246B04B1A760E0861E0A4E2319210D9B64D260DF9561598F01A9E91200F654B06CE7B4E551862B828E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3455049D7B43D89D64EA5D9EE90E0DB0D49B63E08C5680021BBD0BA0FB638E6A7D1454134F00BFDCB31D7E09C32AA3244C964FF1775E14ED9542F65364BA4FF53960759606DA2E136A927AC6DF5659F194
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojyKKJYJ15DtJLhyokL2VF5A==
X-Mailru-Sender: 3A338A78718AEC5AA85B3E7661095C1E481FC1F5A4328AA132777B7A48DB12AF2FF12F7FBD0243143833C6AC539110AEA432B8CD90067B65A6C5C4E98768B51D7AA22088860DD9FF5CDEF9E650933936342CD0BA774DB6A9AE208404248635DF
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitrii Wolf <dev.dragon@bk.ru>

This backslash should be deleted - looks like leftover and not needed.

Signed-off-by: Dmitrii Wolf <dev.dragon@bk.ru>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 690b664df8fa..25ea8e1b6b65 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2052,7 +2052,7 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 #else
 		if ((skb_queue_len(&ieee->skb_waitQ[queue_index]) != 0) ||
 #endif
-		    (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) || \
+		    (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) ||
 		    (ieee->queue_stop)) {
 			/* insert the skb packet to the wait queue */
 			/* as for the completion function, it does not need
-- 
2.25.1

