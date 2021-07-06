Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06983BC4FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 05:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhGFDI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 23:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhGFDI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 23:08:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CFCC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 20:05:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a6so292246plh.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rpUK1zI8UPtbL2LMVzlMcPFji8pVRHI1RGFSCzgONU8=;
        b=DSHKoKfnm93GVE8ZuctQLNVdcgeu75jZ/9RQPyHmmM8+BPtVIVOY02Q1hZst/N26PE
         mG2VbBif93O0lmkH8xUDtGXevKPItODW1rOeaIrHwq3W1R2Ea8/Sl43y2/MoA7OUD6ey
         fwSvZdk0GnX1VdVh+/RJQxq2dgctYl35UtFwJIHfskVC1u2JmEFgjYZ/yoldz/0iHVob
         PWiOZePHh2Vj+bz1Ve4ob/XOfstOlqMau7JFUwFJB2AwWZSOIp1XLJphEW12yO5Ykelp
         kuXFTaoAL81epwvcrXTpIGQAuPiQ7BdgeZbTGHEmxBw7rbeimgb9bs2OOlAJDpdOb/xC
         58kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rpUK1zI8UPtbL2LMVzlMcPFji8pVRHI1RGFSCzgONU8=;
        b=CMb6Zk8SO/HYUBLJpk8WSMdtSWBuy1xbYbbBNIW8SUxR48eSYBDk1QNMH/oKBFWqvf
         4LKkg9+/r7Z4kseDJ3ulbSDO4DUcHcqCZbPNSHvUkxgi7FjulObullfzTJp44Agj5uGZ
         TjbLJO2ywgMhH7TVzHZsSUA5xvOv7z4fPM7147YMQcOQaRHUp7N8vTYcjQkpaS/PYriD
         PSaMi9wxjjclOJUagv2dqMCkh/26l0UEyNFhzKo+VluYaUPcYZSp9ID6GpHUWxLbYnAY
         zBdkq7NiTHYYJBIVP2r0U7k7nbk+iY60V+QwNnPlWW+Hdg7CcscOXsXZgVTatCw4u7u4
         KfIQ==
X-Gm-Message-State: AOAM530Z9y+P4LPns3VyEaTwu5lvno6HPBohjN9GxQAmdU3Kg8BeV+2N
        1M0C4J4Evk6DN29Qpit4r5WuHM+4k/40vwT80yUkhg==
X-Google-Smtp-Source: ABdhPJxUU9XQAaovl9e0hbF8KcHLRYwOOG2KjjzoCq+t34MXba2anIJH/oCbOuuw7LOx9m3EN42Tdcid2qTpocZ1Mgs=
X-Received: by 2002:a17:902:e2d3:b029:129:70aa:990 with SMTP id
 l19-20020a170902e2d3b029012970aa0990mr11886309plc.34.1625540748048; Mon, 05
 Jul 2021 20:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZfGtUbX+TAx-7RJ4ZpoNLHDa9mp6k+DBqHaYiLjhSJokh3Sw@mail.gmail.com>
 <AEsAOwC*DyQcdDctDg-oWKqc.3.1625539281909.Hmail.wangqing@vivo.com>
In-Reply-To: <AEsAOwC*DyQcdDctDg-oWKqc.3.1625539281909.Hmail.wangqing@vivo.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 6 Jul 2021 11:05:11 +0800
Message-ID: <CAMZfGtXSg8YbNDFQ8xtvYd-5aDf3g255Pxo+fKSS_YME11dMaQ@mail.gmail.com>
Subject: Re: Re: [Phishing Risk] [External] [PATCH] mm: add GFP_ATOMIC flag
 after local_lock_irqsave
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 10:41 AM =E7=8E=8B=E6=93=8E <wangqing@vivo.com> wrot=
e:
>
>
> >On Mon, Jul 5, 2021 at 9:57 PM Wang Qing <wangqing@vivo.com> wrote:
> >>
> >> Use GFP_ATOMIC when local_lock_irqsave in __alloc_pages_bulk
> >>
> >> Reported-by: syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com
> >> Signed-off-by: Wang Qing <wangqing@vivo.com>
> >> ---
> >>  mm/page_alloc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index d6e94cc..3016ba5
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -5309,7 +5309,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int =
preferred_nid,
> >>                 }
> >>                 nr_account++;
> >>
> >> -               prep_new_page(page, 0, gfp, 0);
> >> +               prep_new_page(page, 0, gfp | GFP_ATOMIC, 0);
> >
> >Hi Wang Qing,
> >
> >I didn't get the point here. IIUC, prep_new_page() will not allocate
> >memory. So why do we need GFP_ATOMIC? What I missed here?
> >
> >Thanks.
>
> prep_new_page() will allocate memory in some scenarios. For details,
> you can check the bugs detected by syzkaller:
> https://syzkaller.appspot.com/bug?id=3D91c2030241ada0e5d21877f8f2f44c98cf=
fc04bb
>
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
>  ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
>  prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
>  __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
>  alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
>  stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
>  save_stack+0x15e/0x1e0 mm/page_owner.c:120
>  __set_page_owner+0x50/0x290 mm/page_owner.c:181
>  prep_new_page mm/page_alloc.c:2445 [inline]
>  __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313

Got it. But I don't think the fix you mentioned above was
appropriate. What if GFP_KERNEL | GFP_ATOMIC?

Thanks.

>
> Thanks.
>
> Qing
>
> >
> >>                 if (page_list)
> >>                         list_add(&page->lru, page_list);
> >>                 else
> >> --
> >> 2.7.4
> >>
>
>
