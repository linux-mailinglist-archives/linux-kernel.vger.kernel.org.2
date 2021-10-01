Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC56F41E5F5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 04:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351553AbhJACMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 22:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhJACMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 22:12:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FB0C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 19:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pScaUIvcwJXSXP+4eICISXmiRzcJ7264OZZlpmskJYA=; b=WMCOhfJ8YarzX5qjFxh6iTqDle
        KLBZyVhQkLiBBNymQJfBUU/EiOOmXqEI15f676A3QriflZMmKZKZXKgKZCVT5nMIFCApp7lq2dGdL
        4FHJLnsHhSwwkf6eN3XzqCUYsWGNnyB5GI6uLKmPshnwoTDuPj7SpwGxtU/K/9EtG+R8Bxl0zDoQj
        Ph+O2LhoRA1wMyDmnn0/uM6LLFUNbAYRELzc0762EOj7/q0s/MdMOu2GzHigjvkEMWrgKcHvmbMAO
        5vat1OlqGi4lCswWjQy8KpfDmXuawWAWMW1V44MRmtXp0+voVqEmzOM+R9DdRAaxKnoABoLKFnpGL
        +T7wzXyg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mW80s-00GRVJ-56; Fri, 01 Oct 2021 02:11:02 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: time: don't mark comment as kernel-doc
Date:   Thu, 30 Sep 2021 19:11:01 -0700
Message-Id: <20211001021101.18225-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a kernel-doc warning by unmarking the comment as being in
kernel-doc notation.

Fixes this warning:
arch/openrisc/kernel/time.c:137: warning: expecting prototype for Clocksource(). Prototype was for openrisc_timer_read() instead

Fixes: b731fbbd246e ("OpenRISC: Timekeeping")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
---
 arch/openrisc/kernel/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210930.orig/arch/openrisc/kernel/time.c
+++ linux-next-20210930/arch/openrisc/kernel/time.c
@@ -127,7 +127,7 @@ irqreturn_t __irq_entry timer_interrupt(
 	return IRQ_HANDLED;
 }
 
-/**
+/*
  * Clocksource: Based on OpenRISC timer/counter
  *
  * This sets up the OpenRISC Tick Timer as a clock source.  The tick timer
