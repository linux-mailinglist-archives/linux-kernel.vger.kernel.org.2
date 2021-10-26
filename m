Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E343BD27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 00:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbhJZWZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 18:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbhJZWZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 18:25:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA60C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 15:23:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o26so1373124ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yAbsSDTyXKCbmRqx6GfGJ70j5TRIGVZvHi15gEjZWk=;
        b=WwJ04lDbV4WtjPG362zKNVes5Zgq6jhK5f+cv5F1qrZSm9cyeJ5Bmf3Pe0QyNKWyKQ
         qCPtT9ZuZGN28UcLHc5snwkn329H1tWgqF2HU56yvDBNRbWd8ae/ihD6sAClbDOknFwn
         TEuDKdG9/a+G6HhT5Z/GreNwRGKds+QFkrWneycisHf14Jwr1SfSGL590J8qulBw7ZLO
         C3KAEfcs6p3zs8gMdDvzY+JhTF7AsBGoZai7H6OZ/PE4SbZYb7LQh4ynZS1Ab3nMhmsR
         zckHHJm2gjCUG5UcpUl5+bEBJHvVY6H7R4jJ+CSOP/7GU1uDljeKqcw+NJf6WnNr90C8
         bQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yAbsSDTyXKCbmRqx6GfGJ70j5TRIGVZvHi15gEjZWk=;
        b=VDZFTaTtCdIyeeRbNkzyDrGy03aSvuK4R+OdzO7WbnzXusKldeS/vN2KdQZxvw6atb
         qMWBc/eksqyn3GCMiopROaLTSfsd5z4Jl/I9tlHXpPo+53iW4EVXEWUfACMR+/MxqQZU
         jNlmldVD1KRmGZ2ZR/u7sR2DHp1ZXF5PWxhHFujM1V4SS9BRiY7pbI+p9/7BS/KPjn6p
         tV5djzY4U6QTt1xLIJ7mkRq346gQI55IKnYXTjEY/9eooivnbbRObAwOwyACiDdP1uv1
         YG9+SCuJ95OxgwCv7FFssD72OwNcxHulIqfIyCArLXF/1D+4VYEhUA9MvMgQq48hfqUO
         +PvQ==
X-Gm-Message-State: AOAM533P9aG8WF7WLJDTHGnjnpBxlY3y07b9AeYGe8jSDqa/d7ZJXBbQ
        sP9pp4xpP3FGgugOyUVgwbTyaWR5yR+XNaNhpsFNLg==
X-Google-Smtp-Source: ABdhPJxXnc1aAE8cvYRQfGD1NVe+gcg9BWkSLoFndt3NsWEOhwj2NAPZEpVXct6hSZ4d6c+wt4EyHAHK0yGxguSvD9c=
X-Received: by 2002:a2e:8ed0:: with SMTP id e16mr9323697ljl.171.1635287002099;
 Tue, 26 Oct 2021 15:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211026220635.35187-1-mike.kravetz@oracle.com>
In-Reply-To: <20211026220635.35187-1-mike.kravetz@oracle.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Oct 2021 18:22:45 -0400
Message-ID: <CA+CK2bD+US7K+MDdQu7JxheNKpZuD3hi5v7YzOPrP124o8w2hw@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: remove unnecessary set_page_count in prep_compound_gigantic_page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 6:06 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> In commit 7118fc2906e29 ("hugetlb: address ref count racing in
> prep_compound_gigantic_page"), page_ref_freeze is used to atomically
> zero the ref count of tail pages iff they are 1.  The unconditional
> call to set_page_count(0) was left in the code.  This call is after
> page_ref_freeze so it is really a noop.
>
> Remove redundant and unnecessary set_page_count call.
>
> Fixes: 7118fc2906e29 ("hugetlb: address ref count racing in prep_compound_gigantic_page")
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha
