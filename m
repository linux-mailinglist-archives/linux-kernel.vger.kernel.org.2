Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC844550B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241425AbhKQWsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbhKQWsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:48:24 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D69BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:45:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b11so3455214pld.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJJKVzTxaR2Jq12aWGXs8cF0EBjWHSoZFbcR1zTQJSY=;
        b=pYGi5s2dptKtE95Frg3YsX2jfu+KYNuODlHp90NSW6IJspMQDUIKp2BFBGvuW9Slbb
         UBrIoO0f4jvCKsK5hp1dj3ulW8UXQprzfzwfkVKpjzyje3A0RGlr4w1vUh7OWLO0lVwC
         rEoLLI5BsN7U7yN2YzSQTdi5o9umk2wVa5oA/eCwA6cJz5Q7Co8qpBd3Dc4GmaQt1slI
         QxUaqcwCeodeY6QW27I+q/VvH2KWgUT7Atp9jKsUpDLfa5H+yT2fA/K3h2yW0P0kwQsL
         7e9ok38jYYYV6WcBitvLafcfXLzA+BagWKyprqTM2J354t4C/oxU6qy1cFD1SKxr4930
         f5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJJKVzTxaR2Jq12aWGXs8cF0EBjWHSoZFbcR1zTQJSY=;
        b=2NEohfsq9RB2g9Sp4QvErp+GQmrma3ZzKoOLc/x3It5k+dqF/+mrT+ML7Np+PQRNBa
         Xc+UHS0BqU7Vzc2H7K5DPZhbW5QnHHxO/br0tj86DydzzaSaRF/tTanDY5FU3pM5dY0x
         Jv9UORBJnT9uQzGiAeo5l0SpdNqkmxZ5u6ojYsuVnCkLxNmHsomUbvurH5/txjREI365
         7EYFYrhU3hYYlo1cc6Qroknn54KbKzKL4wUhqPdOJXXtzrLs9rfZGZh6+7QK2PjrGqey
         2BH7/qiaVcXAVjGvEf196llwMpqekhdUwJ8GQGljUvtpIpNO/ZS83DcETvQatfCqd/f3
         Bm/Q==
X-Gm-Message-State: AOAM532Ffp63QAt9EHjtjdNKlLJZRuFMwQDmMKzuyGnH4q25GuyK2N2W
        E4P4yk4lw45ag4jk/MDsN8ubyxM7DVnJzf+Wb4Q=
X-Google-Smtp-Source: ABdhPJzDKAKNeZ6lNMEzZwqy8lWbLZM5P2lfS6OQd12MYHADYVW0BMurlUatcKZoXbSgThWdd81s+IhBVZ+K4SMbFd4=
X-Received: by 2002:a17:902:6905:b0:142:9e19:702e with SMTP id
 j5-20020a170902690500b001429e19702emr61362961plk.34.1637189124573; Wed, 17
 Nov 2021 14:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
 <20211117210245.843374-1-goldstein.w.n@gmail.com> <bc0297a1b97a4b129fa3ea1b155f6062@AcuMS.aculab.com>
In-Reply-To: <bc0297a1b97a4b129fa3ea1b155f6062@AcuMS.aculab.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 17 Nov 2021 16:45:13 -0600
Message-ID: <CAFUsyfJTuFjVXHMgYi0uggVNW=1WW1uVYa7avVjW5VBb2cmAkQ@mail.gmail.com>
Subject: Re: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in memmove_64.S
To:     David Laight <David.Laight@aculab.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 4:31 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Noah Goldstein
> > Sent: 17 November 2021 21:03
> >
> > Add check for "short distance movsb" for forwards FSRM usage and
> > entirely remove backwards 'rep movsq'. Both of these usages hit "slow
> > modes" that are an order of magnitude slower than usual.
> >
> > 'rep movsb' has some noticeable VERY slow modes that the current
> > implementation is either 1) not checking for or 2) intentionally
> > using.
>
> How does this relate to the decision that glibc made a few years
> ago to use backwards 'rep movs' for non-overlapping copies?

GLIBC doesn't use backwards `rep movs`.  Since the regions are
non-overlapping it just uses forward copy. Backwards `rep movs` is
from setting the direction flag (`std`) and is a very slow byte
copy. For overlapping regions where backwards copy is necessary GLIBC
uses 4x vec copy loop.

>
>
> Did they find a different corner case??
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
