Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FFD372AB1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhEDNLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhEDNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:11:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CC7C061574;
        Tue,  4 May 2021 06:10:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p4so7376728pfo.3;
        Tue, 04 May 2021 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZK9OQEQteIofKk7KMwkfpXDx0mveLAlNQFksjWalI30=;
        b=fHSPTNymgM+HWGgy6W3XBaxTUpQt9pp5QF3gGArRLc1z/Rsw/rlm01RPpnbtltZb3S
         NNheorZQS05COj8OtXz7h6Z4A9hfrFQPYsYV/3IZT60i/9oewL8e1ZgwZDUMnIEvjTBa
         hA+/YR5yyGYSPKh5g+J6hWdMGghF+3CmUwmI+0sO7EIBBKFCNZmIzA1GM3IKM11BnYSB
         2MEGivyYt1DmsZrKAvELkAdMitwUhNNK2ariVXkjxs5osfw8xnsvf7YZuH2IX06jzTEt
         0lDCjLOtfmqAgs/UkkS5XEy8iZAbFu8Kxr0rO1r1NXoD9C0A/uPzajtAH2FQQWi3PKqZ
         kowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZK9OQEQteIofKk7KMwkfpXDx0mveLAlNQFksjWalI30=;
        b=BGkoxE+ApjvhaBoWuQZGF7i6sLX4sf7BtSEkgLYabUin8s7cHw1bAPJQAPK7UocQ8L
         HUl5aLbzW6JobMI7CPsN7UVOTy+9NkTaIc/z9+bBlIrUTaimDaito+Oi/C/lgWXM7UZn
         7Rwl+kGymqbNP89RdEJedkdYhAUr8xImnqNmHyv4UZ4P58xVvtufHT9ANBQmCyx5a/PY
         wDplwnr2FVQZ2ZYZJ5BAg7A2YfSgSunmMEUnPMs1WegJEceGPtc2/RPLlsT1+O5FCvXh
         kJhPIetinqKL/nlMN44l/1ly7XB7hzuTz+nrxoMSPZd1iOlXWw0iKGrk/uGlwXUhHpLC
         hMTw==
X-Gm-Message-State: AOAM533eGtxN3owuP0AO57WhcdAQVbjljqk9/AOCT3e643qrQ9uiTB14
        Gm6QrB3BaVHIOHfI1G6jg8gOuC2Dax/sMBxmr4CFd2Am1aVBlQ==
X-Google-Smtp-Source: ABdhPJzEzjsS0Ss0IItsofLKar1xLd8nHsjEFk0WLYaflZBMU7XX8/1GR/ro+iRvGAkSIlnrxEKTUPlt0MfH5yc1K6U=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr23542898pfb.7.1620133807633; Tue, 04
 May 2021 06:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210504123139.45101-1-wsa+renesas@sang-engineering.com>
 <CAHp75VdqEa+mRDzwUVix7bY=2R=O0WOwXuLjv=mE4MGGOobYBw@mail.gmail.com> <20210504125130.GA43834@ninjato>
In-Reply-To: <20210504125130.GA43834@ninjato>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 16:09:51 +0300
Message-ID: <CAHp75VfHsMg78vTxEw910ez+28OeNEhzwUQehOHkZxAqePkadQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-laptop: set debugfs blobs to read only
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 3:51 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > Those blobs can only be read. So, don't confuse users with 'writable'
> > > flags.
> >
> > Wouldn't it make sense at the same time to convert ugly namings to
> > octal permissions?
>
> I think this is out-of-scpoe for this patch. While I also use octals
> personally, I don't feel strongly about it and let others use what they
> prefer.

Linus has (had?) a strong opinion about it. My point is to reduce the
churn since two patches fixing the very same parameter in a row seems
too much to me.
https://lwn.net/Articles/696227/

-- 
With Best Regards,
Andy Shevchenko
