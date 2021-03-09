Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8C6332858
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCIORh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCIOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:17:26 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD259C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:17:26 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so5082191pjc.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PERnROPDS6majMQmO2xScJnwwJrNGak76ViyrQxoAAM=;
        b=tnCoog0WRvk39rDmXkBLIhrawSpZJa1/qvua5bZc63EEr+wbHjhtc8oWBX/34GBrHo
         51s0Pd0MKAoDr257fNUnK54oWy7TdBChFnETDujcINUvYMKUEEIJS7PJ1dC/C8YIPKcq
         WLmD4bm1YqdsCDh0atqLGPGgbka248zwXrGcA1utqvCnMPeBrBK1lLtQMIumTegreVms
         KEIWbdqfr5CRjxeISrg7iDA91l/14mGKLHA/+pN2NUdeuKhQuSvFNcKwVO42kO9cVyRq
         Mr7oeAyuF3WHrCcaBh2MboBDUlL7Wjija7DxTzIm8nAXfSy9MEWW6HuFq43Veoiq8cDh
         4nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PERnROPDS6majMQmO2xScJnwwJrNGak76ViyrQxoAAM=;
        b=dq+iEduxKApZv15j8ldo9XpTuKrm4hDMAzegTWGlEd6eWGkJsL+9t5XoawNXvsTGWr
         fPFRL/1WpCjz29TfTrSpOikwkDlF3gzv3nQ0isXhe8Z9ypm+Fyn5U3LkPLNR+5mbf/B+
         TkNGRw34K9erUEvPWik8npZT4g9w8+y2qnUaiYJ6VRicT+DMZUe3v/RpoW4ryzyOMxDA
         KN1gjQPtRdPvdYNNRWh9iKfbImEckwYifXn3pO/4a9oOaXtUjT4ahoLasR+ra116ka79
         HY65xz/CGcXsKDYE4YM8KcMKlOtInl4o+JPF/2rGZcUa9iZ34B7wcpT89tlUK45xvh31
         1yUQ==
X-Gm-Message-State: AOAM530pb9Rok9XQm2Br6kEbC2Z6rGpogtLdxe/Se2qFdb4aRIDSMofp
        OPT5dNK0s0oB8YO8fYDkGAye+/OTZgIbrz6Z
X-Google-Smtp-Source: ABdhPJzpUdPG4UaEgdCj/cr+A4hLNmqtMU3NpjRUngfQzOxbCydMcp/T68de2Ho1p3nqMVy119i2hA==
X-Received: by 2002:a17:902:ed88:b029:e3:6b9f:9ac3 with SMTP id e8-20020a170902ed88b02900e36b9f9ac3mr4154307plj.72.1615299446337;
        Tue, 09 Mar 2021 06:17:26 -0800 (PST)
Received: from localhost.localdomain ([116.73.168.170])
        by smtp.gmail.com with ESMTPSA id o3sm13043490pgm.60.2021.03.09.06.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:17:26 -0800 (PST)
From:   Selvakumar Elangovan <selvakumar16197@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtl8712: fixed whitespace coding style issue
Date:   Tue,  9 Mar 2021 19:47:21 +0530
Message-Id: <20210309141721.16772-1-selvakumar16197@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed additional whitespaces in the rtl8712_xmit.h file.

Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.h b/drivers/staging/rtl8712/rtl8712_xmit.h
index 0b56bd3ac4d0..e4c0a4bf8388 100644
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
@@ -89,7 +87,6 @@ struct tx_desc {
 	__le32 txdw7;
 };
 
-
 union txdesc {
 	struct tx_desc txdesc;
 	unsigned int value[TXDESC_SIZE>>2];
-- 
2.17.1

