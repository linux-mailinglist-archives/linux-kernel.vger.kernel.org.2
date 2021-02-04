Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBF130F96D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbhBDRSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbhBDRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:17:08 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B3AC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 09:16:27 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id y79so3228312qka.23
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=CWs5UE8Kdmh+MQd8bFvaWH6vN8MkKdop27j3PZaaEEk=;
        b=RvmiSNnpq5dIjK/KsaaPz8Tfp6HEdpvhnnQHoDk1y6rJOw7daASh69I/9qr3eTxurJ
         QxdhYhSdCRC08n+OT+0GZ83cLaNqw8d0GXASpB0CVFn8RkwilEwy/NfTqX22URgGRg64
         h3KIvUZs4chncId+curUsRE0pLO7Qk31y2+vE78sNziBdjWR1qR6PCBZC9QgvrfJjL0A
         uhQD3QJlhZNqHAcsVO+a9GjOG0v0uV3LSt6omfqA4hkO95jxobHq2J6wIj53soo6ksOO
         3HxqpLQd7qeK8fsN1id0eKJkt82pcGtts9Ly+gZIAo4N4PApGtoJrlf0vBO+AA+KiQ5z
         iICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=CWs5UE8Kdmh+MQd8bFvaWH6vN8MkKdop27j3PZaaEEk=;
        b=RR0aUMLCzpuc189EvbwQgW9KpzrKDbIiN5DFighUoDnDJ/OeBM5oQ3OMkMidXGvpOx
         63zqf9D/nV6OeNd7y4XljwFYsBhzCaZBPgU2S+1imiHYxIOaEytB2t8SuB1Tbv2wu6Z2
         CvzcrduzkU4DW8UGbSgci2ZP9BivK0vl6hb6rNaDgm46EIDiqQsDhRK4d3+SlTdWtM/d
         PQM7ThCHgR/rSDywwRadr+hpVVXkybyrH003md1MpfxJW/OP3FtGkCWOTBBM/KMwAVIi
         uyvPVn10dUnHcqXoLXBYvdWYCIuTHrecSM4kMLY35PbgT34F59G0DtogRhVTuKsJGCCb
         Qa+A==
X-Gm-Message-State: AOAM531+CzKODNoneJXyKnqkvsStENH99nrDzqmGgfmJzzvehA6JCMTn
        0TlKE5RObRzOCXuF/PKySW9/7FlxpL8=
X-Google-Smtp-Source: ABdhPJwNFc/pfbYrCPQH1RwiV0zjReAT9g+Rvj4tY5TqJz3Zs1352G0A33nGNamEpCBSQz/ihOce7ZsjK2o=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f16f:a28e:552e:abea])
 (user=seanjc job=sendgmr) by 2002:a05:6214:592:: with SMTP id
 bx18mr236964qvb.32.1612458986469; Thu, 04 Feb 2021 09:16:26 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Feb 2021 09:16:19 -0800
Message-Id: <20210204171619.3640084-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] mm: Export follow_pte() for KVM so that KVM can stop using follow_pfn()
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@google.com>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export follow_pte() to fix build breakage when KVM is built as a module.
An in-flight KVM fix switches from follow_pfn() to follow_pte() in order
to grab the page protections along with the PFN.

Fixes: bd2fae8da794 ("KVM: do not assume PTE is writable after follow_pfn")
Cc: David Stevens <stevensd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Paolo, maybe you can squash this with the appropriate acks?

 mm/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..15cbd10afd59 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4775,6 +4775,7 @@ int follow_pte(struct mm_struct *mm, unsigned long address,
 out:
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(follow_pte);
 
 /**
  * follow_pfn - look up PFN at a user virtual address
-- 
2.30.0.365.g02bc693789-goog

