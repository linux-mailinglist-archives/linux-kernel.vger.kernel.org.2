Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7E63B2046
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFWS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229938AbhFWS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfUUvCPY/yCW3nF5S1XXaaySwkjQfz2Hdett2DoZIxY=;
        b=DoQeQwQvTlrF75tHjmKlh1nNdbQi9nyU9+eNMbCqBSnztKQECSJiNpbedEd4o9p1ogv6cg
        dYvveZotzJMTuy//jv+ctQU5FE6mJhgoxTkH5sVridop6p4IgmflXrqq5ws59yD1yLWi8Y
        SCnzCCzXUaWP1hNCBcbMd/6qBww+Ahs=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-gSzp9TT5Otim2QX_C0WypQ-1; Wed, 23 Jun 2021 14:24:39 -0400
X-MC-Unique: gSzp9TT5Otim2QX_C0WypQ-1
Received: by mail-ot1-f69.google.com with SMTP id 108-20020a9d0bf50000b02903d55be6ada3so1793373oth.22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfUUvCPY/yCW3nF5S1XXaaySwkjQfz2Hdett2DoZIxY=;
        b=lBQHzIkoToBf+40x5hUF6Qb4NvyeFqrnvEjM0KpjOJ9dQaqOWJmCM8tL4umLBVYqWr
         sJ8PZGjc1c3T9MIjrZ8HakANblAelEg4JvwzqwHQQ2k9F/PQN2dNeprxu7GWtmHxqmmY
         MoGQLupxBvXD4ixH3dN3Maps7rN9tcuqqBRn6mio8GsFH35X91OEWqwKe/aghogQpd5M
         M7/O18kR3t0nsQp1Gr7wa8P83L21MWlb9+EqxxMvSL2fUbzhoRHiJq7awKvuEKMm8jSZ
         WwxGtkPB+E7C2Xmb3oonX2AvLod4W8SdqZ1bwBe1GIuCksQwoUQN9aptkjDuNyVPWqW2
         eHxA==
X-Gm-Message-State: AOAM532iNAtdzhXv3akgx0yGj5Z7AdGtWLtXEps6jzf8tznVrO6rP+63
        f+BTHfknMQILRMUrpKo+H6l/U/7RdKNbMby0zu/Ih026pVmf15SgWXD8YP0mRc1Tu4C8jkrrleJ
        HgkP/H6NBnGVP/ZTvEyowGgkt
X-Received: by 2002:a05:6830:33ea:: with SMTP id i10mr1095419otu.342.1624472678447;
        Wed, 23 Jun 2021 11:24:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR7yevscaTjSXDf/VKL6RCgn8jGzo+VVZs7d7rmrj54N3eCdj0y/Xdcw5y6jjNgsqzE+WPlw==
X-Received: by 2002:a05:6830:33ea:: with SMTP id i10mr1095404otu.342.1624472678312;
        Wed, 23 Jun 2021 11:24:38 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:37 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 6/7] fpga-mgr: wrap the fpga_remove() op
Date:   Wed, 23 Jun 2021 11:24:09 -0700
Message-Id: <20210623182410.3787784-8-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623182410.3787784-1-trix@redhat.com>
References: <20210623182410.3787784-1-trix@redhat.com>
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
index 7d50ce26bf00c..1a2b8d8be7674 100644
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
  * fpga_mgr_unregister - unregister an FPGA manager
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

