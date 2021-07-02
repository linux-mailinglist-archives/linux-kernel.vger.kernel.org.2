Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0C3BA16B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhGBNpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232714AbhGBNp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:45:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8ED306142C;
        Fri,  2 Jul 2021 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625233376;
        bh=iQ511ti6tPKWj9+Fpr2R4MwXkxW+DRti6nYPHc/VfnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJrROcYyJBc/V9bdA4lRLf5PAh6VGY6cP/rxMpe0lJy32mBWVKnZsPZyDqxaGR5mS
         knrn9+2pYfVRsUyxGCokMIkRbWJwtFwkc1nGYE8U904yUQCxv7rd+6It3KmpIcCtn2
         LZ5My1NvIAXgXtBJf8oidsjG3v1J5UYEBShvQVcNTmAU+nw+mM0i7FyLGFZULqJFgL
         3MTYnpKGaN7d5Dge+GRV+7z4gxtKmet3OdIWqI6GO5KAl6O3+iPMKKNOcltjJ/ByJN
         5kJbPiaSC50QzzdrrsbvnSYGd0hrtLXZQxrze6sqSuzttl70OiqCqisNDMcL4d4Yhh
         rquobRv8M5Uiw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lzJRT-0006QH-Cv; Fri, 02 Jul 2021 15:42:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] USB: serial: cp210x: determine fw version for CP2105 and CP2108
Date:   Fri,  2 Jul 2021 15:42:27 +0200
Message-Id: <20210702134227.24621-7-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210702134227.24621-1-johan@kernel.org>
References: <20210702134227.24621-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CP2105, CP2108 and CP2102N have vendor requests that can be used to
retrieve the firmware version. Having this information available is
essential when trying to work around buggy firmware as a recent CP2102N
regression showed.

Determine and log the firmware version also for CP2105 and CP2108
during type detection at probe.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 0f4cdba160d9..7908e336f962 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -399,6 +399,7 @@ struct cp210x_special_chars {
 };
 
 /* CP210X_VENDOR_SPECIFIC values */
+#define CP210X_GET_FW_VER	0x000E
 #define CP210X_READ_2NCONFIG	0x000E
 #define CP210X_GET_FW_VER_2N	0x0010
 #define CP210X_READ_LATCH	0x00C2
@@ -2103,6 +2104,10 @@ static void cp210x_determine_type(struct usb_serial *serial)
 	}
 
 	switch (priv->partnum) {
+	case CP210X_PARTNUM_CP2105:
+	case CP210X_PARTNUM_CP2108:
+		cp210x_get_fw_version(serial, CP210X_GET_FW_VER);
+		break;
 	case CP210X_PARTNUM_CP2102N_QFN28:
 	case CP210X_PARTNUM_CP2102N_QFN24:
 	case CP210X_PARTNUM_CP2102N_QFN20:
-- 
2.31.1

