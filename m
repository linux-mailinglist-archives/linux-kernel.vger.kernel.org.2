Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8121D37C098
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhELOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhELOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:48:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:47:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t11so840992pjm.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ETqsrv1jzN5EGAkkcRRQ5nZ0wEonlAPtIWyZWxP7xo8=;
        b=ltDzcLn0aP1VqK+owmm2BBYuZjyYqFObprD+vA5zzaBLfAgFSS08UcKeoPRvXx515h
         GGhwxc2TdR2zqp775HMciphgccxbGrWEXw7ow0QuIh3ngYWxTu4T2DEabcUYUC/NPeme
         yfKaHsca86gr9XVJSIjnZcUKU5+TePpF0QrgDaVLp4FJYFgF9Z7vskF9Kl7OCGMoDV0W
         OJnQjttpYnde4dE8BY90udSI+UQz/QsBG68CruD4qM8LNYwLA1kv+seKQTzwwbH8WHBD
         FAODLdtFz9wXcxxxt5gZ6FuPz/cjRrRv5dvPCqZCPUuQTTP6GGRF1gJrXd9FvpnhnULW
         3j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ETqsrv1jzN5EGAkkcRRQ5nZ0wEonlAPtIWyZWxP7xo8=;
        b=FkXsY9VyCBUK1ZEiaMvGc7nKpkR7u+MiznsXhtvaLZjTb8ujZSy7DxJU2KCUvqeuVd
         /KSJBZhzF2jRQOq2eKlutbpgC22UiZ0cSljhEZxMYldYWDZAY+ruuoaiow6zvGFsvOrL
         6uRi2oJ4m9BwHWg825BikIaxxjKDccGR8SJgaGXOql+GIij7OIR2P2ap0EYj8iR75mZZ
         8HVpAkh67gAK8ou41N2W6be9mMwtXscRyQ5N8iKQW0Q7scdl0SWQE/pMD+9d5dkcm9GR
         guaGauMJ33WxEsZVwawQmmf3r5AQXK0rHPJMTgs3Q1xUCt8xEgze5ah9lZOXey9FINOn
         w/VA==
X-Gm-Message-State: AOAM533MNBwT5buWhkuVMYDCJ0zxS1kTO0JQlePMrrRNpwoV+nceWksJ
        L/KDOdOoNDJEFqSDAL/uetc=
X-Google-Smtp-Source: ABdhPJwv951ishoPEC4jhNH4EaSWywMEJopdfEnqAZ3ngx2xh6hzO6ZeGJEvW+tsTj8ESVWGDemzow==
X-Received: by 2002:a17:902:d213:b029:ed:35bb:271b with SMTP id t19-20020a170902d213b02900ed35bb271bmr35526994ply.71.1620830868593;
        Wed, 12 May 2021 07:47:48 -0700 (PDT)
Received: from wuchi.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id v130sm127786pfc.25.2021.05.12.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 07:47:48 -0700 (PDT)
From:   Chi Wu <wuchi.zero@gmail.com>
To:     akpm@linux-foundation.org
Cc:     axboe@fb.com, hcochran@kernelspring.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mszeredi@redhat.com, sedat.dilek@gmail.com, tj@kernel.org,
        Chi Wu <wuchi.zero@gmail.com>
Subject: [PATCH] mm/page-writeback: Use __this_cpu_inc() in account_page_dirtied()
Date:   Wed, 12 May 2021 22:47:42 +0800
Message-Id: <20210512144742.4764-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As account_page_dirtied() was always protected by xa_lock_irqsave(),
so using __this_cpu_inc() is better.

Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0062d5c57d41..e3901d0d329e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2436,7 +2436,7 @@ void account_page_dirtied(struct page *page, struct address_space *mapping)
 		inc_wb_stat(wb, WB_DIRTIED);
 		task_io_account_write(PAGE_SIZE);
 		current->nr_dirtied++;
-		this_cpu_inc(bdp_ratelimits);
+		__this_cpu_inc(bdp_ratelimits);
 
 		mem_cgroup_track_foreign_dirty(page, wb);
 	}
-- 
2.17.1

