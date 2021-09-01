Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFE63FD44B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242551AbhIAHOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbhIAHOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:14:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD07C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=A92WeF+kj3phhIB/9I/v0gWemxSspb1vvpSTLDBhecw=; b=ohwIT00KIygWGe4ZXM1/96S8c6
        bIIeP/EufoYmeKybPLzB/0n5tzdbXJWSM8lzAEBrfIatzjqlHhqvOTsmPPUzkwSZhUlDr6pug5bgB
        VbvolTFQEsGApIUkS1XyZVqq7fV7k+B8FUhtML651m3tL8qftwwdUnelghyo/RV1f+fHMZA3HjBM0
        6SnSkdsZKlWiyG+2aP+Lm+jkec1erAd3Vf50qrA0OLvfKkITJ6KJvUbG+QWfPDgwu+l3DoT/5TGhf
        qXwP0ZkLjb5JMjfqBFobJOaOHDv57IbwN4+f3ukFgLJ/Hf6uWkKtB8Bu0ONld6/ac3cEsxypD6nAf
        Q/aHVTjA==;
Received: from [2001:4bb8:180:a30:2deb:705a:5588:bf7d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLKQF-001ypG-5o; Wed, 01 Sep 2021 07:12:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     torvalds@linux-foundation.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86: make setup.c build again
Date:   Wed,  1 Sep 2021 09:12:32 +0200
Message-Id: <20210901071232.1258388-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a <linux/acpi.h> include to setup.c to ensure it compiles without
any config-dependent implicit includes of that header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 63b20536c8d23..6edec9a28293e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -22,6 +22,7 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
+#include <linux/acpi.h>
 
 #include <uapi/linux/mount.h>
 
-- 
2.30.2

