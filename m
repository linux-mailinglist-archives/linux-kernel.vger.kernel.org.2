Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8552A370194
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhD3Tyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:43 -0400
Received: from server.lespinasse.org ([63.205.204.226]:37105 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhD3Txh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:37 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=yz4li7EYAF4Bbcpj+eNLJ7tuvrtZJHEzYg77XHgRWJ4=;
 b=MKdiv+PQUj9ZqU64bNBi4AWTpDktH7ZMN/8ag8ekw2nIACtjMx6TefVYVA+TS1fIW+PIz
 6N3e3/lGMrma3NeDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=yz4li7EYAF4Bbcpj+eNLJ7tuvrtZJHEzYg77XHgRWJ4=;
 b=G+BJB9MUJJ2/tltjsww/hWrhr9xEhno6hVjbw7OujVBEqr4i7u3YSYzYmxyXr7vGud1Cv
 sUzd7k2sHIyAATrkfMtxynWWAvZpNLDteDaJswKJUviJlczPJDnMOe4uVHWIi0V61iZ10rH
 HsSqiPW9xLPe3FWeh45L5uLWIkUDdR3QIdiI5UtGy5SSrCo4DPzhzxi+ilWQKRRs9HVPCoL
 PJONhmb75V6wEbXYN8W52RbHJKl08b7L8QLitjDnqSIZrN6Zvlt7Wkk1q64LvhiST6dM/ay
 OI9SNyE9qf30/mXzg/jhjYrpriQBCOnxTAXitEqZ4jAo8CXs4MJ1hOX3a9lA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id C4688160367;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id B6D3B19F523; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 28/29] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Date:   Fri, 30 Apr 2021 12:52:29 -0700
Message-Id: <20210430195232.30491-29-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
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
index dfdc3e0af5e1..a344f2d5f146 100644
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

