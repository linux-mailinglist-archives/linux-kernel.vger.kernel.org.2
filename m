Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD49359C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhDIKpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231611AbhDIKpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:45:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54E6B610CB;
        Fri,  9 Apr 2021 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617965105;
        bh=ougxCnzB/DTpWXR0gl7FhXHP/fL32LRHhUHh4l07TXA=;
        h=From:To:Cc:Subject:Date:From;
        b=hQwDRvP1EbC8YUDkT0In/hR9fO5dJwGLuHaLetPeqJaDl247PAMJmgdsXxgPcPSji
         nqjrKubLU+48bGQHoSi1LMKQpejVj3TsxeqQMm388j3Fex5gHEbTwamalRpUa0jIlV
         q1AUBvmJx6Zlzd8SMwymMG7+iTZidLIZZi6nSAyF7ELU00p36wNJiwkpwOOf2odBD5
         HGnyeo30QnqMwcY+ASyMpqDkWwqKJPBS/04OuWp1NA4WSmLg1B6K+WLFiEsn52NWQe
         cyIpAptCocyl7qaN5kJaddH/k6D/xosqXu91+85CO6LuJSyx5JIosIsgKKrGRg5Kx0
         GS6YaTEFPXpsg==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com, stefan.wahren@i2se.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: [PATCH] MAINTAINERS: Update BCM2711/BCM2335 maintainer's mail
Date:   Fri,  9 Apr 2021 12:44:47 +0200
Message-Id: <20210409104448.12259-1-nsaenz@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The @kernel.org e-mail address is likely to last longer than the current
one, so use it.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d269763af39d..c8f32b7c1e06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3414,7 +3414,7 @@ F:	include/linux/dsa/brcm.h
 F:	include/linux/platform_data/b53.h
 
 BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
-M:	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
 L:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.31.1

