Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B05432A223
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836661AbhCBHTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:19:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:40710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835951AbhCBG31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:29:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614666521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYO9bsJ1goXImJD7GVmpOAqQ36iGo8WL5B82dt7tTe0=;
        b=dFUfE3eRrkftlmELV8DsKev13TLcNNwCkXdVljFVUtNWLU3D3ILLKISZzAHShOj/WdELxj
        ClNQgtbYPBxbdTlxLjaVaiYWBC7n0y8FK/0w+I+FarWAPHt/LAi3u451/tk9ZcGpcP8x79
        M8vnzpssbbKehgJlJro/T7P8V/bIWtk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE08CAF8F;
        Tue,  2 Mar 2021 06:28:41 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org, mhocko@suse.com, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 4/4] kernel/smp: fix flush_smp_call_function_queue() cpu offline detection
Date:   Tue,  2 Mar 2021 07:28:38 +0100
Message-Id: <20210302062838.14267-5-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210302062838.14267-1-jgross@suse.com>
References: <20210302062838.14267-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warnings for flushing a logically offline cpu's call_single_queue
are gated by a wrong if statement. It should trigger when there have
been new requests before dequeueing them, not afterwards.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 1a96691dbf7f..b3077c327b0a 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -581,7 +581,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 
 	/* There shouldn't be any pending callbacks on an offline CPU. */
 	if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_id()) &&
-		     !warned && !llist_empty(head))) {
+		     !warned && entry)) {
 		warned = true;
 		WARN(1, "IPI on offline CPU %d\n", smp_processor_id());
 
-- 
2.26.2

