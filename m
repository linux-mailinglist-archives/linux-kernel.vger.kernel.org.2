Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D070338B605
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhETSbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235117AbhETSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621535414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RCwD0QS5qYMZ3I485ga0mBzEclvb9mUVoGt+KyuaoxM=;
        b=g0UGsvg8wqnzKRoIzcse+i+6aKX9tI/b4UPrE2yGewPMN2zAJEIPWz8M6FRkehlCSP2oIR
        9z9IyHHT97hr1F6jUBM7zch2VshYSzYsVuNu1q8I4FH9qvZVOsHpc1n0ZHlNdytgVq8hKJ
        MphMvWkqjC6YZyVeQrTL6tC+E7M7F0Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-RUgU3NsONYG_rgkDTAJGwg-1; Thu, 20 May 2021 14:30:08 -0400
X-MC-Unique: RUgU3NsONYG_rgkDTAJGwg-1
Received: by mail-qv1-f70.google.com with SMTP id l19-20020a0ce0930000b02901efdf1c21ecso11171810qvk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCwD0QS5qYMZ3I485ga0mBzEclvb9mUVoGt+KyuaoxM=;
        b=q8d3EW5P02M+j5nKjfJA06qSdeULF5vibciwAK6RO2rcZ0mSCoKFysj8zst8af4Nhd
         13FARFqM/SeLGVQ9itMx5IssQKWu6wgVQ50xNXkV1xjWcHOkZ7e0HRpCB8FX9p96Xj+J
         RuvT7oGPKWiRDHFzQCXrUVdyaUbVEp7XeT2ieZb09LgCIQKo5LOAtBJSXPaVSqAzsfzQ
         pHhuOU7kcOAlFFhWSsqLgMBQKkhMV5uwZxM3ultUtKlIosUdN0j0gvuk4e6KVIuf7XMj
         4P1RFfNCOsTqrg5PId9bTMBgDlZOsrMBZHVfNrnzm08OzLAmwvw6CpTdcD60noN8U0F4
         yIdA==
X-Gm-Message-State: AOAM532EisjEMzItgOiZPFh3gZ4/mGQbAH+Wb+Lo+iAh0hP/iV5VyjP4
        Lm7XJ/HXFTyH9jJUJ6g5Z0VhceMf7s/rBMPYcf3qS1AmQXNpjVzctlRt06VvO1y5Y0iyhi6gNmh
        uzp1+XfPS8ZMKmLzHAgFt9aHX
X-Received: by 2002:a37:6f42:: with SMTP id k63mr5030588qkc.216.1621535408551;
        Thu, 20 May 2021 11:30:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu+PGA45IxpSIcmoDjGXXutNWvdm/FthshSNGvlLymHTheLReLclqSo5Bl2s3tEOhJStfx9Q==
X-Received: by 2002:a37:6f42:: with SMTP id k63mr5030560qkc.216.1621535408392;
        Thu, 20 May 2021 11:30:08 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p11sm2723200qkj.3.2021.05.20.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:30:08 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 2/5] fpga: add FPGA_MGR_REIMAGE flag
Date:   Thu, 20 May 2021 11:30:04 -0700
Message-Id: <20210520183004.2022169-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If this flag is set the reimage ops will be used otherwise the
reconfig ops will be used to write the image

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/fpga/fpga-mgr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 50a9fea3c47ef..bb11b18527326 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_REIMAGE: Reimage the whole card, fpga bs and other device fw
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_REIMAGE                BIT(5)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.26.3

