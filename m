Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64F43F99B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhJ2JTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:19:04 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:57130 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231481AbhJ2JRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:17:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Uu7wNNx_1635498896;
Received: from localhost.localdomain(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Uu7wNNx_1635498896)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Oct 2021 17:15:05 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        wuzongyong@linux.alibaba.com
Cc:     wei.yang1@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v7 9/9] eni_vdpa: alibaba: fix Kconfig typo
Date:   Fri, 29 Oct 2021 17:14:50 +0800
Message-Id: <0945b37f19b96ecadb79a4e1b01f486119a0b83a.1635493219.git.wuzongyong@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635493219.git.wuzongyong@linux.alibaba.com>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com> <cover.1635493219.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig symbol was misspelled, which leads to randconfig link
failures:

ld.lld: error: undefined symbol: vp_legacy_probe
>>> referenced by eni_vdpa.c
>>>               vdpa/alibaba/eni_vdpa.o:(eni_vdpa_probe) in archive drivers/built-in.a

Fixes: 6a9f32c00609 ("eni_vdpa: add vDPA driver for Alibaba ENI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
---
 drivers/vdpa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 07b0c73212aa..50f45d037611 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -80,7 +80,7 @@ config VP_VDPA
 
 config ALIBABA_ENI_VDPA
 	tristate "vDPA driver for Alibaba ENI"
-	select VIRTIO_PCI_LEGACY_LIB
+	select VIRTIO_PCI_LIB_LEGACY
 	depends on PCI_MSI && X86
 	help
 	  VDPA driver for Alibaba ENI (Elastic Network Interface) which is built upon
-- 
2.31.1

