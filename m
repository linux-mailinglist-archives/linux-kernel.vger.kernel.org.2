Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C084310300
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBEC4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhBEC4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:56:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EC6C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 18:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sdmQZ0I9b44wVQxMMuojt77Q5ebRbY3Ce9uYruPT/N4=; b=KA+EwLhBnICJ36Bwg8niDsOxTi
        dB7enbqL+7hyA1T8Mb3gNOQKrBCAtfWlznTLwtZ1+9wE7u90C8PSoE1ihUCzJsi3pvwJ/RdZeZ2iV
        1F53YqP5B4x4ejA07mHULC5QRcaaJGZaTSeKdx4VEH/D4qVnBMMdL4dqSPfxBPkr7liBsQvSht+ps
        JQAaSYAP4AJeAyjyI9C8yq74cuo4NH4gFc+/wLjKljEEFFlusBG44UkDxRmJj4+Fga87vWfJxyKtV
        h57SNEe3itS0dTeGyZb94slitVJpJ4+kORUaDxrtfrMPcJn54GvjFL/OZL/5Jrd9hkxH1iImIy1VH
        Afu1cYUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7rHK-001jQP-Jq; Fri, 05 Feb 2021 02:55:29 +0000
Date:   Fri, 5 Feb 2021 02:55:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <20210205025526.GG308988@casper.infradead.org>
References: <20210203155001.4121868-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203155001.4121868-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 07:50:01AM -0800, Minchan Kim wrote:
> +++ b/mm/Makefile
> @@ -106,6 +106,7 @@ obj-$(CONFIG_ZSMALLOC)	+= zsmalloc.o
>  obj-$(CONFIG_Z3FOLD)	+= z3fold.o
>  obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
>  obj-$(CONFIG_CMA)	+= cma.o
> +obj-$(CONFIG_SYSFS)     += cma_sysfs.o

ehh ... if we have a kernel build with CMA=n, SYSFS=y, we'll get
cma_sysfs built in with no cma to report on.

> +static ssize_t cma_alloc_attempt_show(struct kobject *kobj,
> +			struct kobj_attribute *attr, char *buf)
> +{
> +	unsigned long val;
> +	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
> +
> +	val = stat->alloc_attempt;
> +
> +	return sysfs_emit(buf, "%lu\n", val);

Why not more simply:

{
	struct cma_stat *stat = container_of(kobj, struct cma_stat, kobj);
	return sysfs_emit(buf, "%lu\n", stat->alloc_attempt);
}

> +	for (i = 0; i < cma_area_count; i++) {
> +		cma = &cma_areas[i];
> +		stat = kzalloc(sizeof(*stat), GFP_KERNEL);
> +		if (!stat)
> +			goto out;

How many cma areas are there going to be?  do we really want to allocate
their stat individually?

