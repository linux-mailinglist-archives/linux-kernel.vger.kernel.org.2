Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4E3B0478
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhFVMdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhFVMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40EC0613A2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f2so23407132wri.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NzFrqHGl0cYS27Ypm4XF1HD4hXM1cpi1KCAV815SAkE=;
        b=rWf1PgkIwW2d1mw2Y8MaIRSkO1MvPeeeSK0nX+NDlNPZj6LTv6at6z3hqi00tbgSzC
         SExs778Ar1nGZbaZPyuhSV0BCTraDAJtc55UqJwETLm0wKK+/9/HjWPv+C5ORY2B1rzA
         sVSk4Hwe+sQO+SfsxV88maJPQsVe63FrQ11y4hSQIRqOcUV1qlFJPPpHK80VBN9r+0MT
         8Aih8r9+foSLEfD0HiFPfu7BLolc+mCHc72SRK699juj0r6NIvd2dokSJRdliK5gzVhp
         ZdN14FDTLLLLzFwzk2RDeL6Oc/ScUu946+gWtzdLUDmom+IKCuwh63Al2aKCJBZp6MHN
         KrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NzFrqHGl0cYS27Ypm4XF1HD4hXM1cpi1KCAV815SAkE=;
        b=g30OqAMZlTOgYakTTiVCk7wQNT6XZQoansXSulZv+z+lgL2GMWAQgqKVC9TStp0G4V
         t2zFnzFNZMi9BX1OnAiAMDOj0M4ipgsqunRbkLhz/V4jnnzRCUT7u52lfrz7wTB0wRmR
         XBr/mkhMDB33ZImllyvcYsLxprZXwfgqRRTbOBX9GaiAvGCdDfeB534FdiXxLCL3Vp9Q
         PVnlMRp1F+0DNL0OtQ68jid/fd8aQWExn/ZKf6GhglPm6l23rF7LJ/dR3mkwkHVH4+Ze
         jtdnJMxoA9Kxo/Su9wYCxZgcT2p0vtzpAmGbTBXuPTiVn7jPXcovamvabZGmZSWs9Zp2
         1+Fg==
X-Gm-Message-State: AOAM5325DQjui9DaBOUx4UQhDqp6Xe1sd1igAn/nGTldFa8dytcSyxZS
        xOSQkVi1sRr4y4n3r1WYFArOY4YLUReEQg==
X-Google-Smtp-Source: ABdhPJxR2iNkaOgY2c+VioOQiZFd57iTiWefau8tUV4SF4MMar0qojvxbwFVxXgTTHJuVdf4vxxOeg==
X-Received: by 2002:a5d:5907:: with SMTP id v7mr4536429wrd.342.1624365006485;
        Tue, 22 Jun 2021 05:30:06 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id z6sm16794608wrh.65.2021.06.22.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:30:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/17] staging: rtl8723bs: remove obsolete 5Ghz comments
Date:   Tue, 22 Jun 2021 14:29:40 +0200
Message-Id: <4d7fb487902f6c60db751b58642ffa48d3f2d74e.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete 5Ghz comments.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 --
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c      | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 8514cfb3d7e0..427f0b88abd7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -202,8 +202,6 @@ rtw_cfg80211_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 
 static int rtw_ieee80211_channel_to_frequency(int chan, int band)
 {
-	/* see 802.11 17.3.8.3.2 and Annex J
-	* there are overlapping channel numbers in 5GHz and 2GHz bands */
 	if (band == NL80211_BAND_2GHZ) {
 		if (chan == 14)
 			return 2484;
diff --git a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
index 0084589499b9..5eef1d68c6f0 100644
--- a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
+++ b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
@@ -44,10 +44,6 @@ static const struct ieee80211_regdomain rtw_regdom_rd = {
 
 static int rtw_ieee80211_channel_to_frequency(int chan, int band)
 {
-	/* see 802.11 17.3.8.3.2 and Annex J
-	 * there are overlapping channel numbers in 5GHz and 2GHz bands
-	 */
-
 	/* NL80211_BAND_2GHZ */
 	if (chan == 14)
 		return 2484;
-- 
2.20.1

