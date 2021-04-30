Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5885136F569
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 07:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhD3FmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 01:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhD3FmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 01:42:11 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 22:41:22 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id x27so33873952qvd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Zx8pZdhiNX5aPOyXUOIzWq8zYQHmuVtq5hGUZrL+hxk=;
        b=leXLFTKdISvneTcPmvgUXPy0vucswWlGanD1F9s2b2AM5ZlSIVmek08Oc6xCvLso+i
         SdFwKFSs0p3/a0i1XzlDr/VTxcPgVkORFyoRglFCTeGrRFseFEJ+CxlNWsvKUSJXuj29
         e2usBGYSeWD10SugISYejx9upWSBnBuzwpRZSo5jq7Kyif963vjzwqVdy+G2OMJsuAIY
         AMax8Z5vPcJOaLCzLCIgM2y5pYstLLiJMIKgGWoto6LU7i998eaIsejstUfW6WVQ2dsA
         gJyujCd7bfz6Q8RZH3JjXzcVN0TCeMNA46pWSoZitsTFYxkzrDpr00mzSd75n/k3JNmg
         1JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Zx8pZdhiNX5aPOyXUOIzWq8zYQHmuVtq5hGUZrL+hxk=;
        b=SVJdQ5PrkEET3Lc9EzIcYAJiaXU/uqHndX6wKmoksAEM9AuIX3FjqhdnxgtYprmNt2
         AnBj5nWW8Thkgi7PZqGimO2pVxTYvlBOoMQc1qMzBl1bvRec4acVyswSX/P/kiFskqI4
         Dd6K9Yg1t81kC7n5ExV2v8HmORyajc3vZdsXUGPdSYvnZrLqXfrrZGCIFVOrBr39saIH
         0gK+rDGHOD1eBuWpq3OtkXSg0hdxh4EUzjzejxdWjCshUB7py8YuB1fCelVTW65s7DbG
         5MnqG7COWwMlkLcZLz0Bamvu48OSC1RzPbNKu0uR/yI66OoCe3In7tNGG4mkmiLEWxgB
         Vk3g==
X-Gm-Message-State: AOAM531/GHp6p+Zhmv2LU7BKxQ+NqCWH3RqPsk7PM43jzRJe4uDU0u1G
        tvoiQgBlB1lxIYJfBz7Lwm/hRg==
X-Google-Smtp-Source: ABdhPJzY13DAJCoJ5dcDvmbdoiHlkA74Mjnt1G1gxrRT/Of1Bop6wAym2XmFy51k0T+0YZ2pDLUGsg==
X-Received: by 2002:a0c:e242:: with SMTP id x2mr3422063qvl.45.1619761281109;
        Thu, 29 Apr 2021 22:41:21 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a24sm672835qkn.104.2021.04.29.22.41.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 29 Apr 2021 22:41:20 -0700 (PDT)
Date:   Thu, 29 Apr 2021 22:41:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
In-Reply-To: <20210429211634.de4e0fb98d27b3ab9d05757c@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2104292229380.16080@eggly.anvils>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils> <20210331024913.GS351017@casper.infradead.org> <alpine.LSU.2.11.2103311413560.1201@eggly.anvils> <20210401170615.GH351017@casper.infradead.org> <20210402031305.GK351017@casper.infradead.org>
 <20210402132708.GM351017@casper.infradead.org> <20210402170414.GQ351017@casper.infradead.org> <alpine.LSU.2.11.2104021239060.1092@eggly.anvils> <alpine.LSU.2.11.2104021354150.1029@eggly.anvils>
 <20210429211634.de4e0fb98d27b3ab9d05757c@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021, Andrew Morton wrote:
> 
> I'm not sure this ever was resolved?

It was not resolved: Matthew had prospective fixes for one way in which
it could happen, but they did not help the case which still hits my
testing (well, I replace the BUG_ON by a WARN_ON, so not hit badly).

> 
> Is it the case that the series "Remove nrexceptional tracking v2" at
> least exposed this bug?

Yes: makes a BUG out of a long-standing issue not noticed before.

> 
> IOW, what the heck should I do with
> 
> mm-introduce-and-use-mapping_empty.patch
> mm-stop-accounting-shadow-entries.patch
> dax-account-dax-entries-as-nrpages.patch
> mm-remove-nrexceptional-from-inode.patch

If Matthew doesn't have a proper fix yet (and it's a bit late for more
than an obvious fix), I think those should go in, with this addition:

[PATCH] mm: remove nrexceptional from inode: remove BUG_ON

clear_inode()'s BUG_ON(!mapping_empty(&inode->i_data)) is unsafe: we know
of two ways in which nodes can and do (on rare occasions) get left behind.
Until those are fixed, do not BUG_ON() nor even WARN_ON(). Yes, this will
then leak those nodes (or the next user of the struct inode may use them);
but this has been happening for years, and the new BUG_ON(!mapping_empty)
was only guilty of revealing that. A proper fix will follow, but no hurry.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 fs/inode.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- mmotm/fs/inode.c	2021-04-22 18:30:46.285908982 -0700
+++ linux/fs/inode.c	2021-04-29 22:13:54.096530691 -0700
@@ -529,7 +529,14 @@ void clear_inode(struct inode *inode)
 	 */
 	xa_lock_irq(&inode->i_data.i_pages);
 	BUG_ON(inode->i_data.nrpages);
-	BUG_ON(!mapping_empty(&inode->i_data));
+	/*
+	 * Almost always, mapping_empty(&inode->i_data) here; but there are
+	 * two known and long-standing ways in which nodes may get left behind
+	 * (when deep radix-tree node allocation failed partway; or when THP
+	 * collapse_file() failed). Until those two known cases are cleaned up,
+	 * or a cleanup function is called here, do not BUG_ON(!mapping_empty),
+	 * nor even WARN_ON(!mapping_empty).
+	 */
 	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.private_list));
 	BUG_ON(!(inode->i_state & I_FREEING));
