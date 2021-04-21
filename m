Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB736677B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhDUJDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbhDUJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:03:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9509BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:03:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q10so29161387pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yx6aQUZUvPvikSOIyFX0nHKqtDVLfC9ijwB0D2c1bfI=;
        b=oIwiM0uDfHzYTsio/ZfgDEzO6t6ogj1GIURnP3Ga8yUuIXydUYzdNzGw8kr1TDjL8X
         sgjXjOLJMOyR9Mpwia4+E+LnhOcmc+p6Ep2SAK3gczVjBcBtxOcOWkf7pdQ4XuTOrE34
         WqekeL78rKzxrf8CmMmjMEiU/9JjRhCU+JYm+yvSmbPU4hpk+kfGNd8SlyNqCYUUyFWh
         9YecQtGKNYaNNkNrimS+E5d6oV1xK8hjVUV/HmRe9NvUawS6a4LlcqXjkQ+REwkN7Uku
         1Cs34jq3K31w3YgROt6wbr70whSuMEiInJiHpzCFZtyayt7fvWGLJRbSjosgKpJNuTD0
         xs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yx6aQUZUvPvikSOIyFX0nHKqtDVLfC9ijwB0D2c1bfI=;
        b=YaN37ZswpmJszsldc6l/kZYy0XfYa1rAe4lvd4PC7AL7jw2SUqHaeBmk/yiY/G++sv
         rLfUCtWQxE7Pg4PL8Otgqup5gLbjREa1TP59XBORxTuqP+NP36Wkoc26H0ddsMbKIg+x
         ejufcPrDXfvkuFnmv1w2trXP5lmkoAe6rHrWx6fqde3AW/LzpAIJhchjwbfWnf9N0Mgw
         I3K0l2pxhwxlMDs1MG/oM1HOiY+FICMbpsUc4GtfngKXjOHjH/1wdc8/zjeXafM4fXlu
         R7Fa06XI3VWuK/y/8DJAC5Qevpz0uX+MD3LBCC2+fsxDIgIBhBlJrOEHn3Hm8/QV0sOZ
         y5DA==
X-Gm-Message-State: AOAM532AqghSEhuRX+a+3kBYpYMLFRFefNIdp2ofbckA/wifp0ABY4Ga
        r9Qm2HI2FVpYHix9UQprvgLrn4+BekZbDf+Nm7C1hQ==
X-Google-Smtp-Source: ABdhPJzxLPXSfufQouIdkQl0RAryo1fFcGzW4CXnNwhc7Q/gH+kQLI/F9ZE950rMyBzaw7BmrqHzuYSVeB0iF/uLLhM=
X-Received: by 2002:a63:1665:: with SMTP id 37mr21355237pgw.31.1618995801174;
 Wed, 21 Apr 2021 02:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210421060259.67554-1-songmuchun@bytedance.com>
 <YH/cVoUCTKu/UkqB@dhcp22.suse.cz> <20210421083315.GA7552@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210421083315.GA7552@hori.linux.bs1.fc.nec.co.jp>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 21 Apr 2021 17:02:44 +0800
Message-ID: <CAMZfGtXSuuMjtr0zNOxSsN3cYZPAYzuf6bqAVqwoO8q4eQ0HtQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 4:33 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Wed, Apr 21, 2021 at 10:03:34AM +0200, Michal Hocko wrote:
> > [Cc Naoya]
> >
> > On Wed 21-04-21 14:02:59, Muchun Song wrote:
> > > The possible bad scenario:
> > >
> > > CPU0:                           CPU1:
> > >
> > >                                 gather_surplus_pages()
> > >                                   page =3D alloc_surplus_huge_page()
> > > memory_failure_hugetlb()
> > >   get_hwpoison_page(page)
> > >     __get_hwpoison_page(page)
> > >       get_page_unless_zero(page)
> > >                                   zero =3D put_page_testzero(page)
> > >                                   VM_BUG_ON_PAGE(!zero, page)
> > >                                   enqueue_huge_page(h, page)
> > >   put_page(page)
> > >
> > > The refcount can possibly be increased by memory-failure or soft_offl=
ine
> > > handlers, we can trigger VM_BUG_ON_PAGE and wrongly add the page to t=
he
> > > hugetlb pool list.
> >
> > The hwpoison side of this looks really suspicious to me. It shouldn't
> > really touch the reference count of hugetlb pages without being very
> > careful (and having hugetlb_lock held).
>
> I have the same feeling, there is a window where a hugepage is refcounted
> during converting from buddy free pages into free hugepage, so refcount
> alone is not enough to prevent the race.  hugetlb_lock is retaken after
> alloc_surplus_huge_page returns, so simply holding hugetlb_lock in
> get_hwpoison_page() seems not work.  Is there any status bit to show that=
 a
> hugepage is just being initialized (not in free hugepage pool or in use)?

HPageFreed() can indicate whether a page is on the
free pool list.

>
> > What would happen if the
> > reference count was increased after the page has been enqueed into the
> > pool? This can just blow up later.
>
> Yes, this is another concern.
>
> Thanks,
> Naoya Horiguchi
