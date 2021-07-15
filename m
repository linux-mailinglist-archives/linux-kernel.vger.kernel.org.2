Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B6D3CA103
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbhGOO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhGOO76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:59:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ECBC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:57:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a13so8154866wrf.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trFt9B5wK6xRGkrNN9eahQdfcGvBp0la1dk04lJiCpA=;
        b=N0PiPgjjUGfonhDvn999uJM5dv2ffJGFzIFkBawjQu6MznQ+XM5kkPc7WUKVwZNexp
         GdGY3McFMe/FZL4RACPyN22JiU+LUiXVrJWFOS4BbwIKCzFMlJe1j6epOavVrBvw4Ivu
         vPKHnjtnk0kS+gkBABCTMLn1+5fQ35luyeeHNRcFKwjlXVes0iiW/6cLqAlJQFSfDJBA
         jKH2UgXvnXcc/G4g/q+u9llB3NOW0AFNcmaQcjw9DJrfT9M29PFCKlmb1SU1LwYNxVtU
         gMz2Hi4Y34GOK3/Fe8tGtZJz7quzG1l5xVVY5gBlvKH+rlO3/juHyHzf/XpShPKZj1x9
         Np0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trFt9B5wK6xRGkrNN9eahQdfcGvBp0la1dk04lJiCpA=;
        b=gqIik31NWX2POE6FxqQ8wnVakmRmeGzHIMehcHGWv1OP89mggtuIdqTjlliAhmkjrj
         1kLzEol0X7xIuj/JlQItiDutdg3kXDzXVNu1sSrcTlmh/hU4W2Jf4qscp7CqWQDjWT4z
         y/XTifuwD+ixvBhd3sR3vcHJI9H8OXeU10DXjW4FeF/5ocE/Qji6f4zdHosBZz3/RfQo
         sEF7mINFhYpXtxCyh+dWIeM4mnhvlLyqv6FtfWR/mo82dWn9DOAuBqmvhAc236qr9Ifk
         vHnuojonAb5xlF6LyTcwrFQXKL0LDwcNJOlJjXio9gi3fLZNR9thoWnoZo+nVI+mAARV
         mU6Q==
X-Gm-Message-State: AOAM533NKJVsFoEK1LYQNOfc1nIaEEku9qzQGOkZCYQJT8AuMGIy0tV2
        b8y3goDv0j6aZrZeJGj098E=
X-Google-Smtp-Source: ABdhPJy/vYIUvT1bf/Kh0W3foAhW2hrzKAzpUKwGsi7FwSshJNKMretk9weUK1ZwXYqJi2x23btcrA==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr6336783wrx.98.1626361022443;
        Thu, 15 Jul 2021 07:57:02 -0700 (PDT)
Received: from agape ([5.171.120.140])
        by smtp.gmail.com with ESMTPSA id x19sm5357402wmi.10.2021.07.15.07.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 07:57:02 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH] staging: rtl8723bs: fix wpa_set_auth_algs() function
Date:   Thu, 15 Jul 2021 16:57:00 +0200
Message-Id: <20210715145700.9427-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <619462ca-e652-30f5-6ffa-3213175d8bbc@canonical.com>
References: <619462ca-e652-30f5-6ffa-3213175d8bbc@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix authentication algorithm constants.
wpa_set_auth_algs() function contains some conditional
statements masking the checked value with the wrong
constants. This produces some unintentional dead code.
Mask the value with the right macros.

Fixes: 5befa937e8da ("staging: rtl8723bs: Fix IEEE80211 authentication algorithm constants.")
Reported-by: Colin Ian King <colin.king@canonical.com>
Tested-on: Lenovo Ideapad MiiX 300-10IBY
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index f95000df8942..965558516cbd 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -349,16 +349,16 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	int ret = 0;
 
-	if ((value & WLAN_AUTH_SHARED_KEY) && (value & WLAN_AUTH_OPEN)) {
+	if ((value & IW_AUTH_ALG_SHARED_KEY) && (value & IW_AUTH_ALG_OPEN_SYSTEM)) {
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeAutoSwitch;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
-	} else if (value & WLAN_AUTH_SHARED_KEY)	{
+	} else if (value & IW_AUTH_ALG_SHARED_KEY)	{
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeShared;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
-	} else if (value & WLAN_AUTH_OPEN) {
+	} else if (value & IW_AUTH_ALG_OPEN_SYSTEM) {
 		/* padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled; */
 		if (padapter->securitypriv.ndisauthtype < Ndis802_11AuthModeWPAPSK) {
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
-- 
2.20.1

