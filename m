Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C23EE084
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 01:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhHPXpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 19:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbhHPXpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 19:45:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 16:45:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r6so25930565wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 16:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omBY4l9pd9PCHLsGgjxVlkygjoBOXq+wPh3rMM5RV0Y=;
        b=db2ryDw+V4CsofvmNSWr+uZXc6aWntzhWOo41p21fuVk7QBgnP7HyVXDunIgnSQ6ZS
         qXcTzriPKukoTGvCwjSi0GWQwha3+hUZeq+dpGAdZRFp9zysYu+6M0OG3I7nBoE4gHcE
         ffwsdFdQhMvjQdQzGzsXPSjNroJAdtSnuAsC9mDqhfN/rmDR6zj9YHadF6RElpIkJJ36
         cqSz3vc4/gLe+JwGgDHr07pOj2nR2y86zri4yq9BZmT4sxx/NJFoyyM/+6Z5LVjntyVq
         OawCtPrVEScoDxYKPvEUVtIWaAWXrZWqjdtlw2AO+RqtlMBWUoT6lKuFXKKLFzrzyW1n
         Rhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omBY4l9pd9PCHLsGgjxVlkygjoBOXq+wPh3rMM5RV0Y=;
        b=GiypVRT5oKa8BsqnQUriMGOKXLZo717CArn/JAOJZgeO99q4NuVr0mMzFI6KnMXKby
         dBSFao1MpAbIXoNnFjVZf5wUNjOy0WB1cAXyDJQiScranLvtca5Ih6N3oYKh2UtwziZo
         0oNaiqpjxtCECWMiUH2PfD4W4tSGH7A+JAwywkQVlsjSnkwDrK3SnL5jHm++bl3zuLz6
         DgE4X0mE5sbxx1hRDzlHcQ0Y1baqwHTH74tgYK0tGSsBWHSbD+bPx3788SmCfuFPnF/l
         hRELXveNylXVplKcjqrWLUCAP0X59NtIEnFC+d/FuYYoHUNtWzRXfFTFkT69nfLSzKq6
         NRBw==
X-Gm-Message-State: AOAM530SFyLb/YD3yodiQML4eabNGfyfCOesWzaKCYZG2gNgKPf6DAj6
        jfqUlSwdGolGDL9yea/xOvzd8NkbshODZe+T
X-Google-Smtp-Source: ABdhPJxBs0P9i8ccjNS9osD2K8GM8/JASHY3TbS88lGqVmmsfxH/zlq4GmhwqAYagZ6M7eje0JrScA==
X-Received: by 2002:a5d:634a:: with SMTP id b10mr518984wrw.305.1629157504405;
        Mon, 16 Aug 2021 16:45:04 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id w11sm291521wrr.48.2021.08.16.16.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 16:45:04 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] staging: r8188eu: remove unneeded DBG_88E call from rtl8188e_Add_RateATid
Date:   Tue, 17 Aug 2021 00:44:58 +0100
Message-Id: <20210816234459.132239-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816234459.132239-1-phil@philpotter.co.uk>
References: <20210816234459.132239-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded DBG_88E macro call from the rtl8188e_Add_RateATid
function in hal/rtl8188e_cmd.c, as it is not particularly clear in my
opinion, and we should strive towards use of existing kernel machinery
for debugging purposes.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 4302054c6c83..77c057e276a5 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -173,9 +173,6 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
 
 	bitmap &= 0x0fffffff;
 
-	DBG_88E("%s=> mac_id:%d, raid:%d, ra_bitmap=0x%x, shortGIrate=0x%02x\n",
-		__func__, macid, raid, bitmap, shortGIrate);
-
 	ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv, macid, raid, bitmap, shortGIrate);
 }
 
-- 
2.31.1

