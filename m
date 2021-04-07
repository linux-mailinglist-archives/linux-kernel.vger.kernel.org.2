Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91083560F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347867AbhDGBvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:51:55 -0400
Received: from server.lespinasse.org ([63.205.204.226]:54091 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343600AbhDGBvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:48 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=9K/3R1jhcIp0kkAhPFf8lQIqNdjGzS/Dm2et+ThCVUU=;
 b=HZg/9fcGH82GArMwzKRhgd90k9JTjmE0UcCqxUku3rDl/DNQoea5vEv+M1GVlvq2t5dFM
 o2dx1RgPy8IXCEPBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=9K/3R1jhcIp0kkAhPFf8lQIqNdjGzS/Dm2et+ThCVUU=;
 b=alyEbiamP4Wh9jF+Cx2z90l+ZloP7zp+sCdFqGMTrBl+ngldVXVxZFPfgoVFLtRW+aOvr
 w6NEEz/icCe8JtewfJfXSqdFKXwsuLj8L4yIU57lYCc0csIkmQXnIbNRH+P4/8dtGGhXJej
 ajivCfQ7cuXMtobqJclVzCilRXtrRCGS74qXlHBbu4Wa1RBeKgaSEI9lACDFGUNHyepK3j1
 9Y82GPymzoZOKcFghOl4lzJvjkX5TsBoqSFpjOnPEcu9ciMWyzuzpXJeIL4iVk6NNR4KoyL
 zUrtAX7SGcN3sJaa4P1JJSwXkv6gN5VzeapLU0UDYhiiEmf30KHXCCp5NiQA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 8BF7D160244;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 7E43919F31F; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
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
Subject: [RFC PATCH 06/37] x86/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Date:   Tue,  6 Apr 2021 18:44:31 -0700
Message-Id: <20210407014502.24091-7-michel@lespinasse.org>
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
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..a93e4ed7040e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -33,6 +33,7 @@ config X86_64
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
 	select ARCH_HAS_ELFCORE_COMPAT
+	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
-- 
2.20.1

