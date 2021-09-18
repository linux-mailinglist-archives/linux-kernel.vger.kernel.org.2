Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B4C41047D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbhIRGyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 02:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbhIRGyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:54:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95680C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 23:52:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c1so8352505pfp.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qpn+FUWspl8hHFYBlprQCoE3a7AoXcPYE7SKxAyAXE=;
        b=bfrHMqribJAIzrW0YTLEN4fPSrSfWSqyiXP6BhUTFZZw6a+h4OjWJJVJHRjsHr2mB+
         Z3Xj53+wbtRC+zfGLMhkLJPGaRKkckFpIlanTu7Zl9Q1nzscnySKeLefJg7+h6BecU17
         x869Z4Hks91pWLKgwK61fvNneyJ6nf67zGHtlln2qDWacAv7W1PaF5g+IoNagGL4Pwuc
         I0HxjbByfVQchkNjF0u59XqLTJkqcq/tMdqOjGwZjgfZ8OOJOhIkZwOKb2sbrGtxN2YO
         KGzzQwjkytlVgQfihEj9+NBgDeIr13l64CaV3qB2MCisKkH/MCC8HsC7GPDbxHqoN6Ri
         HRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qpn+FUWspl8hHFYBlprQCoE3a7AoXcPYE7SKxAyAXE=;
        b=QHDY85SZdRL8d/BvbSCgHG/RoXQw5Kp6kZy1awMkJmfGevy6jGOdBwISA3WYw71oKQ
         pbo++LRLfdSvqls7mbjn7opXIX+8fV27yxRUd2fGIzGlsbqTpN4d54t/F5qisZTjVyXp
         uE1n9c5+VtJDD6UcAUSvjmEOZPueNYyktoUQQjO2c+8ey3Ib7mFK1nBPL6gYQpkarKTf
         xm+BCTbi5E5yoNvqS35snN5iNpLQ9NBIrmUM8nvVbbA25BFuZgQ2byPbrRLX09vCcf34
         fRrIKZVcTGQ1AgvIpIX2JAPe9lDYqA8/NH3HDNpzpMlIVwpSKlcGjEnjZh6Ld2twFbBZ
         7sFA==
X-Gm-Message-State: AOAM531kMlB8d4ZRe93T2almx9vR+KbE8ZKfDIQiPh7SmPeVP1xKmmcg
        Y5B/CIEDHPRr9pA9iXc7j6g=
X-Google-Smtp-Source: ABdhPJzxkJVrIpJgt6OwOH4PLRz0CiB73sVe0RS9mq22otyEJL6mcAoAapPbmy4kH/6KDWBU1XhHbg==
X-Received: by 2002:a63:4541:: with SMTP id u1mr13523990pgk.369.1631947959122;
        Fri, 17 Sep 2021 23:52:39 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x8sm7988251pfq.131.2021.09.17.23.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 23:52:38 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        jan.kiszka@siemens.com, jmoyer@redhat.com,
        dan.j.williams@intel.com, neilb@suse.de, yang.guang5@zte.com.cn,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Modify the check condition
Date:   Sat, 18 Sep 2021 06:52:32 +0000
Message-Id: <20210918065232.239336-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The vma may be NULL, and accessing the member of vma like "vma->vm_start"
in calling follow_phys may occur segmentation fault.
So it should check vma at beginning. If vma is null, it will return. And
the if condition won't execute "vm->vm_flags".

Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/x86/mm/pat/memtype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 4ba2a3ee4bce..b7108b37b754 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1089,7 +1089,7 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	resource_size_t paddr;
 	unsigned long prot;
 
-	if (vma && !(vma->vm_flags & VM_PAT))
+	if (!(vma) || !(vma->vm_flags & VM_PAT))
 		return;
 
 	/* free the chunk starting from pfn or the whole chunk */
-- 
2.25.1

