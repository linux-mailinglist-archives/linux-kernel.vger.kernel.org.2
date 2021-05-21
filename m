Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6994938BEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 07:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbhEUF5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 01:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbhEUF5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 01:57:40 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4076C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:56:17 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so17052370otg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bAwdIn+RhYpuUTl+PkUJ/qNW1q0V+1Gc+xZ9eT6hv/4=;
        b=lf3QeyK6DqEDrGkWIlf1G4tn8LHrw4v1TujHZaqQvJynVfOJE1K6F78Xt5eqqpvVYI
         5Rd0Zyx7E86enEc9dv6ANFndgkJ2+q58ChPqlWxQUA7afQdTfF3fr8uDfKXYXubPvL9S
         7+Cq4K0b0pBN5IikIDUj+qrMWhfB58QyW9oo0LpdzqKWmMAMMwK9Wzd39jz6u5E2UDzv
         iaV0H522LLW2bCq9Z/hcXfYET1NaGToECGk8uBtEtvIxTozlxFxVdgTSLk0KIFt5KMJh
         u5h2XKj6FTzSNKDBJyY4b/hdtHj94Dl7lvYpFopy8C1PgvjiWGebqL0L6RdsSEaK6VE2
         iGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bAwdIn+RhYpuUTl+PkUJ/qNW1q0V+1Gc+xZ9eT6hv/4=;
        b=m/k5krB/ASk/69YD0dtBueH10BDk7rRNBOVVxRACJgClZsRfJH5c8RZrfGaQ/b/Oy9
         snuM5eYt8SGOUAh2m0GC/o9FrMTsf5Vomqni+Fg8hLwZCCb/W6iZSlM+8iccr1WR1S93
         DMXYZQ6SyjJYAlSnRjUKGhyIrhcL8MVAUDhwt4YqC9TEkozYfQ7cfYru96JuUlBwD8YN
         z2+6x5vCrKFfG/69U1koPnbBEIwOv22GMndcViIpNMmEZKRkid7N7IqXMjc5Ot9WDgI5
         mUfZ7csv596UhXdbfqj0MHkmVIKMZKNs137VVf1Usw5/wGXCHNklTmW8MNxIW+gfSKno
         lqrA==
X-Gm-Message-State: AOAM530X+Qb+35KisR62/FV/+mAvCHpv9WQ2ayq5WNKjC/Swvou+zNbu
        Xg7ei/UpWK3zEezj8DtOkGsBFXrssYbwVw==
X-Google-Smtp-Source: ABdhPJxTuEPpjPz/apBnnSIggACO6SBqrT13P1sq/fnEjuxauPeEeps3o3b/v80EVXWm3KFj6Arz5Q==
X-Received: by 2002:a05:6830:1388:: with SMTP id d8mr6774159otq.53.1621576576873;
        Thu, 20 May 2021 22:56:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i11sm1088529otk.70.2021.05.20.22.56.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 20 May 2021 22:56:16 -0700 (PDT)
Date:   Thu, 20 May 2021 22:56:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Anshuman Khandual <anshuman.khandual@arm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/thp: Update mm_struct's MM_ANONPAGES stat for huge
 zero pages
In-Reply-To: <8fa7fea6-4176-32fd-2c6a-abb6b73d0d13@arm.com>
Message-ID: <alpine.LSU.2.11.2105202216330.6768@eggly.anvils>
References: <1621313300-1118-1-git-send-email-anshuman.khandual@arm.com> <alpine.LSU.2.11.2105201852230.5752@eggly.anvils> <8fa7fea6-4176-32fd-2c6a-abb6b73d0d13@arm.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021, Anshuman Khandual wrote:
> On 5/21/21 7:47 AM, Hugh Dickins wrote:
> > On Tue, 18 May 2021, Anshuman Khandual wrote:
> > 
> >> Although the zero huge page is being shared across various processes, each
> >> mapping needs to update its mm_struct's MM_ANONPAGES stat by HPAGE_PMD_NR
> >> to be consistent. This just updates the stats in set_huge_zero_page() after
> >> the mapping gets created and in zap_huge_pmd() when mapping gets destroyed.
> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Zi Yan <ziy@nvidia.com>
> >> Cc: linux-mm@kvack.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > 
> > NAK.
> > 
> > For consistency with what? In the all the years that the huge zero page
> 
> Huge zero page after all is an anon mapping.

