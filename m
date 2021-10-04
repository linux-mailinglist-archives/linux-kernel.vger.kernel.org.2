Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20DC4210D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhJDN6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbhJDN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:58:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4265C0612E4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:53:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so19014pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
        b=fWTORTQPU8zQx0fTickf1QWb8zSvKCJC9iMT0nF+cbY7ifH6UZBUFjBx+ekqHPTao0
         oOCuCk/G5yHAO9Gs3xoqHMtFHrAjyMJlxD8P4du5XDgdXFpYjGkqJmiUjR0L3Ha6m3Po
         FZU/E9sDpckZY2MPRYob36bDyQBEb/jam8meXQHTqbhp95pMfIpvgoaX/6r/sx0aUTyq
         O5xla6vl2UkRcpUinYFtux0SaRFgvgLClCuHxsFByvVkkMJd5N4qqXTxnE2EQ6wABe/q
         8ybUXu3452USf3wXIhY6OBOIjNqzlaOUmfRfkF841Kq+cKujfakiwtylB/Pyek9HCmwb
         yLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
        b=n/v2wUwVMXb0Ry8tKIFDxW62He34xTsujYCPe8qbtBMBORAIRwUm/DLW46gNDolRsA
         h99MRozMntASkWbGMW3Fw1QcNqM1UIEjYXEiSXxBeDjcKBABcFAQ+2GN7uQI3+WHisqW
         5gdve+U0PVRmrWcri8GnqIthTk+zXfeKp9mBP+Y6T4pVv5NcPAP6vAmZVwn3qSm/PXGM
         lg9GkCTOnZWGU1EKdQxFHIzLlx/t09iVJL4Y1GTjTa5fUQA1OlR4rHqwV5bYYvYa4ERX
         /7sQJIcd3mEhMUKUNp5NA+0Qq4YQqo5EzUhBR+aK0zELXX9Jwmy9O87gwbYBayXJUg0m
         PQOQ==
X-Gm-Message-State: AOAM533lvfHY9RM6s+0U9TQNBvFIG9QppABTwipVNICa7qM3Q4CfPkVD
        b4K7uO8trBEjST2JIyBJX9g=
X-Google-Smtp-Source: ABdhPJxx10R9wyzIvpYNiy7S0UB2Mcvw0yPJXJXTjXVhsjOsf5P+ExnKCZXIlghvhRuiDJmHz3+7YA==
X-Received: by 2002:a17:90a:af86:: with SMTP id w6mr31205496pjq.8.1633355627328;
        Mon, 04 Oct 2021 06:53:47 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id k17sm12209548pfu.82.2021.10.04.06.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:53:46 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/8] PCI/DPC: Use pci_aer_clear_status() in dpc_process_error()
Date:   Mon,  4 Oct 2021 19:22:39 +0530
Message-Id: <71cec6aef2535b48911bd98bd010012643eb0bd0.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpc_process_error() clears both AER fatal and non fatal status
registers. Instead of clearing each status registers via a different
function call use pci_aer_clear_status().

This helps clean up the code a bit.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index df3f3a10f8bc..faf4a1e77fab 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_aer_clear_status(pdev);
 	}
 }
 
-- 
2.25.1

