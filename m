Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03608347130
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 06:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhCXFon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 01:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhCXFoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 01:44:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FB4C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 22:44:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so591646pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vZyzdZb7zClnWDp32yie1Io/7W63y0skPKX8iMwls/I=;
        b=FK9lVBFUYOCv1pVKWo5qZKBE7q5MZdByu7qUuLKc+azdMNFbGKAJUs9+SM5AKQa0l4
         tvePM4g+hmsChf/du3SKhKtoSnkmc+l/QklFMrrsgvx1hFPVmrE9uZ34B3yk5XWZz7Nc
         7zHFXMjI79KywH+FltRITP6LxldrBo1a6WsRwiRUUvjrGGwCX45ssmmKunuiL3i6tlfL
         7iskn1Z28173rlaVxT00kO/WluYYHHZgZiS0fqBKvXL7h/LhStzSwWnlPiW4hqLcGyAm
         6iubQAWD8jc9WZK4Vk9CLE1iPhljsKHkIFT5kM24G4sB7CewxYIrE6d+DASSeGoZHdFO
         PjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vZyzdZb7zClnWDp32yie1Io/7W63y0skPKX8iMwls/I=;
        b=AnHL8lNwpuZ5tzDHt2rgcYvMP/9s/3nc/khcLFDOATYrKVnP109M/71a2Kb15FKkdL
         2ep8bAQWIMy1mlrLZpMehObjTCfBdzoJ0lGKv4NVVRrO4XakJZqaIQDKcyE30XBAxaf5
         sZABWaeaJ7IYS2wLUkBrZCZ8jbUr7bVE9uFWzfHJXfe0g+Pd4MF8Zks8k5ccjaH/q7w0
         cnVEGV/js/JiadN48EnfZnYEtwHabLjH8j5VXtpss+SRKPgIPkirBBI5/QwHMiDNgx1g
         QrWrkGIHIogmqvBcJ9aCKQNfJvjgxFUyMqYKHKf+WyEBGbvEYqAmWQwBrbE51W3YRWW1
         WygQ==
X-Gm-Message-State: AOAM533/1gI2d84smViVuEQWQONnuUJf1yVpOEbTFFFEiu4YtRLZL9DE
        P8+HYWw3Upr4v54CfzBlR34=
X-Google-Smtp-Source: ABdhPJyzIF43r33U3LY2waAoqsy4NnUMSYlMYaSs310IbR5TDbHauQR0UJ4Teis3BamXoBW69N579Q==
X-Received: by 2002:a17:90b:3884:: with SMTP id mu4mr1722306pjb.128.1616564669395;
        Tue, 23 Mar 2021 22:44:29 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id d8sm1013356pfq.27.2021.03.23.22.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 22:44:28 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 23 Mar 2021 22:44:26 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, willy@infradead.org,
        digetx@gmail.com
Subject: Re: [PATCH v6] mm: cma: support sysfs
Message-ID: <YFrRugjVLlazTNPy@google.com>
References: <20210324010547.4134370-1-minchan@kernel.org>
 <cbe10402-6574-6e46-9fd9-98b503bd26a4@nvidia.com>
 <YFqxm7UQBtWqH6VU@google.com>
 <d224c6bd-f5b1-74f6-2afc-c3d5b0519ba4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d224c6bd-f5b1-74f6-2afc-c3d5b0519ba4@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:47:27PM -0700, John Hubbard wrote:
> On 3/23/21 8:27 PM, Minchan Kim wrote:
> ...
> > > > +static int __init cma_sysfs_init(void)
> > > > +{
> > > > +	unsigned int i;
> > > > +
> > > > +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> > > > +	if (!cma_kobj_root)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	for (i = 0; i < cma_area_count; i++) {
> > > > +		int err;
> > > > +		struct cma *cma;
> > > > +		struct cma_kobject *cma_kobj;
> > > > +
> > > > +		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
> > > > +		if (!cma_kobj) {
> > > > +			kobject_put(cma_kobj_root);
> > > > +			return -ENOMEM;
> > > 
> > > This leaks little cma_kobj's all over the floor. :)
> > 
> > I thought kobject_put(cma_kobj_root) should deal with it. No?
> > 
> If this fails when i > 0, there will be cma_kobj instances that
> were stashed in the cma_areas[] array. But this code only deletes
> the most recently allocated cma_kobj, not anything allocated on
> previous iterations of the loop.

Oh, I misunderstood that destroying of root kobject will release
children recursively. Seems not true. Go back to old version.


index 16c81c9cb9b7..418951a3f138 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -80,20 +80,19 @@ static struct kobj_type cma_ktype = {
 static int __init cma_sysfs_init(void)
 {
        unsigned int i;
+       int err;
+       struct cma *cma;
+       struct cma_kobject *cma_kobj;

        cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
        if (!cma_kobj_root)
                return -ENOMEM;

        for (i = 0; i < cma_area_count; i++) {
-               int err;
-               struct cma *cma;
-               struct cma_kobject *cma_kobj;
-
                cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
                if (!cma_kobj) {
-                       kobject_put(cma_kobj_root);
-                       return -ENOMEM;
+                       err = -ENOMEM;
+                       goto out;
                }

                cma = &cma_areas[i];
@@ -103,11 +102,21 @@ static int __init cma_sysfs_init(void)
                                           cma_kobj_root, "%s", cma->name);
                if (err) {
                        kobject_put(&cma_kobj->kobj);
-                       kobject_put(cma_kobj_root);
-                       return err;
+                       goto out;
                }
        }

        return 0;
+out:
+       while (--i >= 0) {
+               cma = &cma_areas[i];
+
+               kobject_put(&cma->kobj->kobj);
+               kfree(cma->kobj);
+               cma->kobj = NULL;
+       }
+       kobject_put(cma_kobj_root);
+
+       return err;
 }
 subsys_initcall(cma_sysfs_init);



