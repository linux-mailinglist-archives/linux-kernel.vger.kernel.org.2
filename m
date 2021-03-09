Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A0B3325E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhCIMzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhCIMyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:54:50 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5059AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 04:54:50 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id l2so8703284pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 04:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UHGEau2CR3Zf0FehLU8kNjTEbePgoadEpgpDDWs/gXA=;
        b=n/o1C0e8yaf4M8DRWhQh+xY5+T4LcUl6vejm5QmAk//yF4SpYJVCfotpcH5T4cP/cM
         iBwJF3VFhH9o/tkiVuJaJCCxWvcMLHhmWcjj9h84PbsmH/wbDUKzBluDD7CMXuJxvHv4
         wpExQWZiBZWi12ihulWowpDrygEiEwRT1ghe8oN4l8fdc4i+lVCfgljRlw1HVXnTb96+
         xRfNnTpjn7OX2M+nuG2XaQxsZ2Rztls9NiZLWHvo9weIBmRMYukC9leaaTOHzgPzL4pX
         qkEtgbGdZs9gh8q3XWWh5eufTLhi8I1YjAo5YNUcbZly+ZLAFknoVGR4u3QZIrmtqhll
         jZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UHGEau2CR3Zf0FehLU8kNjTEbePgoadEpgpDDWs/gXA=;
        b=V9Ql7zc/xXKKcVB06GEQ9lo/1reVbtx5ZC+cOuCeQ4a9S6xpjvcc4DkPU9pbQ7htvf
         yws7SGh0/zTD52K1csngxBavLvSiwXvkfPpFeDcikqhfO3wwGY/ONnYozgbIfEAkkzMa
         xpfQGOMAbeKNf5dq9VrbVzyCtfYydJIXPW+wPcUxCy0bfG8YgrsfPUrFfFa7IaBpM39Z
         04HDE+gIW9xh3Z86wXUdzz9bUhCFEV8l4ai/srWA4nWiOAZdAJWZQdwsy8sa9Q7znCAR
         JI/Ae41Gq3Hyy8fGNG72uHzU7McdEPMiy8HtzdbeH3aNkSLM9iM7e++LM5Vn/FC3N35y
         vb+A==
X-Gm-Message-State: AOAM5310/aldK0AWjnnkoBYJ/bwx4vBvT2RsdkRluhzBbIADPT7Lif/7
        QxI3rV/xVbXNjQmkFCNwW5Q=
X-Google-Smtp-Source: ABdhPJwqB8tjuHrLcsi3Y5/s8pzw+6cl4lIsKlgnU6PTT1wG7nUcvZt2jLeJajD/WnTCsI+W1QX6sg==
X-Received: by 2002:a63:ea50:: with SMTP id l16mr24257661pgk.442.1615294489833;
        Tue, 09 Mar 2021 04:54:49 -0800 (PST)
Received: from localhost.localdomain ([27.4.151.14])
        by smtp.gmail.com with ESMTPSA id f19sm13655234pgl.49.2021.03.09.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 04:54:49 -0800 (PST)
From:   Selvakumar Elangovan <selvakumar16197@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: fixed whitespace coding style issue
Date:   Tue,  9 Mar 2021 18:24:45 +0530
Message-Id: <20210309125445.15167-1-selvakumar16197@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed additional whitspaces and added space around the binary operator in the rtl8712_xmit.h file

Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.h b/drivers/staging/rtl8712/rtl8712_xmit.h
index 0b56bd3ac4d0..5cd651a0de75 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.h
+++ b/drivers/staging/rtl8712/rtl8712_xmit.h
@@ -36,10 +36,8 @@
 #define MAX_AMSDU_XMITBUF_SZ 8704
 #define MAX_TXAGG_XMITBUF_SZ 16384 /*16k*/
 
-
 #define tx_cmd tx_desc
 
-
 /*
  *defined for TX DESC Operation
  */
@@ -89,10 +87,9 @@ struct tx_desc {
 	__le32 txdw7;
 };
 
-
 union txdesc {
 	struct tx_desc txdesc;
-	unsigned int value[TXDESC_SIZE>>2];
+	unsigned int value[TXDESC_SIZE >> 2];
 };
 
 int r8712_xmitframe_complete(struct _adapter *padapter,
-- 
2.17.1

