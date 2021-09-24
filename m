Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29F24171C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbhIXM3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245757AbhIXM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98980C061756
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y89so24664776ede.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8J0b/n/pwhYzMH+qtOX6Qmp8dqFy4rk3PZYvNn2b4c=;
        b=WqFntFslHdbEtxPj6GYJhEgJGv3fIZa1OjjkCfHq5CyOPwyzzlcReo5OWpVc7zVdz0
         J/5KAwLAxz1cfRhZ62JmpvJANPeDV+G6eM+S+6rjbvwam6qBHGsIP7hIdAL6qWeEzKft
         7AEKmkfKYpr3pEYzpKYDsigdSTVBFhLClTqxuYMDHUj9w7bSwRoX8byPalrdGKmofuTx
         5wGL0naUGWyq8SISv15KRCgKLxy/lI8wU0N16ShYuvNeElx5T+n2pj2PU1GKl/jFFgHJ
         yqaQJvDfXsxrpavXONAaH6IdA4Eye0gcD5wzdnNoSbkD4GR5fmvsZLvpJcwMXLkjZ8c7
         MIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8J0b/n/pwhYzMH+qtOX6Qmp8dqFy4rk3PZYvNn2b4c=;
        b=A5+tLKNWgp+3iS6AoN8uzyoziYQfusECogBYiYKHC3kastaWrZLtpgWasd/M1EQqUD
         jdo5hu2BoY8K5KUp6Tm5NVyKXhOpgoh/u9ax7gsh3zfcpQ8a5xT6uXNutZvYsUXCB1XD
         NBw7VXQohJZCosgUKwCjwZ+egHbC8LDvWUD9CEmvQJ3keombXYBLp1ButA6IOpjxZvax
         EKTEeA0kKtp6eA2S8B7QHdkdcgoQGckyLmwA8E9fHJEaAOcAv6F8i3qO1dcVX2JOVpta
         DNXCa5nqjYjKeNDQYKNWPIqreQR28xYa0eH1sxyJS0KVezUChbQhSvf5jaw+W0HQn+lo
         5Inw==
X-Gm-Message-State: AOAM532XLbohj4uQ6ZIjbnSp2YHyneGsAGQYnoKnMvUH88npRwiI7mD6
        aQzuWbZqYo7JLYNRS8GyPmM=
X-Google-Smtp-Source: ABdhPJzCWMbqW4O1631UYz1NiKax6LgkFOh4eEd37wdLvM2744vuBoRxBKQSYzk8rHmsSnrLFBFlaA==
X-Received: by 2002:a17:906:584:: with SMTP id 4mr11015083ejn.56.1632486450230;
        Fri, 24 Sep 2021 05:27:30 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v10 03/16] staging: r8188eu: remove test in usbctrl_vendorreq()
Date:   Fri, 24 Sep 2021 14:26:52 +0200
Message-Id: <20210924122705.3781-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary test for "!io_buf" in usbctrl_vendorreq(). This test
is not necessary because io_buf has been assigned with the address of
a region of dynamically allocated memory (dvobj->usb_alloc_vendor_req_buf)
by rtw_init_intf_priv() in os_dep/usb_intf.c.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 84ec7c1346b1..61a016e3608f 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -34,12 +34,6 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 	/*  Acquire IO memory for vendorreq */
 	io_buf = dvobjpriv->usb_vendor_req_buf;
 
-	if (!io_buf) {
-		DBG_88E("[%s] io_buf == NULL\n", __func__);
-		status = -ENOMEM;
-		goto release_mutex;
-	}
-
 	if (requesttype == REALTEK_USB_VENQT_READ)
 		pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
 	else
@@ -91,7 +85,7 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
 			break;
 	}
-release_mutex:
+
 	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
 exit:
 	return status;
-- 
2.33.0

