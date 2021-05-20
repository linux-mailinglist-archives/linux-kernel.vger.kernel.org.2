Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0055F38AE95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbhETMls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbhETMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBC4C0611E0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso2525956wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJNYQv+xEA1wfp6mz1jq9VUq+K1lyhIQv7cIqEk5KA4=;
        b=L5+uuTl9s81pbCNn6vvaypz2XdCQ4hDo3FJlWN3y4wbJa4pQgupAeYIML8xfZ7YipD
         0cE7PcB0QCRdb4biUsuj6FkH0P/unI5faxjQZEDB1WcY9wheZSizWyqUh5MOq1gBUnhN
         tptbBZh6uSmSV7OPwSPbs39GxgIKbw8TeK4jAfgVfBG7rmLC539q0CKEZLvsvdkwygJx
         a3gi0rM0uz5VUW/DAas0xXbD7ZKAcGXUslY45RjOyJqtrDXdRpEAQz1JRdZi1nwcm1TR
         sHwUiSSlz2O+L0P89ZiIJ5Z277ynqdP2A2AaLbHqnWiVKymlz+LoKNzDDzOL3CIbm1lX
         8+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJNYQv+xEA1wfp6mz1jq9VUq+K1lyhIQv7cIqEk5KA4=;
        b=UvqwL8oa0QTMLm1nbg8lRnQetFTR0yUGL34LBxiYjheYhckY7PHlDqcBPbuxd60JZQ
         +z8gqDCCtVWZg1X7aG4pFuHpzNz5X+WOcq0PqOSJz/GJh+utZd4JXBOhIUfKMtZXw9In
         TYGKfYXPbMjJl0lmZsbV//yLfUiqUXKOpVACqGdDADSIyB70RsnJgUNgWbDKeH4727fy
         ONFv5tRJzC4PFySBZ+LbEHYJfllv2HlrUBgqLsOBxtI/oArpIAAdZcM89WmwIT0Nfw5Q
         EjqspNlQ/RRapDJkcIe6vheXAKfq+u90b41nrCkmi9kHkLLxb6nhp9QARNah4QQODifG
         7+8A==
X-Gm-Message-State: AOAM530n93WZPKJ4d5oXYMEWp8JRt0wGGrUpPb8wCpTGoeAKOa3c8VM5
        uynxJ/z3JwG3hZzPn/Li92fahA==
X-Google-Smtp-Source: ABdhPJzTmMB/tS2lgvkPwTkWWFlnUpaA0R/NZVga4amPvKQfGv4bMO7uNd/9j7jLe7nvz9MjY2WvMA==
X-Received: by 2002:a05:600c:35d3:: with SMTP id r19mr3685613wmq.3.1621512046307;
        Thu, 20 May 2021 05:00:46 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 01/15] fs: gfs2: bmap: Demote half-complete kernel-doc headers fix others
Date:   Thu, 20 May 2021 13:00:29 +0100
Message-Id: <20210520120043.3462759-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/bmap.c:1502: warning: Function parameter or member 'rd_gh' not described in 'sweep_bh_for_rgrps'
 fs/gfs2/bmap.c:1502: warning: Excess function parameter 'rg_gh' description in 'sweep_bh_for_rgrps'
 fs/gfs2/bmap.c:1671: warning: Function parameter or member 'sdp' not described in 'find_nonnull_ptr'
 fs/gfs2/bmap.c:1671: warning: Function parameter or member 'end_list' not described in 'find_nonnull_ptr'
 fs/gfs2/bmap.c:1671: warning: Function parameter or member 'end_aligned' not described in 'find_nonnull_ptr'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 0bcf11a9987ba..edf6004b643ac 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1658,7 +1658,7 @@ static bool mp_eq_to_hgt(struct metapath *mp, __u16 *list, unsigned int h)
 	return true;
 }
 
-/**
+/*
  * find_nonnull_ptr - find a non-null pointer given a metapath and height
  * @sdp: The superblock
  * @mp: starting metapath
-- 
2.31.1

