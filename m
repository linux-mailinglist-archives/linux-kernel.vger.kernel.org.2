Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65991370798
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhEAOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 10:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231426AbhEAOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 10:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619880082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/tBe8WZmkkOxqF/hwRfEFiIpzRFCG2CptqZIBKPw6Q=;
        b=g9OA2LFls3SSERj6omUp/9kLZYdKZygon6pqA7t1a29NK5kHGo6+irsaCLeC4SCoTLTPDj
        ZrFo8O0BfyXG62S3gbykgiRr0KsVEeEMh4ODuqTWJSfP+hZns7FPLjuBrKhZMszdizkNei
        IAvkaV6wLCn8bETMTmWP8H5/yUCI62A=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-b6u66ykDN2qQbyWJGY0P-g-1; Sat, 01 May 2021 10:41:19 -0400
X-MC-Unique: b6u66ykDN2qQbyWJGY0P-g-1
Received: by mail-io1-f69.google.com with SMTP id v18-20020a5ed7120000b02903f36dccaebcso573082iom.15
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 07:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/tBe8WZmkkOxqF/hwRfEFiIpzRFCG2CptqZIBKPw6Q=;
        b=Gv6s5eAhSmx/J1gYGTlmD6dZGE1MxgLh0ru9YijUTFQbNnEmr/oA0o4NbZ0FTqYbtn
         STvXrw+IsyDbPqKn8AAHffa/XOMZseK/uwWGkYmnLHYfr5ad4GwFyFNRCPc/6a5R3+ag
         uzbF4FY4IiM6j49joOfUSouCtgl0lZ2UmBRazY5uFuwEtj5HIBq0uDXS1q0v5Rml1tVs
         vZA1JO9MyltWP+c9/lFT414anwOGiqOrju3wtPCFzTzbvjNgUoPN+PKG+0v1zPWfupNC
         YvFyFIlAgqXWFuzHx27Ov6D2KBygyUOxKoh9V0mDV+Qcm87lUeZO9OrtaIXvbx+3FN39
         k5Vg==
X-Gm-Message-State: AOAM531V5vw9ro0UIGB8wb9YZM8vObaH+KPN6BorZhxCxw2x6CMhmDWL
        5mDJO0e0JoWa9TbTTS7QzbAVLQvCEEzOl0CFocH11vRk9AGtG82/QO3L+X0cA+FmKDpZQHO/RA6
        TkM0GFd2WYrMPcdf+Be5E/rVW
X-Received: by 2002:a05:6e02:1c42:: with SMTP id d2mr7926100ilg.287.1619880078480;
        Sat, 01 May 2021 07:41:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6T9MfV4SDndTsV4uuk0FwJd2cZzRHntQUOZ5i0PdrgXvusQOFPqGUeX8DQ65+FUIWtJ1BJw==
X-Received: by 2002:a05:6e02:1c42:: with SMTP id d2mr7926087ilg.287.1619880078253;
        Sat, 01 May 2021 07:41:18 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id k2sm2649343ilq.71.2021.05.01.07.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 07:41:17 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH 2/2] mm/hugetlb: Fix cow where page writtable in child
Date:   Sat,  1 May 2021 10:41:10 -0400
Message-Id: <20210501144110.8784-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501144110.8784-1-peterx@redhat.com>
References: <20210501144110.8784-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fork() and copy hugetlb page range, we'll remember to wrprotect src pte if
needed, however we forget about the child!  Without it, the child will be able
to write to parent's pages when mapped as PROT_READ|PROT_WRITE and MAP_PRIVATE,
which will cause data corruption in the parent process.

This issue can also be exposed by "memfd_test hugetlbfs" kselftest (if it can
pass the F_SEAL_FUTURE_WRITE test first, though).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 629aa4c2259c8..9978fb73b8caf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4056,6 +4056,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				 * See Documentation/vm/mmu_notifier.rst
 				 */
 				huge_ptep_set_wrprotect(src, addr, src_pte);
+				/* Child cannot write too! */
+				entry = huge_pte_wrprotect(entry);
 			}
 
 			page_dup_rmap(ptepage, true);
-- 
2.31.1

