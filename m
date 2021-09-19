Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A58D410DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhISX6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhISXzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9BFC0613E1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q3so54041793edt.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yoxfg1/FcSiARfNU+jPYNat+4eHygLLGuEwb7dEESSg=;
        b=i5bSKv7QdeEfoSfHm5QJHBy9FUVjhgX6jbNm0mQWjvrAVmvKjVI+K7xHf9m4CZzFOQ
         tmcdhY49jNIznZHcR3T5B4l9MChXLtoNOsbv5wqU3AGP9sH7VTkfVr9i77gP9JN4BDYX
         Bpcwb8kRawBPcRLTvbYX1MuotSmNTYVbmeOuNU/AXnugZJywNFT2CvzdG+S87KUwopSX
         co/YDXyRaw7p3kHi+Uz0SsortvCnT6TeN8E1aLnlzcCW16hplsyBdX8btgxMPEui2JYC
         XRZwTJ0yFGbw0VVmn0zTnzUhhuxhQ3p5jIEM46h42a8DkpStmuOZ8vEFYtj3mhl1OZdw
         RSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yoxfg1/FcSiARfNU+jPYNat+4eHygLLGuEwb7dEESSg=;
        b=BUtsokhpRgC5kV/PqPqTN6rCgDhH5eIlpbnpNq8dLkkbdOt/PiYg211Zb0gDoKwlS+
         8nT765WKvg/TEG5ZKk+lSVhoFMqByzhXyqZvnj3pgmuuFKp7cIabH0ZtIJQ82duRr8w7
         gr007U1UjxU9uGBOJyFhJSu8SQr+4GxH6+0rOwg+NRn55DeWBwWWgWAddrUCNhi5xZ2w
         rXOKV5WI6X/GVDTAh/0b1WNyGzh1A+Jga6PDIo13uC9HrMp/5XEpD1LdLDOGONweN03Q
         khKRJfhH/DH4UBcJr7pr29wg38G+dwfnIsvi1xtfLbAWA2xOup5jQUS5KBrWJ3FdpIu7
         ssrw==
X-Gm-Message-State: AOAM5313P0sPsmZ+rOxFF0P5SVmks+Jk3mDXkUaL/1rH5RohzvKW07QS
        4Fy1wm+bVOtOh74xlEQatsk=
X-Google-Smtp-Source: ABdhPJz2KvPUTI4l+SPpmeBJzGBgDaiLSaw9Anf1fKPoFPupXUg4sZ3V5tR2GTcPOn6qWnXhrmBuMg==
X-Received: by 2002:a05:6402:21c3:: with SMTP id bi3mr351829edb.79.1632095660433;
        Sun, 19 Sep 2021 16:54:20 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:20 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 14/19] staging: r8188eu: remove an unnecessary bit AND from rtw_writeN()
Date:   Mon, 20 Sep 2021 01:53:51 +0200
Message-Id: <20210919235356.4151-15-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary bitwise AND because "length" can never be greater
than 0xffff since VENDOR_CMD_MAX_DATA_LEN is defined as (a weird) '254'.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index aa57bd7b8f10..625b29af9410 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -178,7 +178,7 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	ret = usbctrl_vendorreq(intfhdl, value, data, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intfhdl, value, data, length, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

