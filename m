Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9427A38982C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhESUow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229454AbhESUop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621457005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d7rjCgQxk+5xvpaVNfykovhhV8vEkbL0LJZ6/GWPBlM=;
        b=cJw4wMTse5NVPnr4GgsrjypYE3vGepz3XPvAMsJRXlF/ZQBJWFig7WR9wtfbpsW/Y4bg5J
        k3eJLymhHln9w+/MzbEANzJvMHcktGbOmLK7MGITiT9JZGAqTmZhBTMEED1FLflmQjN3b2
        TbmHArNavAkOTb0kfv6w6h3fyiAlvoI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-AwwaJXCQPHmCeSspDvu7ag-1; Wed, 19 May 2021 16:43:23 -0400
X-MC-Unique: AwwaJXCQPHmCeSspDvu7ag-1
Received: by mail-qk1-f199.google.com with SMTP id d15-20020a05620a136fb02902e9e93c69c8so10714267qkl.23
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d7rjCgQxk+5xvpaVNfykovhhV8vEkbL0LJZ6/GWPBlM=;
        b=HUPKxTJ/EekTU5+84P17NQVceRHCW5u/eiNERj/8ZKSRWPamEswwTizyVuaUOKhd6Z
         1UUE4dZm9hA6OAwWUsfBjEL2oDvzGSPbcIQaP0oaI2iRDLlJe4Tp/MqRZizEmpsBoqbW
         V/8C2E5gdyEaJbnx7RnzUCVvtn2h2P2EPcmxPY9gDZDJ4OuwFmbPNlE/sMHYfNph7Yj6
         POAYK+5nsENUIVb6YHS/QhK0XVrur4xoqnCGlXNLeMvBs5w2lQEMlNXNhEIvnbM2thk0
         t9l/u4Ar02POV2yLRlW2AFtx2hiu1VXB3//owMvbSKDNVp9yVdkUpbsWN+5pxq1rsChy
         A4zw==
X-Gm-Message-State: AOAM530+fzRcPEEbYxaPWXebDN0s8til6LH2bittLE9iMq7YCf4ISXuF
        oFCsy2iMQ14SnFHDspitRBCAouYzWJsfQA/XzYYuqpRP7xdmthNVrCXvDeB96gk+61DE84LWN2l
        l3+vL0tb7lOA/ZpPGiGfxuVvS
X-Received: by 2002:a37:38d:: with SMTP id 135mr1520680qkd.136.1621457003296;
        Wed, 19 May 2021 13:43:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdMHznC98oBCZTDwmJO/G1L/uvLiQN7mN+gwV4D1I1ygEupjeNYdhOwwFQ1imXPbyJr2fAFw==
X-Received: by 2002:a37:38d:: with SMTP id 135mr1520665qkd.136.1621457003146;
        Wed, 19 May 2021 13:43:23 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v66sm560563qkd.113.2021.05.19.13.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:43:22 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 2/2] fpga: add cancel() and get_error() to update ops
Date:   Wed, 19 May 2021 13:43:18 -0700
Message-Id: <20210519204318.1976186-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A user may want to cancel an update or get
more information on when an update fails.
Add some device ops to do these.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/fpga/fpga-mgr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index ab68280f3b4a4..31d6ebc34d87a 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -111,6 +111,8 @@ struct fpga_image_info {
  * @write: write count bytes of configuration data to the FPGA
  * @write_sg: write the scatter list of configuration data to the FPGA
  * @write_complete: set FPGA to operating state after writing is done
+ * @cancel: cancel the update
+ * @get_error: get extended error information
  */
 struct fpga_manager_update_ops {
 	int (*write_init)(struct fpga_manager *mgr,
@@ -120,6 +122,8 @@ struct fpga_manager_update_ops {
 	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
 	int (*write_complete)(struct fpga_manager *mgr,
 			      struct fpga_image_info *info);
+	int (*cancel)(struct fpga_manager *mgr);
+	int (*get_error)(struct fpga_manager *mgr, u64 *err);
 };
 
 /**
-- 
2.26.3

