Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED12D3DBB71
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhG3Oyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbhG3OyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:54:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BCFC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:54:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y12so13579595edo.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUYpGNRc+bZWd4eXG+Pz5fTX220aWFftXyXSfRx6Pfo=;
        b=VjBXTwImJHb+3fzN1KzTIPYcdKszZFYIVFTrp9y9ejOFqXEUL7HL5sh5+iUPP0IFf7
         czVjIeDaBs+VbgP217TukyVQ2R6YBSdTA9Wcc3PiEn+Zo3Qa0RoTrGUwrtzHRidHNcWs
         VehUrJeS+7/P30b75EGk6WH35U2BYDAFvUo6RANKijuNHUVj8KU7EdlaHCcRW+/FGNo4
         fz/0PDez2uxpe4qV+A1O3fGGBHinuneOe6d0MhurqsUvEHmg7Vg/Ak/mgxtWltMJbO3p
         B1Tf0FGKCllty06+bvX2//xqOSTJ2jMs0ZvN5M+++4wsQz402/JCVkOKyTLrcUGMdlTX
         r1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUYpGNRc+bZWd4eXG+Pz5fTX220aWFftXyXSfRx6Pfo=;
        b=qmHm/rDeENI9iffyVXq5+CZMGwjgVTDQ8+KZzkFHvFeSQgQrLMN5Agg4JIZRRB5eU9
         b+QQvWSdCSuDrvqraIfuBgQ0vnAhM4zCn7B8cFY/T6OwhsMepeqQZ52gCJcOqzeOIjpg
         uAyozwHgSME/Ko7m1RBcukATMQrfNojarYsHF9KvvbPVv9gAUe5IQnmmE+liQ3Frnv5e
         RGeBez+SeLARw6Ub4yUAOUmutv0ZMYax2xk+C27objkCs4vrM+caMFxkuHc6ikrjN8A+
         gj0TxlyFkC5tQThdG1okN82cIeedSJd+yXbYGRZDTftFSnvEXSatVx4rl980hEt0oB/a
         2shA==
X-Gm-Message-State: AOAM53284eB+/bD6veg46g3HtJZhBvXl7bY6cQkwwgtrnq0Kue/srezA
        RgpILNd/12inbliXe5T4evAorLcYrpg=
X-Google-Smtp-Source: ABdhPJz5thhmML5rAzie7DuETH8qrqPzMxYfOSa2bXGtSJVXMEURv4Blx5Iy8eYZYImffqkNKG2tqg==
X-Received: by 2002:a05:6402:896:: with SMTP id e22mr3477386edy.246.1627656854641;
        Fri, 30 Jul 2021 07:54:14 -0700 (PDT)
Received: from agape ([5.171.81.215])
        by smtp.gmail.com with ESMTPSA id e7sm638775ejt.80.2021.07.30.07.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:54:14 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: rtl8723bs: align condition to match open parentheses
Date:   Fri, 30 Jul 2021 16:54:07 +0200
Message-Id: <941bd42ef6b7d76e80685b133046669a0ca82d8e.1627656773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1627656773.git.fabioaiuto83@gmail.com>
References: <cover.1627656773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following checkpatch issue:

CHECK: Alignment should match open parenthesis
54: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:609:
+		if (target->reserved[0] != 2 &&
+			target->reserved[0] >=
		pnetwork->network.reserved[0]

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index df599c2009b3..d3d068babb5e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -606,7 +606,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 		/*  probe resp(3) > beacon(1) > probe req(2) */
 		if (target->reserved[0] != 2 &&
-			target->reserved[0] >= pnetwork->network.reserved[0]
+		    target->reserved[0] >= pnetwork->network.reserved[0]
 			) {
 			update_ie = true;
 		} else {
-- 
2.20.1

