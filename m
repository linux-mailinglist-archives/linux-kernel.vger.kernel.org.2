Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870CA3A04C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhFHT5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234687AbhFHT5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ub84QQXk/80gOx9jVYvQgeu9ZbjU0KtFBnV/GBkRc70=;
        b=efll40IBKRppx+BWTduMoPV5VkaarcGR6ZMK8K+Bt3oXHv/hRBmwjvI3mCAzLTJu71K9MP
        UOWllDE+mXjxRY0QD2YkTO5Imhk/dwjKz4YprxA8yxagug0ZEa9RFxa0BJZvX0PJBtY0JJ
        tZGfWX+xziQm01JIBdkPiH1vC77Uc2Y=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-93gEB8swOG6ZO9Je4auuZw-1; Tue, 08 Jun 2021 15:55:21 -0400
X-MC-Unique: 93gEB8swOG6ZO9Je4auuZw-1
Received: by mail-oi1-f200.google.com with SMTP id k11-20020a54440b0000b02901f3e6a011b4so4713354oiw.23
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ub84QQXk/80gOx9jVYvQgeu9ZbjU0KtFBnV/GBkRc70=;
        b=WPtEpQhLBBP/x5o9gye91dT5QIbKfc1b60SCPL7BhLL3V2YXm1plL0mzxZWMnkVo8Q
         G+VGAMQqU/DsKDOZhYD2+9e9SB5GnAOniUx7ZTZbL50la4qDN2Zy8nhG4YYdepp5wL0X
         /IrRiTYI/Z3UqV6N/WbZ26gGRBuO4Oux+EHKgNuDSi99fMWGfZquRYpGk0W2+Xim7YIg
         fnO+fUdeX5lJkaYgI19u794qvJfpFNpilP2yaiJ0EsJhnpry6p7zkug3szb75NNEU/0m
         WY8VqzKX67LyxWk3hWtIzW4we45L8dun4FrFt8Wc9SwMpv+rGybj42DkA+z9QmpHIdQT
         4Fvg==
X-Gm-Message-State: AOAM5322yk2C6Mdwl99Hd6NzwK9xwrVq2x55h8MjIIBfKuJPEHCDKBCH
        vZsffd/u8YnN3xlw5isVe5OWlP4Mzkjj8JH40+vQNgqYLUN/rHLOL6XXG8s1tuw0AXLT5lJUi2f
        gIGv8RrqR68eVEqd96p2oxZ6L
X-Received: by 2002:a9d:2904:: with SMTP id d4mr19095281otb.238.1623182120329;
        Tue, 08 Jun 2021 12:55:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmGhb5zky/LBefjfpgPpDFor2hP6i0wi5WpKPdZompoRWYG/9Z6TmmFlW3LXeN5nlet8+wrw==
X-Received: by 2002:a9d:2904:: with SMTP id d4mr19095265otb.238.1623182120144;
        Tue, 08 Jun 2021 12:55:20 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:19 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 6/7] fpga-mgr: wrap the fpga_remove() op
Date:   Tue,  8 Jun 2021 12:55:05 -0700
Message-Id: <20210608195506.3022550-8-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608195506.3022550-1-trix@redhat.com>
References: <20210608195506.3022550-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager is not required to provide a fpga_remove() op.
Add a wrapper consistent with the other op wrappers.
Move op check to wrapper.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d06752be9c6ef..84808c7ca4406 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -731,6 +731,12 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
+static void fpga_mgr_fpga_remove(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->fpga_remove)
+		mgr->mops->fpga_remove(mgr);
+}
+
 /**
  * fpga_mgr_unregister - unregister a FPGA manager
  * @mgr: fpga manager struct
@@ -745,8 +751,7 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 	 * If the low level driver provides a method for putting fpga into
 	 * a desired state upon unregister, do it.
 	 */
-	if (mgr->mops->fpga_remove)
-		mgr->mops->fpga_remove(mgr);
+	fpga_mgr_fpga_remove(mgr);
 
 	device_unregister(&mgr->dev);
 }
-- 
2.26.3

