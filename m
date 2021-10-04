Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68E34210DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhJDN7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbhJDN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:58:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B6C04AEE5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:53:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r201so10676587pgr.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+NqgXClATM2+U/6pmcAe6ttC1b34HIq6gozyTG/Fag=;
        b=psisIvsoqqZTvAJJ5lZS9bVAzGPIXOqlASUu6Ft+XKdLqGhfIJqNLDB3IJY/rOhOn6
         W0emjIskVKKkuFOpMab0ECiJBjhbjT1iPghl9LbSO/wBM01uDStrHFDjsKEEPVjqD+L5
         D+yz0Ti1YGOvhSbCbGQCfOP+lKVLxj4FltbpE3mfhLLvI9pv/kUcPmp2sWNWOB4/GWjR
         to+BiHxENksQs39APHR5XyX9R6fMWxEj3/ghrXb2tb4ljex7JgLIFQlAaTdEGWw0Hj+x
         zuaz++vPpRgvUJ6rOV3iD+3LFFGEb7JL9+6P9G4NMNOLUKH7dFEdhikpbnkPjMN02Gxp
         W7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+NqgXClATM2+U/6pmcAe6ttC1b34HIq6gozyTG/Fag=;
        b=aQlCBP9JpZAyfCQ0rWEB3NNmxoQeAwEIGRkDEfqYabtS9p9ib9uWpVDviC0BSyY6m6
         pizzAZqfE1gIWeOj42rg0E0K+A/CPM/M65fMskI19VuymhPWDh/eFqeWkz3UCO3Tp5nm
         3j5A5GAW+dd6vXq0g/BUAyTDpvyJ/AxJ3MjvkltW8bgKN+kVwInE9ULDG6TrWdN0JA3k
         zJ+HwDupfWgcRADsf4DStbnX5G66VvAaSQyxHNpcKwoUs7tumKQD/n8L5Zk40bXQKZR8
         EN6WpDMaUfhcxofB7kQzgHxXRGyd3mAPbEgc72N3oK8IOug9TMa5T+dHZyyO7ztnOFEp
         aAdA==
X-Gm-Message-State: AOAM533c7iFnfhumD6eT5vrgwPAtNVfHVY/b0tRJT2gHpUS4PDu4DTFL
        wa9QHWYXt7xG5Y0RsZ2IEq8=
X-Google-Smtp-Source: ABdhPJwDSowptib1nJXhPUUJ3bBp3fd+JhzlaX7H/iuzO/TxYXwQ3yb5JSe0S6KbmH4lWdaEU10rQg==
X-Received: by 2002:a63:5c1b:: with SMTP id q27mr10744331pgb.284.1633355632829;
        Mon, 04 Oct 2021 06:53:52 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id k17sm12209548pfu.82.2021.10.04.06.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:53:52 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/8] PCI/DPC: Converge EDR and DPC Path of clearing AER registers
Date:   Mon,  4 Oct 2021 19:22:40 +0530
Message-Id: <14df904c301dc417485f5a7563053b81ab1d3c76.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the EDR path, AER registers are cleared *after* DPC error event is
processed. The process stack in EDR is:

  edr_handle_event()
    dpc_process_error()
    pci_aer_raw_clear_status()
    pcie_do_recovery()

But in DPC path, AER status registers are cleared *while* processing
the error. The process stack in DPC is:

  dpc_handler()
    dpc_process_error()
      pci_aer_clear_status()
    pcie_do_recovery()

In EDR path, AER status registers are cleared irrespective of whether
the error was an RP PIO or unmasked uncorrectable error. But in DPC, the
AER status registers are cleared only when it's an unmasked uncorrectable
error.

This leads to two different behaviours for the same task (handling of
DPC errors) in FFS systems and when native OS has control.

Bring the same semantics for clearing the AER status register in EDR
path and DPC path.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index faf4a1e77fab..68899a3db126 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,7 +288,6 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_status(pdev);
 	}
 }
 
@@ -297,6 +296,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	struct pci_dev *pdev = context;
 
 	dpc_process_error(pdev);
+	pci_aer_clear_status(pdev);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
 	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
-- 
2.25.1

