Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC231A328
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhBLQ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhBLQ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:58:17 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13715C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 08:57:37 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t25so37413pga.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 08:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j0f03PK7GpTXsoMAjMSZo8qzT7Rprl+gDFpZEiQtFEY=;
        b=shPRqUeD7cEszA8IFpWRo86aOhjMemihjFV1otzV2J8JXPwqBklBTU4EhTzr/uWjHH
         z5vphRmF5sg9+UuWzMgmXxwSDexQ+0cjgwjdTkz6gXoqCqL0KwlBhAZzaQAqui51qaar
         WSFe7M5v1z86lVmliX6J+yKPlBNJWDYAhnjPkEphqOF3ZlAl+3jNkpSFzJoKCG43Hmgg
         xu+cq4a2715b3TD1gCuRHATgCQfVXeU+SNbGOqeKDxhqn34uoV5cLDbEzvcgDg7AL/qy
         PkA3nySA1vKvcZUwl8JU+kw+sJhyEsWrghAKJ1yoL4ZW5Xv73ZitZGWkfwBFYARWaHUI
         SheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j0f03PK7GpTXsoMAjMSZo8qzT7Rprl+gDFpZEiQtFEY=;
        b=kfvoy7KxLsze7ugzBOPGouSHCVJpBDK3ZGc0n+s3sy3KCDVB7pJKCy0RLrbVtsxyNa
         kDW433M8bstWw8a9O9hxXKn4NSS2cSMkotM5fIJurnPan+Lgb8mqLsTsOkvb8SM0yzuy
         A7NN7G96218aRcdqDUhrmPRqOQHZj2ExwEKyxm8eHv0dVQsDa/sKH+o6L6/BMaVQGUPN
         iP/ULaIeNcI/hnI+s9gfWo1zVJEau24NUwH/zedChwRDXjzEJEtGSV6MMd+fXjw6aGUJ
         GcBVh2Ujtv3/tKLE9zU11pprvqJm11ZWa6UHtHXHFHOEccWJXBPA4ksBIA69Ml+Ag/UH
         7ZFw==
X-Gm-Message-State: AOAM533v1yCC0LsmfjDdLRTBgSYlPu+nvVfdCLObgnlAeuUZvTv8V7nB
        Kmg5oRuHeG2SzCQWG2y5wSE7vg==
X-Google-Smtp-Source: ABdhPJyBm7ZbXqIf4eDnemzio7E3X+HH5kYK6J09FnMZyfY2A+OYmlNKpY7Hox2pqCkFc1AA6Q4P9g==
X-Received: by 2002:a05:6a00:2385:b029:1b6:1603:4ea3 with SMTP id f5-20020a056a002385b02901b616034ea3mr3662536pfc.40.1613149056388;
        Fri, 12 Feb 2021 08:57:36 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h191sm4387760pge.85.2021.02.12.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 08:57:35 -0800 (PST)
Date:   Fri, 12 Feb 2021 09:57:34 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
Message-ID: <20210212165734.GA2692426@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
 <20210211190024.GD2186000@xps15>
 <be83fd32-e552-ac06-6ee5-3bf22c6daab2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be83fd32-e552-ac06-6ee5-3bf22c6daab2@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > 
> > 
> >> +	if (nr_pages < 2)
> >> +		return NULL;
> >> +
> >> +	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
> >> +	if (IS_ERR(buf))
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
> >> +	if (IS_ERR(pglist)) {
> >> +		kfree(buf);
> >> +		return ERR_PTR(-ENOMEM);
> >> +	}
> >> +
> >> +	for (i = 0; i < nr_pages; i++)
> >> +		pglist[i] = virt_to_page(pages[i]);
> >> +
> >> +	buf->trbe_base = (unsigned long) vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
> >> +	if (IS_ERR((void *)buf->trbe_base)) {
> > 
> > Why not simply make buf->trbe_base a void * instead of having to do all this
> 
> There are many arithmetic and comparison operations involving trbe_base
> element. Hence it might be better to keep it as unsigned long, also to
> keeps it consistent with other pointers i.e trbe_write, trbe_limit.

That is a fair point.  Please add a comment to explain your design choice and
make sure the sparse checker is happy with all of it.

> 
> Snippet from $cat drivers/hwtracing/coresight/coresight-trbe.c | grep "trbe_base"
> There are just two places type casting trbe_base back to (void *).
> 
> 	memset((void *)buf->trbe_base + head, ETE_IGNORE_PACKET, len);
> 	return buf->trbe_base + offset;
> 	WARN_ON(buf->trbe_write < buf->trbe_base);
> 	set_trbe_base_pointer(buf->trbe_base);
> 	buf->trbe_base = (unsigned long)vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
> 	if (IS_ERR((void *)buf->trbe_base)) {
> 		return ERR_PTR(buf->trbe_base);
> 	buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
> 	buf->trbe_write = buf->trbe_base;
> 	vunmap((void *)buf->trbe_base);
> 	base = get_trbe_base_pointer();
> 	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
> 	if (buf->trbe_limit == buf->trbe_base) {
> 	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
> 	if (buf->trbe_limit == buf->trbe_base) {
> 	offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
> 	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
> 	if (buf->trbe_limit == buf->trbe_base) {
> 	WARN_ON(buf->trbe_base != get_trbe_base_pointer());
> 		if (get_trbe_write_pointer() == get_trbe_base_pointer())
>   
> > casting?  And IS_ERR() doesn't work with vmap().
> 
> Sure, will drop IS_ERR() here.
> 

[...]


> > 
> >> +
> >> +static ssize_t dbm_show(struct device *dev, struct device_attribute *attr, char *buf)
> >> +{
> >> +	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
> >> +
> >> +	return sprintf(buf, "%d\n", cpudata->trbe_dbm);
> >> +}
> >> +static DEVICE_ATTR_RO(dbm);
> > 
> > What does "dbm" stand for?  Looking at the documentation for TRBIDR_EL1.F, I
> > don't see what "dbm" relates to.
> 
> I made it up to refer TRBIDR_EL1.F as "Dirty (and Access Flag) Bit Management".
> Could change it as "afdbm" to be more specific or if it is preferred.
> 

I don't see "afdbm" being a better solution - why not simply "flag"?

