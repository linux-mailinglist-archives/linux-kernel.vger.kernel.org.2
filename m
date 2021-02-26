Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF3326468
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhBZOwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBZOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:52:43 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4137AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:52:03 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u20so15296399ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BcTToyzpeOpMOHGf2502u3oDLI9dQyecgjyBUkdWpJU=;
        b=QzVQuEjUz3ppI18P4bRTN00h0uHT541lO9ITFI02yXlfF9/DhS0PGUFkeU+9H4HY3d
         wN9Sp32D65lwcRqK4cKGMYL80hdoa5n16yXfIIqOJlbozAGUOto9zI0WtVf9Ql5amtWg
         CWG18LsyRBnSUxasdsvMgkcQkh8sRcmCzhuBNZIy9IbDK0S8M5VYJ0jTLCkq6aZgC4Jc
         IPwhqeAPp0Oh9oKUZ9awwIH23prx2xuFWDHyixvX+VUIawMfPjPVMacuoF3qidDZ2Jjr
         KWGEa2qA/A9uQuAFyf7oVQ+yBhOOsTnpj95o6YT6f9TQJyS2oj0S/A4A4IxDJ48caF1t
         46sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BcTToyzpeOpMOHGf2502u3oDLI9dQyecgjyBUkdWpJU=;
        b=ilWLGP6FZes5Oy+j809TghAyz1kMEc3Utd6xzp4wxI5xwf0jb2eCZvsrnwtN/cbLkT
         yqOoh3I4DPc2UEnePBo8VDHVynlDMTM8sJCy+6RxIFz8oPrroIZx+FI/hlAw8KUUt03c
         d6j5DvXLvYztPboDLXbjb7jmrkZRmNVBsEUUWm91s8dolEYooH5xCxzHmGmz4vlOG2wp
         1zh6zS9b6YP/z+ud4YOS5+aZOsRa2srQs3NSLYgqojktRHpeaSlnvNFKZz1qBxU35LVb
         9gSw6N/3tsV7ZrZP9sYhgatapsdfaSiJPl+sAp2v35CMmk2sfgTW+qZHv4ahUd4ceHYs
         kH+A==
X-Gm-Message-State: AOAM531ZtXLa4MfVqU05SNuGtuK872+3Jo2O6/gCkTv72ToIR0A2U04P
        xI6gZSxeEXTF40uoPD1HDGVf4Zz6Ft8NRSwa
X-Google-Smtp-Source: ABdhPJyiANY52+/vXMbXgLIX7IYTgMTMZ2ZhjyL9Ed6ngh1Jd33Uh9tBqMCNX+e+dlo0TJHUYuWGPA==
X-Received: by 2002:a17:906:5043:: with SMTP id e3mr3802802ejk.260.1614351122015;
        Fri, 26 Feb 2021 06:52:02 -0800 (PST)
Received: from ubuntudesktop.lan (205.158.32.217.dyn.plus.net. [217.32.158.205])
        by smtp.gmail.com with ESMTPSA id c9sm5964663edt.6.2021.02.26.06.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 06:52:01 -0800 (PST)
From:   Lee Gibson <leegib@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Lee Gibson <leegib@gmail.com>
Subject: [PATCH v3] staging: rtl8192e: Fix possible buffer overflow in _rtl92e_wx_set_scan
Date:   Fri, 26 Feb 2021 14:51:57 +0000
Message-Id: <20210226145157.424065-1-leegib@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function _rtl92e_wx_set_scan calls memcpy without checking the length.
A user could control that length and trigger a buffer overflow.
Fix by checking the length is within the maximum allowed size.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lee Gibson <leegib@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 16bcee13f64b..407effde5e71 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -406,9 +406,10 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 		struct iw_scan_req *req = (struct iw_scan_req *)b;
 
 		if (req->essid_len) {
-			ieee->current_network.ssid_len = req->essid_len;
-			memcpy(ieee->current_network.ssid, req->essid,
-			       req->essid_len);
+			int len = min_t(int, req->essid_len, IW_ESSID_MAX_SIZE);
+
+			ieee->current_network.ssid_len = len;
+			memcpy(ieee->current_network.ssid, req->essid, len);
 		}
 	}
 
-- 
2.25.1

