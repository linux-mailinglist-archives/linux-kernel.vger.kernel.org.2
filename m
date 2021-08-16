Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B53EDA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhHPP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbhHPP7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:59:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718ADC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x12so24324724wrr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njy7Oa+du+KqHnyDswra+IdM9v4OtgIsCVAqZC3W0qU=;
        b=kJo8J046FBzQko4ifjU71w5I7PLUJcsOVY3Xp4Rx9bN5bURyihlZFWMK8ddg47ioBO
         oS7/KCTVC/9YX1n3psxeiqBj13cnFSAuN6pdj0xZjRLq39R4abIfUogthj1uj8nG0cl0
         YwIisW37xRwmERMK4oKUdTJS2xSZoCUtCAn6BuKv4Fkn+Ae5GFTptaP/zH69q4nCMbhS
         1YWUoekmEQTztr7KIv85jW9D5VFSDoWC5LJQsKLHs63Fxs//xq+Jf4KXlz/Drzc1lola
         cZl8PYZAVB3H91oWZf0qIN3dioULy02IjPOAVrehlmTKF+OUtSpm2KofRqVLwb5JXb/W
         oPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njy7Oa+du+KqHnyDswra+IdM9v4OtgIsCVAqZC3W0qU=;
        b=VWM5bv9OWVTg6bnpHey/1XrfIVdZOOy0009QA44wBWIhAWyxBxvW/YONcymaNuibEo
         q07oCIjlV3ly34j3yFDzm4OnLzoZ3W1/z42fmEtJa1MLoyAVzAUJA6qAWBaNxuq7amyc
         7FP4wbSkO3x2HGiNsRzixYCCtYqFXIhfjEcezFGfW1WdTItgzLdqo81ZcaFrJ0nM5X+A
         EsI++KXOjwtIrK1O9004xKIYuiTISbWwYkwHtAbfOHlGEhJm/HFFIIGn1EaQba7F6BZ1
         99u7+MsvPsWtuUuhgMvfhNhzbINRvYvNQRqbppNsLCpW2OLoEPQbPwIaN30B2l/2+kGp
         bnDw==
X-Gm-Message-State: AOAM532hLaSa+FGCh8tnu0zz0SbGtJKYeZfrGsPMAWoxc2P4TRz2UFgW
        FX8FPVr+zOrVN+vl54U5Ihheiciq450=
X-Google-Smtp-Source: ABdhPJybn+cpkfnqtrnTWIY5xPf5zNgQq4ABE+NTPjpC6EwQXc7dYNsvrOrz/EqRkFpxbl8b5Yhs9Q==
X-Received: by 2002:adf:8102:: with SMTP id 2mr18778787wrm.89.1629129560123;
        Mon, 16 Aug 2021 08:59:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/23] staging: r8188eu: remove unnecessary parentheses in core/rtw_cmd.c
Date:   Mon, 16 Aug 2021 17:57:58 +0200
Message-Id: <20210816155818.24005-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_cmd.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ff6c5fa71101..65ca4a2895f8 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -832,7 +832,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->IELength;
 
-	if ((psecnetwork->IELength-12) < 255) {
+	if (psecnetwork->IELength-12 < 255) {
 		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], psecnetwork->IELength-12);
 	} else {
 		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], 255);
-- 
2.32.0

