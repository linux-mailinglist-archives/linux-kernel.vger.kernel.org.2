Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE7D35AE38
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhDJOYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhDJOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265EFC06134C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z1so9791730edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5nuHsBBM9Uu1NfcSwY0BeNDKPAr9Mc7yGwZ1gPZKnI=;
        b=nKprcCW1KTc/ZmDN5ZQEAry5+/nQAra+VVTkkuAbas6WuVdFCJ5fZvp3vXivJT0DM5
         dp18WmeGkl3zuj6UxxceNPQ8M/d0sih/Ac4iUX5J0Vjir+Tk2jLTqUrxcLh5VNGb/LRp
         OljX66TtyEMSo3mg6/apkaUJOMWXtFcfJKHNvS7mE799ijil+vGRQmO6NJL/0W3FfMK7
         36Ng16iUJ7o9uHFFaW+VcvuCqM0PTyktNDO971wVAVo4Plfn9aoleub93Elf6Cmg7yk2
         0J18SHspXPBPGol0Ul9S2rSTCfooV5bLdjx3aDmAOMyvBnI4iIKLt2IVVKg5R6Y/J71V
         y5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5nuHsBBM9Uu1NfcSwY0BeNDKPAr9Mc7yGwZ1gPZKnI=;
        b=C1dXfH2XU7NHuGbq0zuqEQwt1OXx9KYNMhlnHQIUagpiHDLypO8ag0gdi9a8RDNc3P
         /ZHMIACUg+gWdkdMfwenH5t9Lk8bBm86RiAFQNCc2NrJ39McKPAURRALbTbczzc2epuz
         ZvzbeJSMiM4ZTpXcp5kRGhgGcu60xuDxq2eoDYR9JoyUjCoWgjOerhezoNRO+oV7JP1l
         eDOVSjkuYtu75YrokXXujSaHIVT3bC1dUFoWcotGW41azYiWOWSO+vvkqVkVaW0Dgx8B
         p6aeHf9Gjcf7XbrhXme3RUSxKxRgxdj312oxBqwbY1RDaAm2jBuI5rpmVtGYoOwE0nLP
         vctw==
X-Gm-Message-State: AOAM532zZH1Sxw+PotEJgLHxr8uq9zkoSW5xNqs2PFOrrjjU8x5dmTR9
        QxbtnhYTwOVrvtgEt88ig66fgiFD9m74pQ==
X-Google-Smtp-Source: ABdhPJxeC5c3e6VdSCsFCmVjQi/P2oC645yjC7t0oCNNxYoJmVqrKrujomXohaEdCntWE7Kp1NheBw==
X-Received: by 2002:aa7:db9a:: with SMTP id u26mr21776965edt.292.1618064476704;
        Sat, 10 Apr 2021 07:21:16 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id df8sm3270777edb.4.2021.04.10.07.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 23/25] staging: rtl8723bs: fix comparison to true issue
Date:   Sat, 10 Apr 2021 16:20:36 +0200
Message-Id: <680d86950d760003a694f8880c0a912a9d815a5e.1618064275.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issue:

CHECK: Using comparison to true is error prone
136: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:
2497:
+			if (psta->dot8021xalg != 1 ||
	psta->bpairwise_key_installed == true) {

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 9c98820952e4..89a21eb63c0a 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2491,7 +2491,7 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 		plist = get_next(plist);
 
 		if (!memcmp((u8 *)mac, psta->hwaddr, ETH_ALEN)) {
-			if (psta->dot8021xalg != 1 || psta->bpairwise_key_installed == true) {
+			if (psta->dot8021xalg != 1 || psta->bpairwise_key_installed) {
 				list_del_init(&psta->asoc_list);
 				pstapriv->asoc_list_cnt--;
 
-- 
2.20.1

