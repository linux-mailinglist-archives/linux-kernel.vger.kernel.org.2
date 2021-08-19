Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4DC3F2377
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbhHSXAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhHSXAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 19:00:17 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13672C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:59:41 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n24so9814606ion.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTZIfOHRyXqbRj0vGMmgdDyUBJVGJoNZm2wLqjm5mWE=;
        b=MGinE0QLP4WwLR3nsv+V+OQ+QbzraAYbOU4lYI4XNKd8JTtQJH9CypndKoxrNG16Hb
         dkXRH8WunA5gaFa7bmherR7mr7l2zL8GWYxXQZV9Rsg4sltApZdowjhSISCl0sXGFt+U
         EXF2QV324JhglufxMSGTeoLzDyP+EVgECqI3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTZIfOHRyXqbRj0vGMmgdDyUBJVGJoNZm2wLqjm5mWE=;
        b=kOFR1tKiOQkNXSMKBQFw/D7JVD69E0DPaupG9qqK9EfTiY2qbNuAXaaMJsfebdyfGy
         E2xnhbUjlMyVNocqZeHeJYWAkCnAd4eYZGjgyoQlATHaH7+yinX5VU70H5Wjnq3w/poK
         +q2HAXpjjW20FKMRBiGretPBCARkFiqNsf86hVZ07U4z1RVNZSBgco8n6L8M80CeNTkH
         yAJ3/rOx2c09pjV29ObEf8fe80AZ44ua5z8cabH8wRztqNOZulG9Ar7V4yowP6vILL4x
         TgHMJaTF0urSp6U4onozYfrqD5idV4fKuNQbcLQJmz7Nv2WHA+HDuuAQVBHILmsmlahO
         mYag==
X-Gm-Message-State: AOAM530GdknbY5ULpVBmT+N0xcvunI5l+hqSQiW12f6dNTwsOO0BFerL
        fUSV7rlO8gSv5yX1IV1R0LUq6g==
X-Google-Smtp-Source: ABdhPJxouRhLae2784WA0Y++VSaZ3KpxP3Du54Wek2AnvB0xsPH0YxAkXPEcnD5qMMZB/OMCbmsqsw==
X-Received: by 2002:a5d:990f:: with SMTP id x15mr13576695iol.200.1629413980537;
        Thu, 19 Aug 2021 15:59:40 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u15sm2374814ion.34.2021.08.19.15.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 15:59:40 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org, msbroadf@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usbip:vhci_hcd USB port can get stuck in the disabled state
Date:   Thu, 19 Aug 2021 16:59:37 -0600
Message-Id: <20210819225937.41037-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a remote usb device is attached to the local Virtual USB
Host Controller Root Hub port, the bound device driver may send
a port reset command.

vhci_hcd accepts port resets only when the device doesn't have
port address assigned to it. When reset happens device is in
assigned/used state and vhci_hcd rejects it leaving the port in
a stuck state.

This problem was found when a blue-tooth or xbox wireless dongle
was passed through using usbip.

A few drivers reset the port during probe including mt76 driver
specific to this bug report. Fix the problem with a change to
honor reset requests when device is in used state (VDEV_ST_USED).

Suggested-by: Michael <msbroadf@gmail.com>
Reported-and-tested-by: Michael <msbroadf@gmail.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/usb/usbip/vhci_hcd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 4ba6bcdaa8e9..937f28f3d579 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -455,8 +455,14 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			vhci_hcd->port_status[rhport] &= ~(1 << USB_PORT_FEAT_RESET);
 			vhci_hcd->re_timeout = 0;
 
+			/*
+			 * A few drivers do usb reset during probe when
+			 * the device could be in VDEV_ST_USED state
+			 */
 			if (vhci_hcd->vdev[rhport].ud.status ==
-			    VDEV_ST_NOTASSIGNED) {
+				VDEV_ST_NOTASSIGNED ||
+			    vhci_hcd->vdev[rhport].ud.status ==
+				VDEV_ST_USED) {
 				usbip_dbg_vhci_rh(
 					" enable rhport %d (status %u)\n",
 					rhport,
-- 
2.30.2

