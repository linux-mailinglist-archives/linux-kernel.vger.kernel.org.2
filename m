Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417713E1FA6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbhHFAEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhHFAEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:04:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC15961052;
        Fri,  6 Aug 2021 00:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628208226;
        bh=lsSE5tvNy4aTRnsD3X6OAqGqP19GDoBFiD74B70HHOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=icNnBXX9cAIcggbi0r8XlsID4alGDeS2iayE2iY1MEDKvsFRcljBs7OvgqgVv1qzS
         z596vKzjH7NdXyUBDtLLf/UOqQe8HwvguO+QqNZxDB53NSOsdGkGe01szexeEfTrvg
         3nAsGvQtxKX/AIdKme4MiqzVNi4jamwYUTep2kEg=
Date:   Thu, 5 Aug 2021 17:03:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        amit@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        jgowans@amazon.com, mheyne@amazon.de,
        David Rientjes <rientjes@google.com>, sieberf@amazon.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Wei Xu <weixugc@google.com>,
        Paul Turner <pjt@google.com>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Message-Id: <20210805170344.afbf5f1ceb00eb212082ca7b@linux-foundation.org>
In-Reply-To: <20210728083643.5873-1-sjpark@amazon.de>
References: <CALvZod53+KD_F+3z3ztdx6ELFWt+jAXY6Vq-S49bq6-Y2=Cneg@mail.gmail.com>
        <20210728083643.5873-1-sjpark@amazon.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 08:36:43 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> > DAMON does not expose stable APIs at the moment, so these can
> > be changed later if needed. I think it is ok to merge DAMON for some
> > exposure. However I do want to make this clear that the solution space
> > is not complete. The solution of system level monitoring is still
> > needed which can be a future extension to DAMON or more generalized
> > Multigen LRU.
> 
> Agreed.  We have lots more works to do.  Some of those are already posted as
> RFC patchsets[1,2,3,4].  I promise I will happily do the works.  But, how dare
> could only I get all the fun?  I'd like to do that together with others in this
> great community.  One major purpose of this patchset is thus providing a
> flexible framework for such collaboration.  The virtual address space
> monitoring, which this patchset provides in addition to the framework, is also
> for real-world usages, though.
> 
> Now all the patches have at least one 'Reviewed-by:' or 'Acked-by:' tags.  We
> didn't find serious problems since v26[5], which was posted about four months
> ago. so I'm thinking this patchset has passed the minimum qualification.  If
> you think there are more things to be done before this patchset is merged in
> the -mm tree or mainline, please let me know.  If not, Andrew, I'd like you to
> consider merging this patchset into '-mm' tree.

Shall take a look.  With some trepidation.

1-2 years from now someone will pop up with a massive patchset
implementing some monitoring scheme and we'll say "why didn't you use
DAMON" and they'll say "it's unsuitable for <reasons>".

I would like to see more thought/design go into how DAMON could be
modified to address Shakeel's other three requirements.  At least to
the point where we can confidently say "yes, we will be able to do
this".  Are you able to drive this discussion along please?
