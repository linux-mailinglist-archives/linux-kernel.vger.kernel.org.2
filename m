Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29900402823
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbhIGMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhIGMAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:00:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF8C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 04:59:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d18so4558197pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=sYUQ9F7l7pmPrz+Pc22jn/gSKABFcngIahIwWGKuByQ=;
        b=ErIck/odkkfkqV9XKixNXrZJAZN2wyxh9z+s4tqf2BzncxxX1s7V8LHRMoNZAuuhGI
         32VJxdL0snxOcbDUVmgaRe9HArcAc0cXkz8LCbiSloI1onDtz9Fw0Z+QU1rOsmGnTaR/
         Y1MjId5gUVHKb3jNllnSoJMCWZSndhcOoZ4OddkUxlTpA21h8w9t+qt/iID4lKUW+D8r
         7ZUx4iHmkFDaJFSWMrcOUzhukiNRJXVx8atVXnsbEQBK5Oxjw+lOmkQ0xMGeBV1UOdPJ
         dCmg9vh+clk5XqzEAh019QGfj4WvSdFrm9x47Tsn6lCuNz+eW+1B3DLT4joWdWPUgkeP
         4DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=sYUQ9F7l7pmPrz+Pc22jn/gSKABFcngIahIwWGKuByQ=;
        b=gNQLOEt1IVADRrh5CcQkIZEITSi8qR3txsqMjLfUhWm/TWPykG5rh+SQ/FitMFFJ3Y
         YgnzgWHzD7LUkPeMWWulVNDZ6JbjY3ZgugOWzgjXa7nEyAxWh9rtZhuYyBtZX5zC2hi8
         MifpzD3f/oR+W8jqCjerYmV/GCWcpdOzVsWnok+InyitAwxVdicLWI6NQcZJYUghlV3u
         s0NiHSrgnx2n5LqzhYJTPNFMQBSo2TqTd5fHn+TNmghzERxx3EaKuKTwrpfhpQpnKwAn
         Zjzr0N825empJ5ttrGc+S1WVjW1minGhXmzoluRXa7v8X/JS6PS2ASY0EHSSb2R6dTP/
         J2DA==
X-Gm-Message-State: AOAM531Gl/RtUGEnQzV0wZZwtV0udYYmY5yS8OyH4vqhK0NT6Vqz9bq8
        +udbQE9iQYwPsiSYUAO/dvg=
X-Google-Smtp-Source: ABdhPJwVtSRTduJSH6W2JVWrqJgeIYP/47FiFiiAbpAgDOhcco4Mssx19K03DA+Cu6bpqlgRUNX5Ew==
X-Received: by 2002:a17:902:e793:b0:138:f941:e2d7 with SMTP id cp19-20020a170902e79300b00138f941e2d7mr14680711plb.67.1631015985002;
        Tue, 07 Sep 2021 04:59:45 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x75sm13660290pgx.43.2021.09.07.04.59.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 04:59:44 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm : bail out from psi memstall after submit_bio in swap_readpage
Date:   Tue,  7 Sep 2021 19:59:28 +0800
Message-Id: <1631015968-9779-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

It doesn't make sense to count IO time into psi memstall. Bail out after
bio submitted.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/page_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index c493ce9..1d131fc 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -423,6 +423,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	count_vm_event(PSWPIN);
 	bio_get(bio);
 	qc = submit_bio(bio);
+	psi_memstall_leave(&pflags);
 	while (synchronous) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio->bi_private))
@@ -433,7 +434,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 	__set_current_state(TASK_RUNNING);
 	bio_put(bio);
-
+	return ret;
 out:
 	psi_memstall_leave(&pflags);
 	return ret;
-- 
1.9.1

