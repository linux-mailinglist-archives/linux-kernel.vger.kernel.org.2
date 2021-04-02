Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B750B352FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbhDBTVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:21:14 -0400
Received: from smtp-17.italiaonline.it ([213.209.10.17]:44683 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236364AbhDBTVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:21:06 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([87.20.116.197])
        by smtp-17.iol.local with ESMTPA
        id SPLllsyFltpGHSPLrl2Fsg; Fri, 02 Apr 2021 21:21:03 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1617391263; bh=/p8Rl5Pn/DiIFZ14m3YTYyOW5iMxnmcIc1NVIMcsSyU=;
        h=From;
        b=v5QoQB7OsHdei7NhqYGVVALZ5zuLspwvi/wqGhpkJGJXMp33Cp3jKY6BCh8G5n4Vq
         UQrAkgnbAr+5r+JmwoVKNYqNARODisO5qdJcrbTI3ZYRF7TlKZZErPiYfRn7PJRRj0
         sZHUp742NNr1j4/8sz227MXo6UPurX6rQ4/QHDQQrVZdmOQxbHFH5tBD7MLf+zM/rx
         HJViAxf/MYAGbdY1sSj3Tab46rtirxJaHsQuLo8qY0nKb4BPsg1Sfl6P7h6mCNWN7s
         BB30oXQtra4TcVad6w5YcUCtcn6gBwGnzWZgDGMaxd8BsYoi2pSk83STiBAxAVco1T
         Q0pRNt6Z6V54Q==
X-CNFS-Analysis: v=2.4 cv=Q7IXX66a c=1 sm=1 tr=0 ts=60676e9f cx=a_exe
 a=AVqmXbCQpuNSdJmApS5GbQ==:117 a=AVqmXbCQpuNSdJmApS5GbQ==:17
 a=38wqRlg9tItjdq7vn9gA:9 a=8hrBh_S1lF386cKV:21 a=9guEsTgsuuT2DR_H:21
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>, Bin Meng <bmeng.cn@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] fdt: translate address if #size-cells = <0>
Date:   Fri,  2 Apr 2021 21:20:53 +0200
Message-Id: <20210402192054.7934-2-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402192054.7934-1-dariobin@libero.it>
References: <20210402192054.7934-1-dariobin@libero.it>
X-CMAE-Envelope: MS4xfCtRTdCoLJ2l+ys7Y/9ueVP5NO0jLh0APftefEw44q51Um2Gxrttik/fbkAxgU+eAAceMxARlPUZC+g5WTy2N3TQgP/04rXbs9zGd7Ml7JQGhTHE0lzy
 9NgKitBC4BqWQVFXoTtbGmhyFto1sDlGm4xrUvu+OlsmMYkgFmPWvmEn6F+hIfKJa4uQzgklw7C9G0bGTPZzY7HfmMN8CPJXmYc5V9+IJ4ZhjPjqqC6Izy3r
 aRgCbGe45dDbQfp2RGd3WSkWT6C1R/If2jvXNT8RQYW4bnkzFMod8qfh78sHb/tJXKK/QCqeOnYGaloo69/sDU/34KluDn3O8BC3STTZ3YEVvKAhnpK9+PbZ
 i3qWJxxmo3/7YQaXoA1k3Ohgut9W/jUufyYe1nnWrQ98aCr8/D4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __of_translate_address() translates an address from the device tree
into a CPU physical address. A note in the description of the routine
explains that the crossing of any level with #size-cells = <0> can not
be mapped to a CPU physical address not because it's really specified
that way, but because this is traditionally the way IBM at least do
things. This does not happen for Texas Instruments, or at least for the
beaglebone device tree. Without this patch, in fact, the translation into
physical addresses of the registers contained in the am33xx-clocks.dtsi
nodes would not be possible. They all have a parent with #size-cells = <0>.

The CONFIG_OF_TRANSLATE_ZERO_SIZE_CELLS symbol makes translation
possible even in the case of crossing levels with #size-cells = <0>.

The patch has been tested on a beaglebone black board. The addresses
generated for the clock registers are those specified by the AM335x
reference manual.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

 drivers/of/Kconfig       | 13 +++++++++++++
 drivers/of/address.c     |  8 +++++++-
 drivers/of/fdt_address.c |  6 ++++--
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 18450437d5d5..5a76c8c23de6 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -100,4 +100,17 @@ config OF_DMA_DEFAULT_COHERENT
 	# arches should select this if DMA is coherent by default for OF devices
 	bool
 
+
+config OF_TRANSLATE_ZERO_SIZE_CELLS
+	bool "Enable translation for zero size cells"
+	depends on OF_EARLY_FLATTREE || OF_ADDRESS
+	default y if SOC_AM33XX
+	help
+	  The routine used to translate an FDT address into a physical CPU
+	  address was developed by IBM. It considers that crossing any level
+	  with #size-cells = <0> makes translation impossible, even if it is
+	  not the way it was specified.
+	  Enabling this option makes translation possible even in the case
+	  of crossing levels with #size-cells = <0>.
+
 endif # OF
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 73ddf2540f3f..7b7ef69fb126 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -20,7 +20,10 @@
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
 #define OF_CHECK_ADDR_COUNT(na)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS)
-#define OF_CHECK_COUNTS(na, ns)	(OF_CHECK_ADDR_COUNT(na) && (ns) > 0)
+#define OF_CHECK_COUNTS(na, ns)						\
+	(OF_CHECK_ADDR_COUNT(na) &&					\
+	 ((ns) > 0 || (IS_ENABLED(CONFIG_OF_TRANSLATE_ZERO_SIZE_CELLS) && \
+		      (ns) == 0)))
 
 static struct of_bus *of_match_bus(struct device_node *np);
 static int __of_address_to_resource(struct device_node *dev,
@@ -420,6 +423,9 @@ static struct of_bus *of_match_bus(struct device_node *np)
 
 static int of_empty_ranges_quirk(struct device_node *np)
 {
+	if (IS_ENABLED(CONFIG_OF_TRANSLATE_ZERO_SIZE_CELLS))
+		return true;
+
 	if (IS_ENABLED(CONFIG_PPC)) {
 		/* To save cycles, we cache the result for global "Mac" setting */
 		static int quirk_state = -1;
diff --git a/drivers/of/fdt_address.c b/drivers/of/fdt_address.c
index 1dc15ab78b10..09c78c94c1b5 100644
--- a/drivers/of/fdt_address.c
+++ b/drivers/of/fdt_address.c
@@ -19,8 +19,10 @@
 
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
-#define OF_CHECK_COUNTS(na, ns)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS && \
-			(ns) > 0)
+#define OF_CHECK_COUNTS(na, ns)						\
+	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS &&			\
+	 ((ns) > 0 || (IS_ENABLED(CONFIG_OF_TRANSLATE_ZERO_SIZE_CELLS) && \
+		       (ns) == 0)))
 
 /* Debug utility */
 #ifdef DEBUG
-- 
2.17.1

