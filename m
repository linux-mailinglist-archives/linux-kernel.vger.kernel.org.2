Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A17A377C02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 08:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhEJGBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 02:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhEJGBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 02:01:09 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42071C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 22:59:56 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y12so11154796qtx.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 22:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=gaxObsy3YPrpH1zijJRXin726mARZtuqaRFKkyvziKI=;
        b=pp6jcXClHu0nYyzMGAXp5LKUOsjmgyHqUi5+9jQQQKNPMb21zGtoMW/DN00ZQqUtmn
         5l345Dau66yXcvQrtPhJLApedSoxqqLLMqVjCW/hZyU0/lofgHcm6sV7IMSKJv/ql9zP
         23G19FnwcNV0HeQxKlJQ7GCVWdtHFWPuC75UmMbvV1Ha/DifZahLDF4Wucc5UNAW89yG
         WBfxFHaAzhPnfERIrb8stdSCUXL+23OC7pA/V2DvsA4EfebMFxZ3X9i7RHQrKKPm3sLP
         8hRay5SsiwEiSUCAu156gfqYoxEb7sZ3TBOvzLr4G5s5+8kdMp13pNj7fHMm0WvRKevd
         XoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=gaxObsy3YPrpH1zijJRXin726mARZtuqaRFKkyvziKI=;
        b=Y5puNQT1BWm8EBUMx/QkUVvCEHgrs/WGLz0pzti/xtcMKjGIWP1pDUPit/2t5LLedZ
         nSiXViyULtM2x1aFunrn3yYctUuh0HC+GmMh8D7mOgfMR5y76X19sSujVPMiCRqWlrYK
         nFS+k/7DWM64xCBQBiK0wzsS32H5mOR9j/kytXaQE/J/ZG72oGejTwLK2Fqd/b1GVvT5
         +iScoanBETK+OcKBDlbyGVGPd+urGEHmapWRoFN8Vll3iUukTxgBEnimEUY61bLzZL3U
         B5xuX2Ol7JGC02Klfda/ao2sJRUKC4EFzKaWGNk3CsB/gQdU2lFkZlBRSDSrDWq0SVtZ
         185g==
X-Gm-Message-State: AOAM533fs5Qnat2ke20dMEVFbbo4WYCn8lQnF11dI348kVYjHGbs0h0q
        5qoQzPDn8p5Krp6x5CoL10PMb1es8hLQjg==
X-Google-Smtp-Source: ABdhPJw1BbXE6F7/fYsE6Dq/o366WPKxIbih8MadXG8ALLoaKhyTTrCiLr7i26XlphCkd+kEWT9VpQ==
X-Received: by 2002:ac8:5810:: with SMTP id g16mr20453604qtg.135.1620626395819;
        Sun, 09 May 2021 22:59:55 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f7sm11951045qtm.41.2021.05.09.22.59.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 09 May 2021 22:59:55 -0700 (PDT)
Date:   Sun, 9 May 2021 22:59:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] ksm: Revert "use GET_KSM_PAGE_NOLOCK to get ksm page in
 remove_rmap_item_from_tree()"
Message-ID: <alpine.LSU.2.11.2105092253500.1127@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3e96b6a2e9ad929a3230a22f4d64a74671a0720b.
General Protection Fault in rmap_walk_ksm() under memory pressure:
remove_rmap_item_from_tree() needs to take page lock, of course.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/ksm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 5.13-rc1/mm/ksm.c	2021-05-09 17:03:44.010422188 -0700
+++ linux/mm/ksm.c	2021-05-09 22:12:39.403008350 -0700
@@ -776,11 +776,12 @@ static void remove_rmap_item_from_tree(s
 		struct page *page;
 
 		stable_node = rmap_item->head;
-		page = get_ksm_page(stable_node, GET_KSM_PAGE_NOLOCK);
+		page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
 		if (!page)
 			goto out;
 
 		hlist_del(&rmap_item->hlist);
+		unlock_page(page);
 		put_page(page);
 
 		if (!hlist_empty(&stable_node->hlist))
