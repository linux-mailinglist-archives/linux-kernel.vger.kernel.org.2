Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54E641CF72
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347336AbhI2WuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347331AbhI2WuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:50:09 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF61C061767
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:48:28 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l22-20020ac87b36000000b002a6c575f419so10151611qtu.23
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ETcVWno/psejFFgEWsam5NI1lLczvhwOhyjFPnZZicY=;
        b=EghzBSYgJaumTGBJNjWIlqQkmELd14y20ZMqLBeHV1G43vyoHX7wZUtHS9Ck3OyXke
         SJxanL4NUMcG2yOWC0yktYmJtOqYlceftM6+fKTjzlp5v0RL0Vebi0WwQ4Pcr8M1FNBu
         ePRwE2Vy1dyMsGEFKDxhVwcXK5wlQGyY/RpekflN21IJzxBkhoUUyhj7ODMQL5SNi4yF
         dwNFomcEZiFu35kZnbSH8XNl0ihfsZere/O79Xbn2MF+7Hc4hXdf5+q+TkQuxfsc1wvn
         nyAObw/ixyyJgz3hPODjhD1k6kMPbQKYWt/emXaDstFNHpvJkMRTNk8RRjC3rnCUn31S
         tJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ETcVWno/psejFFgEWsam5NI1lLczvhwOhyjFPnZZicY=;
        b=lHVjoaSpHfTPNgVDvUBicxX/LQ6Xt223cGhQTP+SQCTsVPa3ZGGpe49/5i0aBf1U1t
         Fj1UqAOCxpLpdVmvVLobx2j6rbXDQd5XKAY6WQMfh/+YS/cYcOllDjpNqqVdqSwycImf
         qj4rAcqos53HOfUYcO/qT5td/26iqkIE0c3MCBk3NRVguHfs98ii1LT6ir2elPkm8sQn
         mJtKBhL2UI6sisHGn0c/PM0qbeSpENsxT4jeKInNn4fn1Z8pdKfxY3pQ9BBZIiu1xR9z
         8XS8xle/qIWZe3N2WfBTbV8mGNmWefxiMezuYMD5+fMeMwrsrJiOkWoID6K/8XokLV7a
         jmKw==
X-Gm-Message-State: AOAM531EUPx8QUQrmEmNSPyQo8quJagXmo/TgU4+WK1/2ZsXJjaThVAu
        wGvslnnUDl5cf1XwJPI4iZzoaTAv3UYN
X-Google-Smtp-Source: ABdhPJz4dFZxZ37NcH6OGB5NWytbGQwJt62+4qAU4i+rz/Y1LnFor5rxegWAq8JofebiYEc/pO27ztkLBYHa
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:d512:b04f:25a7:c7f])
 (user=rajatja job=sendgmr) by 2002:a05:6214:140c:: with SMTP id
 n12mr2370973qvx.39.1632955707380; Wed, 29 Sep 2021 15:48:27 -0700 (PDT)
Date:   Wed, 29 Sep 2021 15:48:22 -0700
Message-Id: <20210929224823.556943-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH 1/2] usb: hub: Mark root hubs on removable devices, as removable.
From:   Rajat Jain <rajatja@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     levinale@google.com, bleung@google.com, rajatxjain@gmail.com,
        jsbarnes@google.com, pmalani@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all usb root hubs are always marked as DEVICE_REMOVABLE_UNKNOWN
unconditionally. Let us try to help the users to identify the removable
root hubs, by checking the device on which the root hub sits. If the base
(parent) device on which the root hub sits, is removable (e.g. on
thunderbolt docks), then the roothub is also marked as removable.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/usb/core/hub.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 86658a81d284..45d1c81b121d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2440,8 +2440,16 @@ static void set_usb_port_removable(struct usb_device *udev)
 
 	dev_set_removable(&udev->dev, DEVICE_REMOVABLE_UNKNOWN);
 
-	if (!hdev)
+	if (!hdev) {
+		/*
+		 * If the root hub sits on a removable device, mark the root hub
+		 * removable as well. This helps with the USB root hubs sitting
+		 * on the thunderbolt docks.
+		 */
+		if (udev->dev.parent && dev_is_removable(udev->dev.parent))
+			dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
 		return;
+	}
 
 	hub = usb_hub_to_struct_hub(udev->parent);
 
-- 
2.33.0.685.g46640cef36-goog

