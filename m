Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD203318493
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBKFWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 00:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBKFWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:22:13 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC7EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:21:33 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id e4so4130917ote.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 21:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HPtN3v+VEPRgIPL9sC8IW9YRdG+zfcqa9spnEAHVHV8=;
        b=m1Gb+okdv2Fs1qwUqn2h1VbjXih63jajd/9o7eyliKOpiTFQieeUHvEZvgAbEC3Dca
         284Fve4yGYLxI9sOujx4VJ8DTuV8apafDXJs9crX+jT8u4+aBChPa43JuoXyE+aeHIkx
         gBylEgNJz4r+wnBt99WoXdllJllaMb09Vtwfd+xniu44aTR3o67S7OrOBdIiAOYwmvnf
         0WZaCmlUm1BxKqAIVrodcq/l0TFcskqT3n4RcuYBGrB3h0v6JZBVJa32ViF2+YFlEmmj
         UMFuaoKvn3ErQGPX5d9HD5P8SN6znSPMyo6sPVCC1hwVcDs+l760cg7GtF4zelEm5U8P
         NO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HPtN3v+VEPRgIPL9sC8IW9YRdG+zfcqa9spnEAHVHV8=;
        b=LEnoV8uGPVqjDu6X5n5JYwFQgqJMShdClvKXZ3Ce2VGpSI9s0Mblr+2c1GUhajt5oZ
         twQlc1N69S8NovdCjBnMbfulRf1tat0cku7txSwaR4v6kWJ/s9Y0rqWWwYoMzMySd1Gv
         qqukGY42mrvq3usGqIU+IdnggSao+CKT86kUpHemDocv03MCB+gwtfwT4mmCONt5X2Se
         Evs0Mj/e3jCo7moyb67ZverVCM4FbW17E0k1z/u5ommTTPdMKpDJn2vWTR+hfiqw1wyo
         i1r3SN251Eaz6ZHoQUhYkU75ApXc6Aw07LzJwSi57IQf2dg0i3JKdvF+mihWko9zrNl1
         8SbA==
X-Gm-Message-State: AOAM533NC9QjsZYMKiyEw3JFn6lef2zUdDKqXx05HToWil/DFMgg6fFf
        UO2X742lumm3r/MOfgrdd/ExEA==
X-Google-Smtp-Source: ABdhPJyRWtL3Bv2ltaYJ4QoDsfrueQOJpUj7UhB63jUM5UnjCwqn5Ot5cBO/2jrdreWRk6A88lMxjQ==
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr4563109otc.260.1613020892962;
        Wed, 10 Feb 2021 21:21:32 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y65sm966183oie.50.2021.02.10.21.21.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 10 Feb 2021 21:21:32 -0800 (PST)
Date:   Wed, 10 Feb 2021 21:21:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Michal Hocko <mhocko@suse.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, Milan Broz <gmazyland@gmail.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Very slow unlockall()
In-Reply-To: <YCQaqRGjZKYe64zR@dhcp22.suse.cz>
Message-ID: <alpine.LSU.2.11.2102102051300.1872@eggly.anvils>
References: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com> <20210108134140.GA9883@dhcp22.suse.cz> <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com> <9474cd07-676a-56ed-1942-5090e0b9a82f@suse.cz> <e6f84b27-ed29-0fa4-e466-536b529c5720@gmail.com>
 <6eebb858-d517-b70d-9202-f4e84221ed89@suse.cz> <dfc3fe66-07ac-6aba-e10b-c940cdb01ec1@gmail.com> <273db3a6-28b1-6605-1743-ef86e7eb2b72@suse.cz> <YCQQad+rzpPiDmjL@dhcp22.suse.cz> <YCQaqRGjZKYe64zR@dhcp22.suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021, Michal Hocko wrote:
> On Wed 10-02-21 17:57:29, Michal Hocko wrote:
> > On Wed 10-02-21 16:18:50, Vlastimil Babka wrote:
> [...]
> > > And the munlock (munlock_vma_pages_range()) is slow, because it uses
> > > follow_page_mask() in a loop incrementing addresses by PAGE_SIZE, so that's
> > > always traversing all levels of page tables from scratch. Funnily enough,
> > > speeding this up was my first linux-mm series years ago. But the speedup only
> > > works if pte's are present, which is not the case for unpopulated PROT_NONE
> > > areas. That use case was unexpected back then. We should probably convert this
> > > code to a proper page table walk. If there are large areas with unpopulated pmd
> > > entries (or even higher levels) we would traverse them very quickly.
> > 
> > Yes, this is a good idea. I suspect it will be little bit tricky without
> > duplicating a large part of gup page table walker.
> 
> Thinking about it some more, unmap_page_range would be a better model
> for this operation.

Could do, I suppose; but I thought it was just a matter of going back to
using follow_page_mask() in munlock_vma_pages_range() (whose fear of THP
split looks overwrought, since an extra reference now prevents splitting);
and enhancing follow_page_mask() to let the no_page_table() FOLL_DUMP
case set ctx->page_mask appropriately (or perhaps it can be preset
at a higher level, without having to pass ctx so far down, dunno).

Nice little job, but I couldn't quite spare the time to do it: needs a
bit more care than I could afford (I suspect the page_increm business at
the end of munlock_vma_pages_range() is good enough while THP tails are
skipped one by one, but will need to be fixed to apply page_mask correctly
to the start - __get_user_pages()'s page_increm-entation looks superior).

Hugh
