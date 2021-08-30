Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512993FB3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhH3KkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236288AbhH3KkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630319966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9UdhdlCXAumNKGumRgixdjPkcUszwAPFwDnuB62lb9Y=;
        b=etlWIwM5ANd3gvI7akwcdg35GF0U5pW5F6aTgPcob6oszZoBZYmZqHM0b9auwP8NC4k72x
        bhiOKGhkoXGG0wqNFPHBwSc8/uAEUL+7+R8m+rY7In3ACtA5fHbra6CjjDx6B5U1oynVlG
        Bx3Sq2NgdmgMGwbfsufuGAd4c6Zxt4Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-F_bYtltAPmm49sP5A1mXcg-1; Mon, 30 Aug 2021 06:39:25 -0400
X-MC-Unique: F_bYtltAPmm49sP5A1mXcg-1
Received: by mail-wm1-f71.google.com with SMTP id a201-20020a1c7fd2000000b002e748bf0544so9893862wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UdhdlCXAumNKGumRgixdjPkcUszwAPFwDnuB62lb9Y=;
        b=eITk2Sr8HWn7DBl7NeFfnup+1qYg3zRfD/HgcLfM9AjCOYsNkgzH6dFUu/Spm0gpC8
         HX8NxGQX5tJRCyONRdELLlfJzN2LBmeMOKzhmGMdAWCJvZ+tvs+8oQrMKi8XA9PMgAL+
         Uk+9BMqikxf7cYxSavWKyl3AffhhHod45M2JNo+mtlCuOPVYhRtyTEdWGUGC/1O+2NU0
         yTBBzJJfvYNti+sJWAnAnq8kQYKUt1hdMyOf56iyjPMI/KDzgFvN8rXLEEcWj0am0n+E
         KTYmw3SBclkfVvJGmp8kuMoyMYzART9JVEiqH3MUsQ0RlmX3Pun6PseVzP7HReTXHiH9
         J9mw==
X-Gm-Message-State: AOAM530Q1pZTdY0kp3nu0sC0fzc+jYRxMGOi6gm2zm4+KozPvvT8Uwqt
        pW5lU7H9GeEDjIjeY6Pp90sb2lkuS08TJSurNaoa4vPVRRiGAwfGWWw0gyd1qLCDSQr39cDAM9C
        QBVg105+BZTNX+bdSkvV/ECh+
X-Received: by 2002:a05:600c:1d29:: with SMTP id l41mr30280782wms.177.1630319964250;
        Mon, 30 Aug 2021 03:39:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwALzuPla4B1S2RZz1MtMKVuunqRTTV1sR92kQFdy2K3D+8LhOpR7gk+2lXiLEJkwumT7k36w==
X-Received: by 2002:a05:600c:1d29:: with SMTP id l41mr30280771wms.177.1630319964077;
        Mon, 30 Aug 2021 03:39:24 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3c08:b500:afb2:5ebc:3fd2:26de])
        by smtp.gmail.com with ESMTPSA id n18sm16594169wmc.22.2021.08.30.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:39:23 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     robh+dt@kernel.org, nsaenz@kernel.org, f.fainelli@gmail.com
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefan.wahren@i2se.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] ARM: dts: bcm2711-rpi-4-b: Fix pcie0's unit address
Date:   Mon, 30 Aug 2021 12:39:09 +0200
Message-Id: <20210830103909.323356-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtbs_check currently complains that:

arch/arm/boot/dts/bcm2711-rpi-4-b.dts:220.10-231.4: Warning
(pci_device_reg): /scb/pcie@7d500000/pci@1,0: PCI unit address format
error, expected "0,0"

Unsurprisingly pci@0,0 is the right address, as illustrated by its reg
property:

	&pcie0 {
		pci@0,0 {
			/*
			 * As defined in the IEEE Std 1275-1994 document,
			 * reg is a five-cell address encoded as (phys.hi
			 * phys.mid phys.lo size.hi size.lo). phys.hi
			 * should contain the device's BDF as 0b00000000
			 * bbbbbbbb dddddfff 00000000. The other cells
			 * should be zero.
			 */
			reg = <0 0 0 0 0>;
		};
	};

The bus is clearly 0. So fix it.

Fixes: 258f92d2f840 ("ARM: dts: bcm2711: Add reset controller to xHCI node")
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index f24bdd0870a5..8a77f9e942be 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -217,7 +217,7 @@ phy1: ethernet-phy@1 {
 };
 
 &pcie0 {
-	pci@1,0 {
+	pci@0,0 {
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
-- 
2.31.1

