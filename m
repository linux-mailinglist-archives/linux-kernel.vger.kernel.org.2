Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9797431699
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJRK5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhJRK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:57:04 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A07C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:54:53 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e87a:7c37:aec5:5884])
        by baptiste.telenet-ops.be with bizsmtp
        id 7Nur2600122VXnz01Nur1Y; Mon, 18 Oct 2021 12:54:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mcQI6-005sWT-PI; Mon, 18 Oct 2021 12:54:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mcQI6-00DbGk-7p; Mon, 18 Oct 2021 12:54:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] dt-bindings: Consider DT_SCHEMA_FILES when finding all json-schema
Date:   Mon, 18 Oct 2021 12:54:48 +0200
Message-Id: <174ab1d791b7bc65f3b0f11b72be13af1748c731.1634551582.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634551582.git.geert+renesas@glider.be>
References: <cover.1634551582.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting DT_SCHEMA_FILES allows the user to restrict the
"dt_binding_check" make target to a specified set of DT binding files.
However, yamllint is still run on all available files, which not only
takes time, but also outputs warnings for other binding files the
developer is not interested in.

Fix this by renaming "find_cmd" to "find_all_cmd", introducing a new
"find_cmd" to only return the files specified by DT_SCHEMA_FILES (if
present), and using the latter for yamllint.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Introduce find_all_cmd,
  - Only use the restricted set for yamllint.
---
 Documentation/devicetree/bindings/Makefile | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 6305cfa9495ed676..1a8c3ab9a538837a 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -22,23 +22,29 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 # Use full schemas when checking %.example.dts
 DT_TMP_SCHEMA := $(obj)/processed-schema-examples.json
 
-find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
+find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' ! \
 		-name '*.example.dt.yaml' \)
 
+ifeq ($(DT_SCHEMA_FILES),)
+find_cmd = $(find_all_cmd)
+else
+find_cmd = echo $(addprefix $(srctree)/, $(DT_SCHEMA_FILES))
+endif
+
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
                      xargs -n200 -P$$(nproc) $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2) || true
 
 quiet_cmd_chk_bindings = CHKDT   $@
-      cmd_chk_bindings = ($(find_cmd) | \
+      cmd_chk_bindings = ($(find_all_cmd) | \
                          xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)) || true
 
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = f=$$(mktemp) ; \
                       $(if $(DT_MK_SCHEMA_FLAGS), \
                            printf '%s\n' $(real-prereqs), \
-                           $(find_cmd)) > $$f ; \
+                           $(find_all_cmd)) > $$f ; \
                       $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@ ; \
 		      rm -f $$f
 
@@ -48,7 +54,7 @@ define rule_chkdt
 	$(call cmd,mk_schema)
 endef
 
-DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_cmd)))
+DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
 
 override DTC_FLAGS := \
 	-Wno-avoid_unnecessary_addr_size \
-- 
2.25.1

