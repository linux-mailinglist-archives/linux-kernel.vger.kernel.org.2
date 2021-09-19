Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5955E410DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhISX44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhISXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1770FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g8so54010055edt.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRuRxrDfiresVO0AJUGNoniq6DpbX4yHwIzQEFqu2CQ=;
        b=eTRjZxf8tBCNIzyC3hOwXENy186naPWJ72GzDOC1amEDygDzYbQNQ0Xep8wd+P701+
         L1habGBUNIZbP6Xj5EHGs5mccmakQOfK53vKUrQYEbfdq/idj0a3jzfz+9IwkFv5q3I+
         UX2Mo+UO/ORxz3BO7ZT7lfJ1TPnhXzif+C2n7hh8wzhmFBheuV56YLWwoeEzT8Qj3tA9
         JQInWkfk6BbVPGS1tYSRkY8OPoGa06547r1Q9EowxK3Z83Dts0Fmu9s91e7AtGcH2Rke
         kiLx+KCTDl9ODFGgsm9gjkMmxQv4zHVn5F4OWP+Cb5SldU6BaHQpU+z2DUTf0Tbb/LJt
         m97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRuRxrDfiresVO0AJUGNoniq6DpbX4yHwIzQEFqu2CQ=;
        b=pU7vrLZQHaqUZokdZCGryLcBdPBDQx1RmaEhQF20XFNwifGlQnOSaSo2YXhTfChyEp
         p2jwOnOKyKXwJ5vhj61JEwXb4tyCo6XXxR5OFkvE10NLh4LYD5BrIexh1J0le/GbMA3+
         j9CORmNp2eVv960Cg1eh6UuMEMpLOia4VqRRBjPOzLgYDBUtPvv85XbE0y/nRfe2hF57
         sbf2w2767M8nHMXnrJNtc8oYAsU4GFRo2uL7BXTrv4OqgZELB1AvkdPkqE9fr3Amxde7
         FG1AnqdkswL6Cz27rSqQx2RdKqaxOprhN8HCoiiwbub7kVS7TgYOJOPZBuKzRmp+cS+n
         Zotw==
X-Gm-Message-State: AOAM530LLL2pwRmLMuwW5L6uIZJrFrznypz1glzdJTGvRAI86ThxXg6O
        v1oMUDuVRDlGg6TiyBHF+yM=
X-Google-Smtp-Source: ABdhPJxtvh9Aub8PSF0x9sgqIELjjK1hExgmPs3D1ZwOiFAxXj8Hb0k/hwUEpLtAkXQrDfHjzXzxoA==
X-Received: by 2002:aa7:c588:: with SMTP id g8mr25223720edq.331.1632095648676;
        Sun, 19 Sep 2021 16:54:08 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:08 -0700 (PDT)
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
Subject: [PATCH v8 05/19] staging: r8188eu: remove unnedeed parentheses in usbctrl_vendorreq()
Date:   Mon, 20 Sep 2021 01:53:42 +0200
Message-Id: <20210919235356.4151-6-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded parentheses around a test for -ESHUTDOWN in
usbctrl_vendorreq().

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 9138b730490f..0b48dde5657f 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -63,7 +63,7 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 				len, status, *(u32 *)data, vendorreq_times);
 
 			if (status < 0) {
-				if (status == (-ESHUTDOWN) || status == -ENODEV) {
+				if (status == -ESHUTDOWN || status == -ENODEV) {
 					adapt->bSurpriseRemoved = true;
 				} else {
 					struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
-- 
2.33.0

