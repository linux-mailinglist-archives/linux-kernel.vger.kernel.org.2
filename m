Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74D13ECBD7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 02:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhHPAGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 20:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhHPAGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 20:06:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20021C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 17:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=a8K5CgAJ2LfbgMYLfjwU503fankQk3XILQ3kz7Kelbk=; b=l0kmqwJAyqs0ysAKTFt+K5+zOG
        0EvwENiddnauSYMaswxyeqbvkB7Mx/SeupbO6ZEx7le0W01ZVT5ecqzwPQWNoD7h6LvrqtLf7Gksm
        CVaCvwMOGFozbIPkeCDVl35sByf7jKCEJW/0lXR4O1xLRcw9GyOAfKo2I2zb+DhpuA4njJx4kONwG
        eLTFkFpA863JWIIOziJ3e5TXDD2bz4VWX21BFVpIDANCO0NLH08niyP6BMU/2XLKAOUFE5jRkgWRp
        lmpLu+lvglLY12D7WzixyybcXwAIdZqn+3m7rEKbPB9LVuIzX696lAURxyetKJeQ2Kna/0XIqracy
        9UK+LaGQ==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFQ8C-00Fkz1-Gw; Mon, 16 Aug 2021 00:05:32 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] char: move RANDOM_TRUST_CPU & RANDOM_TRUST_BOOTLOADER into the Character devices menu
Date:   Sun, 15 Aug 2021 17:05:31 -0700
Message-Id: <20210816000531.17934-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include RANDOM_TRUST_CPU and RANDOM_TRUST_BOOTLOADER inside the
"Character devices" menu so that they are listed (presented)
with other Character devices.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Theodore Ts'o <tytso@mit.edu>
---
 drivers/char/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210813.orig/drivers/char/Kconfig
+++ linux-next-20210813/drivers/char/Kconfig
@@ -427,8 +427,6 @@ config ADI
 	  and SSM (Silicon Secured Memory).  Intended consumers of this
 	  driver include crash and makedumpfile.
 
-endmenu
-
 config RANDOM_TRUST_CPU
 	bool "Trust the CPU manufacturer to initialize Linux's CRNG"
 	depends on ARCH_RANDOM
@@ -452,3 +450,5 @@ config RANDOM_TRUST_BOOTLOADER
 	booloader is trustworthy so it will be added to the kernel's entropy
 	pool. Otherwise, say N here so it will be regarded as device input that
 	only mixes the entropy pool.
+
+endmenu
