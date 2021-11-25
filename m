Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A49045DF9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbhKYR0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbhKYRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:24:39 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BE2C0619F6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:14:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b1so17825119lfs.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4bw++geKzggzEo+/4ZRu2MQsYbbAkbBIfq6b5JxF0s=;
        b=seinNde8Pld/Lxgy1oZgDrIbJIQ4AdF3GzjG+yKQ5OjYANP+s4qsGAg/sid3k2G/Qq
         qlvp5Bbrg5slnuK8pCoDzZb0pKaqPsNjh/N7glo7ZiOuFzg2BxUeaJB/5v9G5+ggaXMM
         99jUghOJG5KtKZaLkUU9iF4W1/mrlbcVPHaQAlL0swrwybwXjtvqDiZkz41WBFnT6xtp
         nKwqzHC1uMmQpv83xCrASc73KRGjzQt06yBTJw9zUMGUOT6obeDvdD6fQeSwvrcwNvDI
         iZpZukviJmJUuq5Cg3ug4VxznTVCRd0ftt7JX8TOOXXQcFpXs1wVrcuKFcszMs4zPADO
         vs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4bw++geKzggzEo+/4ZRu2MQsYbbAkbBIfq6b5JxF0s=;
        b=FVqDN30rVTra4yu3nyYz1pbNXbh2ocLJn1yV6hkCuF2xp5iS73X43T4eMSQ+kLlvwn
         hjokHvDV4i1ThJCsRRTQUPV2qdzhXj0WZOARp7NO+y4Sunng8v6R+jPGE2Onic+WFoSC
         o4hUy9DsK9tmVyM44jg5cf8f1yqadD7LRWCuYYgoiNu1GiPnlE1NbORv8hLYcAZ924/a
         aCE+Qk+wVkOHQLRyPf97sIt+xnT83+KKZtG9A0BOrMxwAMzR+M5lu9+Gpr2jmPHKxPle
         WH8FNDhQqmXqn3aoTxBQHrTULRGziY5l5B7DI4IfSeqReaGvbSjxcOI6osNsXKA0YtaS
         YG2w==
X-Gm-Message-State: AOAM530uBxr+pC3B/LPstdz47ls1Ew1e6e/D2YvGaBLeM3lkMn5UQg78
        2QVLpYoHeScK83e5yvLDP3U+31BvH6G9Mrg4QNzF1Q==
X-Google-Smtp-Source: ABdhPJzhnqN3fgnk04ujllRzvLeZSR5igv8VPqeJoJG0Z1Ew1/+FQe4/pVRQWRKEbXtY7AZoF0QCAgVnBypeTdWXYHg=
X-Received: by 2002:a19:6412:: with SMTP id y18mr25444303lfb.494.1637860482082;
 Thu, 25 Nov 2021 09:14:42 -0800 (PST)
MIME-Version: 1.0
References: <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com> <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
 <92fe0c31-b083-28c4-d306-da8a3cd891a3@redhat.com> <CALvZod4C1V6Gk96oMCMguaqChjggH0KH3KKcU1QOmjRG+QEAbQ@mail.gmail.com>
 <c61a6f30-ed62-7773-3371-981102f6804f@redhat.com> <CALvZod7xTfg5aeQC7-EaOZJ47Twb8CkoS6u4C=8+y+AX-NREVw@mail.gmail.com>
 <1b400921-8bef-8073-10f9-a7cbb09cfefe@redhat.com> <CALvZod6wyF7v1v888StoXSSWtb7ujaeBUnUB8Vs2RfMzUsj+Gw@mail.gmail.com>
 <YZ9gz8WGic8QOTxE@xz-m1.local>
In-Reply-To: <YZ9gz8WGic8QOTxE@xz-m1.local>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 25 Nov 2021 09:14:30 -0800
Message-ID: <CALvZod5166ReiM7J6kbky6+nRxiY5KbAdx4Yh8njnPddR+nXdQ@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 2:09 AM Peter Xu <peterx@redhat.com> wrote:
>
[...]
>
> Hi, Shakeel,
>
> I saw your v2 has started to pass in zap_details, then we need know the side
> effect on that skip-swap-entry thing because with your v2 code munmap() will
> start to skip swap entry too (while it was not before).
>
> I saw that you didn't mention this in v2 patch either in commit message or
> code, not sure whether you digged that up.  I think it needs some double check
> (or feel free to start this digging by reviewing my small patch above :).
>

I remember mentioning in the patch that this has dependency on your
rfc patch. Just checked again and yeah I only mentioned in the
'changes since v1' section. I will add it more explicitly in the
following versions.

I will take a close look at your patch as well.
