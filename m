Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87D3F8D40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhHZRoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhHZRoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:44:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71BC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:43:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y23so3680444pgi.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1MY4FXuyrHIHxnVsVGM3kgnjUslCMqrCLSsSFVBxeBo=;
        b=t8dUDFPO19amoXQ1mSRTnweDzzs8zreWVh0cYacCz/AHe7PCKkZUn5dDEA/Pc4sYhE
         tEgQhtPO0QJ2XVf/USe8iMJVyOTWNXjMvfwRFNwvfLqrRUNsJmBkModhB6VihfNo05nu
         zsWDYunlUA5mVLZAMTDi2mxN+kwVqCEm4nDSnAqqMow+/qS1B+piiV/7L/vkNFCME3DP
         T9PgHvBYh0ysBYSrBn0LBpJXWi37eisZ3OrjijoTllll73yBFWWwh0xGLVbiwA8dGEew
         SauhREsRY04hJwV7793/L0Aixe1DNOPvqkk/mVgt/9cI1+W070k3I+wxwiirYCBaBIMq
         CTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1MY4FXuyrHIHxnVsVGM3kgnjUslCMqrCLSsSFVBxeBo=;
        b=uPg0nWuIJRuu/hF0xjReyIc3S/F5X4AzTps7uEcqf+OGI9HLOx3A8JjaxO92o5LP0b
         6+LXKPqbdMdkRbty6LCbkLNkk/aFu6QMJ8f9TMHSN+kivEeKF0aVFjEDpcBS3tDFLHi1
         cPQzuiep1l2Vc6rByOvwTLdDj53mKW7mQSefiYJPOevzzybj0raH9OF/T44UqjBMlNb7
         NmdHUWZzRsbcDH7Kus+CHP1h+Np/0qr0IpPV9gWo9icdu6JT//QD16+rVGDX6k+ZEDce
         x41iw8I6Lmi4Gw/Dqb10c9+Uwb7/iJTqAoC6AaESO7bMA78kyCR40arRdgjNSH2UyrI5
         26ow==
X-Gm-Message-State: AOAM532vcfNMYxFeb11aAC6lanuuObin11MvCmYdaOe7QKQYK5g0Br5Y
        /U7Wvd+4vbxcXBHmqNGOIK8BT6D3gQfG
X-Google-Smtp-Source: ABdhPJwfd5NuG59K6vIN356JEBhcIseL+b2LZMo50wvOdadVSffI52nsAl6OnJD/mlZ+oaRyi0A/+g==
X-Received: by 2002:a62:1a03:0:b029:3e0:30aa:5172 with SMTP id a3-20020a621a030000b02903e030aa5172mr4732412pfa.69.1629999799521;
        Thu, 26 Aug 2021 10:43:19 -0700 (PDT)
Received: from localhost.localdomain ([175.157.109.217])
        by smtp.gmail.com with ESMTPSA id u6sm4125224pgr.3.2021.08.26.10.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 10:43:19 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     axboe@kernel.dk
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ATA:libata-pmp: fix warn: missing error code
Date:   Thu, 26 Aug 2021 23:13:01 +0530
Message-Id: <20210826174301.21255-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reported 'sata_pmp_eh_recover() warn: missing error code 'rc''.
This patch resolve it by adding I/O error code to 'rc'.

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/ata/libata-pmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index ba7be3f38617..2ea7b9986f4e 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -977,6 +977,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 			ata_link_warn(pmp_link,
 				"failed to disable NOTIFY (err_mask=0x%x)\n",
 				err_mask);
+			rc = -EIO;
 			goto pmp_fail;
 		}
 	}
-- 
2.17.1

