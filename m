Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38D400DDE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 05:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhIEDhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 23:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhIEDhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 23:37:51 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838BDC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 20:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CUk4iNYAbYWekShqhuG5j1pDz8bdESz91f03JcDCzPo=; b=jqjE2DCihJDpaXoyLVi+7h6vWk
        YSdj+HMdqiufx/soAKX9X/WERvuveKRbsjAgqUzmSPNoMxk2i16XyDwnkXwtSDkBGRFrDY9nGb5h5
        quQx/J6R5W98y6hJXTmdt3k0ewtsMj8/sdEvp3PjRr2MEvF0IJg4qn5xWreAGeuN3wJm59XDLga7P
        gHk8+9uRo7U7jCTTJMKyXn0n602Q76vVqNVEB2p6GXUhsIBok9N+9f8dRwLcAXGbuCVEPkJZmacnL
        PX+zzb+gdEqem9J5OlrZ4e4MpfgjiuXzy3mfAOhylHgYSVijs7wVK7I6RFLDjLG0/Wnf7Bkp7WPVh
        Ig6DaEVA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMixZ-00F9UM-LI; Sun, 05 Sep 2021 03:36:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Jun Ma <majun258@huawei.com>, Yun Wu <wuyun.wu@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
Subject: [PATCH] irqchip: repair non-kernel-doc notation in irq-mbigen.c
Date:   Sat,  4 Sep 2021 20:36:44 -0700
Message-Id: <20210905033644.15988-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings in irq-mbigen.c:

irq-mbigen.c:29: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * In mbigen vector register
irq-mbigen.c:43: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * offset of clear register in mbigen node
irq-mbigen.c:50: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * offset of interrupt type register

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Jun Ma <majun258@huawei.com>
Cc: Yun Wu <wuyun.wu@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Aditya Srivastava <yashsri421@gmail.com>
---
 drivers/irqchip/irq-mbigen.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20210903.orig/drivers/irqchip/irq-mbigen.c
+++ linux-next-20210903/drivers/irqchip/irq-mbigen.c
@@ -25,7 +25,7 @@
 /* The maximum IRQ pin number of mbigen chip(start from 0) */
 #define MAXIMUM_IRQ_PIN_NUM		1407
 
-/**
+/*
  * In mbigen vector register
  * bit[21:12]:	event id value
  * bit[11:0]:	device id
@@ -39,14 +39,14 @@
 /* offset of vector register in mbigen node */
 #define REG_MBIGEN_VEC_OFFSET		0x200
 
-/**
+/*
  * offset of clear register in mbigen node
  * This register is used to clear the status
  * of interrupt
  */
 #define REG_MBIGEN_CLEAR_OFFSET		0xa000
 
-/**
+/*
  * offset of interrupt type register
  * This register is used to configure interrupt
  * trigger type
