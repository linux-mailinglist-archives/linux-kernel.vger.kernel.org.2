Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB0420481
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 02:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJDASe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 20:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhJDASe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 20:18:34 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A5C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 17:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/Nb4MRKaxM4+91oHH7Ktejb5oApeSbdWV88H/UQxSZo=; b=S2RlYKuQD0JvhCC1wzCdKfkPLL
        TtHGi3RXuWm3TjRzVT2lEUR+uc5Ubt28+oN2pNJ7el8tanWuyKpglsC/A0i7ROhl+pO6iT5Q9YtYd
        6fe3LO8LQyDXRM+OftC7Dz4/iSp90w9vajEyix821F8AOmQ7xmhWP/dEcGZmSwllCb2nU5rdX3+sS
        IHL01kDyzyMhBiEsBClvh+hFxENP30lpCSQgIx1CnM4Wu5UtVkY7vJzC4RNQF7nqhFJSX3T8bNBiD
        PIqJXrVKQ7sUfA7yZX5qatKGJWbUEJCrEi453YCAxszRuD3dXwbozKQDMexil9r6O3QNWMbMTeKaC
        J3cX6PzQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXBeu-004kkd-ID; Mon, 04 Oct 2021 00:16:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] misc: HI6421V600_IRQ should depend on HAS_IOMEM
Date:   Sun,  3 Oct 2021 17:16:41 -0700
Message-Id: <20211004001641.23180-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD_CORE depends on HAS_IOMEM so anything that selects MFD_CORE should
also depend on HAS_IOMEM since 'select' does not check any dependencies
of the symbol that is being selected.

Prevents this kconfig warning:

WARNING: unmet direct dependencies detected for MFD_CORE
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [m]:
  - HI6421V600_IRQ [=m] && OF [=y] && SPMI [=m]

Fixes: bb3b6552a5b0 ("staging: hikey9xx: split hi6421v600 irq into a separate driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20211001.orig/drivers/misc/Kconfig
+++ linux-next-20211001/drivers/misc/Kconfig
@@ -224,6 +224,7 @@ config HI6421V600_IRQ
 	tristate "HiSilicon Hi6421v600 IRQ and powerkey"
 	depends on OF
 	depends on SPMI
+	depends on HAS_IOMEM
 	select MFD_CORE
 	select REGMAP_SPMI
 	help
