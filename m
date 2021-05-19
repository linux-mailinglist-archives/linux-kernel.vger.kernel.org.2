Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F61B3891E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354804AbhESOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242696AbhESOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621435819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbWgytZuqM4UIpt46ERdKUKnppPb4ehKqu8JICqxcZw=;
        b=aokNfZ4IG/Ktj6G7vrTwM3Qqdxbqg2+PvMmEcNWGrU85+dGA9Lavw7bJTwGoRSk6RlvEKR
        yguVhKHuqH2jbMPofQDfad+v82oMHNv5vMvw00VabvvE1n8OTStNrNxh/CnXRsO3PHXRwh
        hS4AANn9zufGZZfdOISaZrCt+bngmQY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-gOFriRNSMT2C8hCCAdQVWQ-1; Wed, 19 May 2021 10:50:18 -0400
X-MC-Unique: gOFriRNSMT2C8hCCAdQVWQ-1
Received: by mail-wm1-f69.google.com with SMTP id y193-20020a1c32ca0000b029014cbf30c3f2so1613946wmy.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbWgytZuqM4UIpt46ERdKUKnppPb4ehKqu8JICqxcZw=;
        b=JZUGoOjkwVsv53g5w3JL0rmwX2AXHFPTOtFfFosR5GyQwD/sfauEd4vSIW2e7iZwLj
         bHZlbcK5xezqj1du28U2S/FprkHY8v9uXtN5CGtvmwSahWOFG3OpThR75DG9Ba8vS/fm
         668IBXpH3beddEFJzEqssSDUUCwBkyvRYJiV9dAXqiskMEfT5TF1rnjsLhVnYqEt1A/J
         3WcW3KWzLbvZBRrHxjvetWasQ7lxHRBQUMDqisb2U5i0v9iBoAlsTNLZ2Gafc9ugbAMt
         zQH9fBGUW/5/3X1hTXB8RrOlxtn83V8j/0r6fZ8nW93sT6o3bdQKICc40E3vclBwz10+
         uMAQ==
X-Gm-Message-State: AOAM533jORh5S47vqF3ZPbvdp3q/jg7qCyZAk4UqFo2anCBvfNCLbOUD
        /xHSk82AFgrVV8x9vktsSu/SMVLB2A7zWtUo2l3qzZZ+Q7VfcKi+KxT/HM/KE1srYEYUrhQ2eIL
        lcB/2xX/MfH9o65MuwkS+9u0=
X-Received: by 2002:a1c:2802:: with SMTP id o2mr11912061wmo.170.1621435816074;
        Wed, 19 May 2021 07:50:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzExqQtkXDb+lj+03vZaMs1NTWf1irqt+Pmv5JH54/F+aNXZlT2XWkOY11D/CbrLbTwJGBEkw==
X-Received: by 2002:a1c:2802:: with SMTP id o2mr11912037wmo.170.1621435815874;
        Wed, 19 May 2021 07:50:15 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id k11sm6021496wmj.1.2021.05.19.07.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:50:15 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: bail out on fatal signal during reclaim/compaction retry attempt
Date:   Wed, 19 May 2021 15:50:14 +0100
Message-Id: <20210519145014.3220164-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210519130609.r3ml6ohb2qsrfq2t@ava.usersys.com>
References: <20210519130609.r3ml6ohb2qsrfq2t@ava.usersys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not make sense to retry compaction when the last known compact
result was skipped and a fatal signal is pending.

In the context of try_to_compact_pages(), indeed COMPACT_SKIPPED can be
returned; albeit, not every zone, on the zone list, would be considered
in the case a fatal signal is found to be pending.
Yet, in should_compact_retry(), given the last known compaction result,
each zone, on the zone list, can be considered/or checked
(see compaction_zonelist_suitable()). For example, if a zone was found
to succeed, then reclaim/compaction would be tried again
(notwithstanding the above).

This patch ensures that compaction is not needlessly retried when the
last known compaction result was skipped and in the unlikely case a
fatal signal is found pending. So, OOM is at least attempted.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aaa1655cf682..5f9aac27a1b5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4268,6 +4268,8 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	 * to work with, so we retry only if it looks like reclaim can help.
 	 */
 	if (compaction_needs_reclaim(compact_result)) {
+		if (fatal_signal_pending(current))
+			goto out;
 		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
 		goto out;
 	}
-- 
2.26.3

