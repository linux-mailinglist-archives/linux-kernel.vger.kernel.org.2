Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C041327FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhCANgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:36:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235797AbhCANgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614605683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybf+ggtfILCNltr1swxw8VOdjmkBkmS5pZZjWFFS29c=;
        b=dXhdrFWR0AvmUuUiL+E4OMWKR4BP0JNRprjKROm3kgNbnGUq+WbHCyrPOOXH9p7YsKGje6
        6PtVupHy1LfQSZGvBKQtHh5gseOxPez84op1jbBHA4k2b0PC+B7QEvL63nIdxkWP0tvwpz
        6bTKsnMnCe37gWkaJIsLI7tTd/2Hp30=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-SHKtYJWnMYyEWuygVoCW4A-1; Mon, 01 Mar 2021 08:34:41 -0500
X-MC-Unique: SHKtYJWnMYyEWuygVoCW4A-1
Received: by mail-qk1-f198.google.com with SMTP id m16so13913222qkh.20
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 05:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybf+ggtfILCNltr1swxw8VOdjmkBkmS5pZZjWFFS29c=;
        b=LbGzmltNlcjcaFey86FuRkFSFl0Y22A+7bUMcxFNevAzZ3YyUs1SRhrxwE6CzQiH6U
         9USW135iypMsNe5TsUEXqqaqP7zAQ3rO2nOwhWBV0SQNG2WdNzguDzkXLE7/1/sCSl90
         jUNEipCrcx0n6GalLSUfpKl7G2B7G/RGlTxOp8RGil/NJy4vngd2KVzEXA4gmokxSRZv
         EvT4fpoVIWe1tYTlZrYYCnIMmHuFixBkS+ow11bvuTLZ0XFB+EKHX3xw77W6ApUhfh7Z
         8Jb9B7OFfsI/nM1CZWmsBo7afqJP0dKkF4213LSzKu6ZlZsnxbyDQPtLIV0CoF3mw8d1
         UkBw==
X-Gm-Message-State: AOAM530GHdBEi6lzINMYXlSYqXVw+FGmw/AfpksPI3iqW7gyaVdbSg8r
        coQmmK7K9aajgCJp2mK0nsoKowuHQp9muVSP0I8+amT5lFGZqdzqkS+R/fhZbpFfm95lPiiR4ve
        hmm+ONBk7u+SH7f8C+qw8cU99
X-Received: by 2002:a05:622a:42:: with SMTP id y2mr12949612qtw.186.1614605681194;
        Mon, 01 Mar 2021 05:34:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbUlZvZ75QwyBB04IJg5lkgSwuMY2dUKh/WmZDmHG/CWukZ7M0cNmCw70cjtan5HBTOp18BQ==
X-Received: by 2002:a05:622a:42:: with SMTP id y2mr12949580qtw.186.1614605680734;
        Mon, 01 Mar 2021 05:34:40 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id 73sm6609609qkk.131.2021.03.01.05.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 05:34:40 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] KVM: X86: Fix __x86_set_memory_region() sparse warning
Date:   Mon,  1 Mar 2021 08:34:38 -0500
Message-Id: <20210301133438.396869-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <202102280402.c6iev2Xp-lkp@intel.com>
References: <202102280402.c6iev2Xp-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force ERR_PTR_USR() cast even if the return value is meaningless when deleting
slots, just to pass the sparse check.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Fixes: ff5a983cbb3746d371de2cc95ea7dcfd982b4084
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1b404e4d7dd8..44de71995a34 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10502,7 +10502,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 			return (void __user *)hva;
 	} else {
 		if (!slot || !slot->npages)
-			return 0;
+			return ERR_PTR_USR(0);
 
 		old_npages = slot->npages;
 		hva = slot->userspace_addr;
-- 
2.26.2

