Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA5934701C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhCXD1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhCXD11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:27:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33823C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 20:27:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f17so7193185plr.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 20:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jqtueh3KoN49KTSBstyT2fS2WeP64rLOI7hS8K0Vek4=;
        b=bZuYsqQodWT0uNeJFvyXuHOy9/s+dexsuV/kg3MmW2JkKblQFlTkqax14YflKb0eB+
         rf7Ut3mlA1+GzJYF96Sg7eT0OtV8oSNJv1/9cH6erkPnNGH/u1PWC6KJ0BeygvCUXYgf
         R6Y6IYMtMkBxvquhAImpClDjuIH2CO6NsT0Z8bfsuKxTxw0ze0rYZNrIylYvKo+eSdWb
         jSxjVDHt6Z9z/WstB2cTkOJxxN844Yw/Cv2Kphl60C/gik64Y3RgjGqL7nAsE61bBdiA
         74p7LVOq8Lt2kt8S61ish97LtxJuQCWvzBuNcpZFmffxgJ4BrkKBE8hk152kEOpk22ZH
         k+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jqtueh3KoN49KTSBstyT2fS2WeP64rLOI7hS8K0Vek4=;
        b=c1sfHDRB4obpESactELAOK+PQCqiJpVg86hr9EX0KsSPEYV24nWk9WRemCnYf34u0w
         XDCKyUQVyBDthsq4uQ1brwpfe6BpxTD3yuz/eDuzVJEehNUIWXsb91LrFsRdQ8uCAh6E
         i6EoRgzjr8e6CPvx/nScUzMDphbqe7CGw9+7eLkTEveMXbJSUmYyzE6mi9EKDt38v2NU
         6aMZniHxQV26JwPs0OB82T5epxcADMCNfxOF5noOgVIZ3rzapGqePBK636mZwOQanfqV
         OuMLUE2VzAIEVXutWZn9YIIvm9uHxt4ZeY87eK31Izu+A0qarvGSbcPMlPTiOKIg2wVN
         1HNg==
X-Gm-Message-State: AOAM532Vz/nP1R2w6i4NvwK8FsnIG1mQ/NtIPJSfHp785ufhcrVKZDdh
        JMqnFoWpt2oLfRn/bYE1Ruw=
X-Google-Smtp-Source: ABdhPJxim1UvaXycZbLtKnyN3NyeBl6rOJ0elNbZm+YANxqbAtVQOnk4evdhGGe8hNwxXQUiHEReBA==
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id z2-20020a170902ee02b02900e65397d79cmr1609655plb.21.1616556446586;
        Tue, 23 Mar 2021 20:27:26 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id a144sm555787pfd.200.2021.03.23.20.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 20:27:25 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 23 Mar 2021 20:27:23 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, willy@infradead.org,
        digetx@gmail.com
Subject: Re: [PATCH v6] mm: cma: support sysfs
Message-ID: <YFqxm7UQBtWqH6VU@google.com>
References: <20210324010547.4134370-1-minchan@kernel.org>
 <cbe10402-6574-6e46-9fd9-98b503bd26a4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe10402-6574-6e46-9fd9-98b503bd26a4@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 07:34:12PM -0700, John Hubbard wrote:
