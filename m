Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAFD3CC3E4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhGQPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbhGQO7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:59:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B15C061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:56:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t5so15505455wrw.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PG9JbnafFmHtkZy14fnZvsQtgBLImOnC9bogzsBO68Q=;
        b=RFsI2ll5+UdyKPuWwUqUUwYxkgBONNzratmatXScsj7NBEZQ/hwCmCQkb7eHYMWiOt
         KqieA9MzQejZlS9vuxs5kGBabrygLCJ+5IOF9tByNu9sZdnl2i0Y75KtEUYGxsztlnTL
         7GPzjRSOuxyhdsAulXehqmDUlqd6K1Tl9qge5kBcmfA+zysS9c76GGNw/GqIgbDl5GBp
         ahsSM/uKJUSt0HyDRSeRuVR+b50Pu80zF5yZjbPQ+5WmHbgcXFL0ojGCYb5375PQYNRo
         vr83ERR/vugkTiHYCtN+S7ge5Tm1DgMYgptmuhYLTvW1wfuoLVn5MtQtPgJD1W8wT6F8
         dHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PG9JbnafFmHtkZy14fnZvsQtgBLImOnC9bogzsBO68Q=;
        b=SYo8VWzZqQcgRzer8rg8sRQllbiEnKLCHOdijln3T1XwPjHeqwytKU6ruLZoMUpusp
         A5E1YtqFiJ1skKzcatHGc4aGZwysMJGvpThBe38QZR78fTN2TV63hfYrH/1OA8aKPTah
         QTxZvUGeUFZLKRj3O9ISunZn9bwl1WFXsU/o5Rz38sse1atO7Q7DpLKJX+o7w87wkLin
         bsymdszNtcgreMAdKuADGkFTyBlI7C7nLoYkPkIypoYxWWJVDxC5p/hZ7zdA/RW7WMog
         ZHpITmjZml04GttSXBrXLg5HQsbcZMwdCMIkm0B4tbm4OD9JGv9ABWbMP6HPeXjCpNmu
         M3WQ==
X-Gm-Message-State: AOAM532hnRs4M2bacobbSkOk25wgO6skhSucQBz0+3LKodwJHuFPb048
        TXMhWOeSbAc5ApDi1eWG+P/0N2gCQpE=
X-Google-Smtp-Source: ABdhPJxuLpdmUtg+RbcD7qLaX/bF8MwSIDA6tL7prxf69xpskJmFbx1jaxkfGG67szTPNz/JbVMBSg==
X-Received: by 2002:a05:6000:180f:: with SMTP id m15mr19173087wrh.388.1626533815015;
        Sat, 17 Jul 2021 07:56:55 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id o5sm9895469wms.43.2021.07.17.07.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:56:54 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] staging: rtl8723bs: add get_channel cfg80211 implementation
Date:   Sat, 17 Jul 2021 16:56:42 +0200
Message-Id: <2f00479d8369b82b590291bb0edf27bc3041b0f0.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626533647.git.fabioaiuto83@gmail.com>
References: <cover.1626533647.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add get_channel cfg80211 implementation to let userspace
programs rely on nl80211 protocol to display channel
information.

Old iw dev output:

phy#0
	Interface wlan0
		ifindex 2
		wdev 0x1
		addr 34:c3:d2:73:eb:c7
		ssid Fabio
		type managed
		txpower 12.00 dBm

Fixed output:

phy#0
	Interface wlan0
		ifindex 2
		wdev 0x1
		addr 34:c3:d2:73:eb:c7
		ssid Fabio
		type managed
	new-->	channel 11 (2462 MHz), width: 20 MHz, center1: 2462 Mhz
		txpower 12.00 dBm

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 53 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index fd747c8d920e..d198d10ec272 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2100,7 +2100,58 @@ void rtw_cfg80211_indicate_sta_disassoc(struct adapter *padapter, unsigned char
 	cfg80211_del_sta(ndev, da, GFP_ATOMIC);
 }
 
+static u8 rtw_get_chan_type(struct adapter *adapter)
+{
+	struct mlme_ext_priv *mlme_ext = &adapter->mlmeextpriv;
+
+	switch (mlme_ext->cur_bwmode) {
+	case CHANNEL_WIDTH_20:
+		if (IsSupportedHT(adapter->registrypriv.wireless_mode))
+			return NL80211_CHAN_HT20;
+		else
+			return NL80211_CHAN_NO_HT;
+	case CHANNEL_WIDTH_40:
+		if (mlme_ext->cur_ch_offset == HAL_PRIME_CHNL_OFFSET_UPPER)
+			return NL80211_CHAN_HT40PLUS;
+		else
+			return NL80211_CHAN_HT40MINUS;
+	default:
+		return NL80211_CHAN_HT20;
+	}
 
+	return NL80211_CHAN_HT20;
+}
+
+static int cfg80211_rtw_get_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
+				    struct cfg80211_chan_def *chandef)
+{
+	struct adapter *adapter = wiphy_to_adapter(wiphy);
+	struct registry_priv *registrypriv = &adapter->registrypriv;
+	enum nl80211_channel_type chan_type;
+	struct ieee80211_channel *chan = NULL;
+	int channel;
+	int freq;
+
+	if (!adapter->rtw_wdev)
+		return -ENODEV;
+
+	channel = rtw_get_oper_ch(adapter);
+	if (!channel)
+		return -ENODATA;
+
+	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
+
+	chan = ieee80211_get_channel(adapter->rtw_wdev->wiphy, freq);
+
+	if (registrypriv->ht_enable) {
+		chan_type = rtw_get_chan_type(adapter);
+		cfg80211_chandef_create(chandef, chan, chan_type);
+	} else {
+		cfg80211_chandef_create(chandef, chan, NL80211_CHAN_NO_HT);
+	}
+
+	return 0;
+}
 
 static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struct net_device *ndev)
 {
@@ -2838,7 +2889,7 @@ static struct cfg80211_ops rtw_cfg80211_ops = {
 	.set_pmksa = cfg80211_rtw_set_pmksa,
 	.del_pmksa = cfg80211_rtw_del_pmksa,
 	.flush_pmksa = cfg80211_rtw_flush_pmksa,
-
+	.get_channel = cfg80211_rtw_get_channel,
 	.add_virtual_intf = cfg80211_rtw_add_virtual_intf,
 	.del_virtual_intf = cfg80211_rtw_del_virtual_intf,
 
-- 
2.20.1

