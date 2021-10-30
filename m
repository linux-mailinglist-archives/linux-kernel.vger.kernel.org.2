Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69C2440668
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 02:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhJ3AeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 20:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhJ3AeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 20:34:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92FEC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 17:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mbXNlvfS0AX4H+AHxBGwwr5mqxXb3TapwHfNsCbXVms=; b=EHH1YIwmcgByb1TjZhvQi4Cpju
        F3ekBlDlJhH86G0wb950ecL3/I/sMjOhTT7oSt8/R/YTjHDj6NL+EjOA+V11y0rjZ48cX5O8UUeHQ
        5shBV1z1/Z3elHg423Fl3a6E9kyF6Qkn3OqAgvayaFjHkkRDICQhAUJajyRYNEybR0dxT5rPlvAff
        K9ujGRdFW6gh4t8WtuJKzEbhZIoMlx3AadV5Jdw3tLjeGyjJ2CdbaOGBmX3/io2KYPyCjwBf0cUR9
        bmr8tX0Bjxa1hLUBy0KKZPO5rvLvmeeDXU51ocP1oQVkdM62hgUl1w9D0dV8JAH2xnQMrtSyc7Q86
        TZ6nicXg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgcHX-00Ca0f-4y; Sat, 30 Oct 2021 00:31:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH] ARC: thread_info.h: correct two typos in a comment
Date:   Fri, 29 Oct 2021 17:31:34 -0700
Message-Id: <20211030003134.20553-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos of "separately" and "remains".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Matthew Wilcox <willy@infradead.org> # "remains"
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/include/asm/thread_info.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20211029.orig/arch/arc/include/asm/thread_info.h
+++ linux-next-20211029/arch/arc/include/asm/thread_info.h
@@ -99,8 +99,8 @@ static inline __attribute_const__ struct
 
 /*
  * _TIF_ALLWORK_MASK includes SYSCALL_TRACE, but we don't need it.
- * SYSCALL_TRACE is anyway seperately/unconditionally tested right after a
- * syscall, so all that reamins to be tested is _TIF_WORK_MASK
+ * SYSCALL_TRACE is anyway separately/unconditionally tested right after a
+ * syscall, so all that remains to be tested is _TIF_WORK_MASK
  */
 
 #endif /* _ASM_THREAD_INFO_H */
