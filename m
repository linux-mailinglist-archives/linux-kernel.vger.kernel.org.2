Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296A539AF13
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 02:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhFDAfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 20:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDAfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 20:35:00 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EEAC06174A;
        Thu,  3 Jun 2021 17:33:15 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so3115228oth.9;
        Thu, 03 Jun 2021 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ywr3SjYl3WKKmwQ3Fg20fZRDwIirSCojptSroPciZd4=;
        b=XGRjNWMoOkGK17VtP81644bfJNu7hkMOymZctfCMM4mdg+Wz86bVmLTe+4/0Z3nIPI
         LHdbigQdMyb5MDZEq9Xfp4ebLPneJ3ULa0FU/0bFA8WsfC3AU3k5Ye0CvHFpvLcAgK6s
         TygBz4brMK7WwGZEXHRwkcm1C/or8qNw8D7ZDwUQxOXRha4zaJsyVjCA14i72jbPCIMP
         P9Wc7yqYekqg1h7ZlELhr3UZ3OviPb8r/6Jg/jyX7WolJBDXNqLfKi0DEiv2SF7/lISf
         WHCl6yktOW3kIar9Dxc4imQIFHGHH1IA9pCxmrgC0rr2Cndxh1sCOp6sBxF2YK4o+X65
         ksgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ywr3SjYl3WKKmwQ3Fg20fZRDwIirSCojptSroPciZd4=;
        b=UlwwerBQ/4kw0h5/QuhSJbYH4HWthXnJJRT11rCd0cMK4aIiN9eNAG9QygIj3RY7gn
         mAgodRBTEkbHcSkl106kTQxc33BzWhdqjT2dJobPdm4Oox7GDCAL56J7TjrXKTYrjuZg
         xnlBEC2UiwRq5BeyuOgmsnpUbZxwfpE9JiMK871PFvZ1Zn08940kLXGWwki7wYDNhBGy
         sbHiC2r8fx/ZONiTza83VJBdHoFVoclAwbnPNcWYBRF/z8Ea16JkHkPXBZHqoRrpEGjm
         FaW4OnltWLf8dOCIoWdFBGzgG0WQ04DHDW9qQ0XRvuBby8LdsciwZLhVa9oXlbBQeilC
         ql3g==
X-Gm-Message-State: AOAM5303sPte3IUMMRsAW/tCCG2GGikKEXUrHjbKlJpDqSz/sIQ7ysUu
        kadtA2grKZu2lmg6vsFUyykX/wAiaw==
X-Google-Smtp-Source: ABdhPJxkg3xbg690B9PctcHtfb2vb5cxI7uXx24D9p0nl8yj4DZiqyhwWEpXvc/iVNgYO/1DDqZEmA==
X-Received: by 2002:a05:6830:1594:: with SMTP id i20mr1551496otr.279.1622766793880;
        Thu, 03 Jun 2021 17:33:13 -0700 (PDT)
Received: from threadripper.novatech-llc.local ([216.21.169.52])
        by smtp.gmail.com with ESMTPSA id r26sm127174ots.8.2021.06.03.17.33.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 17:33:12 -0700 (PDT)
From:   George McCollister <george.mccollister@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        George McCollister <george.mccollister@gmail.com>
Subject: [PATCH] USB: serial: ftdi_sio: add NovaTech OrionMX product ID
Date:   Thu,  3 Jun 2021 19:32:08 -0500
Message-Id: <20210604003208.31799-1-george.mccollister@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PID for the NovaTech OrionMX so it can be automatically detected.

Signed-off-by: George McCollister <george.mccollister@gmail.com>
---
 drivers/usb/serial/ftdi_sio.c     | 1 +
 drivers/usb/serial/ftdi_sio_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 369ef140df78..4a1f3a95d017 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -611,6 +611,7 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONLX_PLUS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORION_IO_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONMX_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SYNAPSE_SS200_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CUSTOMWARE_MINIPLEX_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CUSTOMWARE_MINIPLEX2_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index d854e04a4286..add602bebd82 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -581,6 +581,7 @@
 #define FTDI_NT_ORIONLXM_PID		0x7c90	/* OrionLXm Substation Automation Platform */
 #define FTDI_NT_ORIONLX_PLUS_PID	0x7c91	/* OrionLX+ Substation Automation Platform */
 #define FTDI_NT_ORION_IO_PID		0x7c92	/* Orion I/O */
+#define FTDI_NT_ORIONMX_PID		0x7c93	/* OrionMX */
 
 /*
  * Synapse Wireless product ids (FTDI_VID)
-- 
2.11.0

