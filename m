Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2D3268BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhBZU2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhBZUTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:19:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EA6C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:18:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id i14so5023994pjz.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=FP++fkW38doZ9W2MYsX+Ulsxt6WryiBxofgzcF/5/4U=;
        b=Pu588gcoreQtwND83Deks/i9eB0usYHVKKnptjesTTx20IEpTyioW58+m/4Sgi/Cga
         ToQuxUfrD6KNDYF58y42Qfe7mDyf60sQ9QGyT4tHT6zeVsChJ1E1sscoKdKnE+U28/gb
         ZD7zBxAt4YIjYEf3dE+6k6FS/2kaWF9smvxp9cD9mOiuW/g0R/yjnUYD0hvlOu4SoPOu
         hac7YWq5b0tnnak9mMLatdaiinTs4xmzPC0vcMpu+8LcDAE/qurvRk7XoiljdaXejB7q
         4PJ7VBngaas9LwXmIRz3aQq4srO7QQ5e8+rvuRVVEPglJ3lNThs7iVTrQDOeSt7qlyb5
         Pv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=FP++fkW38doZ9W2MYsX+Ulsxt6WryiBxofgzcF/5/4U=;
        b=o1fup9EuOEURuVCs12Pa0WivElx2DIl8I6wU4JOabLdoLtAOsfrf/WLg4jM/Duyalg
         c5RY/KRAnsuwB48V0umSdonnZNOpmmVDsn153TmOCk0SPhSeDRlbQzkjML77qKioY7ZA
         mz+EscNscnZXz5ce2jPsaGCum6hhk10GF6uPMaFlFfalFPmcxcEd91cG3MKcc76piAIX
         xqs+3YgV8zozchanLSMbrucnqLmgfYkivY41W/qmVVBLBVkSo4ejzVtSbBJXojBZ3rNf
         6BWq4f1S4KFjfhTg1hm8Qs0PW0eHW3QQZQUxgwLz3Ghw0LQbyGiULz+QLAbsprJsy43H
         uaHQ==
X-Gm-Message-State: AOAM531LXx+8jsA1dYMwdWPS1CBrid3PNyb1SNdnpHyv9yt48jceASvq
        Pe12nrxPQsFNRkltj6VqMp+rOg==
X-Google-Smtp-Source: ABdhPJz2k7Wd54A2UtRRtpS+NGvOx76/1827VyL9ji5paADxoZbNJx9OLEmXkc7EX4mOqAmkNY2DqA==
X-Received: by 2002:a17:90b:1910:: with SMTP id mp16mr5067925pjb.0.1614370700158;
        Fri, 26 Feb 2021 12:18:20 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y6sm672139pfm.99.2021.02.26.12.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 12:18:19 -0800 (PST)
Subject: [PATCH 1/2] mm: Guard a use of node_reclaim_distance with CONFIFG_NUMA
Date:   Fri, 26 Feb 2021 12:17:20 -0800
Message-Id: <20210226201721.510177-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peterz@infradead.org, srikar@linux.vnet.ibm.com,
        valentin.schneider@arm.com, vbabka@suse.cz, mpe@ellerman.id.au,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     akpm@linux-foundation.org, atishp@atishpatra.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This is only useful under CONFIG_NUMA.  IIUC skipping the check is the
right thing to do here, as without CONFIG_NUMA there will never be any
large node distances on non-NUMA systems.

I expected this to manifest as a link failure under (!CONFIG_NUMA &&
CONFIG_TRANSPARENT_HUGE_PAGES), but I'm not actually seeing that.  I
think the reference is just getting pruned before it's checked, but I
didn't get that from reading the code so I'm worried I'm missing
something.

Either way, this is necessary to guard the definition of
node_reclaim_distance with CONFIG_NUMA.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 mm/khugepaged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a7d6cb912b05..b1bf191c3a54 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -819,8 +819,10 @@ static bool khugepaged_scan_abort(int nid)
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		if (!khugepaged_node_load[i])
 			continue;
+#ifdef CONFIG_NUMA
 		if (node_distance(nid, i) > node_reclaim_distance)
 			return true;
+#endif
 	}
 	return false;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

