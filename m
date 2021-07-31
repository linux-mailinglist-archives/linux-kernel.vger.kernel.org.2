Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD7F3DC370
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 07:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhGaFIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 01:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhGaFIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 01:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627708082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sYG3V3DPg8PK/IfxvLRyIyhXL5HL9rIqRV/leg8w0Mg=;
        b=PsVz3O9vP/As3IaWVFV9L41/X0GhtxuTYqVgwirRgggxrNZ4bBgBDV58aB69+syGQx6HQn
        Un2zsVoZj4RChi5jV7en4ocAp4vFpoGoy84eTV1pvlBePfg/8c3+i0BcRre1WIh1xbQiYf
        ltuK7mf2Ir566mhyeT5EbJVlOJ0C6DI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-eerNwOuzOuKzOSKdIxkpGA-1; Sat, 31 Jul 2021 01:08:01 -0400
X-MC-Unique: eerNwOuzOuKzOSKdIxkpGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8DFE10066E5;
        Sat, 31 Jul 2021 05:07:59 +0000 (UTC)
Received: from jsavitz.bos.com (unknown [10.22.9.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 213A3781E7;
        Sat, 31 Jul 2021 05:07:59 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, trivial@kernel.org
Subject: [PATCH] kernel/irq: Clarify documentation for request_threaded_irq()
Date:   Sat, 31 Jul 2021 01:07:40 -0400
Message-Id: <20210731050740.444454-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify wording and document commonly used IRQF_ONESHOT flag.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 kernel/irq/manage.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ef30b4762947..766468a2fc5a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2072,9 +2072,9 @@ const void *free_nmi(unsigned int irq, void *dev_id)
  *	request_threaded_irq - allocate an interrupt line
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs.
- *		  Primary handler for threaded interrupts
- *		  If NULL and thread_fn != NULL the default
- *		  primary handler is installed
+ *		  Primary handler for threaded interrupts.
+ *		  If handler is NULL and thread_fn != NULL
+ *		  the default primary handler is installed.
  *	@thread_fn: Function called from the irq handler thread
  *		    If NULL, no irq thread is created
  *	@irqflags: Interrupt type flags
@@ -2108,6 +2108,8 @@ const void *free_nmi(unsigned int irq, void *dev_id)
  *
  *	IRQF_SHARED		Interrupt is shared
  *	IRQF_TRIGGER_*		Specify active edge(s) or level
+ *	IRQF_ONESHOT		Do not unmask interrupt line until
+ *				thread_fn returns
  *
  */
 int request_threaded_irq(unsigned int irq, irq_handler_t handler,
-- 
2.27.0

