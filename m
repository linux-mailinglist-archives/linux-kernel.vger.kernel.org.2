Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C0735B019
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhDJT3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 15:29:51 -0400
Received: from smtp34.i.mail.ru ([94.100.177.94]:54992 "EHLO smtp34.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234439AbhDJT3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 15:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bk.ru; s=mail3;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=NVQNe5HJEFG+sCU5DriGBxS+PhTSIpH38n/8WcR/Nvk=;
        b=5EOuIrLaTzdaprJOysj3jaieEcg5US8ApR2odDtQMu+7YqZU9vgtjrI4Proni5lfo9lVnRi5jw1rusO4heceBU8q3Wsf4FGcrvN6h9RFG9bcudXwrCWankmc11tXyxAiccgRjUzDdT6ZhMDIKq/Muva9+R8F0LEColDFD3F1+ME=;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <dev.dragon@bk.ru>)
        id 1lVJIR-0001P4-QM; Sat, 10 Apr 2021 22:29:32 +0300
From:   dev.dragon@bk.ru
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dmitrii Wolf <dev.dragon@bk.ru>
Subject: [PATCH] Staging: rtl8192u: ieee80211: remove odd backslash.
Date:   Sat, 10 Apr 2021 22:29:12 +0300
Message-Id: <20210410192911.47486-1-dev.dragon@bk.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp34.i.mail.ru; auth=pass smtp.auth=dev.dragon@bk.ru smtp.mailfrom=dev.dragon@bk.ru
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD92FFCB8E6708E7480B1C8842CE613979723F2FB4628545A35182A05F538085040FF61310D79CB51A52BB674D9DE483118A6A97FFC44C6662235A441C10B4E624F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77C1346FE4B18DC51EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379A6B93796C91DCB58638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2BF8FA2385D3E21523CF2B613DDF7A6BA06708AB62ED68B8ED2E47CDBA5A96583C09775C1D3CA48CF90D92131081DE748117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE77E7E81EEA8A9722B8941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD2697680F9384605B90301A9DF589746230F7B076A6E789B0E97A8DF7F3B2552694A1E7802607F20496D49FD398EE364050FC8105B04EFE0762849AF716F719AB83EB3661434B16C20AC78D18283394535A9E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6303687A6F40845FD089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-B7AD71C0: AC4F5C86D027EB782CDD5689AFBDA7A24209795067102C07E8F7B195E1C97831327F537E1C91DBDB8FF110C78C8E6CED
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975CE44850EFB5864EA21A5FB9C5559153C094588ABE9D3074C69C2B6934AE262D3EE7EAB7254005DCED246B04B1A760E0861E0A4E2319210D9B64D260DF9561598F01A9E91200F654B0588BE6097D4A97A98E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D348F343DA43F62289F7A98024701FA37CF0BEE00CC2FB6B7A97697D7E3D2828F911074C95A968694281D7E09C32AA3244C0E312B5E377A4D59CA0E2A6A242EC8DC853296C06374E602927AC6DF5659F194
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojqcJA+pXcDulXEjjFEiv68A==
X-Mailru-Sender: 3A338A78718AEC5AA85B3E7661095C1E7D2337A54B3DCD92E4366E813D35928D7D804C57934F49F93833C6AC539110AEA432B8CD90067B65A6C5C4E98768B51D7AA22088860DD9FF5CDEF9E650933936342CD0BA774DB6A9AE208404248635DF
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitrii Wolf <dev.dragon@bk.ru>

This backslash should be deleted - looks like leftover and not needed.
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

