Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F182241D9C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350852AbhI3M3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350215AbhI3M3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:29:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1588C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:27:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so21243206edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=S0kPemQvYyWPRiMxwk9lRwARw4Dkv4jXuFkeqojHeV4=;
        b=Vn8t1W/jTLGQVIAhhXNrjMZTytr/0doXtGzd3pVMgQJ8Z/LY05QtrndKgyNRZvAnz5
         IV2a51XASBuR2nwGNtRwzXoKmnUVw/0kKmFosDceydabt0lxckNuNcpsnnSpjRJtX2/b
         ycOdxyAxmGuHUwC8iwgd7i+/5pCxzFYx9kZVv8PcqMVZyY0Sd/0GZ6Z2BCb5PGG8qNro
         VULdsrJ3CEU5RiFSvqsdtIbB0LNmPFIj+WtmtvsRN4uuZ5+USc46gXBhp0gLKJ1YxvTj
         fad375nBcMV1qeGQPv9M7tiyrt1QxVp0EFD+7mQ6U+s/L4YD+YMldIGEHoY90QhgYfAc
         9SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=S0kPemQvYyWPRiMxwk9lRwARw4Dkv4jXuFkeqojHeV4=;
        b=FPDmuJaVXjB4fjRrdVphu8Pbutad0U4vlZHOquUkcmhhLXQXOI19KhMJuYP+TuYn1s
         KRtHUz2rUDxWBy0UoEw1noIxMe0V6o/gkx5CnsjBN8pF0yFPpc+4ONqY3YcgLY6P7vCn
         PQPFcK9Wv11oFG/KqA+d2JzSb87HaIIFCbuMRgUwvpGqhlu2vX0dDnQ13B859j8TIUy+
         qKbSIMfbBvCxYJBCkqIMwF9JnW2jfKFqDJBu1AsM6rzVYMaks8yt+lfToMYjp8y/5gqJ
         WHUpQA+TXYHrl9GiC26airrcKt6jzCOTBp3KDQBW3bXQxK2251cCDnWSvKKtTOfv0+nr
         dQWQ==
X-Gm-Message-State: AOAM532LIyXLEfSUqIQ9ypBU6YM+PhtagZmaj0BN8b/0PthGwRvW197c
        mYAdbKItaKTjmeWZWNawWNIrBlc6SLYmNHfZ
X-Google-Smtp-Source: ABdhPJwMe94yRoglqWS5X8k/OrQ9yagaSW0SG3zEeeayVL6WuE9ornanXLe85qtpGEyAGC7/6lMPJw==
X-Received: by 2002:a17:906:5e4d:: with SMTP id b13mr4039917eju.428.1633004839233;
        Thu, 30 Sep 2021 05:27:19 -0700 (PDT)
Received: from kkobus.whirley.local (94-214-33-179.cable.dynamic.v4.ziggo.nl. [94.214.33.179])
        by smtp.gmail.com with ESMTPSA id u18sm1389634ejc.26.2021.09.30.05.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 05:27:18 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:27:16 +0200
From:   Dawid Esterhuizen <desterhuizen@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8712: Statements should start on a tabstop
Message-ID: <YVWtJDOVInwQoHss@kkobus.whirley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This path fixes four checkpatch.pl warnings:

Statements should start on a tabstop

Changes since v1:
	- Removed the volatile comments as they served no purpose
	- Fixed the styling with corrected spacing as per checkpatch.pl
        for easier reading

Signed-off-by: Dawid Esterhuizen <desterhuizen@gmail.com>
---
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

