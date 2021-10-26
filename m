Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0843AB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhJZE0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhJZE0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:26:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ADDC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 21:24:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so663777pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8fRa6CBKBdS9xSCRdr3VRDYDNn+53KcgyCR1kCegMck=;
        b=lYAwi2DhCCM6KybejKaTcd1LPmTiEvzBA2TftM/UYgxOixgrJqY1vlIV5KxOCAaqAw
         IzZ2GrdLRxvd9aEcK2ElbThTfW3y+pMMLdno9lePomJdolFZqGSIvqcWjD+BBaXomIIY
         8Z+DiOgCXn51Ao4oBm0Ez2fXCqnv9UrxW+YNCrQffwqOG/SbjOvy8s9VzXJa1pDRidtl
         R0+6Csz0rOx5KjKsdMt0sWj+AP3CPqoy4/i5jxNsCvWSe0YiGb/IIY0Vf15gwX+YGnZB
         p5nQf+KJPO/hQ8ikOTS4LeKLxAJZ37LwIvu66Du1WmeLI2R4YGcn83aZ3GFshbARUY17
         P4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8fRa6CBKBdS9xSCRdr3VRDYDNn+53KcgyCR1kCegMck=;
        b=0cRDyRd7hzafKqlfHDXYHvXV435AWCqiW93/qQU5nCiRQqPDqmJgQgmwHkDY65koYh
         0fMaBeYO3Ffd8ZF+6gBEQFhkatgOsqluYyUouJv9LLnjSuQVNyAQR/ZuEXhSM3JgICI/
         bXTHox/y55wgGERCcftczBnRcyEKU5LYFu0CZ0jn42BYSk5V9BPFHAOJyyHLf/P5TEgd
         WCgOyUnCQKStIvd0ahkH0uFfftRgY4SZk8x9tBzo0t+S0BoIwB5CPtkeszcjAXGed1c0
         SktItCsxz10g93tOObO7MdSZtiqclksbNQXI4oI3i8KWdkkD9YguETrPA/r+mSLlqdBH
         Jf8A==
X-Gm-Message-State: AOAM532S0gzjGvNOFZYtMS8IdDZTBeVP50wrcarRnJ9StDXCZWwP2qoI
        ZXLF7+IFUF/fWKFu0NbZiGIhBGU4l8U4dw==
X-Google-Smtp-Source: ABdhPJwi2AhN9rYoVCJgNz7CjYf6mRMBu9SFpIJcbzohAfzXNIw6mbIeU2o2M7t4RWcaUrLod8m1bQ==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr25961664pjb.7.1635222265258;
        Mon, 25 Oct 2021 21:24:25 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.95.35])
        by smtp.gmail.com with ESMTPSA id s22sm19993535pfe.76.2021.10.25.21.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 21:24:24 -0700 (PDT)
Date:   Tue, 26 Oct 2021 09:54:18 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        matthew.v.deangelis@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: core: remove local variable and goto
 statement
Message-ID: <YXeC8q6IooA4N1ZF@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function rtw_validate_bssid() remove the goto statement.
As on goto exit label, function is returning without any cleanup.
In this function goto statement can be replace by simple return
statement, which will improve readability. After replacing
the goto statement local variable ret is also not needed. So
remove the ret local variable.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 8c11daff2d59..11e9421cad58 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -24,15 +24,10 @@ u8 rtw_validate_bssid(u8 *bssid)

 u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
 {
-	u8 ret = true;
-
-	if (ssid->ssid_length > 32) {
-		ret = false;
-		goto exit;
-	}
+	if (ssid->ssid_length > 32)
+		return false;

-exit:
-	return ret;
+	return true;
 }

 u8 rtw_do_join(struct adapter *padapter)
--
2.33.0

