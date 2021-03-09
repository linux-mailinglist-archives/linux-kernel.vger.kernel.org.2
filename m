Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616633323D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhCILWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhCILV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:21:56 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461EAC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 03:21:53 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:cc57:dd66:c63b:c8e4])
        by baptiste.telenet-ops.be with bizsmtp
        id eBMr2400e1C546401BMs41; Tue, 09 Mar 2021 12:21:52 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lJaQx-006Gg4-J8; Tue, 09 Mar 2021 12:21:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lJaQx-009giZ-50; Tue, 09 Mar 2021 12:21:51 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [RFC] dt-bindings: Consider DT_SCHEMA_FILES when finding all json-schema
Date:   Tue,  9 Mar 2021 12:21:48 +0100
Message-Id: <20210309112148.2309116-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting DT_SCHEMA_FILES allows the user to restrict the
"dt_binding_check" make target to a specified set of DT binding files.
However, yamllint is still run on all available files, which can take
quite some time.

Fix this by changing "find_cmd" to only return the specified files.
Note that this also affects the "cmd_chk_bindings" and "cmd_mk_schema"
rules.

This reduces the execution time of

    make dt_binding_check DT_SCHEMA_FILES=/path/to/json/schema/file

from ca. 22 to less than 2 seconds on an i7-8700K.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Should this be restricted to cmd_yamllint?
I'm not sure which users of find_cmd do and do not need all files.
---
 Documentation/devicetree/bindings/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 780e5618ec0ae2fc..60ac03bade2da0ad 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -22,10 +22,18 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 # Use full schemas when checking %.example.dts
 DT_TMP_SCHEMA := $(obj)/processed-schema-examples.json
 
+ifeq ($(DT_SCHEMA_FILES),)
+
 find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' ! \
 		-name '*.example.dt.yaml' \)
 
+else
+
+find_cmd = echo $(addprefix $(srctree)/, $(DT_SCHEMA_FILES))
+
+endif
+
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
                      xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint) || true
-- 
2.25.1

