Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E1F35A7A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhDIULD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIULC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:11:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA2C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 13:10:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd23so1878812ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lf36qlPIx942AzqupP75X0tTf2UJIm0G/Hhd8SI7Wag=;
        b=dCuXmXCO7osXPm0KUMVbp3DjgNxfeINyZ7M9kdP1FBxyXvyE/CsvJ86jTdR5rNej5r
         6EyM7nzOldp2Q+IyngBXac2jSvnptdRK6X95AhPRvheloHmPhr8XMlSuhEKEyk6hu9lW
         u+VZPfb9jkRkph1fGf1r+ETuVj/kBSnpQ2r2FEn8gwL50XOcMdJ/a9W4zR9tKwkR+IC8
         /HZQxO6w4VMG31bh1uf9lw5g8g+FieBzt4FDv36V1M43W30HKd7EHsFM5OZlT9GrTmbT
         xef0CYt9sh9U9evlE/35ZRDimJraJT9Vynttw2SNK6lJYxXZ+BWzOXhi4qHhbkJEXoAE
         GyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lf36qlPIx942AzqupP75X0tTf2UJIm0G/Hhd8SI7Wag=;
        b=Gejp6nMT0WQ6RZsJie3bkkaYwTWXTBL4MF/sy+NAMGXXJRtNx665i16TKbToW5CZDK
         DCULEr2Rojajzy+yEGb1R1i7IGiFJI/ZC2dkzEAoxmaufKxWov67onM3nqnNt+2eA7t9
         CKzZYpu+KGd2TB4PlkyG8+PZxiTxezK1A08m1/tH0OAOJ/LquoE61kMy75yFinMKWHe+
         2McqKoXNA/h0VhWtgBnirhigLA9wt0zQ073bJ2/oolvgM4tm39ekIMToRNKnXOmPaWnB
         SU/bCOT0dA7NguVtmAaoXRF94yvE2jn4woVB19lA975l2o9p9kixDRj4zdJVGi3f/Mbx
         SAeg==
X-Gm-Message-State: AOAM531QlPLY0kzRyBLCu8XAZSiBqbaPogVAcTmY7aJHA7gUkABfusSx
        glCXRN6tlPgsjJd3Wskd1RBpnaeCQwz2Nb/gMlY=
X-Google-Smtp-Source: ABdhPJyeF4EqtX9vvgTqHhPKB0yFPThkRwGjIgW+Sz4j34OntIYLyYxDMUHW2X1P+C/I6IFRAJp3ZS6a8kAhXr8rgOM=
X-Received: by 2002:a17:906:6dd9:: with SMTP id j25mr17395712ejt.507.1617999046419;
 Fri, 09 Apr 2021 13:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183223.80F1E291@viggo.jf.intel.com>
 <YG7XjTG9tiK29y1j@localhost.localdomain> <CAHbLzkqoaSnuBJMAe_heQt01FuPWODYQHJ955gaJNNojwbUjrw@mail.gmail.com>
 <YG9IthpDC/lri4Qh@localhost.localdomain> <d200de95-c6be-75fd-7302-e5368894d201@intel.com>
In-Reply-To: <d200de95-c6be-75fd-7302-e5368894d201@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 9 Apr 2021 13:10:34 -0700
Message-ID: <CAHbLzkrsxh-Vq0KTpbtnJZSMk0waC7aooYYxXodo-L15KRVbKQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return nr_succeeded
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, weixugc@google.com,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 8:50 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 4/8/21 11:17 AM, Oscar Salvador wrote:
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8490,7 +8490,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
> >               cc->nr_migratepages -= nr_reclaimed;
> >
> >               ret = migrate_pages(&cc->migratepages, alloc_migration_target,
> > -                             NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> > +                             NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE,
> > +                             NULL);
> >       }
> >       if (ret < 0) {
> >               putback_movable_pages(&cc->migratepages);
>
> I also considered passing NULL to mean "I don't care about
> nr_succeeded".  I mostly avoided it to reduce churn.  But, looking at it
> here, it does seem cleaner.
>
> Any objections to moving over to Oscar's suggestion?

No, fine to me.
