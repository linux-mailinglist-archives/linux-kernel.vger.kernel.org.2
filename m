Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7993C86B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbhGNPOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbhGNPOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:14:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC1CC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:11:18 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j34so1795497wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PG9JbnafFmHtkZy14fnZvsQtgBLImOnC9bogzsBO68Q=;
        b=UJHtGb+LwT0zy+L/w6Ws5+yY2JPkV63zglgb0IsBrakD8/DQb3oxW+jfRfWRXeV3sA
         XuNeWFY/VynF2aMjgD5Biww9AGapOiJEkICLuGz5j405P5GZu5eOEgDotEoo+DnXl4sP
         n1kbLVclzkqmbyaW06cUJON9PY169JskS/PexQZeC89o0IgwO2MsHYGGct4yE7vq6DW5
         y3ZRkLdKfEpaaxyIbyGUjl390RvQlcbsC+eIOyZjPZngiMiL3GLMB9mGC8bOS8d/p8VY
         NhuvpyP1O1lCl+IdeGFn5NfwOu0VbJsB39Jf5SO/MiQZyPSWBJB13sAnGH4m+NavqlrP
         zczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PG9JbnafFmHtkZy14fnZvsQtgBLImOnC9bogzsBO68Q=;
        b=FkNOnpI+5aaIlZjYDh8GCn6cV9gq3MMDdMT1+beoCMAp9jzDbVwyKX0WyEB7b7TiyM
         Oe7p0PW4DlTNX3qmyJZQupjZgMtFng37Qld1gKmGYRZFa3Gz6dp0UeAa5rbl7iQo7hKX
         yCxKdHajs2fuSNlJ9wydKfMBTQrpW2sKK/e+kylWzHrOQJfKn5+pU+gcOLsgjExQnQ7T
         eS9J1WCX95tjPmSzPLNPVOfq2wJKbiBR8WZyc0KrGH1/QFMMuUXHC6yqZGLT5tRMetrP
         cFU/QXbTrqXM2O9Y54XHG/P/XT3mFfHMpKkFuW9URro26gEntSl/LLiQqwPxj0KAtg23
         OBwQ==
X-Gm-Message-State: AOAM531EinWduz+eSzZ/Kg4tS2dy62ZzWCNRM9e/u+j+2mqQCvIoj5e/
        rMZnAyb/jFSqWrjs4zaNGm1bT6HX2Nw=
X-Google-Smtp-Source: ABdhPJycD2OfxuPLYOiMg17H0K8RT5chzlF2QRpfN7l5Bx119sJzeU/7EJNbS6Q57qu5ONnRtiNZfQ==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr11833020wmi.36.1626275477293;
        Wed, 14 Jul 2021 08:11:17 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id c125sm6610982wme.36.2021.07.14.08.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:11:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: rtl8723bs: add get_channel cfg80211 implementation
Date:   Wed, 14 Jul 2021 17:11:12 +0200
Message-Id: <2f00479d8369b82b590291bb0edf27bc3041b0f0.1626275102.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626275102.git.fabioaiuto83@gmail.com>
References: <cover.1626275102.git.fabioaiuto83@gmail.com>
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

