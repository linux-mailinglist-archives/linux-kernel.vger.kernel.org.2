Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394F244303A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKBOYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhKBOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:24:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E023C0613B9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:22:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id g3so4088834ljm.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDaXd54uUw4cuAEtFwh6e0QjRhac1tHiBl7h6VYXG/c=;
        b=QJn/USQbVp/0vR8XPnX2DMLOk3xYoQA/IM8xLrQIehB8YQx5EukbUbA/mJHcXBpby3
         XB3CU9KVNX2xorF1SURYNJchcROb84nHp/wT4k3RkvubbLHpcf5umpqh7oT/YGBrFg5o
         5bIGMLq+CBa1V7G1XxdUCu8mhgI45tMVNGe1/xU7swzROHApnGGzelcn63q4fPmgWgk3
         an6jWvsRGND6+sKSiZ5kcbhF8zSsbwYfbT9H+tEVWWATJ7EsoeVELfZM+/g0xmBQf0lP
         hMTu50wKJp1inyMNK9NUStV8uJdPfgikGifEmJ77hVT/rA/o6gK6IprmIib98NvDsNkN
         lZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDaXd54uUw4cuAEtFwh6e0QjRhac1tHiBl7h6VYXG/c=;
        b=dKjBhnctGSeVIJ/orSqRVh8/1PBB0i6qCXhhpPLHO0IVTRQxLvBKVySDygIyv/sd3z
         LJwt41u/CfNrklefufApQu4xK2EiYngkSQVYM7xQLbo0FtqqE9JeNjhdcoutredHiuc0
         MNSveu2h7q1Lu5XSz1/Ed8o0Uu+CLbYH6mmi8KWSbKTA7CCRNU7CPLyv7aGz3RWrogmQ
         TqxtvtAB9O98jRaTzmwAZMMFVPI5AThTgB4peRSb3C1mSDWv9rM9xPTv9glMoRt+BhNE
         tFWj6P9WEoXQ3nRac2aTBh1yXI+zBQRJX/Hsn5FTeQDJE8w6KxIwf24su2d6XFDq3V5f
         uQRg==
X-Gm-Message-State: AOAM530EeadsAHdGXBnFpaVYFNsgeT0x7LahUzoANNeo6xm4Fj7QRfZW
        hNQ8Dp8RhGkaS0zjUSRNhXXDFLGAZgKyRMv7MJ+cHw==
X-Google-Smtp-Source: ABdhPJyf0eK9gsVbstxK6js4ihBySx4yiEGuDCPLxe50BGOWH3Y5s+lTtWl2LNOgFBO2Yteg9XCwseMfb1l8C1YqPzs=
X-Received: by 2002:a2e:161c:: with SMTP id w28mr38245243ljd.132.1635862920249;
 Tue, 02 Nov 2021 07:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211101172127.3060453-1-pgonda@google.com> <20211101172127.3060453-5-pgonda@google.com>
 <952fa937-d139-bd90-825c-f7dfca8d8cb9@amd.com> <CAMkAt6qdNWP-Ka1N=0d16Q1TrbHPXPEkdLoxC8ndsyid-dqA6Q@mail.gmail.com>
 <d6fc38fa-1caa-289a-ae92-102a96638560@amd.com>
In-Reply-To: <d6fc38fa-1caa-289a-ae92-102a96638560@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 2 Nov 2021 08:21:48 -0600
Message-ID: <CAMkAt6qBGckrBje6B0i5JTD5cK9ASViAZZrAPOcyzHmpVnmRdg@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] crypto: ccp - Add SEV_INIT_EX support
To:     Tom Lendacky <Thomas.Lendacky@amd.com>
Cc:     David Rientjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 2:02 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 11/1/21 2:18 PM, Peter Gonda wrote:
> > On Mon, Nov 1, 2021 at 12:41 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >> On 11/1/21 12:21 PM, Peter Gonda wrote:
>
> ...
>
> >>> +
> >>> +     fp = filp_open(init_ex_path, O_RDONLY, 0);
> >>> +     if (IS_ERR(fp)) {
> >>> +             const int ret = PTR_ERR(fp);
> >>
> >> I don't think you need the "const" here.
> >
> > Sounds good, removed. I normally default to consting a variable if I
> > don't expect/want it to change. What guidance should I be following
> > here?
>
> Heh, I don't know... I guess since its in such a short scope it just read
> easier to me.  But, you're correct, const is appropriate here, so I guess
> feel free to leave it in if you want.

Thanks! I'll remove it here to be more consistent with this file.

>
> >
> >>
>
> ...
>
> >> "SEV: write successful to NV file\n"
> >
> > Updated all messages. Should have noted the "SEV: .." format.
>
> It's not like we were very consistent originally, but it would be nice to
> have the new messages start to maintain a consistency.
>
> Thanks,
> Tom
>
> >
