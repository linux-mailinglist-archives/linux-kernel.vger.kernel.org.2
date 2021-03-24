Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77439348436
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhCXVzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbhCXVzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:55:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D6BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:55:17 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id l1so15678451pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wXYRQi+4Ua6dJ+RlkFOgEs3wMt45QU3vsQsKu6v7/e0=;
        b=jID9UGQgQc9JY2nHQbuDNioFRtqow14sa55mHg8r21Vmr003XsHJpUqz9UniBwygKt
         y04vTqMukhaO8pc6SGZCfrW2CphWNbs76ZEyQEmrjS+q0+RM4sqD3gFfWvS8dl/BbmVe
         yZtqwE8LHr3qQGDLDBY9g8R/Xk9e/b+keQowEW3deQo6UX+7AqVisl0d462XlbFwgRi1
         Kx1sIFupO/FRR35FycxL4kjEBInIm3guoDL3MPYJ9t/WmHRWuKlUVDC1g5R3UqZMmVRB
         TAaytiJTQ6cGIKkrruh5KoDa1G6h63RrBqGcSQtDSX4TsLmUHbX3ZPcYujE9g/6DTHPt
         QCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=wXYRQi+4Ua6dJ+RlkFOgEs3wMt45QU3vsQsKu6v7/e0=;
        b=bXl5571NHiyr4vBTY7aIzQzVHULCNumPrnNhxQ/6F7p1iureuj1mRDqQvER5NGxKac
         KyRyA5EKT85ST5RyRfYAOMzrYOvBzX25dZ91vsD2fssCz2Qs/4r9L389+hwoyf4OkWoY
         JP5gATuJy1RKMb6TuS9/TUT1sWFECyjUrjP+aM498/xg1vnMf8kVG3RLsTBJLcOkIoCb
         PKSQxTUVAd1eOk4/+GRRrrHRjqoIAnN17EkEVzzKoW1iI8mQl9U1wJO6EoK7L8OqQ9Sz
         2w5uNg6ijvw0+IYMAzHRkYC6yf46GoHLYawmcIefGiGcV2fyDe7Wl5heCxsFDsKCGu9V
         b5vQ==
X-Gm-Message-State: AOAM530T6f9OwOS8lgYH940sIEX+UZh4rzz90C8Jgpu6rdlPnWiNr6Xo
        8rGoFsCtZHQ3YYtCu9FuqCQ=
X-Google-Smtp-Source: ABdhPJzWxUI8dDNb680lACSnDlagTQlM8wr2Dv/9QmxM0cwMKN/KP2NKF7wudnR5ihBdfJ7DMWV0ZQ==
X-Received: by 2002:a17:903:1cc:b029:e6:f37a:2185 with SMTP id e12-20020a17090301ccb02900e6f37a2185mr5636836plh.67.1616622917204;
        Wed, 24 Mar 2021 14:55:17 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id l20sm3653490pfd.82.2021.03.24.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:55:16 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 24 Mar 2021 14:55:14 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org, Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v7] mm: cma: support sysfs
Message-ID: <YFu1QoiPEnAOAvXS@google.com>
References: <20210324205503.2132082-1-minchan@kernel.org>
 <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 12:31:51AM +0300, Dmitry Osipenko wrote:
> 24.03.2021 23:55, Minchan Kim пишет:
> > Since CMA is getting used more widely, it's more important to
> > keep monitoring CMA statistics for system health since it's
> > directly related to user experience.
> > 
> > This patch introduces sysfs statistics for CMA, in order to provide
> > some basic monitoring of the CMA allocator.
> > 
> >  * the number of CMA page successful allocations
> >  * the number of CMA page allocation failures
> > 
> > These two values allow the user to calcuate the allocation
> > failure rate for each CMA area.
> > 
> > e.g.)
> >   /sys/kernel/mm/cma/WIFI/alloc_pages_[success|fail]
> >   /sys/kernel/mm/cma/SENSOR/alloc_pages_[success|fail]
> >   /sys/kernel/mm/cma/BLUETOOTH/alloc_pages_[success|fail]
> > 
> > The cma_stat was intentionally allocated by dynamic allocation
> > to harmonize with kobject lifetime management.
> > https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/
> > 
> > Reported-by: Dmitry Osipenko <digetx@gmail.com>
> > Tested-by: Dmitry Osipenko <digetx@gmail.com>
> > Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> 
> The tags are incorrect, I haven't suggested this change.

During the development, you have suggested many things
to make it clean. That suggested-by couldn't represent
all the detail but wanted to give credit for you, too
since you spent the time to make it better.

Okay, since you didn't like it, I will remove it.

> 
> > Suggested-by: John Hubbard <jhubbard@nvidia.com>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> > Addresses-Coverity: ("Dereference after null check")
> 
> There are no dereferences fixed by this patch.

Let me add this:
https://lore.kernel.org/linux-mm/20210316100433.17665-1-colin.king@canonical.com/

> 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> ...
> 
> >  #include <linux/debugfs.h>
> > +#include <linux/kobject.h>
> > +
> > +struct cma_kobject {
> > +	struct cma *cma;
> > +	struct kobject kobj;
> 
> If you'll place the kobj as the first member of the struct, then
> container_of will be a no-op.

Cool.

> 
> ...
> > +#include <linux/cma.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +
> > +#include "cma.h"
> > +
> > +void cma_sysfs_account_success_pages(struct cma *cma, unsigned long nr_pages)
> > +{
> > +	atomic64_add(nr_pages, &cma->nr_pages_succeeded);
> > +}
> > +
> > +void cma_sysfs_account_fail_pages(struct cma *cma, unsigned long nr_pages)
> > +{
> > +	atomic64_add(nr_pages, &cma->nr_pages_failed);
> > +}
> > +
> > +#define CMA_ATTR_RO(_name) \
> > +	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
> 
> nit: #defines and inlined helpers typically are placed at the top of the
> code, after includes.

No problem since I should resend anyway.

> 
> > +static inline struct cma *cma_from_kobj(struct kobject *kobj)
> > +{
> > +	struct cma_kobject *cma_kobj = container_of(kobj, struct cma_kobject,
> > +						    kobj);
> > +	struct cma *cma = cma_kobj->cma;
> > +
> > +	return cma;
> 
> nit: you can write this as:
> 
> return container_of(kobj, struct cma_kobject, kobj)->cma;

Better.

> 
> > +}
> > +
> > +static ssize_t alloc_pages_success_show(struct kobject *kobj,
> > +					struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct cma *cma = cma_from_kobj(kobj);
> > +
> > +	return sysfs_emit(buf, "%llu\n",
> > +			atomic64_read(&cma->nr_pages_succeeded));
> 
> nit: Algnment isn't right, should be better to write it as single line, IMO.

Let me make it align rather than single line since I know someone
who keep asking us to not overflow 80 columns unless it's special.

> 
> ...
> > +static int __init cma_sysfs_init(void)
> > +{
> > +	struct kobject *cma_kobj_root;
> > +	struct cma_kobject *cma_kobj;
> > +	struct cma *cma;
> > +	int i, err;
> > +
> > +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> > +	if (!cma_kobj_root)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < cma_area_count; i++) {
> > +		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
> > +		if (!cma_kobj) {
> > +			err = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		cma = &cma_areas[i];
> > +		cma->cma_kobj = cma_kobj;
> > +		cma_kobj->cma = cma;
> > +		err = kobject_init_and_add(&cma_kobj->kobj, &cma_ktype,
> > +				cma_kobj_root, "%s", cma->name);
> 
> nit: Previousy algnment of the code was better here.

Yub.

> 
> Otherwise this is okay to me:
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

Thanks!
