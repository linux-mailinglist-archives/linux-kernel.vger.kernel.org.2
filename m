Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1F53231BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhBWUDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhBWUC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:02:57 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBF6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:02:17 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u4so19108160lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MjjhD2PyEtcxC+ZqCu6N1SO0Pvsotv1wr1KSKHI7fQ=;
        b=b/CmxW7VRnDVhVEKYI0J2I8V9ipMk3X6/a3qiDHR2BPKVL8yLeK5BWmxaXK2khm6TU
         UMAXlOPLj5n3h4dLoXFKdSVOPFPdsm1plweDwwDPWDtpTqA7ZCMQub0imXsH6SOrPM4V
         r2Pb10/ppfku6bByN02T38svCR0IUReoI28Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MjjhD2PyEtcxC+ZqCu6N1SO0Pvsotv1wr1KSKHI7fQ=;
        b=Cjn3pFMYgDD/aBPnv+ABb+I7o76yCiErTIGYSyqdxYRRDGegp6s/Y48BP28z5x5fxG
         rUlH2inuCqc+rWSdbp9pDksmC76anAK3GSth5JxgJKJH9TPjm0s+H6JrwBmTVuOHfT9G
         LbppAHDdNqPfD7YaF8cBuY0JeuWXFkO6niFgjh9eTlW/T6TUSD6cCqZAKbFO8X0CKebC
         uyFeN7lajUg6F5Cg0PsGat7mxFDfN1Bi1k56Tgppm5ytIiUCXtm2Paj0jgjTpb9O42e9
         Qaa2okw6rqYeJpI/7X933WY5KEEMaI6yZ+kktMV+fGpCnmS2H3XppGr9qO6631WEWruj
         Ry1g==
X-Gm-Message-State: AOAM531IMsGTilf0sPG7v8r6yacvzirwwCef/+v1eGzo54GQdG52qByC
        lVdRPK7AsR/c7vHNa48mYGzqSo3ZU3hZIQ==
X-Google-Smtp-Source: ABdhPJzDO/Zjrg1D3lQPk1qWlk5Ma/UCZtPZ9ySGHakHRw9Cbfp7X35zkDhTFtpbEaSELm/01pN8Bg==
X-Received: by 2002:a2e:910d:: with SMTP id m13mr6938495ljg.189.1614110535129;
        Tue, 23 Feb 2021 12:02:15 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id x5sm1974004lfr.185.2021.02.23.12.02.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 12:02:14 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id a22so64526809ljp.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:02:14 -0800 (PST)
X-Received: by 2002:a2e:8255:: with SMTP id j21mr15174001ljh.507.1614110534111;
 Tue, 23 Feb 2021 12:02:14 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com> <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Feb 2021 12:01:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjV=OB7_PUWc4XE2vQ64NRWHeXAwhZVrtBqE8-tYrkaFw@mail.gmail.com>
Message-ID: <CAHk-=wjV=OB7_PUWc4XE2vQ64NRWHeXAwhZVrtBqE8-tYrkaFw@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Jessica Yu <jeyu@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=EF=BF=BCMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I don't see quite what is wrong, but bisection is clear, and points
> the finger at
>
>     367948220fce "module: remove EXPORT_UNUSED_SYMBOL*"
>
> which looks entirely trivial, but clearly isn't.
>
> It's repeatable. That commit slows down my build hugely.

Hmm. I'm starting to suspect that the problem is that the removal of
CONFIG_UNUSED_SYMBOLS now means that we always trigger
CONFIG_TRIM_UNUSED_KSYMS instead.

And then that CONFIG_TRIM_UNUSED_KSYMS is some hugely expensive operation.

                  Linus
