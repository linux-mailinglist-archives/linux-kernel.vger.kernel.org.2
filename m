Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053024543BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhKQJbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:31:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235154AbhKQJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637141284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GW74lTKeqcDtN2h/mSP5w/i30xPY127lVyVN1Tm0gaY=;
        b=Ata4857YmDi2Gi3GwHXEcG79s6zEOL5GBkdICMaZoKo/RoMeNsX+rd8bB1ElWnt5bNyJ7E
        gHA8udtyyVuCyLRTYUlkTxyPRMxWpZtioUmGwtIRDE/lKsm5AbdmtQVCaDCZ69h0c1grqJ
        JJ3XyO/TxVEOzYrkRgUCknPvQ5HHP30=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-QgdPZ7YNN4-NgvcOhvJWtQ-1; Wed, 17 Nov 2021 04:28:02 -0500
X-MC-Unique: QgdPZ7YNN4-NgvcOhvJWtQ-1
Received: by mail-wr1-f70.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso237693wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 01:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GW74lTKeqcDtN2h/mSP5w/i30xPY127lVyVN1Tm0gaY=;
        b=fI68WtD9X+BCXxDHfqm7Vu/R9+QrWyY6SWhhxpE4NkOWVDdqdSJ+0rx0ulHVbsEj73
         wYKAnAg3WRMzsHPJr5UqKazhYgX+eil0nPHZXuksdOClEcqehh1r8H+2ybGBJw//etiC
         6UNig18RC0VoLL65weh8XfsTybaw3go0sTyd2eZU5XJoDdBXfUCohymsSLQb7Rd/p9p5
         zF4DxNQpJRvK1lwbtG5yr/UUL1PlhZLxYT1WoFRDI/XC4r5nDduLz/awla1YER/iGob0
         3x08emZRIhyG2GgBk+S5CKXkxkgIf4ilPqULMa+GWxM5ZDY7LgyA4GzSMyTWwrgwWDYi
         Hx+Q==
X-Gm-Message-State: AOAM530uPtkSEtv+tSo6vNiwNtYij3Z5pFnQzFFIdsueXK3H3fragDTa
        E/gl0AS4mW8tOhcfcy17S/uswMpmm8eqhmdFQmc+sHrM6HNegp4al18Qvft10F/1atvVW/AYlR+
        88+fEgOv4QBORhEo+33aR0VIddFonystspi2GtBpD
X-Received: by 2002:a05:600c:1f19:: with SMTP id bd25mr15829318wmb.75.1637141281264;
        Wed, 17 Nov 2021 01:28:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaDTV+6aHsMLuzIDY2bbJIxOX2vm9dyzDJhrihA4osfWwyGWumuLEHjZwhC1n8gEki1v7Dn61uRsHRD9iWZm8=
X-Received: by 2002:a05:600c:1f19:: with SMTP id bd25mr15829291wmb.75.1637141281059;
 Wed, 17 Nov 2021 01:28:01 -0800 (PST)
MIME-Version: 1.0
References: <720dcf79314acca1a78fae56d478cc851952149d.1637084492.git.christophe.leroy@csgroup.eu>
In-Reply-To: <720dcf79314acca1a78fae56d478cc851952149d.1637084492.git.christophe.leroy@csgroup.eu>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 17 Nov 2021 10:27:49 +0100
Message-ID: <CAHc6FU7AWwpmbMQZu-RQ3B1+i3=ZRDTRgLaue53yz0rd2NiuNw@mail.gmail.com>
Subject: Re: [PATCH] gup: Avoid multiple user access locking/unlocking in fault_in_{read/write}able
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 6:50 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> fault_in_readable() and fault_in_writeable() perform __get_user()
> and __put_user() in a loop, implying multiple user access
> locking/unlocking.
>
> To avoid that, use user access blocks.
>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

> ---
>  mm/gup.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 2c51e9748a6a..be2a41feec7d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1672,21 +1672,22 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
>
>         if (unlikely(size == 0))
>                 return 0;
> +       if (!user_write_access_begin(uaddr, size))
> +               return size;
>         if (!PAGE_ALIGNED(uaddr)) {
> -               if (unlikely(__put_user(0, uaddr) != 0))
> -                       return size;
> +               unsafe_put_user(0, uaddr, out);
>                 uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
>         }
>         end = (char __user *)PAGE_ALIGN((unsigned long)start + size);
>         if (unlikely(end < start))
>                 end = NULL;
>         while (uaddr != end) {
> -               if (unlikely(__put_user(0, uaddr) != 0))
> -                       goto out;
> +               unsafe_put_user(0, uaddr, out);
>                 uaddr += PAGE_SIZE;
>         }
>
>  out:
> +       user_write_access_end();
>         if (size > uaddr - start)
>                 return size - (uaddr - start);
>         return 0;
> @@ -1771,21 +1772,22 @@ size_t fault_in_readable(const char __user *uaddr, size_t size)
>
>         if (unlikely(size == 0))
>                 return 0;
> +       if (!user_read_access_begin(uaddr, size))
> +               return size;
>         if (!PAGE_ALIGNED(uaddr)) {
> -               if (unlikely(__get_user(c, uaddr) != 0))
> -                       return size;
> +               unsafe_get_user(c, uaddr, out);
>                 uaddr = (const char __user *)PAGE_ALIGN((unsigned long)uaddr);
>         }
>         end = (const char __user *)PAGE_ALIGN((unsigned long)start + size);
>         if (unlikely(end < start))
>                 end = NULL;
>         while (uaddr != end) {
> -               if (unlikely(__get_user(c, uaddr) != 0))
> -                       goto out;
> +               unsafe_get_user(c, uaddr, out);
>                 uaddr += PAGE_SIZE;
>         }
>
>  out:
> +       user_read_access_end();
>         (void)c;
>         if (size > uaddr - start)
>                 return size - (uaddr - start);
> --
> 2.31.1
>

