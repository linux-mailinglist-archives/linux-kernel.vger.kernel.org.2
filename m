Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06E433EC55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhCQJMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhCQJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:11:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0348C061763
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x16so1005842wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omHoCGEAHHfzGsCXWaSPZZFL53Kydw/eMLAhlkpH1KI=;
        b=NOs1xeXimZT1FQY+Ocg69tjJxLZq/xMp3D5060fTK4rW+F/DEsGLmdmyXIHTzt1f9Z
         7ak1G7Rbtp8ULeiqAZxM4ipL7uGSXIrNT4wrhcDHpFI2ZMZObqN9JtH68SFyhmVxA+yP
         hBKqtQ8L0Vize5FdnfU8pGnTAVqtvVctIWXtdoXhSrlJkZrKF5QCg3z3rZZke50toe6v
         Gv3ya0UhriLKS8776/30epLokDBbALSBn3k9DyHz+V/G78qxPkOJCMzGXR0kFryI/Ybb
         QFR9AH4sJrHIBG7xnKQObLDfnfd8zx6Vw2x5moOnzUa/336kofXchmRKpDt5SVn4/oRM
         U6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omHoCGEAHHfzGsCXWaSPZZFL53Kydw/eMLAhlkpH1KI=;
        b=ZjXAqih8oftG6+N1t414DSMPNIvsVnwNwx3115gJsqHwfwBaz+Qg0dMuvHfBF4cixb
         QfWBWzC/nuYSB5ewhvdwAz3SkxO1ItukNyEAZ1l1Rm8VVxITDITP6sz6cPs6H4PhhfjH
         I+jDtJ70pA9bS3cG7HBgoYJU9PY7XtobEt4h1Jyu8A/CuywEWQMgz85hqObPzMsuoQr0
         SKMDdEoe8AEZ8WocTPBUVBu3Jn2zVuWtZSlOq/jXcbO7WMANU33JwgBo81ju8MBmaZhE
         i6GGZjFLdxVF1Eo1ZXaETYISyqQdYM0VnzVnFFNX+9eEXb/qF1xPoq0VU8Yr1uM3RogX
         alZg==
X-Gm-Message-State: AOAM532tWRSPuJq1kRJsZUh/f3pv5nOyXp5BWaBq17bxY44hMYJCsC1n
        X+xrYEsERX6SH1jpsykWaFqLsQ==
X-Google-Smtp-Source: ABdhPJwyC6BzxEhifslpYQC6x8udphgqiggUDCfi2SKTbSnWZ2V4oREh2OGLAvUiUcQYvfmezHynXQ==
X-Received: by 2002:a5d:6290:: with SMTP id k16mr3161670wru.177.1615972294389;
        Wed, 17 Mar 2021 02:11:34 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id s83sm1709279wms.16.2021.03.17.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:11:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 6/8] scsi: isci: remote_device: Make local function isci_remote_device_wait_for_resume_from_abort() static
Date:   Wed, 17 Mar 2021 09:11:23 +0000
Message-Id: <20210317091125.2910058-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091125.2910058-1-lee.jones@linaro.org>
References: <20210317091125.2910058-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/isci/remote_device.c:1387:6: warning: no previous prototype for ‘isci_remote_device_wait_for_resume_from_abort’ [-Wmissing-prototypes]

Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/isci/remote_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/remote_device.c b/drivers/scsi/isci/remote_device.c
index c3f540b556895..b1276f7e49c89 100644
--- a/drivers/scsi/isci/remote_device.c
+++ b/drivers/scsi/isci/remote_device.c
@@ -1384,7 +1384,7 @@ static bool isci_remote_device_test_resume_done(
 	return done;
 }
 
-void isci_remote_device_wait_for_resume_from_abort(
+static void isci_remote_device_wait_for_resume_from_abort(
 	struct isci_host *ihost,
 	struct isci_remote_device *idev)
 {
-- 
2.27.0

