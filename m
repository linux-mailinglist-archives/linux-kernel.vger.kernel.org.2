Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0066A3CCC4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 04:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhGSCgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 22:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhGSCgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 22:36:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B37CC061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 19:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/UZVBmXnYvP61myU7O8bG2pwsIQUzRdPvRFJy2H3QRY=; b=C4SxYaZ5TGPB3vNYI4QCR4R1uD
        J1UkLV1EZZjUpTBOr49GL2n+lOtNgCGw8nrHQ2eaKXDHkBZbH84LfpWuVH+NFKbmnhhJoCTv9vr7c
        1h1MeTgorsIjjQLqmTFAC+ZPsmp39HAB2ttDrC0cmvNQrpbjmYF6qnamu9W5QMxRmJRMz4fj2jUi8
        TsoCv9YmP73/q2MZQo5JeQLcouHLTZL9uUwkN09KDhVzvRWEaiSa5fAq9M7fP3/JIyvMaP5RHPZky
        OUisuQCruee7m/7viSFd5vKUzclXMscG5oe9SV09yuLy/puTn1hoo1cB4KCcI5N6vi3RXAvtBCz4T
        pzt74b7g==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5J5i-008HZp-IX; Mon, 19 Jul 2021 02:33:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: don't printk() unconditionally
Date:   Sun, 18 Jul 2021 19:33:09 -0700
Message-Id: <20210719023309.15808-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't call printk() when CONFIG_PRINTK is not set.
Fixes the following build errors:

or1k-linux-ld: arch/openrisc/kernel/entry.o: in function `_external_irq_handler':
(.text+0x804): undefined reference to `printk'
(.text+0x804): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `printk'

Fixes: 9d02a4283e9c ("OpenRISC: Boot code")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
---
 arch/openrisc/kernel/entry.S |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20210716.orig/arch/openrisc/kernel/entry.S
+++ linux-next-20210716/arch/openrisc/kernel/entry.S
@@ -547,6 +547,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
 	l.bnf	1f			// ext irq enabled, all ok.
 	l.nop
 
+#ifdef CONFIG_PRINTK
 	l.addi  r1,r1,-0x8
 	l.movhi r3,hi(42f)
 	l.ori	r3,r3,lo(42f)
@@ -560,6 +561,7 @@ EXCEPTION_ENTRY(_external_irq_handler)
 		.string "\n\rESR interrupt bug: in _external_irq_handler (ESR %x)\n\r"
 		.align 4
 	.previous
+#endif
 
 	l.ori	r4,r4,SPR_SR_IEE	// fix the bug
 //	l.sw	PT_SR(r1),r4
