Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE16424AF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbhJGAMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbhJGAMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:12:14 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966F1C061769;
        Wed,  6 Oct 2021 17:10:12 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 41682C9C;
        Wed,  6 Oct 2021 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633565412;
        bh=8PxEBgL6W+cioy40DEeituztueb3LeZkbsP0wIoL/Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kY2SIwimC82+8OVRRx8RawwF6vON2/1tDFBmvkufF7BIAcyB+uL6Ai+6ZuY+GFjod
         zbBfRwJ8PooTFUPhODE8SDsA9JxMdfv4Rpj9GonN5n+q66yGceoBcXEaBE60Vr1B7k
         X3BebMxwRHlKJqdGuEgPuvumw2A4rQM285HvdyyU=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] of: make OF_DYNAMIC selectable independently of OF_UNITTEST
Date:   Wed,  6 Oct 2021 17:09:52 -0700
Message-Id: <20211007000954.30621-8-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The writable status sysfs file enabled by the 'dynamic' DT property
requires CONFIG_OF_DYNAMIC to be useful, but that shouldn't require
dragging in CONFIG_OF_UNITTEST as well.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/of/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 3dfeae8912df..8e0ba87db030 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -55,12 +55,14 @@ config OF_KOBJ
 # Hardly any platforms need this.  It is safe to select, but only do so if you
 # need it.
 config OF_DYNAMIC
-	bool "Support for dynamic device trees" if OF_UNITTEST
+	bool "Support for dynamic device trees"
 	select OF_KOBJ
 	help
 	  On some platforms, the device tree can be manipulated at runtime.
-	  While this option is selected automatically on such platforms, you
-	  can enable it manually to improve device tree unit test coverage.
+	  With this option enabled, device tree nodes that are marked with
+	  the "dynamic" property can have their status toggled between
+	  "okay" and "reserved" via sysfs.  This can also be enabled to
+	  increase test coverage with CONFIG_OF_UNITTEST if desired.
 
 config OF_ADDRESS
 	def_bool y
-- 
2.33.0

