Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39213365CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhDTPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:49:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:34178 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232504AbhDTPts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:49:48 -0400
IronPort-SDR: bU48S0RrUvJcDLVtv9EVqhiBxKf/8bcetaNgPxzam3Hb+ROEZ7BxVScNRc6luhw4C8eZemtutz
 OZ7eUYd5lBrw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="216140635"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="216140635"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:47:33 -0700
IronPort-SDR: 3yWPQ97nJMs3J79JWj/qOc42O12pgrF77tfk72lUoKm5vBC6hK/t87dDAu9apgNncbsONx1W5G
 ez1juHxoRvYA==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="463164595"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:47:32 -0700
Date:   Tue, 20 Apr 2021 08:47:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jue Wang <juew@google.com>
Cc:     nao.horiguchi@gmail.com, akpm@linux-foundation.org, bp@alien8.de,
        david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        luto@kernel.org, naoya.horiguchi@nec.com, osalvador@suse.de,
        yaoaili@kingsoft.com
Subject: Re: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Message-ID: <20210420154730.GA577592@agluck-desk2.amr.corp.intel.com>
References: <CAPcxDJ5gH9XvZ1bMsRqqU8bTpGLsz75+pWMnj52b-nMZHKhdtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcxDJ5gH9XvZ1bMsRqqU8bTpGLsz75+pWMnj52b-nMZHKhdtQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 07:03:01PM -0700, Jue Wang wrote:
> On Tue, 13 Apr 2021 07:43:20 +0900, Naoya Horiguchi wrote:
> 
> > This patch suggests to do page table walk to find the error virtual
> > address.  If we find multiple virtual addresses in walking, we now can't
> > determine which one is correct, so we fall back to sending SIGBUS in
> > kill_me_maybe() without error info as we do now.  This corner case needs
> > to be solved in the future.
> 
> Instead of walking the page tables, I wonder what about the following idea:
> 
> When failing to get vaddr, memory_failure just ensures the mapping is removed
> and an hwpoisoned swap pte is put in place; or the original page is flagged with
> PG_HWPOISONED and kept in the radix tree (e.g., for SHMEM THP).

To remove the mapping, you need to know the virtual address :-)

Well, I did try a patch that removed *all* user mappings (switched CR3 to
swapper_pgdir) and returned to user. Then have the resulting page fault
report the address. But that didn't work very well.

> NOTE: no SIGBUS is sent to user space.
> 
> Then do_machine_check just returns to user space to resume execution, the
> re-execution will result in a #PF and should land to the exact page fault
> handling code that generates a SIGBUS with the precise vaddr info:

That's how SRAO (and other races) are supposed to work.

-Tony
