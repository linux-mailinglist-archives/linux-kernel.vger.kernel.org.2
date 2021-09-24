Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08044171D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbhIXM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343605AbhIXM3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42021C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v10so30815897edj.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdFvvX5/HN7bvh9JTzeUFUGFd/lBuWQSjRE1lGqFFEU=;
        b=OgjdsnN4Ua1jK98rr1+qMkd+SRLUo9q7yLsln2Ibrtz+is/8y7YM7nsKVhY5xfnycH
         ldgA+bQZNJN9lQiwfDakdcigpKQ9m4VjmZygB89utZ9x+KcUOf253MXg50+fUj1L4Spx
         fdoh44TdzsrF4hzuQ/9WV1E7gkc6Obcttn0bNsd6ylB+RPcd8F8FIVbvl+qFjZh+johX
         oM7MQxaHNnGJTlzZXuLu+4kBIgZ9vTbb+zCF8GXpGRSzacr5jP/uZrrB1wAOWVpiVccL
         C04b+Sk/lWg7EIVUvjJlQpGm1D4EH1DaY4gHxbslpVZJBmklwR0NikO7M/a1NSmRZYFo
         gJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdFvvX5/HN7bvh9JTzeUFUGFd/lBuWQSjRE1lGqFFEU=;
        b=ocSB3usqlbyauwOKddrCUL9OXjsPXUekN0FJp512NLYispWh43nLW8hJluCtFhzIca
         /V21fO0zZdAR4haGcP4dLmIBPwNC5nuWF2BnQhHohQQktSHnTJ1rewzmNfLFJMIVlmdu
         ePB+XPkvEOIOq5GLEFD67E+wEbrHXN46hSV9lHWQZLZFMVEME/l0yDfXaQEoEX7rEeK8
         4+7dRDrVby+8fTyz2b5wGLGnHSyxJRZDbSfmcfuK0hWZrfWC9u5E2tUapxfklnpUdy80
         2H9S+q623UMlYEHw/OpiVoi1wfFMmha53VsAfqyS4wj0fcSg97Ovvh7E+Ila5glLZyhp
         9awg==
X-Gm-Message-State: AOAM530T3I8zdLH/HagoFHpOrxdsz942QZjy3m5NmJSyn9tckUV7laSV
        ZFSw1KIHc5ZsD7+4yDGsEKM=
X-Google-Smtp-Source: ABdhPJxOlRd6a5Cf6Z3o7CvUwTXlsBH9q3aOm9xHyuPWjQ349ZTj+Mcs1IY0UoLFxqbJhjId3406AQ==
X-Received: by 2002:a17:906:828c:: with SMTP id h12mr1614500ejx.414.1632486459878;
        Fri, 24 Sep 2021 05:27:39 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:39 -0700 (PDT)
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
Subject: [PATCH v10 10/16] staging: r8188eu: remove a bitwise AND from rtw_writeN()
Date:   Fri, 24 Sep 2021 14:26:59 +0200
Message-Id: <20210924122705.3781-11-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary bitwise AND because "length" can never be greater
than 0xffff since VENDOR_CMD_MAX_DATA_LEN is defined as '254'.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 8e4e578ed60b..3b50d2b5c0e3 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -176,7 +176,7 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	ret = usbctrl_vendorreq(intf, value, data, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intf, value, data, length, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

