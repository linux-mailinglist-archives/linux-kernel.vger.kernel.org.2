Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B937843169A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhJRK5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJRK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:57:04 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC86C061768
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:54:53 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e87a:7c37:aec5:5884])
        by xavier.telenet-ops.be with bizsmtp
        id 7Nuq2600j22VXnz01NuqP1; Mon, 18 Oct 2021 12:54:50 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mcQI6-005sWN-E9; Mon, 18 Oct 2021 12:54:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mcQI5-00DbGX-Rj; Mon, 18 Oct 2021 12:54:49 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] dt-bindings: Parallelize yamllint
Date:   Mon, 18 Oct 2021 12:54:47 +0200
Message-Id: <c68bdbdf3112c4658e0748c8fc51959e69fbae2e.1634551582.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634551582.git.geert+renesas@glider.be>
References: <cover.1634551582.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use xargs sharding like "chk_bindings" does, to parallelize the
execution of yamllint.

This reduces the yamllint execution time from ca. 21 to 5 seconds on
i7-8700K.

Suggested-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 Documentation/devicetree/bindings/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index a072e95de626c83b..6305cfa9495ed676 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -28,7 +28,7 @@ find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
-                     xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true
+                     xargs -n200 -P$$(nproc) $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true
 
 quiet_cmd_chk_bindings = CHKDT   $@
       cmd_chk_bindings = ($(find_cmd) | \
-- 
2.25.1

