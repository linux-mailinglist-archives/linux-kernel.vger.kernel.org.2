Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FEA3DC1C3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhGaABF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhGaABE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:01:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330F9C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BKlTn4JcrbDRik5XvEGMTuqk/oTwwmSPzlHfGJ7WBwA=; b=enoakZ9CQ46zB6lUa/P82sGBGp
        GevOLBPlwx4CgtRnKipPtImArr9wEtZN2S5+vLIaF13QFR/shMTr2Iv9MO+t4bwrvIfizxNNyMtFq
        VtwsUt2lPVS8ZhVoOkRpapfUmwSyXk1nBf59h8QG0Qrye4kstJI2N35RQJcBIt0tU9rGSN8ig72DP
        WvUrMIKTEiiBW3oM/uvvS7eQBN1CeELolkvJ1a6d2gF70WlIzRN0Y6FLWU8N76AV/olbG85VCtHwZ
        03ZGo9RNL8mZiUfeOmibiMs0ne/u4k+g+3IFpDiI8zJGIFRryi+gMKSv7V8voVCSjAMRC6EAEiFw9
        DLnG5EIw==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9cQy-00AZUF-8D; Sat, 31 Jul 2021 00:00:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] trace: eradicate noisy warning in trace_osnoise.c
Date:   Fri, 30 Jul 2021 17:00:55 -0700
Message-Id: <20210731000055.28876-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'm officially tired of this noise warning coming from
trace_osnoise.c, so shut it up. Also, adding new warnings is not OK.

../kernel/trace/trace_osnoise.c: In function ‘start_kthread’:
../kernel/trace/trace_osnoise.c:1461:8: warning: ‘main’ is usually a function [-Wmain]
  void *main = osnoise_main;
        ^~~~

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- mmotm-2021-0728-1824.orig/kernel/trace/Makefile
+++ mmotm-2021-0728-1824/kernel/trace/Makefile
@@ -36,6 +36,8 @@ CFLAGS_bpf_trace.o := -I$(src)
 CFLAGS_trace_benchmark.o := -I$(src)
 CFLAGS_trace_events_filter.o := -I$(src)
 
+CFLAGS_trace_osnoise.o := -Wno-main
+
 obj-$(CONFIG_TRACE_CLOCK) += trace_clock.o
 
 obj-$(CONFIG_FUNCTION_TRACER) += libftrace.o
