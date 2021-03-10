Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1662D33482A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhCJTkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:40:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233816AbhCJTkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615405218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BjOJ0dCqhdIeLq3n4wL65+iP7wjuw6Bqt//gPOcAu8Y=;
        b=iIuHWLGztyiZnK2kuPkPg2N3VHeGwSR0mafzfGHLtubJkg38B5Og6ajPWKoFP1Z6kPCc7W
        p7wPUO/wNNyKWLnk8+plRL7lTGEHyFO0YPIQX4dzrGu6YSi5gpCNCLQO4Bakehy+VyWCLM
        auKCRqBth3NLfuGP+GUS6IsH02dlJVA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-FLAlDuQvOl6cuaq3k-UPBg-1; Wed, 10 Mar 2021 14:40:16 -0500
X-MC-Unique: FLAlDuQvOl6cuaq3k-UPBg-1
Received: by mail-qv1-f70.google.com with SMTP id u8so13497663qvm.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 11:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjOJ0dCqhdIeLq3n4wL65+iP7wjuw6Bqt//gPOcAu8Y=;
        b=UkojkuiKHIbKxchGhozkRL7RZKx8UIaTGp6ikQ74prq+HIY7rxPp1sEIUoWM/5+XB0
         W9bcRqXkOqQKXGDzkES8DabUYx6/DoWvvfAKqXz+ATylscDG97hGslf1FTwu8H2E+T0b
         2b1FOnI3Fo5cHHERpc/9Nlb1+dxkfVCFA4eMB8ls5VrU/O8u4D6y8qoGk1QGm3/7sSu1
         +Av2+C43UUF3W8CiR+ubfgY1YCyIY+8IBckCe8ErRCG7JiNrU1hwGQsrWuSpvB5qdtaQ
         HH1QnpiQSqS8R3tYR8fAxPMTmvCNkweVdEGhr+g6+rxNsdpxYXMhnlcaoCwQe4CawbIC
         u4Kg==
X-Gm-Message-State: AOAM530+puyJBcoH61ww02EfULlUu69uE/NVVKCYtql8sRw+ZrRPGqbq
        kBIzj5Bq8z2kC+y3T8g3bgM4sHKbuLXNaUUoAlQy4bTdkT2csegglBZnh0KLUHR9ibKmYSMr/MO
        2ALJWi1Y2TgFjdsLIEerDc8Mq
X-Received: by 2002:a37:9444:: with SMTP id w65mr4271280qkd.88.1615405216145;
        Wed, 10 Mar 2021 11:40:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOvTvsteE7aCYhpK18aeuxfi8A/1tgyWbU+qZS807rgYUZyq5xPe1e+WnK0uLo+Q/nmdz4ag==
X-Received: by 2002:a37:9444:: with SMTP id w65mr4271265qkd.88.1615405215943;
        Wed, 10 Mar 2021 11:40:15 -0800 (PST)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id j6sm233211qkm.81.2021.03.10.11.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:40:15 -0800 (PST)
Date:   Wed, 10 Mar 2021 14:40:14 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] mm/hugetlb: Fix build with !ARCH_WANT_HUGE_PMD_SHARE
Message-ID: <20210310194014.GE6530@xz-x1>
References: <20210310185359.88297-1-peterx@redhat.com>
 <debfe3d9-3d8b-af2a-de23-b927bd119e4e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <debfe3d9-3d8b-af2a-de23-b927bd119e4e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:21:50AM -0800, Mike Kravetz wrote:
> On 3/10/21 10:53 AM, Peter Xu wrote:
> > want_pmd_share() is undefined with !ARCH_WANT_HUGE_PMD_SHARE since it's put
> > by accident into a "#ifdef ARCH_WANT_HUGE_PMD_SHARE" block.  Moving it out
> > won't work either since vma_shareable() is only defined within the block.
> > Define it for !ARCH_WANT_HUGE_PMD_SHARE instead.
> > 
> > Fixes: 5b109cc1cdcc ("hugetlb/userfaultfd: forbid huge pmd sharing when uffd enabled")
> 
> That commit id is from Andrew's tree and I don't think it is stable.
> There is a different id in the next tree.  Not exactly sure how this is
> supposed to be handled.

I see - it'll be even better if this patch can be squashed into it.

> 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Axel Rasmussen <axelrasmussen@google.com>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/hugetlb.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Thanks Peter,
> Not your fault, but that header file is a bit of a mess.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

I'm still guilty on not noticing this before since I still could..  I think it
gives me some more clue to make less such mistake in the future.

Thanks for taking a quick look, Mike!

-- 
Peter Xu

