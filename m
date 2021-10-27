Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7044F43BFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbhJ0Cd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhJ0Cdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:33:55 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740FC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:31:31 -0700 (PDT)
Date:   Wed, 27 Oct 2021 11:31:19 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635301889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TSHBBsEnM48VfyIfqBXTjY8VZ85+5qmBADTRLB/oKUc=;
        b=KkowZlZAT4Ju0OiTaRS+W0CILr3V1kll9g/Hj9R7sQlwG5pzTNmcuDrOAQHewibbxaCnp0
        9EhMSocz9hOf/jLMkIKh+FLtZmjwBYp1w7n6r7Swr7Fn/JFRf/PgD49Mp2tRokkZ2FUcpo
        NGzAwhfKacZE4Xf2bf72rm12DpsP8sM=
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
Subject: Re: [PATCH v2 1/4] mm/hwpoison: mf_mutex for soft offline and
 unpoison
Message-ID: <20211027023119.GC2707645@u2004>
References: <20211025230503.2650970-1-naoya.horiguchi@linux.dev>
 <20211025230503.2650970-2-naoya.horiguchi@linux.dev>
 <CAHbLzkoZXPZBkAR0CcLa6DpJuFZDxt1P5TvwsYidG0XmK5WTtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkoZXPZBkAR0CcLa6DpJuFZDxt1P5TvwsYidG0XmK5WTtg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 06:32:36PM -0700, Yang Shi wrote:
> On Mon, Oct 25, 2021 at 4:06 PM Naoya Horiguchi
> <naoya.horiguchi@linux.dev> wrote:
> >
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >
> > Originally mf_mutex is introduced to serialize multiple MCE events, but
> > it's also helpful to exclude races among  soft_offline_page() and
> > unpoison_memory().  So apply mf_mutex to them.
> 
> My understanding is it is not that useful to make unpoison run
> parallel with memory_failure() and soft offline, so they can be
> serialized by mf_mutex and we could make the memory failure handler
> and soft offline simpler.

Thank you for the suggestion, this sounds correct and more specific.

> 
> If the above statement is correct, could you please tweak this commit
> log to reflect it with patch #2 squashed into this patch?

Sure, I'm thinking of revising like below:

  Originally mf_mutex is introduced to serialize multiple MCE events, but
  it is not that useful to allow unpoison to run in parallel with memory_failure()
  and soft offline.  So apply mf_they to soft offline and unpoison.
  The memory failure handler and soft offline handler get simpler with this.

Thanks,
Naoya Horiguchi
