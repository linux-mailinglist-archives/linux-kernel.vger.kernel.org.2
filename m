Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D523A1EA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFIVOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFIVOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:14:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22CEC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 14:12:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b12so7418490plg.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=jaT4lo9T5SEpPCFBCBUJXwFG0QTH+RrodR1Rx/0Ww4g=;
        b=WUOI/IfgB8YbMF1QA6HN2ZzWRCz2Qh3OP1C93nUDshtKUt2b1We2EeO9UjLmB+2+sD
         uPzRgbZFtudq4z+PDpTzfk+P4zTxV0VcLUuT1dl5bi2PVJKXClIzFAPwNTNs8q11ex8q
         epmpCf2wjz+QKdxmJJVTHbEb8Z5/l3cZ688SSHjpQ1kGshLK6cvXPdZTOYx8xaI8T+vA
         m0qY2cXYjhgsaouLVpxL3XC0A0HFGhMyGIt60Vlh86gvLUwTQn8Af0KJmWfMQBD9qI7W
         XR0K8uT0k9riwNeiZjVTDnmv/ylsgUJqDFkuPW4TIGB/GqxWqoQjmsY5ZxF0GtfSRP2z
         8WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=jaT4lo9T5SEpPCFBCBUJXwFG0QTH+RrodR1Rx/0Ww4g=;
        b=D8vYOLgnWorai2QvN4SjWzfOMvfLOcqZ6JI3U43cbRjfFRW9iATUPe6MI2SKJN6nlg
         N73feqwT+Bv2Dgk5KB6oeDNZ16fNOUc+NSbwYVB2eAZCmb9v/U7VHcNtMo6CBDm1RVVE
         SwF2dYInAxZPlbtjXzs5ZYCF5jqYw4/NJJAUuWc35BIuplPYKXfzhnkZpsxOptJnc2z4
         VYotcWqumtll62/cfSCdOaQmaXno1ZMPGy6dLYy2SEX2ot4EVbJ9z4tfD4J7RvHFek+z
         MD7Lc1EqsCkKuN0FCDeWu6nitMZd6MjyLfLcvWFo6C5epxOwWA9WcaMAlQYeV8mY/7Dj
         VmhA==
X-Gm-Message-State: AOAM531xKA11EOysUVAoTlQX1GdATRbwWu7oXcwrTkNnngVqZ5L5CE5k
        t8reN+DgMyFTkpaA2tiKgpetOw==
X-Google-Smtp-Source: ABdhPJy41HmwNNZ9IdFCcQ1yjMnnUMuK/qO1FP/PNY+23ehuLdXZlBXfRYNqOUFfF7rNnn168y77Qw==
X-Received: by 2002:a17:902:a981:b029:116:a139:6054 with SMTP id bh1-20020a170902a981b0290116a1396054mr1426866plb.60.1623273134253;
        Wed, 09 Jun 2021 14:12:14 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id em15sm471056pjb.43.2021.06.09.14.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 14:12:13 -0700 (PDT)
Date:   Wed, 9 Jun 2021 14:11:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/10] mm/thp: unmap_mapping_page() to fix THP
 truncate_cleanup_page()
In-Reply-To: <CAHbLzkqCJx11qCz0rNNz89C9O+Po8UoS5v_H_Qg3M8Q1eUp5pw@mail.gmail.com>
Message-ID: <50eb41a-e6f8-e566-20ef-22fb63b0a529@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com> <f1f68716-5a53-20ff-7ac0-d82fc3978d4e@google.com> <CAHbLzkqCJx11qCz0rNNz89C9O+Po8UoS5v_H_Qg3M8Q1eUp5pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021, Yang Shi wrote:
> On Tue, Jun 8, 2021 at 9:19 PM Hugh Dickins <hughd@google.com> wrote:
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1361,7 +1361,17 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
> >                         else if (zap_huge_pmd(tlb, vma, pmd, addr))
> >                                 goto next;
> >                         /* fall through */
> > +               } else if (details && details->single_page &&
> > +                          PageTransCompound(details->single_page) &&
> > +                          next - addr == HPAGE_PMD_SIZE && pmd_none(*pmd)) {
> > +                       /*
> > +                        * Take and drop THP pmd lock so that we cannot return
> > +                        * prematurely, while zap_huge_pmd() has cleared *pmd,
> > +                        * but not yet decremented compound_mapcount().
> > +                        */
> > +                       spin_unlock(pmd_lock(tlb->mm, pmd));
> 
> Just a nit, why not follow the style of patch #3 to have lock and
> unlock with separate lines?

Good point.  Doing it on one line is my own preferred style (particularly
with the "take and drop lock" comment just above), carried forward from
before.  I simply didn't think to change this one when I agreed to change
the other.  You're right to question it: v3 of just this 06/10 follows.

And thank you to Kirill and to you for these rapid further reviews (and
for silently forgiving my screwup in omitting to Cc linux-mm and lkml
on those early ones).

Hugh
