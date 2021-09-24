Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8344171D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbhIXM3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbhIXM3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D102C061757
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g8so35416225edt.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+O516dRas0PleKnQD2Ngp8BTWaQ5AdYStSXmf67/51c=;
        b=RtfMfEtoc9sHbAx/ZVBLjlg1CQGZwKVTszV6qxZwAdwOtCWRnSZi/JlHlqgQBb/vzH
         4u2pk3bxCBYx8iGx+iWW95PGUBfLUPnGnIJfdaXAPOQ8KQ5CLaBTbl/ltUb3FTQGS6Bd
         axFGHtIL36mESmeHItqsciFUmvr3DatTon8OCmsTCBaf84uCA7nlhNrDZBpIJ2FBK2SV
         5F2a0aBcmAnI1igFM9npwuwrV6v5u8eAC9zjR2SNICM8NCBTM+Ks3KtcceZ/SaxJAgzs
         TPKhVzoh2ZhtmzDNf2+vuLrtIBpp5Wuh2/UXxcKkfii7bTC+/dFk1RFa8xNFAnk3btFP
         qIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+O516dRas0PleKnQD2Ngp8BTWaQ5AdYStSXmf67/51c=;
        b=JudDWYEhGXFn7GiQ3r9u1ndmkHIIsmZOoFxdmQBHKY6MUFAqWnGzL640Wt7pLMbW8V
         XTrJngPorKUmEcrVk2N1uCYqijm43MInwtOd1x9FDY3Q6IbJ59CK8hiq5PyOH89wY9h9
         KWL8yNHvrk+4hLjzMocLPmumL2z4f+GKldVnMZgZu7BrZViAzt4cptrohf2OuTqQC2/C
         tUM2boktKt2pCO3dmanbuIK8hJgz9dE3VxawtVtI9OFx+9IBjbjBkj++evHO9+BZWeuG
         JeUgmnLPSajkfDepsBshgYB+wOsPb9lZK+ePEaftAKkCsFg+u3RS7bYPjp06xvaoZG7m
         Jz6Q==
X-Gm-Message-State: AOAM533pNRdJ267OXYnNvP+Bzph5mc7o7L9EiObXxCtaOvPt68kjuaP5
        48DxZPYgrtjx1ZvmQrYCjB8=
X-Google-Smtp-Source: ABdhPJws4kNyOu+0DEn2hN6VhHtSvSSEgFp4gED2OAHfh4c/8aZWo6rF2U52NmhgD1MASOpXvwkWPA==
X-Received: by 2002:a17:906:3b53:: with SMTP id h19mr10809575ejf.109.1632486462848;
        Fri, 24 Sep 2021 05:27:42 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:42 -0700 (PDT)
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
Subject: [PATCH v10 12/16] staging: r8188eu: Remove a test from usbctrl_vendorreq()
Date:   Fri, 24 Sep 2021 14:27:01 +0200
Message-Id: <20210924122705.3781-13-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary 'if' test from usbctrl_vendorreq() because
"length" is never greater than MAX_VENDOR_REQ_CMD_SIZE.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 04a878c1a87d..b3f8a76b5db2 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -23,12 +23,6 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 		goto exit;
 	}
 
-	if (len > MAX_VENDOR_REQ_CMD_SIZE) {
-		DBG_88E("[%s] Buffer len error ,vendor request failed\n", __func__);
-		status = -EINVAL;
-		goto exit;
-	}
-
 	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
 
 	/*  Acquire IO memory for vendorreq */
-- 
2.33.0

