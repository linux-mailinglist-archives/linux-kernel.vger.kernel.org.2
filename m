Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5403937B417
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhELCMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhELCMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:12:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 850EB61584;
        Wed, 12 May 2021 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620785465;
        bh=ADNAuVNL7VKzMtCTra0eiRMMYNwmQU7DmXsqtOvziK0=;
        h=From:To:Cc:Subject:Date:From;
        b=p8fiUlmUi12wMP26kNzLLQBYacskOFXCwRsGKwulVbyErQUqk9WUaIgG1LFxYXAKO
         RI1tSy3m/yY5KYm8z87vU3xe8RA0DU3Qk8/Eew0rhbAX1mXURumCh+HkIX8RGvmWTX
         ZuOWsZt9bbdg59JElfK/4CDwcA58qXd/STpmLBDUZ/ogLZN3KycO55QPspeCzfydSq
         KgJTf3O6tJSzXLJaOx9aiCIIMCLwq5k1sxE007Ch0WnTa8mupIr9ouBQgkoOcYkziS
         LJE/WUEl1YWcl9gNbI2F+uDEvXr5W+wvM/nJ2DV+7y5ds8QQAJxuu5f4BJKkMhUgkA
         dAxhT0rwT/TwQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, ley.foon.tan@intel.com
Subject: [PATCH] MAINTAINERS: remove Ley Foon for NIOS2
Date:   Tue, 11 May 2021 21:10:55 -0500
Message-Id: <20210512021055.2195467-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ley Foon is transferring her NIOS2 maintainership to me because she
is moving on to do different work.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..83aef3e767c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12960,9 +12960,9 @@ F:	Documentation/scsi/NinjaSCSI.rst
 F:	drivers/scsi/nsp32*
 
 NIOS2 ARCHITECTURE
-M:	Ley Foon Tan <ley.foon.tan@intel.com>
+M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
 F:	arch/nios2/
 
 NITRO ENCLAVES (NE)
-- 
2.25.1

