Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E26F370185
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhD3Txs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:48 -0400
Received: from server.lespinasse.org ([63.205.204.226]:44459 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhD3TxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:23 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=9K/3R1jhcIp0kkAhPFf8lQIqNdjGzS/Dm2et+ThCVUU=;
 b=t9iVfFmnuULsrM9oO60Hza/+gie/Dmpqd4k2nIs6SwThp5++nNppPCoAFZbqrB3NfW9JY
 dfvfPJa4Uo5WFApAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=9K/3R1jhcIp0kkAhPFf8lQIqNdjGzS/Dm2et+ThCVUU=;
 b=uEw7dwjyMOux+wwSljJXnIIqA/dK09jeoMJkyTCBCKK5n/WQFc2Jh1sBuHb7wdGSlG+vA
 szGj7oU2M48eP7P4pRSbOyMeEYx4k3EqrWwtUBkB1aW/51TMwsThVt5E3GH232n+7KvpnLu
 tLLAk7PW2CmZIXaRUyEgVLyjFQEmpyMQ0qQwayxn7wQTIvagBEQkLbYehTiXIWsm2UMNCQ+
 e/RvX5+VotMZSpZWu7qd3QFEvGdFf8211H/4/EPu31iLqZ0UOtMlw0Ys0+BBakQNxvith3F
 GJJ8mE6+rBT78syxuJYCgCDidAoII+PzyuxW66nEDKW+9RUoK1PaljZpGcTw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 39D0D160311;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 2811719F522; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 07/29] x86/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Date:   Fri, 30 Apr 2021 12:52:08 -0700
Message-Id: <20210430195232.30491-8-michel@lespinasse.org>
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

