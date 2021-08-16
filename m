Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605303EE06B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 01:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhHPX3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 19:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhHPX3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 19:29:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FEF5606A5;
        Mon, 16 Aug 2021 23:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629156512;
        bh=4n+RmyA6BCpELUNEjamrhEqJy00J6bq1EviW19Mc8Cw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=io5zJdg0Gnv6RmMsQ/i/nwLZG/PncP4vWbOa6puoskHUXiDVZmtjNeoM9FxrAJ+ad
         8FQ3f/3rxxIbjeapMsnL1IWOu02UF0z9LUPKscxM69YbPCkfjuGiXi8FPi3Vfwkp2t
         Q6f4KxSbPmgsUJ5WUw8QK6wSJgBMLpSUq5g8Kutk=
Date:   Mon, 16 Aug 2021 16:28:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 5/8] hugetlb: document the demote sysfs interfaces
Message-Id: <20210816162829.a228c4629b411900702b7f5f@linux-foundation.org>
In-Reply-To: <20210816224953.157796-6-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
        <20210816224953.157796-6-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 15:49:50 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Describe demote and demote_size interfaces.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst | 29 ++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 8abaeb144e44..902059a0257b 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -234,8 +234,12 @@ will exist, of the form::
>  
>  	hugepages-${size}kB
>  
> -Inside each of these directories, the same set of files will exist::
> +Inside each of these directories, the set of files contained in ``/proc``
> +will exist.  In addition, two additional interfaces for demoting huge
> +pages will exist::
>  
> +        demote
> +        demote_size
>  	nr_hugepages
>  	nr_hugepages_mempolicy
>  	nr_overcommit_hugepages
> @@ -243,7 +247,28 @@ Inside each of these directories, the same set of files will exist::
>  	resv_hugepages
>  	surplus_hugepages
>  
> -which function as described above for the default huge page-sized case.
> +The demote interfaces provide the ability to split a huge page into
> +smaller huge pages.  For example, the x86 architecture supports both
> +1GB and 2MB huge pages sizes.  A 1GB huge page can be split into 512
> +2MB huge pages.  The demote interfaces are:
> +
> +demote_size
> +        is the size of demoted pages.  When a page is demoted a corresponding
> +        number of huge pages of demote_size will be created.  For huge pages
> +        of the smallest supported size (2MB on x86), demote_size will be the
> +        system page size (PAGE_SIZE).  If demote_size is the system page size
> +        then demoting a page will simply free the huge page.  demote_size is
> +        a read only interface.
> +
> +demote
> +        is used to demote a number of huge pages.  A user with root privileges
> +        can write to this file.  It may not be possible to demote the
> +        requested number of huge pages.  To determine how many pages were
> +        actually demoted, compare the value of nr_hugepages before and after
> +        writing to the demote interface.  demote is a write only interface.
> +
> +The interfaces which are the same as in ``/proc`` function as described
> +above for the default huge page-sized case.

Are these new demote interfaces duplicated in /proc? 
Documentation/admin-guide/mm/hugetlbpage.rst says "The ``/proc``
interfaces discussed above have been retained for backwards
compatibility.", so new interfaces need not appear in /proc?
