Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046E43D7AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhG0QOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhG0QOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:14:23 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64880C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:14:23 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:b0a9:7e88:5ca4:551a])
        by laurent.telenet-ops.be with bizsmtp
        id aGEM2500X1fSPfK01GEMf1; Tue, 27 Jul 2021 18:14:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8Pin-001S9J-AB; Tue, 27 Jul 2021 18:14:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8Pim-00FrHS-Ri; Tue, 27 Jul 2021 18:14:20 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] MAINTAINERS: Add DT Bindings for Auxiliary Display Drivers
Date:   Tue, 27 Jul 2021 18:14:17 +0200
Message-Id: <21077068bf45bc0f21fe946fc352d46a698b4942.1627402410.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "AUXILIARY DISPLAY DRIVERS" section lacks the related DT bindings.
Add them.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fb20d4dfd4a7e60..9baee2fdf76486a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3094,6 +3094,7 @@ F:	lib/*audit.c
 AUXILIARY DISPLAY DRIVERS
 M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
+F:	Documentation/devicetree/bindings/auxdisplay/
 F:	drivers/auxdisplay/
 F:	include/linux/cfag12864b.h
 
-- 
2.25.1

