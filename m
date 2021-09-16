Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0B040ECFF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbhIPWAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240605AbhIPWAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631829523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p2nOnT/BtxTSAXpnqdHXN1Y4k+CMsYKb4beYByvY8jY=;
        b=U6It/A7BNEusyPYpDXthF+zuLDirNPXfOKDoPeZFnnBXLv6HaY27ggRK++tXvG6mFlA/3g
        q3p2UgdPPOfhtxkk+qTAqv4e3RGbHFy8SKat0P0xE3gjWlQ9H9nkN2aJ0pkfbSi5o/O1m2
        cAjw3BTLnyB451gl8oXAKBJ0JVr7LMY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-KwprJ7veOJeqSyA8ZaOYaA-1; Thu, 16 Sep 2021 17:58:42 -0400
X-MC-Unique: KwprJ7veOJeqSyA8ZaOYaA-1
Received: by mail-qt1-f198.google.com with SMTP id z16-20020ac86b90000000b0029eec160182so73633889qts.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2nOnT/BtxTSAXpnqdHXN1Y4k+CMsYKb4beYByvY8jY=;
        b=Tr91M7OiAoasnw9J7ipSItzR002XHXKl3WDBqly88W1lTvcbi0rgVjLDfLJNx4aof3
         9O5jFqH8ibLHT+FSc8q67M6zV7TUWCxwsRKnr0xUX3gPhQYJvEFox5h3g0+NI0K7Y2yz
         G1ASUJMnVH+RXgavoHnsRoI1olZeh8FgT/IH8zWFhhlUYtkr/GTZ1mhltHkEkESsLRSx
         TMT/9ZH/2JHmyzkRRWWqY6XSg4lG9UgZ/MJlMcvsSRRDQgIVQ+QFG1oJRi/KaLjZrrd2
         vKh0o1xHm8e4HVmFrf5NwzhwCRI9gmlLFtOMf1n17fWWiby9haNLDbwigi8LYj2ngiQA
         /mxw==
X-Gm-Message-State: AOAM530i/TjyODQJ6i9Q2gALa+LriKTISAA0rkfp3xG43E79smcQmCdA
        fDdoL7TBOiVBO8OnprnhvZ5C+lWYsplVDeOKT68RVSrAJv2tC3A89xy43W6FdSIU7A0enY8/Fvi
        YTSyYEgw5s9sO7oev5MRC332H
X-Received: by 2002:a37:e409:: with SMTP id y9mr5981398qkf.441.1631829521883;
        Thu, 16 Sep 2021 14:58:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhfdGFXrqy/ukybe2LuApn40ildbDdIpxxhJNlm1xp8LfoJMi0CKvrlurNql13VHOqdn1FaQ==
X-Received: by 2002:a37:e409:: with SMTP id y9mr5981383qkf.441.1631829521661;
        Thu, 16 Sep 2021 14:58:41 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id c7sm2990832qtv.9.2021.09.16.14.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 14:58:41 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm/smaps: Use vma->vm_pgoff directly when counting partial swap
Date:   Thu, 16 Sep 2021 17:58:39 -0400
Message-Id: <20210916215839.95177-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linear_page_index(vma, vma->vm_start) of a shmem vma is exactly vm_pgoff.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/shmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 96ccf6e941aa..2aef5b8e17c9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -856,8 +856,7 @@ unsigned long shmem_swap_usage(struct vm_area_struct *vma)
 		return swapped << PAGE_SHIFT;
 
 	/* Here comes the more involved part */
-	return shmem_partial_swap_usage(mapping,
-			linear_page_index(vma, vma->vm_start),
+	return shmem_partial_swap_usage(mapping, vma->vm_pgoff,
 			linear_page_index(vma, vma->vm_end));
 }
 
-- 
2.31.1

