Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D107A41C736
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbhI2Owc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344425AbhI2Ow2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:52:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:50:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bd28so9586934edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrkvQ2eKuEYOVmBoyItYGr7OfjmhRlari/VBbv1nfYo=;
        b=HQK2tyEQyeb7RAc9DRQ9+cPZ/trT6Xz+xOwZASaElJ+Dl4RluMtbDDUNc7f4V94Mvb
         HNlPqWcKgZ+gtqxi08uCXNABb2Y6m+f7MHAOlfnmrWhlQTblMDIJSsoxUYHkACRyDC0V
         HZic6fIrOwFl5LCKr8L42fUFNxiUMaoPyd+zmLx2+8/qMEjxFSllVIiNN9RFERtOsJ4m
         rWTkP65A/Z06frLhJleN7diBjqCPZ53mZOJqE1vYM8utXVQTLGpju7vVtw/H6n3pRlds
         WJJX+ZIumyHVgXa+lCTTlZ4R90ekEflN0onaN+2YLveRwDgd9Qss7HUSjQmSdjLddcUS
         9eMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrkvQ2eKuEYOVmBoyItYGr7OfjmhRlari/VBbv1nfYo=;
        b=T6L/hc7bYMXW3dBX6KPo/+dSUwvJJB8D/bknDovxQu1NuL0rqAh5DsI2U3MsPNPzA7
         QHdm3cq9FcwYLThauNlALuG1nblAIKLDFg2FE/z4E9m7uqtX68MJKyDPfUyOrAtBJFih
         nCCSpcODXeupmBDSQPNxjfol00xk3lsmXTEMa/1rw7S0t6iwccdzb7IMGsoxbXmmTLV4
         BKTaneHcUFOQIc4v42DyKEndnE0QreJLMXF3dWpdPC0FcLHwpBUO8+KsGpi7+CfFDn9e
         IXIg15QtvXc4CmbStRmPBE+ZLRMAZE4go8e9KE9g7OD5i04QoWs4EzlkBugtYenk3dBE
         jbmA==
X-Gm-Message-State: AOAM530k50KDEdsYRN9fks0rg6pz41aco6/T1VpOR0/tD0GJuDEcl0X1
        qwMH1FrAPZQDGV9dhWpIteKDStwquhFyRmNyr9w=
X-Google-Smtp-Source: ABdhPJxx+zAx9SJMP3Zaw5VePGhet6GYBeqWZYvuUtbrMItDAYWzxCV2VCo71j8DxzcQzBzZ5OmcTrMgth7pYwmHlBw=
X-Received: by 2002:a17:906:5212:: with SMTP id g18mr122817ejm.564.1632926981858;
 Wed, 29 Sep 2021 07:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210908132727.16165-1-david@redhat.com> <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
 <ea75df96-f381-6949-5627-1382a370dc71@redhat.com> <20210916193403.GA1940@pc638.lan>
 <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com> <20210921221337.GA60191@pc638.lan>
 <7f62d710-ca85-7d33-332a-25ff88b5452f@redhat.com> <20210922104141.GA27011@pc638.lan>
 <e378e60a-319b-e9aa-7e30-3e280c4431da@redhat.com> <CA+KHdyWZ9T2GEuUENXD_OYHX1JxKfZuW5YzmDtqXUYSgkQd8fQ@mail.gmail.com>
 <953ea84a-aabb-f64b-b417-ba60928430e0@redhat.com>
In-Reply-To: <953ea84a-aabb-f64b-b417-ba60928430e0@redhat.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 29 Sep 2021 16:49:30 +0200
Message-ID: <CA+KHdyWFjtoVqGd=7-yp33G-5WcZCtf80BaAk+3jx2bW5FCfWA@mail.gmail.com>
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment > 1
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 4:40 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 29.09.21 16:30, Uladzislau Rezki wrote:
> >>
> >> So the idea is that once we run into a dead end because we took a left
> >> subtree, we rollback to the next possible rigth subtree and try again.
> >> If we run into another dead end, we repeat ... thus, this can now happen
> >> more than once.
> >>
> >> I assume the only implication is that this can now be slower in some
> >> corner cases with larger alignment, because it might take longer to find
> >> something suitable. Fair enough.
> >>
> > Yep, your understanding is correct regarding the tree traversal. If no
> > suitable block
> > is found in left sub-tree we roll-back and check right one. So it can
> > be(the scanning)
> > more than one time.
> >
> > I did some performance analyzing using vmalloc test suite to figure
> > out a performance
> > loss for allocations with specific alignment. On that syntactic test i
> > see approx. 30%
> > of degradation:
>
> How realistic is that test case? I assume most alignment we're dealing
> with is:
> * 1/PAGE_SIZE
> * huge page size (for automatic huge page placing)
>
Well that is synthetic test. Most of the alignments are 1 or PAGE_SIZE.
There are users which use internal API where you can specify an alignment
you want but those are mainly like KASAN, module alloc, etc.

> >
> > 2.225 microseconds vs 1.496 microseconds. That time includes both
> > vmalloc() and vfree()
> > calls. I do not consider it as a big degrade, but from the other hand
> > we can still adjust the
> > search length for alignments > one page:
> >
> > # add it on top of previous proposal and search length instead of size
> > length = align > PAGE_SIZE ? size + align:size;
>
> That will not allow to place huge pages in the case of kasan. And I
> consider that more important than optimizing a syntactic test :) My 2 cents.
>
Could you please to be more specific? I mean how is it connected with huge
pages mappings? Huge-pages are which have order > 0. Or you mean that
a special alignments are needed for mapping huge pages?

-- 
Uladzislau Rezki
