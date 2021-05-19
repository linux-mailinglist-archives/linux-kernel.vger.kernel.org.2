Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB853897B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhESUTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232038AbhESUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621455469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVWmqrHmN8k1tD/caQDTal6fqjCBCOWgYK0fgUgjsDY=;
        b=eN0SR921tosV+sQbENTFEW4rPtBznTd03V/yCzXKSQu4uJHetf1vwPHDYDbQGpE4/f2+s/
        EqY9XwImfmhMhp36vqnsnq1Sv8JNMPCk3AvzSa2e973XlDHT2v721Q5aFFyDMBqheO69+H
        sLpbmPNAQh+AEiiTYa1Sz+ETIOOkCio=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-UZj9Xp51Na-nqOfFUg7axA-1; Wed, 19 May 2021 16:17:46 -0400
X-MC-Unique: UZj9Xp51Na-nqOfFUg7axA-1
Received: by mail-wm1-f71.google.com with SMTP id 12-20020a1c010c0000b0290176491efde9so1792679wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVWmqrHmN8k1tD/caQDTal6fqjCBCOWgYK0fgUgjsDY=;
        b=E5E4qiexQZCYriIfNZsWql+o6tJ4eDErWTmYoyTzcNQifKok0znhokls0/fFOEo+oq
         IZSirs61Kh116SIJetyXldz+4HR8HgBIUP6uwl9Yff/2xTqOVPAWnMyI6zOwbudjhnAy
         KzA/PRROx9+PHM10c2c8cbKAKKPu8lDe4/PkNvKCQhCVlnFqKhsJE51gdge9pbJHspz6
         ra7ComADCfaJpWmfn76rpio6JCfodzsCm9eZcBe9RDIQFMNNi99YxoCvZV/aLDgyBEkr
         Ihz2pBA4UDADCI852EioWvZNOTPrKwDy3Gl+WDcsPCTdxrTIG36fiuGiTzNUAcuAMecu
         83cQ==
X-Gm-Message-State: AOAM533iPN1yGbDD24cuVVCB0ulb7X/KsE+VQb7u7SPnjYwUYcQejkbW
        yr9SrLLDTACeVZRBWFTexu5uZMULvTRG73bC+DW2lr5goFaryt2dlffzLaQmahk0HZz1ZmVmx2H
        x00mE7LB6oICbpotn5KbFcx0=
X-Received: by 2002:adf:faca:: with SMTP id a10mr701563wrs.9.1621455464693;
        Wed, 19 May 2021 13:17:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYEc9LRcRWaH8SeBjkhf17hx8NzdqxOG8U3gTeobgD/L+twK8rDMC44kE6H4Bc4EtVflBAeA==
X-Received: by 2002:adf:faca:: with SMTP id a10mr701551wrs.9.1621455464542;
        Wed, 19 May 2021 13:17:44 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p6sm474549wma.4.2021.05.19.13.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:17:44 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        willy@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/page_alloc: bail out on fatal signal during reclaim/compaction retry attempt
Date:   Wed, 19 May 2021 21:17:43 +0100
Message-Id: <20210519201743.3260890-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <YKVn69o1UizH0kJD@casper.infradead.org>
References: <YKVn69o1UizH0kJD@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not make sense to retry compaction when a fatal signal is
pending.

In the context of try_to_compact_pages(), indeed COMPACT_SKIPPED can be
returned; albeit, not every zone, on the zone list, would be considered
in the case a fatal signal is found to be pending.
Yet, in should_compact_retry(), given the last known compaction result,
each zone, on the zone list, can be considered/or checked
(see compaction_zonelist_suitable()). For example, if a zone was found
to succeed, then reclaim/compaction would be tried again
(notwithstanding the above).

This patch ensures that compaction is not needlessly retried
irrespective of the last known compaction result e.g. if it was skipped,
in the unlikely case a fatal signal is found pending.
So, OOM is at least attempted.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aaa1655cf682..b317057ac186 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4252,6 +4252,9 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	if (!order)
 		return false;
 
+	if (fatal_signal_pending(current))
+		return false;
+
 	if (compaction_made_progress(compact_result))
 		(*compaction_retries)++;
 
-- 
2.26.3

