Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2068730505E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbhA0EDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhA0DCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:02:41 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEBFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xhV0Benv3VefaUhXEHmyjX8yxKTDsckJSRvSN4FMtn8=; b=qfVqQguoZatadvfLN9z+4ndh1g
        eG5uHeg6i0B4k7QODg7LrmnGu6S63RoNFn8Vk4TP2qsnM605RAcCmeNQYW+yqk1cBWxBymMpeS3nU
        WU+7U7Z2vIJIJeA0z+3kCeunjPnOBnIt33BIVAObDSJC2yI2ScRVHcAIjDfSePeLFDuN31XovPFiG
        2E0iMz5Uv6SQ0IyzN4kyVBsdmvs+mqmZkFoJ4319+QpHWY6K7D9Pgs6yHrT2UOoT20UOFbRX0LaPj
        ca783HQBkY5PV11Js3gmz+nO9FQnsFTI09CwwdPlnGkWrIz9kodcNejZAMx+JBUpnqKCou4azibT1
        ri87X+PA==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4aS3-0002P2-7s; Wed, 27 Jan 2021 02:20:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND] arm: unwind.h: fix duplicated word
Date:   Tue, 26 Jan 2021 18:20:53 -0800
Message-Id: <20210127022053.25517-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the repeated words "the" to "to the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/unwind.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/arm/include/asm/unwind.h
+++ linux-next-20200720/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according to the ARM EABI documents */
 enum unwind_reason_code {
 	URC_OK = 0,			/* operation completed successfully */
 	URC_CONTINUE_UNWIND = 8,
