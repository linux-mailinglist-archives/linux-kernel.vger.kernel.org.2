Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8CE3F55AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhHXCKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhHXCKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:10:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C886C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:09:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so778420pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08aO+jCRMsaJzTjrGQzurk0ey1pwgskCgL+V9erG5PI=;
        b=HacAj8LOl7rXmKqFsrgFe+j6OYcCwSQZdP2HTYoXSmWLDyG9Aame1o/kUZm1FFOJKC
         zjn0prjj4mbXFpbVrfgUhbZmo8owsR3RCcCYliysA5DZqi3ShKOsxriOCjCMvmxpw+GU
         qHSoj3azCT9cmRDoiZclndv7vDxFCTptKkN6oAep3+XvlH8LArGjt3R9bFKzRuGnMMDh
         O7yiV97xpJlIj88kx/nP10V3LHJxZmgJDfRHdSNReVlUBCLrIRlBMmy2ezz9jdd751vS
         coM+Ic+EDMjcSnl8QJere9pKGU7Yx4qFKsFLXy0SMd66LuK6Gmpt5xPQg6HAJjC5nEwT
         Rh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08aO+jCRMsaJzTjrGQzurk0ey1pwgskCgL+V9erG5PI=;
        b=GaqZtznKuX+K+eVhqq39z72dknnQ4kA9m/XKjpjMpJ5sBz4PujLxFO8BPsb0sOZWPz
         Tkqjs6IqXcGwwci+1kpuj1HbW46lmZ59wGGUdFSlUAQoVt79jMEMO4v7I+I8bBUUmjxT
         usI7zdmS8pMzO6GOTdUWQYA7ggnE+Ex9i/Vamh8GLpJon7bLLch0uyTvFtaN4jxURbbz
         8yfSqMRZr7BJbGdQuYLJMUGvkfOymzrYOwv3swg6MaUigAoY+0Ebx0muwaIBePgkkw2n
         63RDlhvMc5IK9BOW04gg4Cj8yRWT+us1jJTA4XRQ0jM4kK25p7qDZr7S78srxYI/TBbO
         xwIQ==
X-Gm-Message-State: AOAM532r1dnjKcWdBi2fXdVoXTwGAD0d2dKNLGLck5bqV0t4prwaYeEW
        Own+Eon887nSvX17HIc88yw=
X-Google-Smtp-Source: ABdhPJyGNV5HuEEKZxUHIsJX1mAeS/d7mg3XfPJq06DFfWLjzyKS6QJXiQyVdDwyEyX7QAHYbiNw7A==
X-Received: by 2002:a17:902:9b90:b029:12d:5ce1:4d99 with SMTP id y16-20020a1709029b90b029012d5ce14d99mr30701209plp.37.1629770994784;
        Mon, 23 Aug 2021 19:09:54 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id h16sm16830958pfn.215.2021.08.23.19.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 19:09:53 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, osalvador@suse.de, tdmackey@twitter.com,
        david@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Date:   Mon, 23 Aug 2021 19:09:46 -0700
Message-Id: <20210824020946.195257-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210824020946.195257-1-shy828301@gmail.com>
References: <20210824020946.195257-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently just very simple message is shown for unhandlable page, e.g.
non-LRU page, like:
soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()

It is not very helpful for further debug, calling dump_page() could show
more useful information.

Calling dump_page() in get_any_page() in order to not duplicate the call
in a couple of different places.  It may be called with pcp disabled and
holding memory hotplug lock, it should be not a big deal since hwpoison
handler is not called very often.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v3: * Remove redundant pr_info per Noaya Horiguchi

 mm/memory-failure.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7cfa134b1370..5f8249e4d7dc 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1228,6 +1228,9 @@ static int get_any_page(struct page *p, unsigned long flags)
 		ret = -EIO;
 	}
 out:
+	if (ret == -EIO)
+		dump_page(p, "hwpoison: unhandlable page");
+
 	return ret;
 }
 
@@ -2205,9 +2208,6 @@ int soft_offline_page(unsigned long pfn, int flags)
 			try_again = false;
 			goto retry;
 		}
-	} else if (ret == -EIO) {
-		pr_info("%s: %#lx: unknown page type: %lx (%pGp)\n",
-			 __func__, pfn, page->flags, &page->flags);
 	}
 
 	return ret;
-- 
2.26.2

