Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556D733261E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhCINHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhCINGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:06:54 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747AEC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:06:54 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:cc57:dd66:c63b:c8e4])
        by andre.telenet-ops.be with bizsmtp
        id eD6r2400h1C546401D6rLT; Tue, 09 Mar 2021 14:06:52 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lJc4Z-006IN8-Hb; Tue, 09 Mar 2021 14:06:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lJc4Z-009j8c-35; Tue, 09 Mar 2021 14:06:51 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] docs: dt: submitting-patches: Fix grammar in subsystem section
Date:   Tue,  9 Mar 2021 14:06:50 +0100
Message-Id: <20210309130650.2318419-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reword the subsystem bindings section to make sense, from a grammatical
point of view.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/submitting-patches.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
index 68129ff09967d5d7..1d11c25249ff5465 100644
--- a/Documentation/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -75,8 +75,8 @@ II. For kernel maintainers
      binding, and it hasn't received an Acked-by from the devicetree
      maintainers after a few weeks, go ahead and take it.
 
-     Subsystem bindings (anything affecting more than a single device)
-     then getting a devicetree maintainer to review it is required.
+     For subsystem bindings (anything affecting more than a single device),
+     getting a devicetree maintainer to review it is required.
 
   3) For a series going though multiple trees, the binding patch should be
      kept with the driver using the binding.
-- 
2.25.1

