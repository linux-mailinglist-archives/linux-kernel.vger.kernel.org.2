Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417A642D2E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhJNGrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhJNGrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:47:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9454F60F21;
        Thu, 14 Oct 2021 06:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634193931;
        bh=A7vtA7EguJnBwyoJBmEP4sqGH1ppqg97OGt4QN41RuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=B3lcSxm3zkNKWPlNcVPF+tV3K6UtDow2eo3vkVkk7uLpz/z5juymLfnEaXhdYBg1g
         ZXRduK5ocDLdJ0xcq98oxFwagKXZ0Pn/vNEAKOustTNbWwjZYwfVKPlLeb/s039Bcp
         J2On4C0wWCCD4DK6m+Kd4u12A0aiGgArr6VUQFseSlYnC87lBOHVfjx0JxvN5Or71v
         zXg5OrIo5cviPC37n9zqbx1f0cdn8/tZB04b8zeMdYfzJF9x9Wz+9momA7Hey6u60m
         wWBA41xqdM/jQJtULQv0enZFINixBN4JAtKUvQAyDlj+rK+6vtsu4BkIHzkI/dShbR
         Tct5megKDFs9A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm/damon/dbgfs: Allow users to set initial monitoring target regions
Date:   Thu, 14 Oct 2021 06:45:22 +0000
Message-Id: <20211014064522.24455-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211013154535.4aaeaaf9d0182922e405dd1e@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 15:45:35 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 12 Oct 2021 20:57:05 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Some 'damon-dbgfs' users would want to monitor only a part of the entire
> > virtual memory address space.  The program interface users in the kernel
> > space could use '->before_start()' callback or set the regions inside
> > the context struct as they want, but 'damon-dbgfs' users cannot.
> > 
> > For the reason, this commit introduces a new debugfs file called
> > 'init_region'.  'damon-dbgfs' users can specify which initial monitoring
> > target address regions they want by writing special input to the file.
> > The input should describe each region in each line in the below form:
> > 
> >     <pid> <start address> <end address>
> > 
> > Note that the regions will be updated to cover entire memory mapped
> > regions after a 'regions update interval' is passed.  If you want the
> > regions to not be updated after the initial setting, you could set the
> > interval as a very long time, say, a few decades.
> > 
> > ...
> >
> > +static int add_init_region(struct damon_ctx *c,
> > +			 unsigned long target_id, struct damon_addr_range *ar)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r, *prev;
> > +	unsigned long id;
> > +	int rc = -EINVAL;
> > +
> > +	if (ar->start >= ar->end)
> > +		return -EINVAL;
> > +
> > +	damon_for_each_target(t, c) {
> > +		id = t->id;
> > +		if (targetid_is_pid(c))
> > +			id = (unsigned long)pid_vnr((struct pid *)id);
> 
> This is a bit ugly.  Did you consider making damon_target.id a union of
> all the possible types it can contain?  This will avoid typecasts, has
> documentation value and reflacts what is actually going on.

Agreed, thank you for this great comment!  I will make it at least before
adding another type of monitoring target.


Thanks,
SJ

> 
> > +		if (id == target_id) {
> > +			r = damon_new_region(ar->start, ar->end);
> > +			if (!r)
> > +				return -ENOMEM;
> > +			damon_add_region(r, t);
> > +			if (damon_nr_regions(t) > 1) {
> > +				prev = damon_prev_region(r);
> > +				if (prev->ar.end > r->ar.start) {
> > +					damon_destroy_region(r, t);
> > +					return -EINVAL;
> > +				}
> > +			}
> > +			rc = 0;
> > +		}
> > +	}
> > +	return rc;
> > +}
> > +
> 
> 
