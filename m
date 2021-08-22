Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E713F3F88
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 15:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhHVNo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 09:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhHVNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:44:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A7EC061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:43:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bo18so10341137pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r1Enw6eKYLeGW0q6ReZjdVeghYydNYSv2C3y3Z0cpkM=;
        b=NSo9ngLhucEUmwdAMxx6cuXU6f2BurZbvDGjfAT3Tv9nWJvGDx+Ds5wF9qtRDvNClM
         mN6ZCzFmmqqOmBgA0Hhz4rU7AOX1wGdELmKauwjcu6CVYvlq9Fk+PI33BEk/a8E1RGiA
         Oq8E+OM5yEXo7yJoEnI0ZFRhjgdTJdR3NCneKWPPPBCgerl95qLVv96J8LpaTdyl5hcl
         qr7Q5XAy3rRP5gGxmpFuzyfP7eCFyhH6UTCHcVZyE0OPViMapsHXS/gIR2DgUuuzpoL7
         tK3bL63mIMsvm7doOWAHSPpr5VGptxaZlyp/7JzEIg8unXkFoZxqfo41P88B9bwNAOqR
         1TEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r1Enw6eKYLeGW0q6ReZjdVeghYydNYSv2C3y3Z0cpkM=;
        b=B/QzpMGB8SyVnuJVFAaq7ERBH/tzGIfB/kTQXFCdpbPI+v0LuBfPrY8aXCzULQhuYh
         7kCA6tG6N9y+V6KWftjnTxCJoK98Zh5IR/gJPc8orsah2YIJz7IQptL1lU4vWRwFg185
         /W0zZqgyH39oOfP1zC1o8/feZKk7YF2HXDQNWo1KPND1jEqDeTFzx1lckqmuNueGiUOM
         c6DVPtG2wopEJL+38yILJh9kMq/7k03ji4LtFxmC0g/OlNpFZRt0lKf+xcwUttCw9VFu
         5CAV36dVkuPVwXBIag4VjNGHWvswoLecN9dqzeMxEZlSZb4QrP2PVcipg8v5L/47jt48
         dd9w==
X-Gm-Message-State: AOAM530wNcVOecuBdFAOHu9a/5DX5GLBrXU7pEbls4HparAqMxQyrwIJ
        9qSnW7Av9L00DVTOYW5v7Wii
X-Google-Smtp-Source: ABdhPJwqYkottPCIqJX23CCHTUq+6WgHNDI7zo0sXHcXtSxT0lWbxtbrjQo8Iu1JRnmnLyN9nt4giQ==
X-Received: by 2002:a17:902:8c83:b029:129:17e5:a1cc with SMTP id t3-20020a1709028c83b029012917e5a1ccmr24343549plo.49.1629639826358;
        Sun, 22 Aug 2021 06:43:46 -0700 (PDT)
Received: from localhost.localdomain ([123.231.122.209])
        by smtp.gmail.com with ESMTPSA id g26sm15106581pgb.45.2021.08.22.06.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 06:43:46 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2] HID: betop: fix slab-out-of-bounds Write in betop_probe
Date:   Sun, 22 Aug 2021 19:13:19 +0530
Message-Id: <20210822134319.3738-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210816201544.26405-1-asha.16@itfac.mrt.ac.lk>
References: <20210816201544.26405-1-asha.16@itfac.mrt.ac.lk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported slab-out-of-bounds Write bug in hid-betopff driver.
The problem is the driver assumes the device must have an input report but
some malicious devices violate this assumption.

So this patch checks hid_device's input is non empty before it's been used.

Reported-by: syzbot+07efed3bc5a1407bd742@syzkaller.appspotmail.com
Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/hid/hid-betopff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-betopff.c b/drivers/hid/hid-betopff.c
index 0790fbd3fc9a..2d62bde21413 100644
--- a/drivers/hid/hid-betopff.c
+++ b/drivers/hid/hid-betopff.c
@@ -116,6 +116,11 @@ static int betop_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
 
+	if (list_empty(&hdev->inputs)) {
+		hid_err(hdev, "no inputs found\n");
+		return -ENODEV;
+	}
+
 	if (id->driver_data)
 		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
 
-- 
2.17.1

