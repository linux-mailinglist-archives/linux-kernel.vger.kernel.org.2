Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95F936119B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhDOSCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDOSCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:02:05 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF56C061574;
        Thu, 15 Apr 2021 11:01:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id ef17so6482514qvb.0;
        Thu, 15 Apr 2021 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+WxuAKEYQzQlAdaDBCbqiRsU5nkpRKPpDVKPGbJZoo=;
        b=omSdtTy3Z5hj1lplWc42YYdNIlvPA/d1BuVz2FqBEc6iBdhR0s/5+WagAAL4Zk1YAc
         CWjUthRXgYMcuzLis14YOrHsvBbIuTUswDXGQQJmOJ1+VpihxfgTWaBSqvA41vXj1lAR
         ATm6S/A6Cbh/mzZHi9MgQnA8xEmV7s8/xCWzzUNZ8kVFvt++osMV0Pn1/pvc6B9PuHE4
         YY12+zAA6R6/zkUeoIz1yTyqsuKrwU8Q+aw5AxOGJv177G0bgQZI4W8ZV/qRKccUshhz
         umO9bqMYm9LobzFe6oKAEY3NlD/z4o17Lw3g/CKtL9Wk3um/gQJ2qZeLPffjsCTz6h2b
         J3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+WxuAKEYQzQlAdaDBCbqiRsU5nkpRKPpDVKPGbJZoo=;
        b=UvsdVXU3luBqHVFcBBa8mxdqvMX3afDcZVrusEfsg0TclYRhgbVuBp4wQVZYKbQSmL
         Cjx2obj7ID09THyhy4S28myR+HvIYp4fSqo7lMw5altMNTDDdnaOQzvc7OfoFZEFJuRR
         KfMPCejmE2NcvgnxvbMEWSSoyS1ppDNwkcmQuZ0DigcggxKpuzoJovYH05O+pWk6SrUD
         Sa9WraZ9wJmYhEH9csNRM7LBMNGLU4GGSR5ekcvLqTKvc4OreznjBcE4eoeQ4wOssYZu
         kqKFOSIgo09UibaCIlbvhEwU4NNFqjSe2a/yqszMjLGG+8HsTCyfu/YsmCxKARjVwEgk
         Cyxw==
X-Gm-Message-State: AOAM530Z8QF9ta26GpWdMv/3OHOchN4fHOXWXBJb7Lw7yimqWIRQS4bd
        ZVpuAQLbaquo+44PRplKQnk=
X-Google-Smtp-Source: ABdhPJwbEnxJ32ca8ntb2wP5VKo0v0Tu2H5S4ts3+g6Ej4zFLT4aKZE3Po2+SmGJRN4ouqA+MCapFw==
X-Received: by 2002:a0c:fd62:: with SMTP id k2mr4410395qvs.51.1618509701724;
        Thu, 15 Apr 2021 11:01:41 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1000])
        by smtp.gmail.com with ESMTPSA id f16sm2544834qkl.25.2021.04.15.11.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:01:41 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, aik@ozlabs.ru
Cc:     Leonardo Bras <leobras.c@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses
Date:   Thu, 15 Apr 2021 15:00:51 -0300
Message-Id: <20210415180050.373791-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many other resource flag parsers already add this flag when the input
has bits 24 & 25 set, so update this one to do the same.

Some devices (like virtio-net) have more than one memory resource
(like MMIO32 and MMIO64) and without this flag it would be needed to
verify the address range to know which one is which.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 drivers/of/address.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 73ddf2540f3f..dc7147843783 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -116,9 +116,12 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
 		flags |= IORESOURCE_IO;
 		break;
 	case 0x02: /* 32 bits */
-	case 0x03: /* 64 bits */
 		flags |= IORESOURCE_MEM;
 		break;
+
+	case 0x03: /* 64 bits */
+		flags |= IORESOURCE_MEM | IORESOURCE_MEM_64;
+		break;
 	}
 	if (w & 0x40000000)
 		flags |= IORESOURCE_PREFETCH;
-- 
2.30.2

