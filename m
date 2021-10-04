Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF174212C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhJDPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:38:35 -0400
Received: from smtp1.axis.com ([195.60.68.17]:45236 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235465AbhJDPid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633361804;
  x=1664897804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UYFFJPxtl6flc0oGzUVAnUnydlzyo+IHmBDZ17tVdz4=;
  b=ohhGc/PYjTCA0CE/oRjNBNrR/AF/qofXI2drTPCl609kyM1+CnQHvnqN
   GZSu8zKg71YH7HUn/DJoCw/zRkc4JoAnuaRMdaYlpQ5fwAPVbLfpesYL6
   bQGvjN6uk1OCmfcO0Uebv5kwXK8Iq3zXLdct2LllbY6Zp+X0NNpzHfz37
   4XTblTVvTOYQDiEMN3jjmJ7A0/yKl2KR23n66NQGZeV2URbQE+MaTGaSr
   DjjO7V+THRWzlUI26X5ZYsksnEXcs+TU9OeQO821A0drw1m1cRHfxEtwT
   zLwwGfjzeRrYxMBeU0gxyWf6oo5EfdAWQh1yPR7eFSBZOxWsgvThmbz7E
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <peda@axentia.se>, <devicetree@vger.kernel.org>
CC:     <kernel@axis.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 1/2] dt-bindings: mux: gpio-mux: Add property for settle time
Date:   Mon, 4 Oct 2021 17:36:39 +0200
Message-ID: <20211004153640.20650-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211004153640.20650-1-vincent.whitchurch@axis.com>
References: <20211004153640.20650-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware may require some time for the muxed analog signals to settle
after the muxing is changed.  Allow this time to be specified in the
devicetree.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 Documentation/devicetree/bindings/mux/gpio-mux.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
index 0a7c8d64981a..7cffa0711f02 100644
--- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
+++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
@@ -31,6 +31,11 @@ properties:
   idle-state:
     default: -1
 
+  settle-time-us:
+    default: 0
+    description:
+      Time required for analog signals to settle after muxing.
+
 required:
   - compatible
   - mux-gpios
-- 
2.28.0

