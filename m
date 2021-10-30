Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0144069F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 03:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhJ3BNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 21:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhJ3BNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 21:13:20 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF12C061570;
        Fri, 29 Oct 2021 18:10:51 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id bk22so4406019qkb.6;
        Fri, 29 Oct 2021 18:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiHgAm6bAVmqKKaX9zBnP/GQ6TBFMsyS9/nMvi1BERs=;
        b=ILPvvvksrCbx69o9/Il9TNGfavAy6nHY/cCCE3AZEgP1ci9xFW2My50WtKqauc0HyW
         k5dsmJVVacVEkb2UskKttbtpEmWl/XUfhvdBhnoj/tveOgvqaQ3dWHlzFl7V59oc1XGY
         2NGs2OZuixkVOfaAyQ7gM3FuR6C6Kad0uPCZSwupsjsr1uCEMWxk2S50G6O+DFX3Wr28
         EViS7KqWkGi8evWtVCS5sHTdVqemURT5txzIiJa9+/38KofRCjPj5v+JQTooGCp3Jhce
         YU+u7qqVqdBG/Zmo7u/vXW01OeGhdUDE2KrQsl0tX06NaS0CBkaaNjVEkOgzraAyC4R+
         nupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiHgAm6bAVmqKKaX9zBnP/GQ6TBFMsyS9/nMvi1BERs=;
        b=mmyEOZQM4zMSWSdG0tVqOAhToU8dNF4Op/fhA7er+7MvYosdQ9kCAntKPJAMtHuXNm
         NCGB/kNtV2VSgRU9hIV4IWM5jIsNSEWkhLVtDTH41x5PtRF8De5zZlpMwUapdmFKtHMw
         RoDPDpcEJaCXfOlIWMXdL9GMyZ2OLjwibDmijCW//vDnUjFSn1D/PraFrsDyuQZ/cDGk
         5+qbnfTz5DuKWgV4MzsmvWs+2n77x/nD00OcCQ5uJP+GuGWpHGtTyH0TWyQdLgQzorVy
         xjR2mLrpNuvDs+aCpzJfpgdCIJhJgPl4IQtHMC6DX+iQmZdpjSz3ltpJ0p2r6zM334k4
         3hJA==
X-Gm-Message-State: AOAM531Uw9VVgqi3RxZuHoq+ROCiQ360nHe8hD06A7CiY4jcf0igglT0
        Se40m5au7K6OfRuyoMOUBgg=
X-Google-Smtp-Source: ABdhPJwwZFyf63BLym48PP+jtXbbtWua7hJUCRLMXoCmFkxtLnO1KlaqgEFHQev1xS7q7QeGUJmfxQ==
X-Received: by 2002:a05:620a:1901:: with SMTP id bj1mr9223045qkb.325.1635556250661;
        Fri, 29 Oct 2021 18:10:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id q13sm5322138qkl.7.2021.10.29.18.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 18:10:50 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: unittest: document intentional interrupt-map provider build warning
Date:   Fri, 29 Oct 2021 20:10:39 -0500
Message-Id: <20211030011039.2106946-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

A recently implemented dtc compiler warning reports a dts problem
via a build warning:

   drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider

The warning will be addressed by a separate patch by suppressing the
warning for .dts files that include this .dtsi.  This patch documents
why the warning is due to a deliberately incorrect .dtsi file so that
no one will fix the .dtsi file to prevent the build warning.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 .../of/unittest-data/tests-interrupts.dtsi    | 19 +++++++++++++++++++
 drivers/of/unittest.c                         |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
index 9b60a549f502..8c8d267d4d3c 100644
--- a/drivers/of/unittest-data/tests-interrupts.dtsi
+++ b/drivers/of/unittest-data/tests-interrupts.dtsi
@@ -31,6 +31,21 @@ test_intmap0: intmap0 {
 
 			test_intmap1: intmap1 {
 				#interrupt-cells = <2>;
+				/*
+				 * #address-cells is required
+				 *
+				 * The property is not provided in this node to
+				 * test that the code will properly handle
+				 * this case for legacy .dts files.
+				 *
+				 * Not having #address-cells will result in a
+				 * warning from dtc starting with
+				 * version v1.6.1-19-g0a3a9d3449c8
+				 * The warning is suppressed by adding
+				 * -Wno-interrupts_property to the Makefile
+				 * for all .dts files this include this .dtsi
+				#address-cells = <1>;
+				 */
 				interrupt-map = <0x5000 1 2 &test_intc0 15>;
 			};
 
@@ -46,6 +61,10 @@ interrupts1 {
 
 			interrupts-extended0 {
 				reg = <0x5000 0x100>;
+				/*
+				 * Do not remove &test_intmap1 from this
+				 * property - see comment in node intmap1
+				 */
 				interrupts-extended = <&test_intc0 1>,
 						      <&test_intc1 2 3 4>,
 						      <&test_intc2 5 6>,
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 8c056972a6dd..04bfef8f67c3 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1129,6 +1129,12 @@ static void __init of_unittest_parse_interrupts_extended(void)
 			passed &= (args.args[1] == 14);
 			break;
 		case 6:
+			/*
+			 * Tests child node that is missing property
+			 * #address-cells.  See the comments in
+			 * drivers/of/unittest-data/tests-interrupts.dtsi
+			 * nodes intmap1 and interrupts-extended0
+			 */
 			passed &= !rc;
 			passed &= (args.args_count == 1);
 			passed &= (args.args[0] == 15);
-- 
Frank Rowand <frank.rowand@sony.com>

