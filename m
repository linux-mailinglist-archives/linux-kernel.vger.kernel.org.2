Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28AE38B1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbhETOab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236440AbhETOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621520945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYOc57ukgw42N/SN5E1bnm5deoP6acpYVUsf7mHSuH8=;
        b=DZODC0hXsPk/+WwNhNyQWcGbnI2BH2iHkyPlbPmuaI09O1bpO8WSyJswy9FS8X+gAmWR+q
        xckcrJlkk+GgdkggjZL42wJaWSFYV0hLRWwIcm6kUnI7yqSuwuOSHt4WIC0AzU1eLkY09y
        /7P5ycLJj+CwJWtp5DwqksoPu+iRRLE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-0rzCIsqsNsKXt3FTymGq-w-1; Thu, 20 May 2021 10:29:03 -0400
X-MC-Unique: 0rzCIsqsNsKXt3FTymGq-w-1
Received: by mail-wr1-f71.google.com with SMTP id g3-20020adfd1e30000b02901122a4b850aso686530wrd.20
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYOc57ukgw42N/SN5E1bnm5deoP6acpYVUsf7mHSuH8=;
        b=M6/1cu8wwJ8uD7caqLnUpmFGcZJvGo46tpPcqWQMvZOjLyLF3JAj+x+NMN71iLTzF2
         zAbvUAQEmJlhWX8Hl/qPKkc1cXQOsfw7qmuvEeFbDYmt7a5GCAOfu17wCYVC2muxbHeo
         ixMH1dytTkHtTFGeV8QDl9EzKTOzS9eXueAma5XlqFpaTGP7zc5pScUZIrq1PKRQ7uD3
         wHoCFHmUQz/Q4WC7pkwWB6Ue3pt2NlVC15aTsAFGzsju4aH6YiqhQEhtrhPmrUYXvD+M
         rl/eYOSzDckGljmrTbJfRYoAqr9WtS1ottWyvGb2ny1r/BLIGQt4Ez00XgfsAbnZGpju
         /r6Q==
X-Gm-Message-State: AOAM533hm2hqkutau55Z/VKw/xmsfw5JX3Kxzuerew5qfYAtuMFbn3e8
        AikQOxjz3nrUA7Tn11Nd8rSHzgnYnZe+SMVhPZr/8KmvOHBLw0slYrwKB4B5ZBhuqlLZve4O0hC
        V26SUm3CkAj60+G/xSNCOEgA=
X-Received: by 2002:a7b:c841:: with SMTP id c1mr3984976wml.123.1621520942673;
        Thu, 20 May 2021 07:29:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEbGPnyNZxPxygXLaN6j4fqdxsCTcH6CY0x7XaZ7SRad5T96/CwNYW80Oacd2SE3qX6+15wg==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr3984953wml.123.1621520942497;
        Thu, 20 May 2021 07:29:02 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id m7sm3338168wrv.35.2021.05.20.07.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 07:29:02 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        willy@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm/page_alloc: bail out on fatal signal during reclaim/compaction retry attempt
Date:   Thu, 20 May 2021 15:29:01 +0100
Message-Id: <20210520142901.3371299-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <YKZObDpduqwWi/Zm@casper.infradead.org>
References: <YKZObDpduqwWi/Zm@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A customer experienced a low-memory situation and decided to issue a
SIGKILL (i.e. a fatal signal). Instead of promptly terminating as one
would expect, the aforementioned task remained unresponsive.

Further investigation indicated that the task was "stuck" in the
reclaim/compaction retry loop. Now, it does not make sense to retry
compaction when a fatal signal is pending.

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

