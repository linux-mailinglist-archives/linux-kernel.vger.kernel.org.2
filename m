Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8539F4D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhFHLX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhFHLXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:23:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F8EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 04:21:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h24so32052651ejy.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Xr+IY5qcdEYEQUsNiCMfqH1+q7GDdk2pyxDjbZ/SfA=;
        b=WEdd8YsHCEY5xEn66qtoYbItau6L2De8KpR1yJGPeShWtKo3QXRbxQBJY06li80CIw
         XV6ejeuXGfxd/UdWgR6HbHm5EZtDbfVai/nihkGEt7B/IDsPIQd3gnklWDKhnfM3aiq1
         eHkEf+LQGdPlYsEcUWHJJGcMypjobEEvSH0zWfFTCq65/gxjUNmbjkllQH/rZd13P4jD
         aUYzokxxiGyIC0MyDlKu3/3V5QvaN9FsPfraJZHWv8SWAg0RbuNQiAwxkNAI/ZZCAdLz
         OhBjt1QBjE2vgyi7V1EeV6igoi7JWUmMaWomnzVuMr5WpEg2EM/R3fkJcm3aXPwZkLED
         qk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Xr+IY5qcdEYEQUsNiCMfqH1+q7GDdk2pyxDjbZ/SfA=;
        b=NEp4OE17yyx6asoJpShqcdTcE+x/IiiE1j14x1KiEV5IdVLwPa5xtgl+2c75U5kBl/
         YLLAQ3q99Sfds7NVLSR6HWGk79UfDqZzqgUuLP4K5B/Lc4yTB/IgCLdEcbKWxcwderh6
         8GOzcV1mRHy4nBDrYMJkmKk75WwHuwp5R+qX39IrmJsjxmiQpap0i6rAaXthby//d7Mu
         j/KuqF8AJfIq9arvA/BZSjttbzkBakEBC0DH2pAEMmei3CnH+BDa7UhvWdZtbEnAe2RE
         /Bjs+MhojWlpzFq4uDsmiTJkQhwoTSOxVmLe6WQNijSFzpzDMIb1+97YLWvSgDw71RGQ
         Mwbg==
X-Gm-Message-State: AOAM531ttnxuumqwQKgYymYyvRCN4NBXmyLkCYnG8aFFgHKIaqLS1T/a
        pTSaCAaAJn4TIkbP4bcA4co=
X-Google-Smtp-Source: ABdhPJwudGlga0r0YmjTDaeM7SQOckRxmpyLGJldYIA/dFopBv6sY192fCSt9TYN7m6vk5GuemL5Uw==
X-Received: by 2002:a17:906:fcb0:: with SMTP id qw16mr22709497ejb.269.1623151283154;
        Tue, 08 Jun 2021 04:21:23 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id r21sm8930448edy.78.2021.06.08.04.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:21:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8723bs: hal: Delete tests with no effects
Date:   Tue,  8 Jun 2021 13:21:18 +0200
Message-Id: <20210608112118.1213-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deleted tests with no effects. Detected by Coccinelle.
It seems that these tests have been inadvertently
left while removing BTC_PRINT logs in commit 8e30fb99d729.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
index 6822990bca7f..3829701f10f9 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
@@ -410,20 +410,12 @@ static u8 halbtc8723b2ant_ActionAlgorithm(struct btc_coexist *pBtCoexist)
 				pBtLinkInfo->bHidExist &&
 				pBtLinkInfo->bPanExist
 			) {
-				if (bBtHsOn) {
-					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
-				} else {
-					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
-				}
+				algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 			} else if (
 				pBtLinkInfo->bPanExist &&
 				pBtLinkInfo->bA2dpExist
 			) {
-				if (bBtHsOn) {
-					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
-				} else {
-					algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
-				}
+				algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 			}
 		} else {
 			if (
-- 
2.31.1

