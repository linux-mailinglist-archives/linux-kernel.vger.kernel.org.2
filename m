Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB693E86BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbhHJXvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhHJXvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:51:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA99BC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f5so325364wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+m3BtSABkvmdLkwH7PXhgpCYw0RdvCvmBAQL6bV+6/w=;
        b=gWxx0hurSO6vJMt8tkjjyjZj+FnBIvpiCY4XYSZcImRBhVn5PzEY2iSFUPOohmsvLF
         D68xxgB51rmiERFOeOl/MCweSS2J98yYgc3UbQXzIKfJYsu5UuF6bg3glb0Zeyv4uge1
         QOwTtaJQX1uYn6iK71A0tIf8jZls2wUuRSOQsLimxMpP92hEmhm0u4wgl0Ta5JW9CyDC
         hlse9HxINCTqoYeOq7GcreQPGSdFE5Y92wimXvYbt7XuTrVNpmaePlUnDWmtUFq8680l
         15pPocsUvUZHbChne6pQBJFghvubSt+IVrQW5Nu0/91J/v0zyR4xrLuA7IrEjoyUmqAd
         oz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+m3BtSABkvmdLkwH7PXhgpCYw0RdvCvmBAQL6bV+6/w=;
        b=lLQxNJ4aJGQUUIBbcf/kRDpZHQfXDlogRPnPKGkGANoCpucST12029Dj/7HcVDPIlw
         ix83GHdhCrZHLKtBk51Ss8hOpwzhyrnFpw3crGDDVXysv7dXmRIKvLHwXRROTKUwa8S4
         RkmCCyHY58M3BjcVaelytg7VrBEPc6KbQBiNzCDrgjcDRbd4Mb5immKiUGDr8Akm99dX
         13erGPCChsoRYkoo3QZhPQqT0FdLafDXOB6vSRHuK2gxRs/iurKxTB4z0opzMIzObqax
         xgp2YaeJSfTUJOCiWTMA4ZhWsZ7fVk4ealDUuCKtkZ64A+bHYxSYQPe/Tw6QLNg+YdGh
         PeSg==
X-Gm-Message-State: AOAM531bGEgauuNFVh58TjidbKP9kuLBS3dH7x9E5x7Txw701WqjZPQX
        RPs+HO3hPUN5cFgXx8ImdxFKIQ==
X-Google-Smtp-Source: ABdhPJzpVf3k/8X7clnMPjY2XJANhf8crbeeVGsD8Kdr7YqcNvin6pvjg7NlianalxB0nRCVSv1sVw==
X-Received: by 2002:a5d:64c2:: with SMTP id f2mr33102159wri.128.1628639453635;
        Tue, 10 Aug 2021 16:50:53 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id p14sm13881220wro.3.2021.08.10.16.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:50:53 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: r8188eu: remove unused variable from rtw_init_drv_sw
Date:   Wed, 11 Aug 2021 00:50:45 +0100
Message-Id: <20210810235047.177883-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810235047.177883-1-phil@philpotter.co.uk>
References: <20210810235047.177883-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable from rtw_init_drv_sw function in
os_dep/os_intfs.c

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/os_dep/os_intfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 38d3283dbac3..1eb53cf8bccb 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -852,7 +852,6 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 u8 rtw_init_drv_sw(struct adapter *padapter)
 {
 	u8	ret8 = _SUCCESS;
-	unsigned long flags;
 
 	if ((rtw_init_cmd_priv(&padapter->cmdpriv)) == _FAIL) {
 		ret8 = _FAIL;
-- 
2.31.1

