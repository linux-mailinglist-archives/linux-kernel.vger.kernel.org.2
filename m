Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EF738968D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhESTYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230486AbhESTYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621452204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3WjHLe7Vud9dDJn40LFvnZRilRoTHkcFzpqQq2wlvq4=;
        b=Y2GB6P19iFiqKHkfOiW9Lbq/FrgP0/13N7/IZDPsbvpgW8O6IS71fnrMRDe8Qahjw+NQAN
        TO2OottWyEpJdA7zkeA+6CNGt23mSBfiAv+9ssrwucOT5B9mY6G8EXgydnLdRdIqoGRPyL
        uV8i0FNJ+wMkpEDk0Mb/9wkTmNAusFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-FBzjh4ukNI2vHrkQN_80wg-1; Wed, 19 May 2021 15:23:23 -0400
X-MC-Unique: FBzjh4ukNI2vHrkQN_80wg-1
Received: by mail-wr1-f72.google.com with SMTP id 1-20020adf93810000b029010fd5ac4ed7so7579320wrp.15
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WjHLe7Vud9dDJn40LFvnZRilRoTHkcFzpqQq2wlvq4=;
        b=JA4EDWr/q5r7VOaHUcRL0h7sY1fUjFJRunoR5/wpuHXPcJCxFCxZminMdPHiflrJLI
         C++lYg40tjXP0GMTzmLtN1e+6ddEyC/Kak9pjXlMGDIIU3su0jwNVm3/zIrwYqoKGiOg
         92AnlV5wUnKhXaHc4tXWuf9brRS7jQaShY7QAoCA7f8misy6Nvkc/dgFNCGuUHeQDJ8E
         oIRYIUTfk2lBoePr++uDRKfCCzcnLpS0l/nIAGfxXcNe7zc1EBb5ve7lIoh1rOYEZYbW
         orDqnU/tEwmui+jTgxgcOw46wmEatD8njSPfibfkLhuxHZo9gsjLqAGCv4HNUEfwPgK1
         YYTA==
X-Gm-Message-State: AOAM530pskpbxwFml3uodrkQShBIxfJb5u8/nysAGcrl0hbJkBd3L/OI
        Na/g28r3xXSct0EhVgM6sRMWz/giqSguagWMCxW2KxB0zP2DfrK4yWhhUNnnAO2lNDuJNsMxM1E
        yWpyvyOY+mNC2Dsiq8x4QJmc=
X-Received: by 2002:a5d:688c:: with SMTP id h12mr520962wru.348.1621452202189;
        Wed, 19 May 2021 12:23:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym03hDmbID+lz+UjdMn7Xm8C/IopBXH7nwK38fTok52P/RFMMQ5K8a86YxCSqStlXtpXeTsw==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr520952wru.348.1621452202051;
        Wed, 19 May 2021 12:23:22 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id k6sm6664098wmi.42.2021.05.19.12.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:23:21 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/page_alloc: bail out on fatal signal during reclaim/compaction retry attempt
Date:   Wed, 19 May 2021 20:23:21 +0100
Message-Id: <20210519192321.3247175-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.26.3
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
index aaa1655cf682..49f416ffb54f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4252,6 +4252,9 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 	if (!order)
 		return false;
 
+	if (fatal_signal_pending(current))
+		goto out;
+
 	if (compaction_made_progress(compact_result))
 		(*compaction_retries)++;
 
-- 
2.26.3

