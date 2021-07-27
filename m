Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272403D6F70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhG0G2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhG0G2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:28:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44619C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 23:28:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c16so9041488plh.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 23:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0G+NqzAvfTHBs08uzNiyXIWeT1GpRd5xZS7if6Ooo4=;
        b=FrPUfnll9HAo8rg3rm1L8BgZvinjoYNWLsCe8VF6qjOOpOkkykOA87p1JbNe/822c3
         BwYbIlrg8BRC6k8XpCLXK+/4ZGkbcaGyfWweHzMUeNy8zaiBIcCZtPG/J3ppVZWCHF+K
         VpZsA6Wd3wtvbSnt484EkAVs2ZPXD/LAUHRdzPQMCRxmaHp5KuJNXJ2u3QuIJmEqK5Yb
         nbJuWO6wvlAUDc+XnhL8dwUCbZsRep7k4YnwN1BPkQeZA8PzKMK5MNN98jUF0oc0ISsV
         athIfcL1cNF89Rt5dKWaJ2tKqjh6+bvpmVTwg7X5vJjnTRrLIGrfU6SBSfP+SrzZ5dQK
         pB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0G+NqzAvfTHBs08uzNiyXIWeT1GpRd5xZS7if6Ooo4=;
        b=lJuhIpOwpJkAGpKZegYhVeOz05NxYp1AKx5+0F+BQ10L3DbWClR40jLmV4IS5yRJUV
         k72RP6EKRzpvCnhHoKjelLRKTy7/qLxL7BfjtSBDXNgOabaZxkfzjT85T6rOSq7sNb3f
         /pkDt6gPRV0Onj38SGSnogizOrQky+eYLl0QvHUUKIAUTJWIZrsqho0rtMgN2UpInVw8
         lLyagfSFBTFUoExkScwL9MD7cz4Tmlj5rtVaFhYj4jXD/a3dgnt68bxAlZd+FY/Jokjv
         a6mOFc8nrgEW4G/iIpMALMXobvnO5LWvzMscOlNFhoYF0bOUXJr1vLNX11Tbd4T5vfFU
         FvrQ==
X-Gm-Message-State: AOAM533J2om49pXPBgHzYDpkZjSg89MRrGR9IxbjU+btdrIlgKa6A8uu
        5HFUtthmU1is6oNoUZj8iQ74Hpsbd2hAe2SVlz25Fg==
X-Google-Smtp-Source: ABdhPJzuYi4yIxwR2z/828VWqqpEpUF8Kpv2lA+SMK6YDA0+3Ql9hzanK7UNiIoyuHmfgc7y3xVI6zP3wXj+lYX+3Ic=
X-Received: by 2002:a05:6a00:1508:b029:332:3aab:d842 with SMTP id
 q8-20020a056a001508b02903323aabd842mr21474337pfu.59.1627367288681; Mon, 26
 Jul 2021 23:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091800.42645-1-songmuchun@bytedance.com>
 <20210714091800.42645-2-songmuchun@bytedance.com> <cf279a44-2a1a-6385-8230-86e083e11ba0@oracle.com>
In-Reply-To: <cf279a44-2a1a-6385-8230-86e083e11ba0@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 27 Jul 2021 14:27:31 +0800
Message-ID: <CAMZfGtUtk9uyO7v0v94YqLaHhrZ-CoFvVH60n54apib7PHPcKw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 5:04 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 7/14/21 2:17 AM, Muchun Song wrote:
> > Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> > PAGEFLAGS_MASK to make the code clear to get the page flags.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/page-flags.h      | 4 +++-
> >  include/trace/events/page_ref.h | 4 ++--
> >  lib/test_printf.c               | 2 +-
> >  lib/vsprintf.c                  | 2 +-
> >  4 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 5922031ffab6..358d3f6fa976 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -178,6 +178,8 @@ enum pageflags {
> >       PG_reported = PG_uptodate,
> >  };
> >
> > +#define PAGEFLAGS_MASK               (~((1UL << NR_PAGEFLAGS) - 1))
>
> Can you explain why you chose this definition instead of
>
> #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
>
> and mostly use ~PAGEFLAGS_MASK below?

Hi Mike,

Actually, I learned from PAGE_MASK. So I thought the macro
like xxx_MASK should be the format of 0x00...00ff...ff. I don't
know if this is an unwritten rule. Please correct me if I am
wrong.

Thanks.

> --
> Mike Kravetz
