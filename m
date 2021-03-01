Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D2329975
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344826AbhCBAQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 19:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239546AbhCASXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:23:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57A2C65132;
        Mon,  1 Mar 2021 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614618222;
        bh=DRL8Qftwm1Qrd2JQGS5Zl6XByw9sbS+8gog7OZHIZ1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXEIDMVUNv2o1rLPVemdHtJOn1mVWXeKhZlxGNm8hlxUWUq1xtawwHKIfpaIuhJ0J
         eBAwegH//mcNbdx/apbyt8EWSjXxtH38kC6XffJ6BRTYVGg9VwiX0Kp2owIm+qNABb
         CN230zWa8M77AmLGI95rb4qgbSebrHFuxALPxm58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.10 010/663] PCI: Decline to resize resources if boot config must be preserved
Date:   Mon,  1 Mar 2021 17:04:18 +0100
Message-Id: <20210301161142.289000449@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161141.760350206@linuxfoundation.org>
References: <20210301161141.760350206@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

commit 729e3a669d1b62e9876a671ac03ccba399a23b68 upstream.

The _DSM #5 method in the ACPI host bridge object tells us whether the OS
must preserve the resource assignments done by firmware. If this is the
case, we should not permit drivers to resize BARs on the fly. Make
pci_resize_resource() take this into account.

Link: https://lore.kernel.org/r/20210109095353.13417-1-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org	# v5.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/setup-res.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -410,10 +410,16 @@ EXPORT_SYMBOL(pci_release_resource);
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 {
 	struct resource *res = dev->resource + resno;
+	struct pci_host_bridge *host;
 	int old, ret;
 	u32 sizes;
 	u16 cmd;
 
+	/* Check if we must preserve the firmware's resource assignment */
+	host = pci_find_host_bridge(dev->bus);
+	if (host->preserve_config)
+		return -ENOTSUPP;
+
 	/* Make sure the resource isn't assigned before resizing it. */
 	if (!(res->flags & IORESOURCE_UNSET))
 		return -EBUSY;


