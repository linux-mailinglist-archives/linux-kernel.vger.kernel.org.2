Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F186644BACD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 05:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhKJET0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 23:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhKJETZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 23:19:25 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7835AC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 20:16:38 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 131so3067874ybc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 20:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCsAieRHfHn5cktrSz+nVZwZNS/wLjeQ3hgn+o0ozPc=;
        b=Mli8Tpm92EpuCHNFjuUQRfDwcAszIdAOHGuXXLHaS9oy6j2R/8KrD1Peoh1KTFzFPW
         xDtUgwfjZFY2+gdJYaKacLnAnpNfHJRPg9O5hzgzh1VhZNIty3c2xcylE7658khhy2XZ
         IEEgDi3ErDUgbp02CZkNpNB5IJy9SjurGKLg6RXgLWpBr0GjaeLjoBSy2N16YGwLxKco
         7wYauAm4ammTVxANOWZH3kvyG1A42SgzIyDm3U673kGoIsIEb6ZryYHbkpaLjy4jq/0u
         RP0DeQHzy8PCdAWXe6M5NmooNYH20zgL0upm6Zw3n+aBTbah02nvZHUA7ojHt8yZwcAw
         d61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCsAieRHfHn5cktrSz+nVZwZNS/wLjeQ3hgn+o0ozPc=;
        b=RSac4KKT1D0yQdvLFpMpQ2oQC4XI8Np9+tFfc9KxXW2FBxtrO24cPIUuxfqc3KDuu9
         omjlQuPOsxh4Y5xIbjBjYQegQ7HoArIkLD3iT8hoCAtN8QVOzbqNbAykFl5xuUHjM5Ye
         aRrSDSU4bS5wqFRjkcrss5RMbbiWm9ysuACssz2MuRH92Wg3YjFVjj9rNzhaLtNigtxe
         1JgGULxpLnHLLxFGrMdq+w/8LwLlHvJvdnWLSR1BZ1BI2DbW1CkcQ9GbGbTbEFSx6RRX
         dpTVbXaxieSzwDlRwp5CyJPfsTawUuk/8ewB6f8cmrkj/7iGUZNMfRXJewa2vpYQDhe4
         vASA==
X-Gm-Message-State: AOAM532wsjpRD5EIMO1/vbjC+2ne55YBndlj7IPXzTMGgqK+IOLvwyKa
        7kZ+iO6nbGr6y4F5dIrxxZIM6aRYlR3XpphM8xhi0A==
X-Google-Smtp-Source: ABdhPJwi6CPZJmcjD6FkgBTubgTI/S2YDDH+oxUbzJdD4c92D7cNRpEkEw/YAg0DMrIBSl1vYzUxavKDs60vRS4LGHk=
X-Received: by 2002:a05:6902:72f:: with SMTP id l15mr15160277ybt.279.1636517797662;
 Tue, 09 Nov 2021 20:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20211110033221.22083-1-hanyihao@vivo.com>
In-Reply-To: <20211110033221.22083-1-hanyihao@vivo.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 10 Nov 2021 12:15:57 +0800
Message-ID: <CAMZfGtXbSgLQD2MSda0YoXNUioAzVhQmH5YpSsFLZ0vSMiEHUg@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: use swap() to make code cleaner
To:     Yihao Han <hanyihao@vivo.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:32 AM Yihao Han <hanyihao@vivo.com> wrote:
>
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
>
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
>  mm/damon/vaddr.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 35fe49080ee9..414d9fb9c827 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -100,11 +100,7 @@ static unsigned long sz_range(struct damon_addr_range *r)
>  static void swap_ranges(struct damon_addr_range *r1,
>                         struct damon_addr_range *r2)
>  {
> -       struct damon_addr_range tmp;
> -
> -       tmp = *r1;
> -       *r1 = *r2;
> -       *r2 = tmp;
> +       swap(*r1, *r2);

IMHO, I suggest removing swap_ranges() completely
since it's only a wrapper of swap() after your changes.
The caller can invoke swap() directly.

Thanks.

>  }
>
>  /*
> --
> 2.17.1
>
