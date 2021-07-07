Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777DF3BF06B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhGGTpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhGGTpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:45:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB511C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 12:42:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r26so7131092lfp.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRtFQfyk5rkHzCvBDJ7m/53ib3pszFLVwjo8wznH6UE=;
        b=yFcO6aCHT5Wp8XcHLs3x7QjI1v+tekgMJbmj6pPFaNrWmUZ3yjUxexHb2wvivrLnvk
         wpPtu8QUxvDBn0Z7SDU7DAa/e8ONb2256TAahLeb4MKewzgad9koVgCZx/tc9KSYH8Nk
         MkMQmMz/XSiGUA513D3Y2WGA7AY6rnls41T6Neg+NDC2MyS5DPdVLd+letBRoFYEz5Vy
         XFdsxz/8jbYQwq88kH3vktlGJdUyOxN5GUjfgp9sXS9tdux2jP8qSeBbCa+7nhGIfXzW
         xW3bjO1Su9ioQZNguLLj3A4OlCZGjhI9jOoxP0iPSTjeO0IWgWxPafFneFHgMuxtuEMJ
         nsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRtFQfyk5rkHzCvBDJ7m/53ib3pszFLVwjo8wznH6UE=;
        b=gZXA5hqMOInovZx08afERa+74QD8ELAOqkfXfdoebG395UZStiC2eLp2ZeuQTC+29j
         CRjYGzYk5BLUnPuBd3OilQEGf1hFu9euFjD2CtyJJrHiqvjwUnA0eOJeuI2fMJBDpQwu
         McQ1aDk+cUwYx7eVIUw0mpw1qhG+9sY8orXPZYt2KJrmnhz3o+GVakN7hd14Zyodx36M
         WzXpcNYL1AV8yUZ9FuA3vYB5aqfEbmiGm7oM5vJul8z/YAGN33nyDM2WWHcQGZQuY8dq
         hkYNBdh9Q7kC06i/ayb4I84BnFHNwZilFN1qzHvaEuehpruXPLSqGZz91EDhS3ieRvMU
         kHZQ==
X-Gm-Message-State: AOAM532BcDKVMPxycy6ybemDxyQJX8DGlxEbqv7VN7TxQQbQ/iiwWjB5
        DEemaB0W7Dxy0KNEK9EiBYB+cLM1JovjmDNLdQgGfw==
X-Google-Smtp-Source: ABdhPJwxhl4aUAm4oVA+H8xrPvcXq5kElGbA8grQFD3N2KD69Hh/pYn0WdVnS32vEA1aPDwawe5JdRzQHP5s+cnOh2Y=
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr10051224ljm.170.1625686971167;
 Wed, 07 Jul 2021 12:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210630013421.735092-1-john.stultz@linaro.org>
 <20210630013421.735092-2-john.stultz@linaro.org> <YOVL1f4m+8ly9fyM@infradead.org>
 <afea8c13-ef8d-7eb1-c362-8d6d1649751d@amd.com> <YOVUX1ZmZ3YZpjic@infradead.org>
In-Reply-To: <YOVUX1ZmZ3YZpjic@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 7 Jul 2021 12:42:40 -0700
Message-ID: <CALAqxLXEcRufetNJo6ZETs4OyFWdWE3uU7_zOzVVcRtkkhYiyA@mail.gmail.com>
Subject: Re: page pools, was Re: [PATCH v9 1/5] drm: Add a sharable drm
 page-pool implementation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Christian K??nig" <christian.koenig@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        "??rjan Eide" <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 12:15 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jul 07, 2021 at 09:10:26AM +0200, Christian K??nig wrote:
> > Well, the original code all this is based on already had the comment that
> > this really belong into the page allocator.
> >
> > The key point is traditionally only GPUs used uncached and write-combined
> > memory in such large quantities that having a pool for them makes sense.
> >
> > Because of this we had this separately to reduce the complexity in the page
> > allocator to handle another set of complexity of allocation types.
> >
> > For the upside, for those use cases it means huge performance improvements
> > for those drivers. See the numbers John provided in the cover letter.
> >
> > But essentially at least I would be totally fine moving this into the page
> > allocator, but moving it outside of TTM already helps with this goal. So
> > this patch set is certainly a step into the right direction.
>
> Unless I'm badly misreading the patch and this series there is nothing
> about cache attributes in this code.  It just allocates pages, zeroes
> them, eventually hands them out to a consumer and registers a shrinker
> for its freelist.
>
> If OTOH it actually dealt with cachability that should be documented
> in the commit log and probably also the naming of the implementation.

So the cache attributes are still managed in the tmm_pool code. This
series just pulls the pool/shrinker management out into common code so
we can use it in the dmabuf heap code without duplicating things.

thanks
-john