No, it's a shared page used inside an anon mapping. It's not PageAnon.

> Hence why it must not be
> counted for process rss MM_ANONPAGES accounting ?

Because it's being shared between (potentially) many tasks, and many
parts of their address space. It's intended to give them all a saving.

> Is there a specific
> reason why zero huge pages should not counted for MM_ANONPAGES ?

We'd have to look back to ~20-year-old mail (maybe lore has it) to see
whatever arguments were made for and against counting the ZERO_PAGE()
in rss - certainly it can be argued either way, but the way it was
decided is to leave it out of rss.  And the huge zero page was
introduced to follow the same rule.

> Does
> not it risk an inaccurate MM_ANONPAGES accounting for the processes
> using huge zero pages ?

They are accurately and consistently accounted (until your patch);
it's only inaccurate if you're expecting it to be included in rss
(agreed, it can be a surprise to find that it is not included).

> 
> > has existed, it has been intentionally exempted from rss accounting:
> > consistent with the small zero page, which itself has always been
> > intentionally exempted from rss accounting. In fact, that's a good part
> 
> Why are small zero pages exempted from rss accounting which in turn
> might have caused huge zero page to take the same approach as well ?

A gift from the kernel, so large unCOWed zero areas come for free.

> 
> > of the reason the huge zero page was introduced (see 4a6c1297268c).
> 
> Huge zero page reduces memory consumption on read faults which is a
> definite advantage but would there be a problem if rss stat goes up
> for each huge zero page mapping instances. The commit mentioned here
> talks about increase in actual memory utilization as seen from the
> rss accounting stat, without huge zero page usage.
> 
> I am wondering if actual memory usage remains the same (reduced with
> huge zero page usage), what could be the problem in an increased
> MM_ANONPAGES accounting for a given process.

If a process is monitoring its usage, or its usage is being monitored,
then a sudden increase in rss like this will cause them trouble:
it's an incompatible change which would have to be reverted.

> Dont we update the rss
> accounting for shared memory as well ?

Yes, in MM_SHMEMPAGES; but I don't get your point there.
I suppose we could add an MM_ZEROPAGES, but I don't know where
it would be shown, nor who would be interested to look at it.

> 
> > 
> > To change that now will break any users depending on it.
> 
> Just to understand it correctly, are rss accounting procedures/methods
> something which cannot be changed as users are currently dependent on
> it ? OR this proposal here is not a good enough reason to change it ?

I guess we could change it if there were a security issue with it,
but I don't think you're suggesting that.  You have not actually
given any reason to change it, other than "to be consistent".
Yet you're choosing inconsistency with long-standing usage.

> 
> > 
> > Not to mention the
> > BUG: Bad rss-counter state mm:00000000aa61ef82 type:MM_ANONPAGES val:512
> > I just got from mmotm.
> 
> Okay, unfortunately some how did not see this problem while testing. Is
> there a specific test case which will be able to trigger this bug ?

I did a read fault into a large private anonymous mapping, to map in
the huge zero page; I then wrote a byte to that page, to COW it; and
exited.  Checked dmesg and found that "Bad rss-counter" as expected.

(I lie: actually, I thought I mapped in the huge zero page in two
places, and COWed them both; so was a bit surprised to see val:512
when I was expecting val:1024.  I guess I screwed up my addresses.)

There's probably one or more of the LTP tests which would show it,
but don't care to chase down implementation details in a NAKed patch.

Hugh
