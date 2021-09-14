Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862C640AACE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhINJ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:27:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38768 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhINJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:27:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C4A0522095;
        Tue, 14 Sep 2021 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631611563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oJP5Hgn0wV1kbaF6/yb6lHz6NXZ6FhJcsm4BqlwB55s=;
        b=fBut3+/sp5BYQ8IrsEowd/IeHG4Il6jc/Gg4/1XgvqA7d0wzDxq4r2KPYPb912k3aJOG4R
        Z0zSKPBHEoNK/vaPqNxaIu2gp0AaVNTbwmQ9Y4v8DYZqjqvW8dDAqDFrZuzkokdVGmKR7R
        WCJtP259Bum9OVJTFCo0f2ogSaJGy2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631611563;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oJP5Hgn0wV1kbaF6/yb6lHz6NXZ6FhJcsm4BqlwB55s=;
        b=jvEP3lpXJ38/zVth26ajMow8wilEaur2rRYv7gumOt+4GAe1zr6MaD4YwZOXquXXh+B41g
        LaAZObtUHWcfceBQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 98D01A3B94;
        Tue, 14 Sep 2021 09:26:03 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH] MAINTAINERS: remove dead e-mails
Date:   Tue, 14 Sep 2021 11:26:03 +0200
Message-Id: <20210914092603.18722-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jacmet@sunsite.dk and linux@prisktech.co.nz are dead:
* This is the qmail-send program at a.mx.sunsite.dk.
  <jacmet@sunsite.dk>:
  Sorry, no mailbox here by that name. (#5.1.1)
* 4.1.2 <linux@prisktech.co.nz>: Recipient address rejected: Domain not
  found

Remove them from MAINTAINERS.

CCing Peter with his (different) e-mail, he likely wants to update?

Could not find an alternative e-mail for Tony (CCing usb & arm). Maybe
someon knows how to contact him.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Peter Korsgaard <peter@korsgaard.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-usb@vger.kernel.org
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f800abca74b0..a2ae91e67aaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2803,7 +2803,6 @@ F:	arch/arm/mach-pxa/include/mach/vpac270.h
 F:	arch/arm/mach-pxa/vpac270.c
 
 ARM/VT8500 ARM ARCHITECTURE
-M:	Tony Prisk <linux@prisktech.co.nz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-wmt.txt
@@ -19320,13 +19319,11 @@ S:	Maintained
 F:	drivers/usb/misc/chaoskey.c
 
 USB CYPRESS C67X00 DRIVER
-M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/c67x00/
 
 USB DAVICOM DM9601 DRIVER
-M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.linux-usb.org/usbnet
-- 
2.33.0

