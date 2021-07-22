Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296CB3D2A09
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhGVQIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhGVQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:04:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF3C061A48
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 09:42:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a17-20020a17090abe11b0290173ce472b8aso5154194pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pCFZoqp+BH8M6WvlQZlo0eVZuOKBtQAUn+OHR1du9kk=;
        b=hjOC/YjyNUBvsdhdgQf/IMUhlVQjfCsQ5NdHH7P0L4XV1zkJ/vSDMBMouZ+uPIsnui
         jFi3kvxxaGB1Z+yeNGMRUOFArKyXmNxrUOp0WGiSAji4yRFvQ/O+w/lOcnvjh+k2HJmO
         zmKBJvcV7zAUzR1zAOWJy/ZD4xIpAcThBvKd1Y9Ee6w8lphxV7Y/JlZqaH3JY+6apr1l
         AK+ccKq38i9/VihJJeqo8tnWwr3+IhhXd7RYS7UuOKA6bnnxXnXtH1/NqKLhOiH1uTKY
         B3BLGIKmE+JMfciZyC33WtNTUVhAMOlnQ1JsO5IwP/BGpAzrudOWtu1LIr2Klvnt/n9Q
         tp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pCFZoqp+BH8M6WvlQZlo0eVZuOKBtQAUn+OHR1du9kk=;
        b=VzeZBKvI4H1TiUM+jI06FacRhySC2Ifq0A9IHe35p5Jn5kzGgtkJSoPrnVELc8C3Xw
         9gjv62Ee5z3S8gSA1CKJBMl9KhVh+LHwEt4vZ1tLiyFAHo1J6d/b1s6qYn9ITQ7dm11H
         hWkUFFjHumeqUOgzfMqqjHa09GAZWdEpbHiwxrpoojPAww2x3SNUcbGc5Aqqmowup9qb
         gN+g5BZNNvNHkVZDq3ROFeHsDcQ9oetA3Fs8n7VCUCQxYZtqnXXv3zzpAeZWFYFXxbSb
         riBeilcQ28ZDDCdXqhStwihpNuj8IfTF1HupSjFHlBIZX+UuLTdqGNWW3uPeIHYMwgh2
         XR5Q==
X-Gm-Message-State: AOAM533ZGs6qju75c4A2kr85PGW0OwwOiIHXbrvWlBRBVLTwFkhQO1gZ
        k8tGxqVNdRb6MqkQGv6tT0h1/8G0862nRocw
X-Google-Smtp-Source: ABdhPJydFdXu9WSOKBA4rWcAem0aOZvpj191muPrFetwaIoQ4hkl3r9+itX6bS90WJMPBANYHwUK7w==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id w16-20020a170902a710b029012b9b9fc461mr387306plq.59.1626972149968;
        Thu, 22 Jul 2021 09:42:29 -0700 (PDT)
Received: from localhost.localdomain ([103.238.106.236])
        by smtp.gmail.com with ESMTPSA id n33sm34135903pgm.55.2021.07.22.09.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:42:29 -0700 (PDT)
From:   Jignesh Patel <jigs0101@gmail.com>
Cc:     jigs0101@gmail.com, Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Paul McQuade <paulmcquad@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: Line over 100 characters
Date:   Thu, 22 Jul 2021 22:11:37 +0530
Message-Id: <20210722164144.377781-1-jigs0101@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break various lines into multiple lines to respect 100 character width limit.
Reported by checkpatch.pl

Signed-off-by: Jignesh Patel <jigs0101@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index b817aa8b9de4..b83d6da01b7c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -254,9 +254,12 @@ void expire_timeout_chk(struct adapter *padapter)
 			updated = ap_free_sta(padapter, psta, true,
 					      WLAN_REASON_DEAUTH_LEAVING);
 		} else {
-			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
+			/** TODO: Aging mechanism to digest frames in
+			 *  sleep_q to avoid running out of xmitframe
+			 */
 			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
-			    padapter->xmitpriv.free_xmitframe_cnt < (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2))
+			    padapter->xmitpriv.free_xmitframe_cnt <
+			    (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2))
 				wakeup_sta_to_xmit(padapter, psta);
 		}
 	}
-- 
2.25.1

