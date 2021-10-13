Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C58242CED4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhJMWrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhJMWrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:47:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1CA961130;
        Wed, 13 Oct 2021 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634165138;
        bh=5WdUyjg12k3PxxjZH9zug2aqg29k94ORIzfCCkILNUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QTDJOYGWkYeUqg04/vVTEWKgQUazJzM95jKx/9HUfi0KxqRwcWRLLh9/xVTLlSyCa
         AK78Blsabq1a4ClbCl27dVARfFLUEm94hWgJ5GKWTQv0ZZBRfetJO0Z5ESsNsectRW
         R2uhoPIEepb5r1n5jg1e1036UjRVI1xdD18rYypA=
Date:   Wed, 13 Oct 2021 15:45:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan.Cameron@Huawei.com, amit@kernel.org,
        benh@kernel.crashing.org, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, foersleo@amazon.de,
        gthelen@google.com, markubo@amazon.de, rientjes@google.com,
        shakeelb@google.com, shuah@kernel.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm/damon/dbgfs: Allow users to set initial
 monitoring target regions
Message-Id: <20211013154535.4aaeaaf9d0182922e405dd1e@linux-foundation.org>
In-Reply-To: <20211012205711.29216-2-sj@kernel.org>
References: <20211012205711.29216-1-sj@kernel.org>
        <20211012205711.29216-2-sj@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 20:57:05 +0000 SeongJae Park <sj@kernel.org> wrote:

> Some 'damon-dbgfs' users would want to monitor only a part of the entire
> virtual memory address space.  The program interface users in the kernel
> space could use '->before_start()' callback or set the regions inside
> the context struct as they want, but 'damon-dbgfs' users cannot.
> 
> For the reason, this commit introduces a new debugfs file called
> 'init_region'.  'damon-dbgfs' users can specify which initial monitoring
> target address regions they want by writing special input to the file.
> The input should describe each region in each line in the below form:
> 
>     <pid> <start address> <end address>
> 
> Note that the regions will be updated to cover entire memory mapped
> regions after a 'regions update interval' is passed.  If you want the
> regions to not be updated after the initial setting, you could set the
> interval as a very long time, say, a few decades.
> 
> ...
>
> +static int add_init_region(struct damon_ctx *c,
> +			 unsigned long target_id, struct damon_addr_range *ar)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r, *prev;
> +	unsigned long id;
> +	int rc = -EINVAL;
> +
> +	if (ar->start >= ar->end)
> +		return -EINVAL;
> +
> +	damon_for_each_target(t, c) {
> +		id = t->id;
> +		if (targetid_is_pid(c))
> +			id = (unsigned long)pid_vnr((struct pid *)id);

This is a bit ugly.  Did you consider making damon_target.id a union of
all the possible types it can contain?  This will avoid typecasts, has
documentation value and reflacts what is actually going on.

> +		if (id == target_id) {
> +			r = damon_new_region(ar->start, ar->end);
> +			if (!r)
> +				return -ENOMEM;
> +			damon_add_region(r, t);
> +			if (damon_nr_regions(t) > 1) {
> +				prev = damon_prev_region(r);
> +				if (prev->ar.end > r->ar.start) {
> +					damon_destroy_region(r, t);
> +					return -EINVAL;
> +				}
> +			}
> +			rc = 0;
> +		}
> +	}
> +	return rc;
> +}
> +

