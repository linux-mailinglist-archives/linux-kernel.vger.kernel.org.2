Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475E3407237
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhIJUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:00:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36043 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhIJUAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:00:47 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18AJxIMf517265
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 10 Sep 2021 12:59:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18AJxIMf517265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021083001; t=1631303967;
        bh=V6F7bdaXf2OKxaplYOc+J8bYBVsMAGw7SiKf5H6zkvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQAwjzU9fZ75ZTOph955PE0+wc9kRhBUt9xnBN/o8lASxOhZT99k8zpfiI6qwFgwv
         YO/7GmoONxV7xNhBQtYvz4meoH6+Qk044YrjhzNOcbI+DOEnBJHch/U/J3AxFcYaDT
         5h2SYjOSfJpycnxpn7GkTxvfQ4Z4VI6UQzKAZencr+FsNazc1vMj9zv2odSPEh2DsM
         FLAecyaKWmpP8VxmllDFXE+9fvl5zWpFN/Wc+7jSXMBwPUT2XizzC+vLpEO9I/weGm
         xm/H+vG6tdV+YFLfmrVy0g03cReUqGD0cw5WBASYBIiQelUVQ7pM8CjdOIj9lIUczx
         ZD+P3POQKqSQA==
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     x86 mailing list <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH] drm/bochs: add Bochs PCI ID for Simics model
Date:   Fri, 10 Sep 2021 12:59:08 -0700
Message-Id: <20210910195910.2542662-2-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210910195910.2542662-1-hpa@zytor.com>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <20210910195910.2542662-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current (and older) Simics models for the Bochs VGA used the wrong PCI
vendor ID (0x4321 instead of 0x1234).  Although this can hopefully be
fixed in the future, it is a problem for users of the current version,
not the least because to update the device ID the BIOS has to be
rebuilt in order to see BIOS output.

Add support for the 4321:1111 device number in addition to the
1234:1111 one.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 drivers/gpu/drm/tiny/bochs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 73415fa9ae0f..2ce3bd903b70 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -63,6 +63,7 @@ MODULE_PARM_DESC(defy, "default y resolution");
 
 enum bochs_types {
 	BOCHS_QEMU_STDVGA,
+	BOCHS_SIMICS,
 	BOCHS_UNKNOWN,
 };
 
@@ -695,6 +696,13 @@ static const struct pci_device_id bochs_pci_tbl[] = {
 		.subdevice   = PCI_ANY_ID,
 		.driver_data = BOCHS_UNKNOWN,
 	},
+	{
+		.vendor      = 0x4321,
+		.device      = 0x1111,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = BOCHS_SIMICS,
+	},
 	{ /* end of list */ }
 };
 
-- 
2.31.1

