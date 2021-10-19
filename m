Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E627432BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 04:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJSCYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 22:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSCY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 22:24:29 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F228C06161C;
        Mon, 18 Oct 2021 19:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=K9yjFTzm8R78+gWBuyz5a22sfs031rU2l2UkfbxmOEQ=; b=BXFVSA4swTMiT4pPkVesKyI4bz
        OF8Jz/FOsPev/L4bWQTXQibC2V3hDHpKFjZcM1fDFzr8Cv58i+xwWXC9XIgYzaYwgcf6ydexcciIE
        pvEzaQs/OOJocn7EU7xRmvcXz8ESL0hc51yWArUHkF94xtlcCbYZONojerGmtnws+Eki+i8W33zt3
        2bG+QuzGB1YLqO2hjrOClqzBy9MXaTq7FwFpkhv5d0XwwOlmS4SrHN62amDRrbEE1jVlqdnnG6Uqc
        Bw7655+E3u/PXgs7oz/eGh2+wCQyY/IA8isamZR+Bdlzev1+vYNGYEzW27l3aYAYFtiKgJdgCc4SV
        n9B4fQSw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcelZ-00Ha8K-VE; Tue, 19 Oct 2021 02:22:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH -next] Documentation: futex: handle source file rename
Date:   Mon, 18 Oct 2021 19:22:12 -0700
Message-Id: <20211019022212.6914-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the move/rename of kernel/futex.c to kernel/futex/core.c.

Prevents docs build errors and warnings:

Error: Cannot open file ../kernel/futex.c
Error: Cannot open file ../kernel/futex.c
Error: Cannot open file ../kernel/futex.c
Error: Cannot open file ../kernel/futex.c
WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -sphinx-version 1.8.5 -internal ../kernel/futex.c' failed with return code 2
WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -sphinx-version 1.8.5 -internal ../kernel/futex.c' failed with return code 2

Fixes: 77e52ae35463 ("futex: Move to kernel/futex/")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: André Almeida <andrealmeid@collabora.com>
Cc: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/kernel-hacking/locking.rst                    |    2 +-
 Documentation/translations/it_IT/kernel-hacking/locking.rst |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20211018.orig/Documentation/kernel-hacking/locking.rst
+++ linux-next-20211018/Documentation/kernel-hacking/locking.rst
@@ -1352,7 +1352,7 @@ Mutex API reference
 Futex API reference
 ===================
 
-.. kernel-doc:: kernel/futex.c
+.. kernel-doc:: kernel/futex/core.c
    :internal:
 
 Further reading
--- linux-next-20211018.orig/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ linux-next-20211018/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1396,7 +1396,7 @@ Riferimento per l'API dei Mutex
 Riferimento per l'API dei Futex
 ===============================
 
-.. kernel-doc:: kernel/futex.c
+.. kernel-doc:: kernel/futex/core.c
    :internal:
 
 Approfondimenti
