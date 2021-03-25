Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB18349AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 21:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhCYUJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 16:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:08:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Shyze7IYwmhdHuk7ciduosr01KilslJO6pqTFNfikQU=; b=ioLIImccLGwVIYrkNdnjxiaVcf
        ShZvZlyqF0RC+1EwtkpAaKvmZ3F/reGuOBnAF+eGpmRq84NTpac7IOd1PiSzatcp981MN0NBoCSNe
        rzH8Sbaqy0lQaOHHCCDR30u5gtFY85brlJ/UevK3T5pZrbzWjSoa/RCZgvpOVsR2gemv6G6MSgxs6
        weea96UMKae3zacfKBPPr/5EKDdkH9bq+NTBMD7hZOEp5uuKdR2igTQKMoHy6WOyvfU/Ndh7E7Q1e
        yooSWs+En8usHn07bxSFa97Av8CBl3K6iENrax5BV3TdkIfEuSsscpl3nj951frli0zlbhlMSwdt+
        KDs4uihw==;
Received: from [2601:1c0:6280:3f0::3ba4] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPWHH-0028a1-W4; Thu, 25 Mar 2021 20:08:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests: powerpc: unmark non-kernel-doc comments
Date:   Thu, 25 Mar 2021 13:08:20 -0700
Message-Id: <20210325200820.16594-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the 'beginning of kernel-doc' notation markers (/**)
in places that are not in kernel-doc format.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 tools/testing/selftests/powerpc/tm/tm-trap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210323.orig/tools/testing/selftests/powerpc/tm/tm-trap.c
+++ linux-next-20210323/tools/testing/selftests/powerpc/tm/tm-trap.c
@@ -66,7 +66,7 @@ void trap_signal_handler(int signo, sigi
 	/* Get thread endianness: extract bit LE from MSR */
 	thread_endianness = MSR_LE & ucp->uc_mcontext.gp_regs[PT_MSR];
 
-	/***
+	/*
 	 * Little-Endian Machine
 	 */
 
@@ -126,7 +126,7 @@ void trap_signal_handler(int signo, sigi
 		}
 	}
 
-	/***
+	/*
 	 * Big-Endian Machine
 	 */
 
