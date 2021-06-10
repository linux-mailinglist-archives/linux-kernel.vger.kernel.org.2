Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6153A377D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFJXBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhFJXBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:01:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BBFE613E7;
        Thu, 10 Jun 2021 22:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623365980;
        bh=eAk/RlclQL7/weZiH/mH89yOgBpeK9/zIcd17GGJxac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RDkezbSYdIQn8L5Xah3S1uOXt8pYkqqRKkuzKE+OACR9j2GMZswPX3Xzr4nPzIG6n
         yHepvR+gAvZhINQbJr1uErFgHna26XFafXPq5cHRf1O3oNEC5Wic8oJ/iFCrXRUGk0
         vdAbgbLznILM7JjpdI1yPnZXl7Q30NcgD9NI6gM8=
Date:   Thu, 10 Jun 2021 15:59:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] mm/page_alloc: Allow high-order pages to be stored
 on the per-cpu lists
Message-Id: <20210610155940.7d0e1430fd15461d9dabb2d4@linux-foundation.org>
In-Reply-To: <3B44DF44-5669-40B6-A122-011F1A749FAA@nvidia.com>
References: <20210603142220.10851-1-mgorman@techsingularity.net>
        <20210603142220.10851-3-mgorman@techsingularity.net>
        <88FCC7AA-FAAA-4B87-B382-50BD54B2886B@nvidia.com>
        <20210610111821.GY30378@techsingularity.net>
        <3B44DF44-5669-40B6-A122-011F1A749FAA@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 07:40:47 -0400 Zi Yan <ziy@nvidia.com> wrote:

> >> The attached config has THP disabled. The VM cannot boot with THP enabled,
> >> either.
> >>
> >
> > There is not a lot of information to go on here. Can you confirm that a
> > revert of that specific patch from mmotm-2021-06-07-18-33 also boots? It
> > sounds like your console log is empty, does anything useful appear if
> > you add "earlyprintk=serial,ttyS0,115200" to the kernel command line?
> 
> Sure. I can confirm that reverting the patch makes the VM boot.
> The important information I forgot to mention is that after I remove
> the NUMA setting in the QEMU, the VM can boot too.

Thanks, I'll drop
mm-page_alloc-allow-high-order-pages-to-be-stored-on-the-per-cpu-lists.patch
for now.

