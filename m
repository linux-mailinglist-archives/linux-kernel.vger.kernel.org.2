Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB4838B56E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhETRsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbhETRsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:48:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DD0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:47:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v12so9522004plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaNz0pGgnw41U7b9/4YySDsutMOtFyU5/A1BP+vwOSo=;
        b=nCxzoJwnT7b6cU313aMMJaaa/LaDoZ4dIFz/OQLbUH1mpz+AZordGu5hYYSSoF3iuZ
         9jzy8zZoas868Og3FAhNYOhzCj2pdqvV9gHZYuJ5nbVWCIdbZNxc6kfmtl+GyipUpUAi
         FbVj/sxrrKf0Q25Z6ougkD5jPcdFSl7uW9HamsQTMVYAXiUbV5ovyPgE/vugL3v1mCVh
         6jh7FVqWmc7LhgJCPiiAxUAmAcMBzfDpJ1td1suJCAULiANv+WqwmOd4uyD1O3J7zZre
         mJbVZQwLGKY49yHvgTRqxv46eCFFLE6a83VkLBwO5pJp6DaHy4C7o/k+Kir4HAL/fYqw
         Di2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uaNz0pGgnw41U7b9/4YySDsutMOtFyU5/A1BP+vwOSo=;
        b=UndIRCccDswfOSaD2HxPJgd4PYMQOAYrscKNCny1PWV7Q+khy4IkqkQZYxLN7OMHxO
         /lSbcLdwAXLSYNZzBbNdhpLH/QUzjVHVJ7Tjiyynvlo6g/ETqZuIoqWalDk0QFLWLRwe
         Gjm53sFL4nsA4lgQvR/Xq3zyBy2H76i4y+65dj2cWw/29GNbBXdf6T5TEdFAxG4wUtLw
         uWF9TVOIi3yfxFQ1iu8bJBw0giSI/5tYZQ2dgrRMK9ZldOxmuMtrdNUEMas6B3P3Xo23
         XjzhChbnKOtXVQYyfZseI2bIoyk5Zu6THn5Yux40Kk/+7Vlw8mXm+0X4rbpZF0z2FDfc
         TZDg==
X-Gm-Message-State: AOAM531sGqgqf7eeWvaprcW35ac3Ir3izKYBmwtGXtlQDTJaJKhxrt9U
        nl/MdqlAUgNk2QrvJrOqja8=
X-Google-Smtp-Source: ABdhPJyxsXj/b5lWKiUQS4qPuu+WqQ2yEz3XfUJJmUnGQ5dI42+4c2/1SAu9dNtZLBLiOuMOjm1pkA==
X-Received: by 2002:a17:90a:7e09:: with SMTP id i9mr5967986pjl.166.1621532840693;
        Thu, 20 May 2021 10:47:20 -0700 (PDT)
Received: from ubuntu.localdomain ([103.196.78.23])
        by smtp.googlemail.com with ESMTPSA id t15sm5775310pjh.0.2021.05.20.10.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 10:47:20 -0700 (PDT)
From:   Hriday Hegde <hridayhegde1999@gmail.com>
Cc:     hridayhegde1999@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Sean Behan <codebam@riseup.net>,
        Colin Ian King <colin.king@canonical.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: emxx_udc: Fixed coding style in places where lines should not end in '('
Date:   Thu, 20 May 2021 10:46:57 -0700
Message-Id: <20210520174701.8370-1-hridayhegde1999@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixes were for the following checkpatch outputs:

CHECK: Lines should not end with a '('
1076: FILE: drivers/staging/emxx_udc/emxx_udc.c:1076:
+				_nbu2ss_writel(

CHECK: Lines should not end with a '('
1228: FILE: drivers/staging/emxx_udc/emxx_udc.c:1228:
+		length = _nbu2ss_readl(

CHECK: Lines should not end with a '('
1465: FILE: drivers/staging/emxx_udc/emxx_udc.c:1465:
+			regdata = _nbu2ss_readl(

Signed-off-by: Hriday Hegde <hridayhegde1999@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 741147a4f0fe..8364316c1d25 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -1073,8 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
 		i_word_length = length / sizeof(u32);
 		if (i_word_length > 0) {
 			for (i = 0; i < i_word_length; i++) {
-				_nbu2ss_writel(
-					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
+				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1]
+					.EP_WRITE,
 					p_buf_32->dw);
 
 				p_buf_32++;
@@ -1225,8 +1225,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
 		return;
 
 	if (ep->epnum > 0) {
-		length = _nbu2ss_readl(
-			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
+		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
 
 		length &= EPN_LDATA;
 		if (length < ep->ep.maxpacket)
@@ -1462,8 +1461,7 @@ static void _nbu2ss_epn_set_stall(struct nbu2ss_udc *udc,
 		for (limit_cnt = 0
 			; limit_cnt < IN_DATA_EMPTY_COUNT
 			; limit_cnt++) {
-			regdata = _nbu2ss_readl(
-				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
+			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
 
 			if ((regdata & EPN_IN_DATA) == 0)
 				break;
-- 
2.25.1

