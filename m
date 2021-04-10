Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B672C35AE33
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhDJOXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbhDJOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043EC061349
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u21so13004207ejo.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofzLDaPPZazs9esoDl/1YmCRcwlxUciflzoipNXxyZY=;
        b=FPnf1XFryr81WHzQ/k9HnwMYiuDZyMbxc8qNAUuS3Dh0Nj8WAfbPNc2u6djlPizjHu
         3drCNdIVp2trdXkx6q9X0Tu7h20h6oUHaz/GtzRz6Y4BrfLUc/ZIusDNkiBXpQp9qWTL
         EZYzWT+qgntEbuaLeNwhxU5F8VBUCwCejOkc27OcIu9WqTbFa99Xr1fJNnWjqDMPb0uL
         Q5EW6hPCvxFt3E7qWzcqnBU4n59qsnMuvxCPfVrAsQAnl0Q86vKZFUcEivdTF8Ed3Q8D
         lBn4xKIR3A5mKriXdLcRTeAHNJ5kjzZSQL3235WLYmNLb5kI1Ix/85BVoF7DdDTysz/U
         A6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofzLDaPPZazs9esoDl/1YmCRcwlxUciflzoipNXxyZY=;
        b=l/6QxljpLYy/ytC7OC+YPHldlYJI1NuZ5RyCcRk24Km84MF8P2qBRa1b0PHntcR5Lz
         QJg2Wq1y712l/O3NnA4XrkyVr2l/sXwPv5vjnD1ktB/+MSzAWzZicOdWzai3PxU0wXc4
         FbYs9BYSrLOi0HwEo7mEQymjfAbUkSIVFU171JpafmmWsPEUirNABRcq6YCGFwvkZe5A
         HEh20JvjleKr3SS0UCXaQkpJGY6KJoiEQ1Dd/h19EmkOclsa9ZWCEQHQ6nTzIoUYHtqB
         abGUq8jAKw3Btx6kUjmqPHHvuwvNid/5aWR+rP82TMkFXvWWRYDHEXa7Fv/hFB5Fd4n2
         mFlA==
X-Gm-Message-State: AOAM533EBEszjRb8j9ayCEt+ZX1qvqbNO1bEcZRHP4xj17bCHmVjF9cT
        qObk12+mqoZN9E4x9pLRvztQ4MhbItTwwQ==
X-Google-Smtp-Source: ABdhPJx9Axw7JFoWIsuUIXujl9/o+fgXHhLUnrFKtQpI0lorN82qg3koKvl/isJDw41inuMvQySrbA==
X-Received: by 2002:a17:906:8496:: with SMTP id m22mr19950507ejx.313.1618064471791;
        Sat, 10 Apr 2021 07:21:11 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id dj8sm3170750edb.86.2021.04.10.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:11 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 20/25] staging: rtl8723bs: put constant on the right side of a test in os_dep/ioctl_cfg80211.c
Date:   Sat, 10 Apr 2021 16:20:33 +0200
Message-Id: <5ac547f3a4bd228f372da7057bbfb3cac1535857.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issue:

CHECK: Comparison to NULL could be written "psta"
72: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:854:
+			if (psta != NULL) {

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 4014b692d954..617c88c6e4e7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -851,7 +851,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_MP_STATE) == true) /* sta mode */
 		{
 			psta = rtw_get_stainfo(pstapriv, get_bssid(pmlmepriv));
-			if (psta != NULL) {
+			if (psta) {
 				/* Jeff: don't disable ieee8021x_blocked while clearing key */
 				if (strcmp(param->u.crypt.alg, "none") != 0)
 					psta->ieee8021x_blocked = false;
-- 
2.20.1

