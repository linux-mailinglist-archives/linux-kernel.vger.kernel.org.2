Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940473B5665
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 02:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhF1AnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 20:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhF1AnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 20:43:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE73C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 17:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0CRh94sDskcrsrbGFlTvADWfh4XXtEAT9Y9zJdvidZM=; b=2nBPIF2dtrEOx1H3JjbaMLy9X6
        gCKNgVyB7jJky2lh3jYP2A3WxF55oQfcV7J74XpwnwAJ8NaUz+68IYcDbqgV78/Hhn3tdTJJBB2QW
        xWqX4h4mmlQzaNNtvAp6YPdOadF8frQwsxUvT+oysr+zCvo7lWP9wKiNzru/DtzrGWeCbOs5VMK3T
        mX3efTkPVEuEUkCFGmqHZdczRSoL/wsasyWBZRGRaNZ6p1qBn+248RMqwspp6LlJgrIjHGIGa7ii8
        QjtJKd5YkS79+uhx8Vqh3VqcwvMo7sD2kEK7e1X9EEaIVt7BFL9TWFFkF7daUAtyYyoqR3/C9Mb/e
        6kN7S+EQ==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxfKP-006Ma1-8C; Mon, 28 Jun 2021 00:40:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>
Subject: [PATCH -next] IRQ: irqdesc.c: drop excess kernel-doc entry @lookup
Date:   Sun, 27 Jun 2021 17:40:44 -0700
Message-Id: <20210628004044.9011-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warning in irqdesc.c:

../kernel/irq/irqdesc.c:692: warning: Excess function parameter 'lookup' description in 'handle_domain_irq'

Fixes: e1c054918c6c ("genirq: Move non-irqdomain handle_domain_irq() handling into ARM's handle_IRQ()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/irqdesc.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20210625.orig/kernel/irq/irqdesc.c
+++ linux-next-20210625/kernel/irq/irqdesc.c
@@ -682,7 +682,6 @@ EXPORT_SYMBOL_GPL(generic_handle_domain_
  *                     usually for a root interrupt controller
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
- * @lookup:	Whether to perform the domain lookup or not
  * @regs:	Register file coming from the low-level handling code
  *
  * Returns:	0 on success, or -EINVAL if conversion has failed
