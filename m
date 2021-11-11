Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9541D44D667
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhKKMP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhKKMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:15:27 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C6C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 04:12:38 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id q74so14459625ybq.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 04:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzX0j/pXSoaKsl6RsYsXPTfSGUQR1MnGXUzur5DcEnE=;
        b=ROg6S+2bDI17/ri6eg2myT8UBjMjm9ZxL3/wG/uq9uTWC5HyvwVwosUFt/wMt1Cdvp
         ey6+W1k+pK9lcIuE8sldf03jhQdcvOfPL6T9rmV2wqZq83+tTOGtaOztj5WNpcm4cmVZ
         hPL4gBYQs4FppDNuC1JehW+h/5I/yRL1MCxOq8N4+FLNjXZR91p/SAKoRR7Rspj1xmTU
         nk7A0IG5VklPhsrwUXpkQ+8GEva0P6utCVLHIz2OKf49JKTYi6B6fkj/rOdW9LktknLC
         pQMzu4uV3h66+N7TTS6LqHVGm9lqtBGciTMqW0KM6SwoqakoGNnrCRlpNBhDuDO1mAPg
         iZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzX0j/pXSoaKsl6RsYsXPTfSGUQR1MnGXUzur5DcEnE=;
        b=3Va39tSAatWGtfbxBN5g+yFkcJjcwwK4FT8YxflakWJ5ZwdYr4HNsnnoO1aebjt/Ol
         h9NyoXqFDckV3qtpiCzvqmVHFtXzPFVJ2eA+mHBpZWZ4FqcLE4je50rcx4n26Y0Wf7zi
         yNbtb3KWXQrSGClRNVMn/X0CAuUDM3QLvAFSy5RQAmUumYL0jskK7khNkYPzHwHCBYrt
         DbxaQxvVtVU1EbNSU5sVOrtfTaXFdlP9TYZHLvu97LSx2l7LqEzdSfeybWeVIeM0b2S/
         ojMjs/Bo2O2Bt6/b1+WLnU2jsZizeCuMN2raEAPOOPAYJShz2RSPLdh4WpIQMc7UXXuo
         jE1g==
X-Gm-Message-State: AOAM533abpS0wengwbxta5zZ8f0a9KPLnNAAZIasw10cW0FLHb86vuAM
        RDnc8cgZEd4Jm6jplxbPU2eD3axng0uNPWaSIVl4sQ==
X-Google-Smtp-Source: ABdhPJxOyeHjYITOB8RJtUXaN0LJVFxZIppfhk4ltjrXDzQhxWLVS8VSQXpjbHiWUjS7HxB6Ce2sDZkUmyUsw5VPnOE=
X-Received: by 2002:a25:b0a8:: with SMTP id f40mr7074181ybj.125.1636632757819;
 Thu, 11 Nov 2021 04:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20211111084617.6746-1-ajaygargnsit@gmail.com> <6864f744-ca3e-f328-8793-2adb0146db03@bytedance.com>
 <CAHP4M8VNZY+NLzUAVHTWK6a6pggvv4a-q9nvYAqkkco6id3Tog@mail.gmail.com>
In-Reply-To: <CAHP4M8VNZY+NLzUAVHTWK6a6pggvv4a-q9nvYAqkkco6id3Tog@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Nov 2021 20:11:56 +0800
Message-ID: <CAMZfGtXCFJ3NUw-bBsphLbCtdDAfHERAEkTSMU9k1cfd4DrRMA@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 7:40 PM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> >
> > How about the following changes since the above if block
> > already do the judgment?
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index f0eee4e221a7..0c84b6624026 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -4195,13 +4195,13 @@ struct page *shmem_read_mapping_page_gfp(struct
> > address_space *mapping,
> >          BUG_ON(!shmem_mapping(mapping));
> >          error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
> >                                    gfp, NULL, NULL, NULL);
> > -       if (error)
> > +       if (error) {
> >                  page = ERR_PTR(error);
> > -       else
> > +       } else {
> >                  unlock_page(page);
> > -
> > -       if (PageHWPoison(page))
> > -               page = ERR_PTR(-EIO);
> > +               if (PageHWPoison(page))
> > +                       page = ERR_PTR(-EIO);
> > +       }
> >
> >          return page;
>
>
> You have
>
> * simply put braces (not required for 1-liner if/else blocks)
> * contributed nothing to the issue the patch addresses.
>
> I hope this is not a deliberate joke/spam.

What? I put "if (PageHWPoison(page))" into the else branch,
it should be added braces since it's not 1-line blocks. Why do
you think it does not address the issue? What am I missing
here?
