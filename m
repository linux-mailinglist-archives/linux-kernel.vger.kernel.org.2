Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ACC4210DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbhJDN7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbhJDN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:58:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2755BC04AEEB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:54:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n2so11130557plk.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUEhHrxHzVocYPRDueBy4ZqExPBHlS+x/5Sx/kTwk+s=;
        b=Bm9B2TCc+pMuYE4C0rpSmDtzwLBJ4SJSbtzpmPELaHks5uhPGs1raFcHG6BMtHCmAy
         i20aEEMSP1A1cJRjJYUr9CdozRMsWt4uK4YX7EoRhuevG3mx5Q8yOGjl3j7zThW+kO8P
         xZR1QHXk7zTvfK+kMTCW3V18/ROBJJshCHbOFvc5LDD/vclUckHeQ77I0b6IlvpGuu0K
         npS0ZQNeSGDTRJJwyj92HQuQXy0sfhQ4bgMDCw7QIynJPL0G9Z26wA9t/3lErBp50W3t
         L4DKXZFThXCHXHoCVM6qObiJIYYRNYzelvnm8dT1yW6Lms9Yhsv/XYyV7CCS3nwP27Rq
         z9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUEhHrxHzVocYPRDueBy4ZqExPBHlS+x/5Sx/kTwk+s=;
        b=bOBs6p8uSAgxa5KmabiEkoDwUAEVSlAe2Q/faeOUqFXrW2r7vO5YBa8hdsgPptyqHj
         WbeUMwcMFwAowSwJBcpVC+YYKkdmag1qvoO4ToMtcLalzn/+J73sljVz3Qlno6zsDm3a
         x8CX10XQSsl21TTR8xA5anw02gcKQwITayCiMKNNNP+3qiRCfJVJ3tsHh1xNvSEmmnLR
         86GcFo3AFSJWfsFwWmFx4CC+Yx+AaS2yRWwO7e4lRV9f5c9b4cw8Kgqobdj/F2G5/sSI
         KjCUT2FR1nnCzjJyGBBj/x7qa45CFsGMkw9X9VTPiRbHKYl8fbL0X90t19ywP5W4x+jR
         x86A==
X-Gm-Message-State: AOAM532ate2B+UOY89GMykNMAeTvc2GByeSzVx2FauIle/c0Rgyb3J3l
        tKFS3cjgpafEiggbuHj40sY=
X-Google-Smtp-Source: ABdhPJzd+ivSEbdrdJqf4yNE76Ef4GKAYZmLnOzMQB87hkgM/ERxY+NBNp4gunlMcnbIirdGHnl+PQ==
X-Received: by 2002:a17:90b:1804:: with SMTP id lw4mr18231178pjb.174.1633355641670;
        Mon, 04 Oct 2021 06:54:01 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id k17sm12209548pfu.82.2021.10.04.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:54:01 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] PCI/ERR: Remove redundant clearing of AER register in pcie_do_recovery()
Date:   Mon,  4 Oct 2021 19:22:42 +0530
Message-Id: <2360908d0f8406ed63a17a733c4d1defb49ee3d3.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcie_do_recovery() is shared across the following paths:
 - ACPI APEI
 - Native AER path
 - EDR
 - DPC

ACPI APEI
==========

  ghes_handle_aer()
    aer_recover_queue()
      kfifo_in_spinlocked(aer_recover_ring)

  aer_recover_work_func()
    while (kfifo_get(aer_recover_ring))
      pcie_do_recovery()

In this path the system firmware clears the AER registers before
handing off the record to the OS in ghes_handle_aer()

Native AER
==========

 aer_irq()
   aer_add_err_devices_to_queue()
     kfifo_put(&rpc->aer_fifo, *e_dev)
     clear_error_source_aer_registers()   <---- AER registers are cleard

 aer_isr()
   aer_isr_one_error()
    handle_error_source()
      pcie_do_recovery()

The AER registers are cleared during the handling of IRQ, i.e before we
the recovery starts.

DPC
=====

  dpc_handler()
    dpc_process_error()
    pci_aer_clear_status()       <---- AER registers are cleared
    pcie_do_recovery()

EDR
====

  edr_handle_event()
    dpc_process_error()
    pci_aer_raw_clear_status()  <---- AER registers are cleared
    pcie_do_recovery()

In all the above paths, the AER registers are cleared before
pcie_do_recovery(). The non fatal status AER registers are again cleared
in pcie_do_recovery(). This is redundant.

Remove redundant clearing of AER register in pcie_do_recovery()

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/err.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index b576aa890c76..fe04b0ae22f4 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -231,14 +231,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	/*
 	 * If we have native control of AER, clear error status in the device
-	 * that detected the error.  If the platform retained control of AER,
-	 * it is responsible for clearing this status.  In that case, the
-	 * signaling device may not even be visible to the OS.
+	 * that detected the error.
 	 */
-	if (host->native_aer || pcie_ports_native) {
+	if (host->native_aer || pcie_ports_native)
 		pcie_clear_device_status(dev);
-		pci_aer_clear_nonfatal_status(dev);
-	}
+
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
-- 
2.25.1

