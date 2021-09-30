Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7739241DC22
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351847AbhI3OT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbhI3OT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:19:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC50AC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:17:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ba1so22857260edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Qs8ocYYWIoKCUwNvO6ccY6ArZAl7WcN4rLzhCGCErNs=;
        b=NDK7BxfZQG92fJR1PY3ARzwBJg2lnYIV2v23oDGJpOMeNr5tY1OcQuYt+hDtUYKads
         Uo7c0X3aZXmRRDEhDpY4QZmPHyOk4Vp65W3fzxClEroY2DYlJ4XUQjqMIKFK52vfvC3r
         iqvYi/S/LJjTLSpwDqah2kxShsWtmI+Tb3xVuTxu2D/QPs0/3AqnpnI/wbdP8pdFX08o
         DGt+fTwxPIWikeOAlSOsD4jrPUCcijSRmcwd+mtgOBMvvEW5CRGCQHAD+QTxCuYzmR4z
         I0rbqNosrEC1MTMmwfZ6bzWhdQ0JGocnnQr9gOGMwuzIJssSFNVVPn6cp4AD9zq2S5Ks
         Jf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Qs8ocYYWIoKCUwNvO6ccY6ArZAl7WcN4rLzhCGCErNs=;
        b=GLcjZyQeIpBQHi/8aENQ39aEa27zy1Z400NBOrKRP80e4e17wHDO5YyIhf76e84KnH
         KhOn18tmqgiQWmQ2U2ZY7BMWP3vGyYOfsDOihi0dmSsU9A/7KaVSHABaF9TmVV5BzyXM
         noYeCFj+djItRFvaObux6+Ij7SknXcB11UPCFiaqOu383hm39siYFb3W5cfVBk532pVp
         Lvdr24tKM6fX8tkjR9/zZmnLMYnLNtSK/XdEwUBHwVbYzf5I9uPJfR/gYG5BpG/Tk6n2
         h4I4K9ZwGLUajks/E9kIk4CVSj6SegmeC2kWj1BxFKH9llJi4Qch0TZKNO45ywcQ9pWK
         dfKQ==
X-Gm-Message-State: AOAM530GHv7W5D58lUz0v/6cDXdRblQIHPoeNFCCO2dFNy4+zy1s81mJ
        e7NtrBXFsVugwAyxNK7RyPIicfGkyZgh6x+Q
X-Google-Smtp-Source: ABdhPJzKztxn3aPGBZFDU/ZZGBgHWlkEtVRdG5CYj5erUk732ieUZ7p4U+5bFyzuPShRgw92S6EPTQ==
X-Received: by 2002:a50:c04e:: with SMTP id u14mr2860973edd.235.1633011379453;
        Thu, 30 Sep 2021 07:16:19 -0700 (PDT)
Received: from kkobus.whirley.local (94-214-33-179.cable.dynamic.v4.ziggo.nl. [94.214.33.179])
        by smtp.gmail.com with ESMTPSA id cf16sm1536708edb.51.2021.09.30.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:16:18 -0700 (PDT)
Date:   Thu, 30 Sep 2021 16:16:16 +0200
From:   Dawid Esterhuizen <desterhuizen@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8712: Statements should start on a tabstop
Message-ID: <YVXGsMZDGmdGjErJ@kkobus.whirley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This path fixes four checkpatch.pl warnings:

Statements should start on a tabstop

Signed-off-by: Dawid Esterhuizen <desterhuizen@gmail.com>
---
Changes since v2:
	- Fixed the patch comments to comply to standard

Changes since v1:
	- Removed the volatile comments as they served no purpose
	- Fixed the styling with corrected spacing as per checkpatch.pl
        for easier reading

 drivers/staging/rtl8712/rtl871x_xmit.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index 2e6afc7bb0a1..cdcbc87a3cad 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -182,11 +182,11 @@ struct sta_xmit_priv {
 };
 
 struct	hw_txqueue {
-	/*volatile*/ sint	head;
-	/*volatile*/ sint	tail;
-	/*volatile*/ sint	free_sz;	/*in units of 64 bytes*/
-	/*volatile*/ sint      free_cmdsz;
-	/*volatile*/ sint	 txsz[8];
+	sint	head;
+	sint	tail;
+	sint	free_sz;	/* in units of 64 bytes */
+	sint	free_cmdsz;
+	sint	txsz[8];
 	uint	ff_hwaddr;
 	uint	cmd_hwaddr;
 	sint	ac_tag;
-- 
2.33.0

