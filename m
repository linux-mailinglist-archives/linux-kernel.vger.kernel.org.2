Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89C23D0DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbhGUK76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhGUKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:47:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DAC0613DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:28:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l1so1925901edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bk4wRjdguMEsiA5aIxfKqwQ+Lo4bbEX+lKr1vHTiTCE=;
        b=IvR2mUTkaWaFBQaDJsMeWZ6HGHikIF6+dDtMpCrWMJUTZ6GsMwR3F9XS/7fDSYCKOU
         3nmKKBhKBVVeWePnsTqAVVMn/oxwk948xEQ10YkwHuK2zB1oFFJJnfkGHKcDZLw2LNxF
         8Jq4gdzH+tR0sDGDXs6EApeFLrryQkFEQ/orJxs/QRKmJBFeiGulwjAuhcA1/vFijx/f
         OnoncDirGe9wGSwljqPY6r+w/rb3bPDoaEAmq+l9tbV0Puo2ZC2erFDh5FkBUALgEtdp
         sS1LAseB7oDd/EWtnSiGVY5McMV7fxnBpDPx5Q+RWwy4Tst73At0tOgGf/6LsX/OgEEu
         rHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bk4wRjdguMEsiA5aIxfKqwQ+Lo4bbEX+lKr1vHTiTCE=;
        b=hosEGp/SMPTWSrAtFU0UvIL9oq2y6PzzYDZ3YNdwMikv4fRjlrIn0CPgSN/4zIh1rT
         CZ9oKwcwPn2BafrWnWCyElDAZIql/SCAqVOFVFW/ymJIOdWG5XEaWRcAadG/xRyG+96r
         upSzpjVSqk/9pKPG70liLJZOroY+w/sQ/C6pX0/n7lhYtT8cUGJ507hZlKl6rNJ0SFZ1
         0/vNvJUYVJLCW3GmEMT8qVTf9VT3OFgCgG1zAZp4XqtEcZt3UqskOd4t3/HRcE7/lbIh
         aQxo0JniKk9MFROQHKnrHHZd4qHd3sn72rwU+6SaCy9NP9CsB+DcDouC7RiruF+AfN78
         BPBA==
X-Gm-Message-State: AOAM532kp9Zt5G++5KF22MK0V6ducpOQAma8cMJFi1Y6RrRy1WMqL0YS
        lfc/IWlR9QmNVBn8Kq8mCvs=
X-Google-Smtp-Source: ABdhPJwK9RYgH4F1Mem8Y4k4Mpo5mEHPqjfXYj5VyaOJdyRJept+nu09/wWv4Np5bRPH+hs37cUZ+w==
X-Received: by 2002:aa7:d604:: with SMTP id c4mr47350553edr.39.1626866913301;
        Wed, 21 Jul 2021 04:28:33 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id f12sm8205065ejz.99.2021.07.21.04.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 04:28:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8188eu: Remove unused iw_operation_mode[]
Date:   Wed, 21 Jul 2021 13:28:29 +0200
Message-Id: <20210721112829.17317-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused iw_operation_mode array.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index d4dce8ef0322..eef8ed71cdef 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -46,11 +46,6 @@ static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
 	6000000, 9000000, 12000000, 18000000, 24000000, 36000000,
 	48000000, 54000000};
 
-static const char * const iw_operation_mode[] = {
-	"Auto", "Ad-Hoc", "Managed",  "Master", "Repeater",
-	"Secondary", "Monitor"
-};
-
 void indicate_wx_scan_complete_event(struct adapter *padapter)
 {
 	union iwreq_data wrqu;
-- 
2.32.0

