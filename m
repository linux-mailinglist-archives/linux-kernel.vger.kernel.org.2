Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5833B3F3B94
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhHURKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhHURKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:10:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B710EC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:10:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so4068536pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KMYRhCleUnsrpCQrbXzZrYt+3Cldg63mJQ1Fu61khs=;
        b=19VJ7fuU92Y/WuP3Z0IlsVsvz8yPtirjrh3a2VbqpuwG0WRZkpa2Hh6JkoQRG8xQWm
         d1EkMRij8NGlvAeBivqVsn4fbX9PnBNiHJnp//OQr9zechEKo9n0d+MIWh6ygJdMysYT
         k8ZuL4C4dj1uTD6xneoESWCv9ZQu4dAm8u/pDdpT5ah5XBn13h1RO4M8T3ULUC6m2TDb
         28zE6AqpVhh+iWq0EaiMCg5W9wObrKeLdKHvRqfIzp5YU5u0v783xA3PIfgUND9NDDap
         t62OcgJGChS7S5l0t7FA5tHsfHEz6oraDSTaGxTJIUbMt9bzqEdG3Mey7dOXcandbHy0
         1Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KMYRhCleUnsrpCQrbXzZrYt+3Cldg63mJQ1Fu61khs=;
        b=W5HxD6enGLeG7IVPQjVpALNS04iPI+IJWuEvjRsSH0PRfrcDLltj8bHpaveiQBwzGD
         zg1fqL3sXigw4MPrDUI86bVuqPnSk7EJR8YRj/DuRp9CO7GcZPGIEpqyOnGvDsg0cwlF
         tU0dWSq/tIQswELk5NP3iTtk+DWU1kEtlwUDYKmcLxNn4v8RTU1y9JIXhLQVuGD66vev
         JbzjaMD5Z9EkioNOxmHbobCPpE0vYdIXdE2s9TB+jVP8LMhOtkZ6GMVOCItCspwpY5Dh
         XMiHhyPYrB+8Fj4Q92MFXAZJ1dbCvmLPqCx3XLyRhaUj74PtaUHDo2DKC12Jp+WBrCK4
         WQtA==
X-Gm-Message-State: AOAM530OjZYI+SMRKRvUb51B/JgXYDIHBv20I8g+GKh8SfdHIEKWCSYK
        71bfNdejl/gFbrMI4LJA7Yi5w78RBl+3SyFx8fCODQ==
X-Google-Smtp-Source: ABdhPJzdWiuAlZusbfPp3FheBWopH/WF+quCCb7hfvhmldROeM2pifqhnBE95CRo7SY1rVFdVKr0Tf2YzdVbNdT9ST8=
X-Received: by 2002:a17:902:6ac6:b0:133:230b:e8bc with SMTP id
 i6-20020a1709026ac600b00133230be8bcmr744789plt.22.1629565813018; Sat, 21 Aug
 2021 10:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210821000508.79422-1-phil@philpotter.co.uk> <ac672cfe-038d-2fe9-0ac6-904ad7761b54@lwfinger.net>
In-Reply-To: <ac672cfe-038d-2fe9-0ac6-904ad7761b54@lwfinger.net>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:10:02 +0100
Message-ID: <CAA=Fs0myhWsn147t4pFfFc=QNc0-4jZaAeREqLGMZ-xN+LNVPg@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove forward declaration of Efuse_Read1ByteFromFakeContent
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 at 15:45, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 8/20/21 7:05 PM, Phillip Potter wrote:
> > Remove forward declaration of Efuse_Read1ByteFromFakeContent function
> > from core/rtw_efuse.c, as the function is defined in full directly
> > after this and therefore this forward declaration is redundant.
> >
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >   drivers/staging/r8188eu/core/rtw_efuse.c | 6 ------
> >   1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
> > index decccf7622f0..45b757ab64e1 100644
> > --- a/drivers/staging/r8188eu/core/rtw_efuse.c
> > +++ b/drivers/staging/r8188eu/core/rtw_efuse.c
> > @@ -29,12 +29,6 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
> >   #define REG_EFUSE_CTRL              0x0030
> >   #define EFUSE_CTRL                  REG_EFUSE_CTRL          /*  E-Fuse Control. */
> >   /*  */
> > -
> > -bool
> > -Efuse_Read1ByteFromFakeContent(
> > -                     struct adapter *pAdapter,
> > -                     u16 Offset,
> > -             u8 *Value);
> >   bool
> >   Efuse_Read1ByteFromFakeContent(
> >                       struct adapter *pAdapter,
> >
>
> Phil,
>
> There a number of such forward references immediately followed by the actual
> routine. I removed some of these when the driver was in the GitHub repo, but I
> missed a few.
>
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
>
> Larry
>

Dear Larry,

Thanks for this, I ended up doing a V2 that declares the function as
static as well. No doubt there will be others like this - I just
picked this one off as I happened to notice it :-)

Regards,
Phil
