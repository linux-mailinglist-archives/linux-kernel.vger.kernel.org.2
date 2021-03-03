Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774E432C266
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376586AbhCCTnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhCCTZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:25:45 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF0BC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 11:25:01 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id l133so27236490oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 11:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpnUMvWVOJdi34gV5Xr4CO6KXX8Go12ukZ8hFpNKPao=;
        b=RT6QttOzOrQM2tUqzZTRK1txLRiMMB/svOEsSWmZ+y7f7nABd0aMhQkUI8GYStp298
         EAmOSPeAWegHzMOAiTV524x+Ez6TIeFsukC5qZO1kY48OhJNl2AIcfGvJRhVyn+NPc+s
         9H+pyZuoslkMUlyTSPRhsN5YPyo4YYD67s9A9dbMX7xja4ntGeyJTKSv9erHMtBiW41A
         gtxrY2AhPRo/2eU+9fuIlthySu43aGBHs9nXclRlpdL2qfqADr3bNY6wvSBv6IHMDHVM
         31kS/5z3hVXbF2tL3w3ZhS7RCQh3nXq5/Ojtm9nDKI7EAL8U57gVW2SprC7wEShI1qhf
         bZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpnUMvWVOJdi34gV5Xr4CO6KXX8Go12ukZ8hFpNKPao=;
        b=TtqOVPsWvh9hR4LSZeTflnKl6I5/6BZIZncbFz1Zskg9bSgheirly0+aWZZ2jwa1EH
         JrVig9pGr3Oe2TZplAIwI3QTzpp5qNi0S6PNCnBfhoBo5da3sNNoQt4k//tVR6GQCo9K
         QOrARhdl3VSa49zun1HQHVmZFulMuxfaJa6ws0j7xF4kAS8VQzXE9ayOq6JkdSruRgPs
         QaVfcJi3Bz2wbKJyyQVFg09/31EwTZPUNOU9KHYAYrEoTUCKx1KapeNHr79lbTjeGNsy
         CSEHU1DzkFIGIHkixhu23hqfJfXTVm8pmiMakuXlPdNMTl1Rz0PVPkK5EvPK6nuLv+r9
         VC4Q==
X-Gm-Message-State: AOAM531RV8+POTQLBGyX9JF7rix1UmXNhHuf3CMkFw+65PuTR1t+hROj
        9W4Bv6m/6F8IaF5nWP1tsxdY3A==
X-Google-Smtp-Source: ABdhPJwlg1YhN8VRFvG9rWwHEDXIDusrKVuVtKQaPnftr+rfmHZMu26YwK+2LetpsUVN1U8gM3DGaw==
X-Received: by 2002:aca:683:: with SMTP id 125mr304319oig.172.1614799500958;
        Wed, 03 Mar 2021 11:25:00 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n17sm2965762oos.20.2021.03.03.11.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 11:25:00 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ray Chi <raychi@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] usb: dwc3: Flip condition guarding power_supply_put()
Date:   Wed,  3 Mar 2021 11:26:14 -0800
Message-Id: <20210303192614.759729-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The condition guarding the power_supply_put() calls in error and
removal paths are backwards, resulting in a guaranteed NULL pointer
dereference if no power supply was acquired.

Fixes: 59fa3def35de ("usb: dwc3: add a power supply for current control")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d15f065849cd..94fdbe502ce9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1628,7 +1628,7 @@ static int dwc3_probe(struct platform_device *pdev)
 assert_reset:
 	reset_control_assert(dwc->reset);
 
-	if (!dwc->usb_psy)
+	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
 
 	return ret;
@@ -1653,7 +1653,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
 
-	if (!dwc->usb_psy)
+	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
 
 	return 0;
-- 
2.29.2

