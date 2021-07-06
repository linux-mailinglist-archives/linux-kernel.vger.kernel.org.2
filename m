Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C7A3BDF5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 00:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhGFWVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 18:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhGFWVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 18:21:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2484D61CA7;
        Tue,  6 Jul 2021 22:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625609939;
        bh=vVhcm6en8OuKSbYaoUlMTM0oUqJ46aoOwp3VE0Lkut0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jdS4r8U1M1pTaqDulnkHBJr/iwtQv11Gn9U3lASJdfLZR9s3cGm6dBL/Ste7k3ARz
         0+kNrLdpLbRcEXg+jv5lU6m0Dvy48a3oHxBxp2p9cYKDA2iBdLcy/eRC1nP5MMyOv5
         lsFvbmXtZ/qdtc8rYk16ZDsBRSXjzu5ijcuEGWto=
Date:   Tue, 6 Jul 2021 15:18:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 0/2] memory-hotplug.rst: complete admin-guide
 overhaul
Message-Id: <20210706151851.8edeaf8dbcf7e6710d90cfa5@linux-foundation.org>
In-Reply-To: <4624932e-2022-a60d-f58f-e11b70014efa@redhat.com>
References: <20210609075752.4596-1-david@redhat.com>
        <4624932e-2022-a60d-f58f-e11b70014efa@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 17:30:13 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 09.06.21 09:57, David Hildenbrand wrote:
> > This is v3 of the memory hot(un)plug admin-guide overhaul.
> > 
> > v2 -> v3:
> > - Added ACKs and RBs (thanks!)
> > - s/aarch64/arm64/
> > - Refine error handling when onlining/offlining
> > - s/memory hotplug/memory offlining/ in the vmemmap optimization section
> >    for huge pages
> > 
> > v1 -> v2:
> > - Added "memory-hotplug.rst: remove locking details from admin-guide"
> > - Incorporated all feedback from Mike and Michal (thanks!)
> > - Compressed some lines to make full use of 80 chars.
> > - Added details regarding 64bit/supported archs to the introduction.
> > - Added KASAN to the list of sizing considerations.
> > 
> > David Hildenbrand (2):
> >    memory-hotplug.rst: remove locking details from admin-guide
> >    memory-hotplug.rst: complete admin-guide overhaul
> > 
> >   .../admin-guide/mm/memory-hotplug.rst         | 800 ++++++++++--------
> >   1 file changed, 455 insertions(+), 345 deletions(-)
> > 
> 
> Andrew,
> 
> are you planning on picking+sending this for this cycle, or do you 
> prefer to let this doc update rest for a little bit longer?
> 
> I can spot that mmotm still contains v1.

Seems that whenever I take a documentation patch, Jon pops up and takes
it as well.   Except this time ;)

Please resend whatever's needed against current mainline?
