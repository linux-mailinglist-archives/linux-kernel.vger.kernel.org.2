Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1ED4210D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbhJDN60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238857AbhJDN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:58:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C3C04AEDD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:53:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 187so10150688pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0szOl/Q5keJYQjPtxy9YApfb7ftHWXnTXQ4eoRdC7oM=;
        b=PpuJlKKnU2ogwrrbB82jmOo0YlJoX1B8j5N8kx/iU153EJ1sn+ERmcL4bT8Ty3x4fH
         ZPekROvXKmmkST4W+zyV5s1ETxRFaksYBZmGTWeZrWqAfuJOgPX8Vp+Kaj09grA2v49s
         mevWdSPrZAarCQ2oPLB+ulnkxOtCdohDxTS2e5f58wdWhRnS0jt/nPpXfDPLU+yMRvHX
         0KJb1EOQY0JK4Iu5vcO228swY3eTAgLvQUkf/ITZp8jDYznVRR6Y/GyOp11gfDGiw0HQ
         MrWi8/pHprykWPqO7R6N1m5nR7wPRtwOgMIL05mtTNtU4KjwghTClk31N/9I5dFxe/7g
         Jj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0szOl/Q5keJYQjPtxy9YApfb7ftHWXnTXQ4eoRdC7oM=;
        b=wV6aGl8ypEDZj3r1Y1IB2z1FVwkOddaKmpdv395E8QwexZQNHZerDz3wUoxQ5u9krE
         Yc+EIOPBtFY5jL9/VrsrZ52R75V4+s0VEuhcU1160icO4dIhwJDhBIdYZZRYb1lmad0R
         O7ZigVPmfjdlHPDdvn15IpeGdpnXRSrqf1wmBf/nQ336ZR1qUTa77R9C3bbm1sLsjG9E
         FNTpSvKEbaNGTjvoGUv8Ba/M5B3BcpysuJRjqY9+pJqe9x+bm+RDKqfCOJIKemfJNwJa
         pZzozfjhUmzp31kTMMk9tDBCUm689KtrColUdmhxBpO9bhbZtaqNe3qwbXE8TELCL9pD
         KJRg==
X-Gm-Message-State: AOAM533Im9H3w7NOH4sDDtRFwtjd2t+1bbSlJcUn0pgMLzdZwfxuzD7w
        93EY+3KiQHRTtz8YBYouWj0=
X-Google-Smtp-Source: ABdhPJw4oR8G3X8FxIomguPZUChHNyp7K/HoXgLw2iHgeEb7gBRXR9CiSFGeDJ1GrP59tH5rwHwjEw==
X-Received: by 2002:aa7:870b:0:b0:44b:bcef:32b4 with SMTP id b11-20020aa7870b000000b0044bbcef32b4mr25767456pfo.41.1633355618807;
        Mon, 04 Oct 2021 06:53:38 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id k17sm12209548pfu.82.2021.10.04.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:53:38 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] PCI/DPC: Initialize info->id in dpc_process_error()
Date:   Mon,  4 Oct 2021 19:22:38 +0530
Message-Id: <d6e7eabf4fcf80b454dbcec507b3553448fcc95a.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the dpc_process_error() path, info->id isn't initialized before being
passed to aer_print_error(). In the corresponding AER path, it is
initialized in aer_isr_one_error().

The error message shown during Coverity Scan is:

  Coverity #1461602
  CID 1461602 (#1 of 1): Uninitialized scalar variable (UNINIT)
  8. uninit_use_in_call: Using uninitialized value info.id when calling aer_print_error.

Initialize the "info->id" before passing it to aer_print_error()

Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index c556e7beafe3..df3f3a10f8bc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -262,14 +262,14 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 
 void dpc_process_error(struct pci_dev *pdev)
 {
-	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
+	u16 cap = pdev->dpc_cap, status, reason, ext_reason;
 	struct aer_err_info info;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &info.id);
 
 	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
-		 status, source);
+		 status, info.id);
 
 	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
 	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
-- 
2.25.1

