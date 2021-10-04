Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB7D4210D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhJDN6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbhJDN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:58:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18379C04AEDB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:53:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m5so1822482pfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FR6K5YUYcCv1FDH4y5DK0PhIoCQEDWlRf94cnPNCwds=;
        b=m7Cii4O3QZLRYFRd30tuRa1ZGW5M1nO9R064AjZksMB9Vx2UcoVaHIPKQCoCpX+ab2
         xxE5BgKLDZb0+xhrQH1YgdG4LisEAqX4cNSdHTyaDqk9I1QBxLGXsGie8FtGgeSoFxXn
         QQiNcRbsZwcNAGpjW/E4nmrU3+Kf7dVizxU5cjmihNXPDWSNuQgiez8sI61FGn0OqBu6
         AitsR5SoUvrPwOGHAoWpYb+itJUZr75vuT2EYNrhkM7WfNUHAti/qP//FRdpmFZQHAq2
         obH22mG+VGLBeBSn7dGb8kMWwjIIJ6Q3OV/kZw6S/ny0IYyJvSK1lbfR4Sc6UTdmO2EU
         RJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FR6K5YUYcCv1FDH4y5DK0PhIoCQEDWlRf94cnPNCwds=;
        b=66MItmG850rDF1TSuX5gla7oPG+iaZRcIgsMfXulxjGZm5RcfS8Oe/Wx5mHwxvjeVH
         PdT4l0ftJuqNohFPrGgh4ZHUuWk3i2Mkm4d6RT8x8c6txQVZ7SsTEp2QLGZvtgcCdxpo
         fdk/H0pumsJ1mFUWDXl/5d/GpwePok3tllLQMwI/PE/hUy8twUE5k5jyvX6TR6usaXL5
         QzrMBdDGJuzmxBSUK649wDcytLaLdZYegIuE4LLLkyZoffMorF1EurLTbz9EoEb1lFrg
         sQD24hWeRKG/amCaptz5EFZvNMbw9YbQbMgxgHjYDqPXiH9cAibWgLruIjW1yli96lHf
         GZoQ==
X-Gm-Message-State: AOAM533EEHZ3rw5PmfCsjTj3Zn+lWqM/e4wIta2sw6BMfn3KxHbVWys3
        ppM/EFAUzpWAKIGt+nFo/mI=
X-Google-Smtp-Source: ABdhPJwqgQQmy2bTDwBaFQ3GZmWyi+4O57N3AsLw3XYvg9TAQJSn+qRPsDk/VZ0CSFCVCv/AP5hqmw==
X-Received: by 2002:aa7:8bd4:0:b0:44b:1f60:497 with SMTP id s20-20020aa78bd4000000b0044b1f600497mr24979664pfd.78.1633355613620;
        Mon, 04 Oct 2021 06:53:33 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id k17sm12209548pfu.82.2021.10.04.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:53:33 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] PCI: Cleanup struct aer_err_info
Date:   Mon,  4 Oct 2021 19:22:37 +0530
Message-Id: <247efb0e4168393f4aee5e267a9aa8b3a8adff0f.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The id, status and the mask fields of the struct aer_err_info comes
directly from the registers, hence their sizes should be explicit.

The length of these registers are:
  - id: 16 bits - Represents the Error Source Requester ID
  - status: 32 bits - COR/UNCOR Error Status
  - mask: 32 bits - COR/UNCOR Error Mask

Since the length of the above registers are even, use u16 and u32
to represent their values.

Also remove the __pad fields.

"pahole" was run on the modified struct aer_err_info and the size
remains unchanged.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pci.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1cce56c2aea0..9be7a966fda7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -427,18 +427,16 @@ struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
 
-	unsigned int id:16;
+	u16	id;
 
 	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int __pad1:5;
 	unsigned int multi_error_valid:1;
 
 	unsigned int first_error:5;
-	unsigned int __pad2:2;
 	unsigned int tlp_header_valid:1;
 
-	unsigned int status;		/* COR/UNCOR Error Status */
-	unsigned int mask;		/* COR/UNCOR Error Mask */
+	u32 status;		/* COR/UNCOR Error Status */
+	u32 mask;		/* COR/UNCOR Error Mask */
 	struct aer_header_log_regs tlp;	/* TLP Header */
 };
 
-- 
2.25.1

