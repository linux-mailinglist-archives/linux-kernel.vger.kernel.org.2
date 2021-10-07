Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38293424AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbhJGAMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:12:38 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:44663 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbhJGAMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:12:14 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 232BAB11;
        Wed,  6 Oct 2021 17:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633565413;
        bh=KPHYi63s/G5XAlxpI8QkOVb49ijpIDoF7YfnJ8N7apw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKvC3KdwWMtPY936nAP1AEkiUaITTjyc55y6lQs6QNxcbjUOgwzmzE5ifms9CPcaM
         6EGAYE/k7e05sRe2IPqp8DOBwMsYS7W+au5bOj8EsO+RJUsqLNcnGMSzWuOKO3uemp
         H524UwzBbq393MbRfpDckxxgBx4hBZDzRX60od6I=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] dt-bindings: document new 'dynamic' common property
Date:   Wed,  6 Oct 2021 17:09:53 -0700
Message-Id: <20211007000954.30621-9-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../devicetree/bindings/common-properties.txt  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
index 98a28130e100..db6c54e1071d 100644
--- a/Documentation/devicetree/bindings/common-properties.txt
+++ b/Documentation/devicetree/bindings/common-properties.txt
@@ -83,3 +83,21 @@ gpio@0 {
 	      #gpio-cells = <2>;
 	      #daisy-chained-devices = <3>;
 };
+
+Dynamic devices
+---------------
+
+Certain devices may require support for runtime attachment and
+detachment (hot-plugging, essentially).
+
+Optional properties:
+ - dynamic: Boolean; indicates that the device's status may change at
+   runtime.
+
+Example:
+&spi1 {
+	      compatible = "name";
+	      status = "reserved";
+	      ...
+	      dynamic;
+};
-- 
2.33.0

