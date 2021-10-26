Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48F43AE1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhJZIe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234481AbhJZIet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:34:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2245860E8C;
        Tue, 26 Oct 2021 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635237146;
        bh=Np5uvCL7SAY+xKREpkQD5F9psWb/DCaA1uMgfOsvw94=;
        h=From:To:Cc:Subject:Date:From;
        b=YVONyq0jH01z8GaA5jaD63ThMhxFOuXbsaAyA+W0ZtO3aQop4A/uQy7DY27a7o2HX
         KcuxOnrhcOCqj5WGfZt8qOqj+7vmyi7PIRSNCV3q0c9oaNDdqkfPD7qBteylRIbYyR
         TWG7hRk5sIL22gMsmlIMg+Q9wYRnfcHuz8sLm5Z+lvHRX0dUQp9pfcmbhuIYbzE7dK
         1BXuuqP4t6sxW0Ab7ff3j5e+v2YXBlMT6DH0jxR7A4JM51+knPaIOzZbx9axMJ7DVU
         0Hb+BtaaiFsnLiAM9BHImoWNmMHUjz2xE9BAgYnwRejqSV7t2G7B1yR9K1BIejVjUc
         +05DIZGrZ09fQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Eli Cohen <elic@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] eni_vdpa: alibaba: fix Kconfig typo
Date:   Tue, 26 Oct 2021 10:31:59 +0200
Message-Id: <20211026083214.3375383-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The Kconfig symbol was misspelled, which leads to randconfig link
failures:

ld.lld: error: undefined symbol: vp_legacy_probe
>>> referenced by eni_vdpa.c
>>>               vdpa/alibaba/eni_vdpa.o:(eni_vdpa_probe) in archive drivers/built-in.a

Fixes: 52e437b2b222 ("eni_vdpa: add vDPA driver for Alibaba ENI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/vdpa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 481a38e6c600..dd258f42140e 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -80,7 +80,7 @@ config VP_VDPA
 
 config ALIBABA_ENI_VDPA
 	tristate "vDPA driver for Alibaba ENI"
-	select VIRTIO_PCI_LEGACY_LIB
+	select VIRTIO_PCI_LIB_LEGACY
 	depends on PCI_MSI && !CPU_BIG_ENDIAN
 	help
 	  VDPA driver for Alibaba ENI (Elastic Network Interface) which is built upon
-- 
2.29.2

