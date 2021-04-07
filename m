Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCFE356113
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348036AbhDGBxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347838AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F0AC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=i4NbI3unpGfKmh/q3AwoGzRSmZqSP94rN8RwRpY2aUw=;
 b=ogyMJqgSLmExCrvp3/r1Eg9S61h33kAnPRVDh2Te/XblEDKT6dg06kOiBaxK2gikeeF52
 N4XMq6tUs84jd0lAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=i4NbI3unpGfKmh/q3AwoGzRSmZqSP94rN8RwRpY2aUw=;
 b=jtbAFBUFlPRu6wvR0Ewud3YJqowLRXFk0qeM/CUxucqhxAT2GZCHQcPFJ4JSBbET3P/eB
 bQ95KETLzufZHm9mva1B1rEMc/8fxlllZeEp5NoY10XqNIH067D7NdQzPPj8G2tqSd61UoF
 dYw5UPH8/M2tbkXH8aoeX60sT2OuFImrT2/xmDo3h1dvqmCqXvARJg6ucmU79zLUwhqmrsp
 f1sT5VlqvUq71oCCVfooJ6kEpqH/FMxYTdpGIZtzdPShke2xpBOqTXZoWDkPSqhbykxMTuv
 GQrAg3VK7g8e2N4vMVzh03cWBHaLqpqJeUIDnUlY583azbD0peIQLRu1UGgQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 6E930160699;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 6021519F31F; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 36/37] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Date:   Tue,  6 Apr 2021 18:45:01 -0700
Message-Id: <20210407014502.24091-37-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT so that the speculative fault
handling code can be compiled on this architecture.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e4e1b6550115..6c2bbfe3fd38 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -208,6 +208,7 @@ config ARM64
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
-- 
2.20.1

