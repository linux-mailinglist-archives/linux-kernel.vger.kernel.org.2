Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B635D354
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343812AbhDLWny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbhDLWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:43:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67872C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:43:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso7944794pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+eLCTporA8diA9+4AwwE0Qpo+13q5cqafF4gWgDZDZA=;
        b=f/HYbNRLsApenom0NFRbF9JdUXkmoFwxcRf6BNOXYUII4ox16vyEHHeI6wxMAPi0Gq
         C3Uv9pW8IY5/cYsfSHcKeS0HXJZiKFUiCi3r+DZXg1ZmG6w5NcIFEE5o+cpNmAesCwtm
         Rqy/VkoEfacLhP2zBOCA3hjpRJ2a/rAbtiz8huTKx1WT62yutctCdJ6XNr5yaMz7wBb7
         aIKRheBotsTFfaSb4IEluArWWfySIPI13A2cU4XdSUlpEjqDgyOwHsScSatylhPLNM+F
         K8MhiLvUU+5o0yDouHqYdeL/uwuxIHWkvY6x09CV4FinCKkCAQVdaZ/DPsWAgxnosXwT
         V1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+eLCTporA8diA9+4AwwE0Qpo+13q5cqafF4gWgDZDZA=;
        b=WaeTx4XhjY6N2MVX8u+1TCuY8TenHoUYQvu7fnv0VkL6vNgXtuU1NCNTib4G4vUX4Y
         1LnBoWlo67u5Dm1sf212eM5Hb+lUx6/jcEyb04RA/s9i96XO0DPj5fjsGSwpJPZ0oYrt
         ArHsiqGMcyT1WmL+ONtZXYNLLiRr8BXehNr+g662iBDhMUguNsXhdcR1tMkkew9VFXN4
         TfxSovAS9PUHoI2X/f4qKM1J4UsFPTKR1btZeu1tKwSOgGBDaNAfE6ifDnMyc0igwygt
         mnwL1I53a0/a4TsmGRDEHjQLcOnuM4Yr3jAWPbkEbK3UUMBLNoDjeF7DCC0H52RZ77Eb
         gZpQ==
X-Gm-Message-State: AOAM531b5UmLvJyd2MrKkvOknyMWxJwjg/j3HynhP7vQftyaPVm6ZsAV
        HnJzKhGDjxi0saA6XRaD7g==
X-Google-Smtp-Source: ABdhPJxIkwcM/K0oArvegDYbDl0TUq2BZZovmIRLlI/eji+k5V+qSKF/qUJPjmgKVVWaOVZcY0wx9g==
X-Received: by 2002:a17:902:8f89:b029:ea:ea23:a02c with SMTP id z9-20020a1709028f89b02900eaea23a02cmr8991008plo.71.1618267413002;
        Mon, 12 Apr 2021 15:43:33 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id l25sm13365373pgu.72.2021.04.12.15.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 15:43:32 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] mm,hwpoison: return -EHWPOISON when page already
Date:   Tue, 13 Apr 2021 07:43:19 +0900
Message-Id: <20210412224320.1747638-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
References: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

When the page is already poisoned, another memory_failure() call in the
same page now returns 0, meaning OK. For nested memory mce handling, this
behavior may lead to one mce looping, Example:

1. When LCME is enabled, and there are two processes A && B running on
different core X && Y separately, which will access one same page, then
the page corrupted when process A access it, a MCE will be rasied to
core X and the error process is just underway.

2. Then B access the page and trigger another MCE to core Y, it will also
do error process, it will see TestSetPageHWPoison be true, and 0 is
returned.

3. The kill_me_maybe will check the return:

    1244 static void kill_me_maybe(struct callback_head *cb)
    1245 {
    ...
    1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
    1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
    1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
    1257                 sync_core();
    1258                 return;
    1259         }
    ...
    1267 }

4. The error process for B will end, and may nothing happened if
kill-early is not set, The process B will re-excute instruction and get
into mce again and then loop happens. And also the set_mce_nospec()
here is not proper, may refer to commit fd0e786d9d09 ("x86/mm,
mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages").

For other cases which care the return value of memory_failure() should
check why they want to process a memory error which have already been
processed. This behavior seems reasonable.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git v5.12-rc5/mm/memory-failure.c v5.12-rc5_patched/mm/memory-failure.c
index c1509f4b565e..368ef77e01f9 100644
--- v5.12-rc5/mm/memory-failure.c
+++ v5.12-rc5_patched/mm/memory-failure.c
@@ -1228,7 +1228,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(head)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 		       pfn);
-		return 0;
+		return -EHWPOISON;
 	}
 
 	num_poisoned_pages_inc();
@@ -1438,7 +1438,7 @@ int memory_failure(unsigned long pfn, int flags)
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
 		mutex_unlock(&mf_mutex);
-		return 0;
+		return -EHWPOISON;
 	}
 
 	orig_head = hpage = compound_head(p);
-- 
2.25.1

