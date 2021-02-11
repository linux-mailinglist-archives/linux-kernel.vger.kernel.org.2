Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A08318618
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 09:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBKIHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:07:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:33142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhBKIHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:07:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93CADAE05;
        Thu, 11 Feb 2021 08:06:19 +0000 (UTC)
Date:   Thu, 11 Feb 2021 09:06:17 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, hwpoison: enable error handling on shmem thp
Message-ID: <20210211080617.GA4087@localhost.localdomain>
References: <20210209062128.453814-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209062128.453814-1-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 03:21:28PM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Currently hwpoison code checks PageAnon() for thp and refuses to handle
> errors on non-anonymous thps (just for historical reason).  We now
> support non-anonymou thp like shmem one, so this patch suggests to enable
> to handle shmem thps. Fortunately, we already have can_split_huge_page()
> to check if a give thp is splittable, so this patch relies on it.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Looks good to me, thanks Naoya:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
