Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ACB4141FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhIVGha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:37:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48576 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhIVGh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:37:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3838720088;
        Wed, 22 Sep 2021 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632292559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gfr/hCvClxRucXRWXVi9j4H3NbdWGDnOwvguA7u39Ow=;
        b=HtSIpnf9pQm4aZX/3TDQ/7hMoIMCyuZdaSVXu6WSN0LnlHXIChmNEp2elztJUQ6NcIoqXt
        /dgyrxtNMvwXJ5+MP+CtIUHVwc82v3o28GlFAfRqRTd1V1xOqSH1jC2kKV9rb2HYNU5IvZ
        ZobXXuLmL1vsePCzWgQHidLiT/OYkWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632292559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gfr/hCvClxRucXRWXVi9j4H3NbdWGDnOwvguA7u39Ow=;
        b=2fmclXILXteY+PXRkmIXPwujIpqkWWlQ7qC4T0X+JAkKlyKFYPRRULwfaRpOcfJG7Wi+LW
        baCqRnZN766XacAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 08C34A3B81;
        Wed, 22 Sep 2021 06:35:58 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        linux-arm-kernel@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2] MAINTAINERS: ARM/VT8500, remove defunct e-mail
Date:   Wed, 22 Sep 2021 08:35:58 +0200
Message-Id: <20210922063558.26417-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux@prisktech.co.nz is defunct:
4.1.2 <linux@prisktech.co.nz>: Recipient address rejected: Domain not found

Remove it from MAINTAINERS and make thus the ARM/VT8500 entry an orphan.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
[v2]
- switch also Maintained -> Orphan

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aafc58437abd..08ed07f745f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2821,9 +2821,8 @@ F:	arch/arm/mach-pxa/include/mach/vpac270.h
 F:	arch/arm/mach-pxa/vpac270.c
 
 ARM/VT8500 ARM ARCHITECTURE
-M:	Tony Prisk <linux@prisktech.co.nz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/i2c/i2c-wmt.txt
 F:	arch/arm/mach-vt8500/
 F:	drivers/clocksource/timer-vt8500.c
-- 
2.33.0

