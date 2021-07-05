Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150AF3BB8F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhGEIX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhGEIXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:23:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDB1E61415;
        Mon,  5 Jul 2021 08:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625473240;
        bh=SYTTcfYK+j/Pfq7K8TLV5XJAAQ7TNgyPYPL1DmPYZgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzYLpu895mILIUYywEBwmybrW6CpN3rxcCI5ij4RLom+rSkB2Q2DJCJx4Gy9zEq7h
         L3V+QgzuQMInQumSDAfCQsGT4uAaNHATlfcNLfaoQx3CSGJzNamYL/7PbChrq5Ho0D
         pwBTyeK7JAxKO+Rju/SdF0fVyXFwIUWBKaeydOmPKbcA2j8gOyAN7B3WE4J3NCDbny
         C4zyA+S6ZyKTgqI/FeuXj7hUULEEPtHFF1aLP+RNm9LpFJvoPiscuwFj03BkDE9cZO
         y0Fkc/1nB/Ff8H/sU0EdJhT0NS+KtSwUKnkaSpNCyBQyLNeIgqEbUSzLOBrpD3awk2
         q1KxGefktUAog==
Received: from johan by xi with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1m0JqF-0004m3-IX; Mon, 05 Jul 2021 10:20:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] USB: serial: cp210x: determine fw version for CP2105 and CP2108
Date:   Mon,  5 Jul 2021 10:20:15 +0200
Message-Id: <20210705082015.18286-7-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210705082015.18286-1-johan@kernel.org>
References: <20210705082015.18286-1-johan@kernel.org>
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
index 6aaf54f16f8c..51670c80bf67 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -399,6 +399,7 @@ struct cp210x_special_chars {
 };
 
 /* CP210X_VENDOR_SPECIFIC values */
+#define CP210X_GET_FW_VER	0x000E
 #define CP210X_READ_2NCONFIG	0x000E
 #define CP210X_GET_FW_VER_2N	0x0010
 #define CP210X_READ_LATCH	0x00C2
@@ -2107,6 +2108,10 @@ static void cp210x_determine_type(struct usb_serial *serial)
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

