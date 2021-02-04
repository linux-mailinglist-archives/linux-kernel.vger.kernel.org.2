Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C3B3101EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhBEA6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:58:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44080 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhBEA6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:58:32 -0500
Message-Id: <20210204211154.091926005@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612486670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QALo4+SIOHUN9Dy5Ngn2WJT0CCykooKHvfheoC+bZ/M=;
        b=01StAidAq7/9wX5/ASG1jwfizBiuf79jVX41BHkuT/eaYMaxHo388DQODAXrA2DAt5WeD6
        hRuwFCy+fetJjSyOzBqQqba44SFgNzgSAc3nMUucty3MxX1s2yUSAVAWVjZ8KOPQt/KHiv
        MEx7GsWkf4V0JUdaDqnmDd+Xjco9b7gam8HdrQLXobPAC9sV4mo0tNpaj876Mxo5yMRH3y
        TDkBy2Wygc6elgM4WjYGW/+NhXCxlQJPL6Bk+LO54lOi9bEZbPrdZ/hUekqRyM+OeSPqKO
        eqSBNIRX8l9eK0lLCIuzR38nI5Iae28WMQ+tbBffGeFH2xM+zSChE1oQHwW/iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612486670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QALo4+SIOHUN9Dy5Ngn2WJT0CCykooKHvfheoC+bZ/M=;
        b=8879B+GuIJ05pgkkiAyZCfNlJmFgGFxzKQORF46zW7fqhrZIWvdQVIqmBy1NexhKWGJgXU
        4Dc+shJDwxjPbOCg==
Date:   Thu, 04 Feb 2021 21:49:04 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 01/12] x86/entry: Fix instrumentation annotation
References: <20210204204903.350275743@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embracing a callout into instrumentation_begin() / instrumentation_begin()
does not really make sense. Make the latter instrumentation_end().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -270,7 +270,7 @@ static void __xen_pv_evtchn_do_upcall(vo
 
 	instrumentation_begin();
 	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
-	instrumentation_begin();
+	instrumentation_end();
 
 	set_irq_regs(old_regs);
 

