Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A5640118C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 22:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhIEUn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 16:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhIEUnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 16:43:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41ABC061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 13:42:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y6so7759926lje.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7sHgNwoOa9//VFt2qH71qaB4nY0YqNgFxnvDIKi9n7A=;
        b=ewz96NKaP0huTasPQ+6dlHcI+kGp/c+PQbklf9XQ8n23FwKVAVteMg0/Obqlz3q38K
         mmdq5T7vTz+tEa85vpuQTgH8V9d0QAO5/ayY6P0or+hjJivVYlwMMZjYOEBEyjBk/lde
         Ts/fPxRZ9nhZmY6DXjkjAZoeWcIz5JNeCGlzdjCk+vgFl/bzlNAYneTVuK36BRUiDPr2
         oCOiEvfCx2mcGQpmyEZpivNKYAipyK2IKOqV/6SxkeypSGU95mDIFujjyQYKhjfFPrY8
         6slDThKBy8EfKAMZ6YIvj6SSd49ltmdXu6Z1f3GcDRJT732F3tB2va+JqUHpKLxSMTlN
         d3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7sHgNwoOa9//VFt2qH71qaB4nY0YqNgFxnvDIKi9n7A=;
        b=lq7Hw74JYbuF2EieaOW91GdbXeISLubYzfkLB9d4U8CZHeeVPEiqlujNNVTB2oKm9h
         YJ5YBAR9ne7FWKvdj98ee/+8DXDkwqTdPH1itY4aSJbbUBbWcqvt7+Cw9ko/yE3If+63
         SALJoD/x5OMlYuXa8kXg2BoSb66Qq9OnCtIE7qPJtfJmxUL+UUjJG1L5IUUvoZ25x1zI
         ADRoxQzg5pZaCG4k92JgJwObexjnoeVQv2mF1Iqfk0J7/06P6L6jgUrUv7GdB0R07cYp
         m/hZaFgcj4RHFiOwK7wPQO79ZxZ+BqaKZzgPUEz7ppl51yyWvvEu7NTa8WnbWaoVbrpd
         KutA==
X-Gm-Message-State: AOAM532d/ZTdnBZGCzZPf93cksHf+h6ko4JClsbTzodVMvr4APyj5jT4
        SH6ShaIOrXCqnfF6VlMiQA8=
X-Google-Smtp-Source: ABdhPJz/qdW1J7jjebgPt5QJ5gpHlQrlz0UYgMQ+DxeRzTDU5SjvS2I6qR8QELzL0a9z7YaKLrZoJg==
X-Received: by 2002:a2e:a809:: with SMTP id l9mr7934205ljq.147.1630874539904;
        Sun, 05 Sep 2021 13:42:19 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.70])
        by smtp.gmail.com with ESMTPSA id y9sm774633ljm.5.2021.09.05.13.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 13:42:19 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] staging: r8188eu: remove useless check
Date:   Sun,  5 Sep 2021 23:42:18 +0300
Message-Id: <20210905204218.19317-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch says:
usb_intf.c:326 rtw_hw_suspend() warn: variable dereferenced before check 'padapter' (see line 323)
usb_intf.c:387 rtw_hw_resume() warn: variable dereferenced before check 'padapter' (see line 385)

There is only one caller of rtw_hw_suspend() and it does not check
padapter pointer, so let's just omit this check to make smatch happy.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bb85ab77fd26..42a375e7345c 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -322,9 +322,6 @@ int rtw_hw_suspend(struct adapter *padapter)
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 	struct net_device *pnetdev = padapter->pnetdev;
 
-
-	if (!padapter)
-		goto error_exit;
 	if ((!padapter->bup) || (padapter->bDriverStopped) ||
 	    (padapter->bSurpriseRemoved)) {
 		DBG_88E("padapter->bup=%d bDriverStopped=%d bSurpriseRemoved = %d\n",
-- 
2.33.0

