Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E183E3D0C23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbhGUJSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbhGUJJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:09:05 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7B1C061574;
        Wed, 21 Jul 2021 02:49:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j4so1357692pgk.5;
        Wed, 21 Jul 2021 02:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p64r8KL6wIevGGwT3Mir3GkMuoxd3eg4xzs6ImulFaA=;
        b=OYYSdOmikyQwETiV/RB4bb6Rq4zuo6z59GX3XQMgU2slIR/y9cGfoJ9smoIr2F7i0q
         3nDN87imoOIHCQ93r9jUc9mr+nKseaiX/STEuIPl6b87aobdaKyXhDyUV9eK8sBiAzRF
         5JdTA/7yB7AV0o1qRroWR6EhEhe2rEeTHU26huIVFZ9o6robQ0YvXx9nOK/LbHaUmxGx
         PcdP4CCezPv2K+HZu2ypf6EGiCS+l6ePMa+pkYXvQS0wfw+MqWDrC+8ZfYp98iqC8zuj
         QzXZlQi6twc68Zgbha9aEmTEboDpEtVNash2WzP+oxAKiL4VIqQ10sQaToPbI5fuQas9
         WOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p64r8KL6wIevGGwT3Mir3GkMuoxd3eg4xzs6ImulFaA=;
        b=c6gbfl6/OCdtgqrLRsJSxeCUszqFIRUwTdXl00AdQzVjk+YPRotx6MwItIrhOtwlTc
         g++sgiF5FQUaczoZmta/VIWkHd5vKiil+kIacG+WdHEVqz2+WjniQlXn02dz0OeLZVmD
         1hC6H0FpaWeO4XRUIFYMwlqIhaehD/C1CroqCLt6TUvRBglFyZWvIN8FrF/SIr3phABW
         /YjGWul1J2A4rGGBoaBUWwN8dWOkJSl6H02D+QgCj182itocGDeZf/3HE0E3BIWvkaaM
         b05QY7EihDvoqv0w5OqDWOlHDbXc3t1rT1Maq53/KyxkPHy4792KFv52yY+XE/Tg6V5A
         yCkw==
X-Gm-Message-State: AOAM531evvGJU8hOQB2SSmOfS0lDuQY5lqn4tNBdUgWjgFhGt+/ekLO0
        yVsz7TYRqXnI94ZiNCOmUww=
X-Google-Smtp-Source: ABdhPJz6UUZPtBAEHAso3bBHjzRnm6hr8zSKKVWOm/FzCx9nfmOqTEYbGN54PzWn31UlE1ADnAKKrQ==
X-Received: by 2002:a63:1f0e:: with SMTP id f14mr30807250pgf.65.1626860980979;
        Wed, 21 Jul 2021 02:49:40 -0700 (PDT)
Received: from michael-gitpc.. ([1.132.144.53])
        by smtp.gmail.com with ESMTPSA id l10sm3265581pjg.11.2021.07.21.02.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 02:49:40 -0700 (PDT)
From:   Michael Broadfoot <msbroadf@gmail.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Broadfoot <msbroadf@gmail.com>
Subject: [PATCH] vhci_hcd: Always re-enable a USB Port after reset
Date:   Wed, 21 Jul 2021 19:49:22 +1000
Message-Id: <20210721094922.15642-1-msbroadf@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A (virtual) usb port can getting stuck in a disabled state on reset
Always re-enable a usb port regardless of if its addressed or not

Signed-off-by: Michael Broadfoot <msbroadf@gmail.com>
---
 drivers/usb/usbip/vhci_hcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 4ba6bcdaa8e9..cea3781d04e6 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -455,15 +455,12 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			vhci_hcd->port_status[rhport] &= ~(1 << USB_PORT_FEAT_RESET);
 			vhci_hcd->re_timeout = 0;
 
-			if (vhci_hcd->vdev[rhport].ud.status ==
-			    VDEV_ST_NOTASSIGNED) {
 				usbip_dbg_vhci_rh(
 					" enable rhport %d (status %u)\n",
 					rhport,
 					vhci_hcd->vdev[rhport].ud.status);
 				vhci_hcd->port_status[rhport] |=
 					USB_PORT_STAT_ENABLE;
-			}
 
 			if (hcd->speed < HCD_USB3) {
 				switch (vhci_hcd->vdev[rhport].speed) {
-- 
2.30.2

