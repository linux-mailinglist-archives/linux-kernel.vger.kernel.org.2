Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED39F389CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhETFPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETFPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:15:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68B7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 22:13:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m190so11029332pga.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 22:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KaaO+rgq7za+Bh8Mhm+Si3DDC8n5bDNTzJDoNGn9P2E=;
        b=qV4r0Jx+ks1W5hhnGC7jyO5rmXFsKRY4Pgr1mWgOKRw1DzOB6TnhK4cO8H9YulwoJp
         scVEvxyMoKcCwMDZ73f6dENYbgrwcoFbwxWdFCViAmFErYHPTnI5494i/7mwrv7Py5uo
         5qBnKBnALrOJK1MYSBjJyTjedIjVHOSRHye0goYVAm2p/tSSeoXIAcgcU5qhA/CSuCsP
         FdRX1aqycFNbDs57ELfhvgTpbZp31CguhPLfPhzXJjsvi7C6AiRse45Nu5PbFN7kDOUT
         sJidtSnKt2/ju5HY5VrHL67+gB+hdXB8vNAQmYKEfTuYYwofiEWcSof+XwKU4zuAQf3N
         raLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KaaO+rgq7za+Bh8Mhm+Si3DDC8n5bDNTzJDoNGn9P2E=;
        b=TUMY9bACMTDeD4mWM1i+uC1vGvWcEGK39V0DSVDKbdfrynN4+2bNXgQEqQTmaaV2KW
         pRRqo/oShEViW23AjMVyNq8HBWjdoe/5ky34IWTgsc6BeJ31xtdYgSD7dqJL93JiTN2k
         jRWfJuIMtZvw+lGYTBfD3A7xclS3V/eFvz1Lry7n/enUnLOPHpQH9OsyizqHub3CiBCJ
         /GeXfCcAES7QzH9zebtcb0bs5wfeJtjzgGGkze5qXMbZDl2c8IJDldye+fUGOaSlOg6I
         KCTi0NjgzunecSO96DF88s0FP3cHi9gsBDtqBGVxHFBNEmbmrg6MvMJmdGZsnuIcaQEQ
         TTLg==
X-Gm-Message-State: AOAM5335EMmydEXMh7rMo39OhmmgDzzPXPOzMjBlD6PIf+0wpmi56HgO
        octAASMwbdq6XdiyhzIU4jlGG2Whq2zJY+ITY8uxGQ==
X-Google-Smtp-Source: ABdhPJzOHTOmxl+VFUBauY9/0vq0OrnBaQUC1Sr+Oh0R3kHarioCsMUpiIKAF0Mxi7BBfX5ogHaw6+GY9NYaiRwT30A=
X-Received: by 2002:a65:5288:: with SMTP id y8mr2747587pgp.31.1621487622186;
 Wed, 19 May 2021 22:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210520025949.1866-1-songmuchun@bytedance.com> <20210519212412.5653163f94904b141d5d74ce@linux-foundation.org>
In-Reply-To: <20210519212412.5653163f94904b141d5d74ce@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 20 May 2021 13:13:05 +0800
Message-ID: <CAMZfGtVKgfc7Gxf_07038SOJKDbi--9u0Jhwk7fTdrpkXu0m_Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: migrate: fix missing update
 page_private to hugetlb_page_subpool
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        zhengqi.arch@bytedance.com, fam.zheng@bytedance.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 12:24 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 20 May 2021 10:59:49 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > Since commit d6995da31122 ("hugetlb: use page.private for hugetlb specific
> > page flags") converts page.private for hugetlb specific page flags. We
> > should use hugetlb_page_subpool() to get the subpool pointer instead of
> > page_private(). The commit forgot to update it in the page migration
> > routine. So fix it.
> >
> > ...
> >
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1290,7 +1290,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >        * page_mapping() set, hugetlbfs specific move page routine will not
> >        * be called and we could leak usage counts for subpools.
> >        */
> > -     if (page_private(hpage) && !page_mapping(hpage)) {
> > +     if (hugetlb_page_subpool(hpage) && !page_mapping(hpage)) {
> >               rc = -EBUSY;
> >               goto out_unlock;
> >       }
>
> So it uses the wrong page*, so this isn't just a cosmetic fix.  One
> cannot tell from this changelog.
>
> Please describe the runtime effects of this bug.  Please always include
> this information when fixing bugs.  And when adding them.

OK. I should update the commit log in the next version.

Thanks.
