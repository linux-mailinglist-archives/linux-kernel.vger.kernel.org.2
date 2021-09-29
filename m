Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F12541CF74
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347349AbhI2WuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbhI2WuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:50:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E76C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:48:32 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h25-20020a0cab19000000b0037a49d15c93so9242346qvb.22
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mFpUuvuBysqSnfHqvwDvzANzBcF7cW/0AhHxyq0yb1s=;
        b=Xxllz9r3zQ7FdUefiuUS5kevHpMWap6f7+0JlD4MKmf0vYLOLs8VBSHFqjD4OumEaD
         RDYBm8Jy09Ot4eBxC8XZ2evmtT/TUnNRfKWWxgfbvvLLLw6Y5CdRYIuHAtiPSSdz2ypp
         0mX8FBiJoz3+zzwvyoM+OW99mqENXsgT/YZh52LKZXPENBF9oG9Lm4/KzRj8hq168pB3
         J3LxLTZoccMlTP5bkJeYeD83tJO0+3RfRMCVT5TAK2ItacCStU4+4Xu3gp1SEjR9W4/3
         ihxpjvO21LGKWM8m4B0VRNh7L20IHZw43CTz8IT/i5EGqFETOjFrNxTv0BSNuoLAFSVO
         tLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mFpUuvuBysqSnfHqvwDvzANzBcF7cW/0AhHxyq0yb1s=;
        b=4byKpe+wngkp+JCPFbPxlbW5NXD+dx/cGzP87oi64CYEv+qG9apuWkpCHsOQDq5Kwf
         m9IVjL1TMlklSoLgVIsePYDHhuvhoqTxYYAJT5NocgK9NHm46OYHw1/cUVYQIeIfcZ/v
         We6JzAU/Ol+AMTyzcC2lJyuLAhpLelTj44joh0q7C//x21iIV4Khul4O/MIO+rEthW3d
         4BW76WeZ2yVNrOPlmRH9tQs8/zndwfNXpp49eQ26GO9p63qeiD0EsBBK7pr1EbDPJLTl
         bWLhJJYuxzxKg0aNLYrEYu7SUBfMTgj6ItDeFx1aRaz5QKSpXEe6y2Begms933pDM00N
         8BUQ==
X-Gm-Message-State: AOAM532Ru2ISIU6c/xWoy1QrdwFZqVG7sUqeoYvJQytUJOAUgl/NYq88
        0siFOErRtJnhC0hXcYfIx95pO13KTQYL
X-Google-Smtp-Source: ABdhPJygHQnglVl5yNrmZd8JNAstsl85b+1dCuzHHaOIhfPNgsUwoZudN05/VWdUigVG1DEnAP/66jrp3aib
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:d512:b04f:25a7:c7f])
 (user=rajatja job=sendgmr) by 2002:a05:6214:122e:: with SMTP id
 p14mr2344816qvv.37.1632955711698; Wed, 29 Sep 2021 15:48:31 -0700 (PDT)
Date:   Wed, 29 Sep 2021 15:48:23 -0700
In-Reply-To: <20210929224823.556943-1-rajatja@google.com>
Message-Id: <20210929224823.556943-2-rajatja@google.com>
Mime-Version: 1.0
References: <20210929224823.556943-1-rajatja@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub, as removable
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

If a usb device sits below a removable hub, mark the device also as
removable. This helps with devices inserted on a standard removable hub or
also thunderbold docks, to be shown as removable.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/usb/core/hub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 45d1c81b121d..901d74bcdbd9 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2449,6 +2449,13 @@ static void set_usb_port_removable(struct usb_device *udev)
 		if (udev->dev.parent && dev_is_removable(udev->dev.parent))
 			dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
 		return;
+	} else if (dev_is_removable(&hdev->dev)) {
+		/*
+		 * If this USB device sits downstream a removable hub, then mark
+		 * this device also as removable.
+		 */
+		dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
+		return;
 	}
 
 	hub = usb_hub_to_struct_hub(udev->parent);
-- 
2.33.0.685.g46640cef36-goog

