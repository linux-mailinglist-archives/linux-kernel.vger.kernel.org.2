Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC94171C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbhIXM3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245735AbhIXM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4688BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g8so35413760edt.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hf9oTNZKOUajfI54KCH2+7bKh2Aob9UZCoTzOKf0/U=;
        b=g+y2bwV4S5HSM7/UNhyVMgzYjpWPL5xZcVx1nwxxvUWEcN1AN2Jv6qlEn90Z2TtYHA
         3G6fNtVr48I53gEXLhNgxAbawFjjR0QQHcTRfHdpqNuv9XYuYDUjpWLs/ydplmeYIQXv
         pny8lPA0x+z42dztZGOG16vOtz7DV0skw68lhfB8aygr9WFnytySzN7EJNhbzrLANscP
         Y/ccJHK2n5z/mLRrlpLDrfopruR+Mk+QLRpSx/yJpXSr7vm6O3UAOpZzfuMnMbfrpLQ5
         4pIxFfvFn28dK3nPA+Es9J8aUFRJ2WvsEzhRHGI81CXmtDHW8PYBCpm2gsWFj4vvyw4c
         afFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hf9oTNZKOUajfI54KCH2+7bKh2Aob9UZCoTzOKf0/U=;
        b=cPX9+4Cuo8leXLrmuqxKD6iF2eo8/gbOLzk+u3fHDNwRDctglK65ee7GHeD/hJpiWw
         Le5QsGzWubuK5hEnY+JhjBe10VT9Qx9Rw6yibxrn6DGdDxqaXp0bDLve+MlmWQAsN0Wq
         aeQ1ccePaNRy36YRLhcm0Shgy/dxjXGLasPGMR21nYJacWebh5HjQD3F9SLzR0sH+nil
         qFLGTN7uk08hpEQmUT2SN09dfdYUvM8JMwDU3WyjLzluSV/dQNqKIrlaQuPGM+7wah6y
         ircwntI24ujaIP59PVO0INtHjR29AJIvqo7+fQp7RbK2JJhPfj+7/t39+3LucjN+1LPH
         hugw==
X-Gm-Message-State: AOAM5303cAafacFvCcPlwUEVkiuqYH7lJ0eaWSGRoBIF8YHPE2TiVqG9
        DI878vCDrESjE2SQWuxFTv4=
X-Google-Smtp-Source: ABdhPJz1qNDgMZOjFL0gYWMsFE9wBr4IWvS8BZN3HgpcFlDxgCaPFDgmKHAvNp5ynWlMV4L2jl2jvg==
X-Received: by 2002:a05:6402:150a:: with SMTP id f10mr4710563edw.318.1632486448860;
        Fri, 24 Sep 2021 05:27:28 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:28 -0700 (PDT)
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
Subject: [PATCH v10 02/16] staging: r8188eu: reorder declarations in usbctrl_vendorreq()
Date:   Fri, 24 Sep 2021 14:26:51 +0200
Message-Id: <20210924122705.3781-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder variables declarations according to the "Reverse Xmas Tree"
style.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 3e7bc510197e..84ec7c1346b1 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -13,10 +13,10 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 	struct adapter *adapt = intf->padapter;
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
+	int vendorreq_times = 0;
 	unsigned int pipe;
 	int status = 0;
 	u8 *io_buf;
-	int vendorreq_times = 0;
 
 	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
 		status = -EPERM;
-- 
2.33.0

