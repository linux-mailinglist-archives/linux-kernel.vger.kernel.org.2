Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F83F43BEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhJ0BUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:20:47 -0400
Received: from out1.migadu.com ([91.121.223.63]:10252 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236966AbhJ0BUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:20:46 -0400
Date:   Wed, 27 Oct 2021 10:18:07 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635297500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eC+dtU9OfBZl1jqB8KdIpIwy9ri5TDG2MDVAjdUs+Ys=;
        b=cAYCzMBwv9VqDWnvD0vLA5VHCYkdjNeAT6fHU9ROOFTg4Ky6SNXhCIJ+Toyesv10mFB91/
        0FF2SdgO6HTYhiRFMdbS7VvQGr5vRpjqlM/Jecz+BOUfJx7b7Pc0bQco5DbBNkS0vyh8zE
        NRlMDqc88MFndSXeHzmcZrTMmigv+vA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] mm/hwpoison: remove race consideration
Message-ID: <20211027011807.GA2707645@u2004>
References: <20211025230503.2650970-1-naoya.horiguchi@linux.dev>
 <20211025230503.2650970-3-naoya.horiguchi@linux.dev>
 <CAHbLzkrUb4YcnuXY9MYs+afRCFSfNdTmJAYyqHPxnqrEdFehhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkrUb4YcnuXY9MYs+afRCFSfNdTmJAYyqHPxnqrEdFehhA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 06:04:13PM -0700, Yang Shi wrote:
> On Mon, Oct 25, 2021 at 4:06 PM Naoya Horiguchi
> <naoya.horiguchi@linux.dev> wrote:
> >
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >
> > Now memory_failure() and unpoison_memory() are protected by mf_mutex,
> > so no need to explicitly check races between them.  So remove them.
> 
> It seems this patch could be folded into patch #1. Some "unlock_mutex"
> were added by patch #1 then they were removed by this patch
> immediately, it seems a bit of a waste and this patch is actually the
> by-product of patch #1.

OK, I'll do this in the next post.

Thanks,
Naoya Horiguchi
