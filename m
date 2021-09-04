Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED32400BA4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 16:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhIDO3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 10:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbhIDO3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 10:29:22 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9049C061757;
        Sat,  4 Sep 2021 07:28:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 928B8D848B;
        Sat,  4 Sep 2021 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1630765697; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=riBzg7yfs/WKceqbRh7CnMdVZOOQ2QoEgRJlHcvkjSY=;
        b=STjNJ980Zt0BD9BMPVq/jIdiDqrhlOwfyqEWpmy5fnsY2Y5GQBX8ND/uGuDZJ50ImGVY6/
        wPE5270bngJRE2IoJ+TlINB24zIuPwH9T5eLyOiCrbkUoMd6hIFIhJ9nt+4B868BQFAvJ6
        hTO8IL4S7adLAcCcZ+u7wWuwliKmN3/F64YBT5Qfd26iAkkna1B2mVC90W6ZUkoc59/wjm
        lWMfQasopzrX5bHRAmBamgN8wivxliD38HiQgagQOy2ft4qOURxUxsmwp9OPwB80nH1pbu
        o49bT/0B/+H2vBV9kRZgnlqpNQqJV46lUN+juzWEMwXmaEzrjrLxBufIcHyyqw==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 2/4] dt-bindings: vendor-prefixes: add jethome prefix
Date:   Sat,  4 Sep 2021 17:27:43 +0300
Message-Id: <20210904142745.183875-3-adeep@lexina.in>
In-Reply-To: <20210904142745.183875-1-adeep@lexina.in>
References: <20210904142745.183875-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JetHome is trademark of IP Sokolov P.A., manufacturer of home automation
devices.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a867f7102c35..c52f0d3261bb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -577,6 +577,8 @@ patternProperties:
     description: JEDEC Solid State Technology Association
   "^jesurun,.*":
     description: Shenzhen Jesurun Electronics Business Dept.
+  "^jethome,.*":
+    description: JetHome (IP Sokolov P.A.)
   "^jianda,.*":
     description: Jiandangjing Technology Co., Ltd.
   "^kam,.*":
-- 
2.30.2

