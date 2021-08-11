Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B0B3E8CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhHKI5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbhHKI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:57:40 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72B5C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:57:16 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:438:1ff1:1071:f524])
        by albert.telenet-ops.be with bizsmtp
        id g8xF250061gJxCh068xFaJ; Wed, 11 Aug 2021 10:57:15 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDk30-001yjw-SV; Wed, 11 Aug 2021 10:57:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mDk30-0059K5-Dw; Wed, 11 Aug 2021 10:57:14 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] MAINTAINERS: Add DT Bindings for Auxiliary Display Drivers
Date:   Wed, 11 Aug 2021 10:57:08 +0200
Message-Id: <01bc16af8d37fc1d8adb0cc350d5c7f00bacbbfe.1628672164.git.geert@linux-m68k.org>
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
index dfb3b20bd0601bfa..2a3a58d830754316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3103,6 +3103,7 @@ F:	lib/*audit.c
 AUXILIARY DISPLAY DRIVERS
 M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
+F:	Documentation/devicetree/bindings/auxdisplay/
 F:	drivers/auxdisplay/
 F:	include/linux/cfag12864b.h
 
-- 
2.25.1

