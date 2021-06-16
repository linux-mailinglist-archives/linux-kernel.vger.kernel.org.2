Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD20B3A94C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhFPILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:11:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4943 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhFPILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:11:00 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4d6H4DBRz6yfn;
        Wed, 16 Jun 2021 16:05:43 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 16:08:53 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 16:08:52 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH -next 1/3] staging: rtl8723bs: os_dep: use eth_broadcast_addr() to assign broadcast address
Date:   Wed, 16 Jun 2021 16:12:41 +0800
Message-ID: <20210616081243.2511663-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616081243.2511663-1-yangyingliang@huawei.com>
References: <20210616081243.2511663-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using eth_broadcast_addr() to assign broadcast address instead
of memset() or copying from an array that contains the all-ones
broadcast address.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 5 ++---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index cb605351ac8d..727c9fdad06a 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -229,7 +229,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	size_t len, bssinf_len = 0;
 	struct ieee80211_hdr *pwlanhdr;
 	__le16 *fctrl;
-	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	struct wireless_dev *wdev = padapter->rtw_wdev;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -310,7 +309,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	/* pmlmeext->mgnt_seq++; */
 
 	if (pnetwork->network.Reserved[0] == 1) { /*  WIFI_BEACON */
-		memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
+		eth_broadcast_addr(pwlanhdr->addr1);
 		SetFrameSubType(pbuf, WIFI_BEACON);
 	} else {
 		memcpy(pwlanhdr->addr1, myid(&(padapter->eeprompriv)), ETH_ALEN);
@@ -960,7 +959,7 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	memset(param, 0, param_len);
 
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
-	memset(param->sta_addr, 0xff, ETH_ALEN);
+	eth_broadcast_addr(param->sta_addr);
 
 	switch (params->cipher) {
 	case IW_AUTH_CIPHER_NONE:
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 149d3b6e44d0..5032701171f6 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -1915,7 +1915,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 		return -1;
 
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
-	memset(param->sta_addr, 0xff, ETH_ALEN);
+	eth_broadcast_addr(param->sta_addr);
 
 
 	switch (pext->alg) {
-- 
2.25.1

