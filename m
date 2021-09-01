Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2C93FDEE6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbhIAPnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343705AbhIAPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:43:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E291C061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:42:41 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id q70so5892619ybg.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aCBEJKtdvAJtrTrGgodt4LUm0+Z7gqZfpmD/VmzxRk=;
        b=R1ryQlLrLKGt/v8//Q9rGKUHdcgBDrp6/sYQ33GTCTpJ5Un4Skro0oOst3pFa2vmzj
         0eRJUNhpZce5+8lwfZ3e5akFkVTbhP2ghPnNi3hUABx/JlqLQyuA6pychIwvcmbqln/i
         CR26ejZI3VeSRhRM2ycMIXajd+c3VGOQ2S/iLnA4ZhA/O55klYq5+MCnjcsfecphzRSV
         K+FMeY8OE+XpUXLB0I9AXogd+d0Qsn72gxpzdG4UJzafkOgNmMXj8X19Dr+JH9GElsrS
         5pfGbfXWHsUfRVe70ybV7MTIxJza2dg/DX/SJDyL+6atpZIIKQxhh4+KI9jfDbMYpqSP
         CcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aCBEJKtdvAJtrTrGgodt4LUm0+Z7gqZfpmD/VmzxRk=;
        b=FWPg+3kVuWZvb5AdMrtrpvF46Xg9U9LGKHMxi+JXg11ad1Y8qGQiFGo0NdUAVMdCvZ
         RwxYuHk1ibObGdurOqsaeSOzhwfoynmjEdEp39R+JqI/78H3aNDAztAqqI2jEFCwNT7g
         9wUWp1k9tJLNyrjkyckJX5qj0q4L4E0h9NiE+q/3/ocl2Rp4MNKTd2h0wVlx6QX8gr6A
         O1gF632+bFqMP8vYW9jXFJonQs6c3FKBD7SsBI2whPUECxpQ9x8ONabn54wl2++8B5Xu
         y7dG3Xw17Vh9Gr2vXBJQw9lLbd/kJBl5ffE0dPquMXOxJ5CPHCjHA0mAp2rCJIgQpk0/
         kS7w==
X-Gm-Message-State: AOAM533s5pbNLX1oPxO/XzaJQs1suBh/dFNlc443x+rChxQqOj5VrZOp
        uXTifpjvJQcEEgxQGdKTL1OEw73OFetg0YjAjv20Hg==
X-Google-Smtp-Source: ABdhPJwgQPH0nvbXpOtJyJ8qfGoULlT527Pv1mAagLgarkJHCp5SC7DsgZ+zIsArG/MC/YiqIV0K+Xpv+P7vOkdmGkQ=
X-Received: by 2002:a25:9ac6:: with SMTP id t6mr189907ybo.190.1630510960178;
 Wed, 01 Sep 2021 08:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com> <20210827191858.2037087-3-surenb@google.com>
 <YS81abHD8KZMrX8D@dhcp22.suse.cz>
In-Reply-To: <YS81abHD8KZMrX8D@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Sep 2021 08:42:29 -0700
Message-ID: <CAJuCfpHWCtqCcuZdyfc4-virtynOMv2f_iU=OJUB_6b2Xz+k9g@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 1:10 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Fri 27-08-21 12:18:57, Suren Baghdasaryan wrote:
> [...]
> > +static void replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
> > +{
> > +     if (!name) {
> > +             free_vma_anon_name(vma);
> > +             return;
> > +     }
> > +
> > +     if (vma->anon_name) {
> > +             /* Should never happen, to dup use dup_vma_anon_name() */
> > +             WARN_ON(vma->anon_name == name);
>
> What is the point of this warning?

I wanted to make sure replace_vma_anon_name() is not used from inside
vm_area_dup() or some similar place (does not exist today but maybe in
the future) where "new" vma is a copy of "orig" vma and
new->anon_name==orig->anon_name. If someone by mistake calls
replace_vma_anon_name(new, orig->anon_name) and
new->anon_name==orig->anon_name then they will keep pointing to the
same name pointer, which breaks an assumption that ->anon_name
pointers are not shared among vmas even if the string is the same.
That would eventually lead to use-after-free error. After the next
patch implementing refcounting, the similar situation would lead to
both new and orig vma pointing to the same anon_vma_name structure
without raising the refcount, which would also lead to use-after-free
error. That's why the above comment asks to use dup_vma_anon_name() if
this warning ever happens.
I can remove the warning but I thought the problem is subtle enough to
put some safeguards.

>
> > +
> > +             /* Same name, nothing to do here */
> > +             if (!strcmp(name, vma->anon_name))
> > +                     return;
> > +
> > +             free_vma_anon_name(vma);
> > +     }
> > +     vma->anon_name = kstrdup(name, GFP_KERNEL);
> > +}
> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
