Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFEA38BCC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 05:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbhEUDDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 23:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhEUDDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 23:03:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F20DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:02:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u7so1638175plq.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pyb0TctjvaI/OUB8rDFVD7xXzPEU5hRVJt7W8tnhK1Q=;
        b=T0p2rR2gWnKeMMy4lg+36jLMLFefCFJQpxF0fSZkNAor+htwgnU68pj6lm/uDsIehQ
         9TILJ8hh2jMOfmo7unm+O+zjFg3F7j5YF2y1kHU5DvMya8wngy3oCiyDeLLuopkomOZr
         CBJp7FBTP1HcZulZyTo/aYLz48bmJxu8THj+rZJMYk+SzaMzvNTPCRR41+5xwonWmVkC
         PjD1Nd0PIthLpEGuPN30a2BgvTsr5nnhcYUD+ouD3GWsXFHreuDDUiho/Ttlah4sCgeq
         hhICjTEfI+c85VQ41rPPBsxMhxS+ZfL1vPZCu0kxEhOubQGquDV6O94m/jp4p24DamhY
         cXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyb0TctjvaI/OUB8rDFVD7xXzPEU5hRVJt7W8tnhK1Q=;
        b=SLEU878DcaAOKs34lAWAl1rvQt2pr+IE1x4ZrBc8Jg9iEevBEIEVWxVp6c38KaTL31
         R/nsmVLiUyLxR8UCxzJxTmb+nPTdzX1AxIZWRI/VrCFUp+MQAEX4WJBkMrH7YBAeO+Te
         NxkjyHd6xDeLX/HcwO8OsSDQHTXgEmWQUjpqCKQgo5gByPd3oCIsgZqKSvMTsyyfvRaJ
         07vWUIWckyJjQmM4V41IwPxEDPWcvRS2PoAndTCJqApCn1DciRWyi3Q0DktP9I1x43YM
         4mxQb6nxT4Km4JsoABf431quE9V+nOUytXZVDJ9pCzvOpbXw0ZnCZkeBU7tafOruURjv
         hxTA==
X-Gm-Message-State: AOAM533wbtui7a6nvL0+0jnQfwfl4USBTsyPGe2dKiN2NkY8wZXdspxh
        7q3Egpbmf91YrbmTbhgYQg==
X-Google-Smtp-Source: ABdhPJxFqjiOZDuJCAgryzL8NkinikwGV9C+njllULaSHVoCRPlzpo0KTnp4x3CmDRX2fyPw3CWGrA==
X-Received: by 2002:a17:90a:fa88:: with SMTP id cu8mr8631050pjb.233.1621566129802;
        Thu, 20 May 2021 20:02:09 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id 191sm2959677pfx.121.2021.05.20.20.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 20:02:09 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] mm,hwpoison: Return -EHWPOISON to denote that the page has already been poisoned
Date:   Fri, 21 May 2021 12:01:55 +0900
Message-Id: <20210521030156.2612074-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
References: <20210521030156.2612074-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

When memory_failure() is called with MF_ACTION_REQUIRED on the
page that has already been hwpoisoned, memory_failure() could fail
to send SIGBUS to the affected process, which results in infinite
loop of MCEs.

Currently memory_failure() returns 0 if it's called for already
hwpoisoned page, then the caller, kill_me_maybe(), could return
without sending SIGBUS to current process.  An action required MCE
is raised when the current process accesses to the broken memory,
so no SIGBUS means that the current process continues to run and
access to the error page again soon, so running into MCE loop.

This issue can arise for example in the following scenarios:

  - Two or more threads access to the poisoned page concurrently.
    If local MCE is enabled, MCE handler independently handles the
    MCE events.  So there's a race among MCE events, and the
    second or latter threads fall into the situation in question.

  - If there was a precedent memory error event and memory_failure()
    for the event failed to unmap the error page for some reason,
    the subsequent memory access to the error page triggers the
    MCE loop situation.

To fix the issue, make memory_failure() return an error code when the
error page has already been hwpoisoned.  This allows memory error
handler to control how it sends signals to userspace.  And make sure
that any process touching a hwpoisoned page should get a SIGBUS even
in "already hwpoisoned" path of memory_failure() as is done in page
fault path.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
ChangeLog v5:
- update patch description.
---
 mm/memory-failure.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git v5.13-rc2/mm/memory-failure.c v5.13-rc2_patched/mm/memory-failure.c
index 0f0b932ccbca..8add7cafad5e 100644
--- v5.13-rc2/mm/memory-failure.c
+++ v5.13-rc2_patched/mm/memory-failure.c
@@ -1247,7 +1247,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(head)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 		       pfn);
-		return 0;
+		return -EHWPOISON;
 	}
 
 	num_poisoned_pages_inc();
@@ -1456,6 +1456,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
+		res = -EHWPOISON;
 		goto unlock_mutex;
 	}
 
-- 
2.25.1