> On 3/23/21 6:05 PM, Minchan Kim wrote:
> ...> diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
> > new file mode 100644
> > index 000000000000..c3791a032dc5
> > --- /dev/null
> > +++ b/mm/cma_sysfs.c
> > @@ -0,0 +1,107 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * CMA SysFS Interface
> > + *
> > + * Copyright (c) 2021 Minchan Kim <minchan@kernel.org>
> > + */
> > +
> > +#include <linux/cma.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +
> > +#include "cma.h"
> > +
> > +void cma_sysfs_account_success_pages(struct cma *cma, size_t count)
> > +{
> > +	atomic64_add(count, &cma->nr_pages_succeeded);
> > +}
> > +
> > +void cma_sysfs_account_fail_pages(struct cma *cma, size_t count)
> > +{
> > +	atomic64_add(count, &cma->nr_pages_failed);
> > +}
> > +
> > +#define CMA_ATTR_RO(_name) \
> > +	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
> > +
> > +#define to_cma_kobject(x) container_of(x, struct cma_kobject, kobj)
> 
> I really don't think that helps. container_of() is so widely used and
> understood that it is not a good move make people read one more wrapper
> for it. Instead, see below...
> 
> > +
> > +static ssize_t alloc_pages_success_show(struct kobject *kobj,
> > +					struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct cma_kobject *cma_kobj = to_cma_kobject(kobj);
> > +	struct cma *cma = cma_kobj->cma;
> 
> ...if you're looking to get rid of the real code duplication, then you
> could put *both* of those lines into a wrapper function, instead, like this:
> 
> static inline struct cma* cma_from_kobj(struct kobject *kobj)
> {
> 	struct cma_kobject *cma_kobj = container_of(kobj, struct cma_kobject,
> 						    kobj);
> 	struct cma *cma = cma_kobj->cma;
> 
> 	return cma;
> }
> 
> static ssize_t alloc_pages_success_show(struct kobject *kobj,
> 					struct kobj_attribute *attr, char *buf)
> {
> 	struct cma *cma = cma_from_kobj(kobj);
> 
> 	return sysfs_emit(buf, "%llu\n",
> 			  atomic64_read(&cma->nr_pages_succeeded));
> }
> CMA_ATTR_RO(alloc_pages_success);
> 
> static ssize_t alloc_pages_fail_show(struct kobject *kobj,
> 				     struct kobj_attribute *attr, char *buf)
> {
> 	struct cma *cma = cma_from_kobj(kobj);
> 
> 	return sysfs_emit(buf, "%llu\n", atomic64_read(&cma->nr_pages_failed));
> }
> CMA_ATTR_RO(alloc_pages_fail);
> 
> static void cma_kobj_release(struct kobject *kobj)
> {
> 	struct cma_kobject *cma_kobj = container_of(kobj, struct cma_kobject,
> 						    kobj);
> 	struct cma *cma = cma_kobj->cma;
> 
> 	kfree(cma_kobj);
> 	cma->kobj = NULL;
> }
> 
> ...isn't that nicer? Saves a little code, gets rid of a macro.

Yub.

> 
> > +
> > +	return sysfs_emit(buf, "%llu\n",
> > +			  atomic64_read(&cma->nr_pages_succeeded));
> > +}
> > +CMA_ATTR_RO(alloc_pages_success);
> > +
> > +static ssize_t alloc_pages_fail_show(struct kobject *kobj,
> > +				     struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct cma_kobject *cma_kobj = to_cma_kobject(kobj);
> > +	struct cma *cma = cma_kobj->cma;
> > +
> > +	return sysfs_emit(buf, "%llu\n", atomic64_read(&cma->nr_pages_failed));
> > +}
> > +CMA_ATTR_RO(alloc_pages_fail);
> > +
> > +static void cma_kobj_release(struct kobject *kobj)
> > +{
> > +	struct cma_kobject *cma_kobj = to_cma_kobject(kobj);
> > +	struct cma *cma = cma_kobj->cma;
> > +
> > +	kfree(cma_kobj);
> > +	cma->kobj = NULL;
> > +}
> > +
> > +static struct attribute *cma_attrs[] = {
> > +	&alloc_pages_success_attr.attr,
> > +	&alloc_pages_fail_attr.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(cma);
> > +
> > +static struct kobject *cma_kobj_root;
> > +
> > +static struct kobj_type cma_ktype = {
> > +	.release = cma_kobj_release,
> > +	.sysfs_ops = &kobj_sysfs_ops,
> > +	.default_groups = cma_groups
> > +};
> > +
> > +static int __init cma_sysfs_init(void)
> > +{
> > +	unsigned int i;
> > +
> > +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> > +	if (!cma_kobj_root)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < cma_area_count; i++) {
> > +		int err;
> > +		struct cma *cma;
> > +		struct cma_kobject *cma_kobj;
> > +
> > +		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
> > +		if (!cma_kobj) {
> > +			kobject_put(cma_kobj_root);
> > +			return -ENOMEM;
> 
> This leaks little cma_kobj's all over the floor. :)

I thought kobject_put(cma_kobj_root) should deal with it. No?

> 
> What you might want here is a separate routine to clean up, because
> it has to loop through and free whatever was allocated on previous
> iterations of this loop here.
> 
> > +		}
> > +
> > +		cma = &cma_areas[i];
> > +		cma->kobj = cma_kobj;
> > +		cma_kobj->cma = cma;
> > +		err = kobject_init_and_add(&cma_kobj->kobj, &cma_ktype,
> > +					   cma_kobj_root, "%s", cma->name);
> > +		if (err) {
> > +			kobject_put(&cma_kobj->kobj);
> > +			kobject_put(cma_kobj_root);
> > +			return err;
> 
> Hopefully this little bit of logic could also go into the cleanup
> routine.
> 
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +subsys_initcall(cma_sysfs_init);
> > 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
