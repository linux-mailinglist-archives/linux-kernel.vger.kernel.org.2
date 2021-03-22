Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4062134361B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCVBCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCVBBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:01:54 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A931C061574;
        Sun, 21 Mar 2021 18:01:53 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id x82so4817837ybg.5;
        Sun, 21 Mar 2021 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nl4OYmv9YuQQ6cekAX/d8VH6rON0g3qhC7O/Vawr8PA=;
        b=ufpZtW6BkPRDohQl+giQbBAs7odfOIWo2wU5bfbI34udu3MP3IbNw3Qtj6BFyFw4kW
         gsDJRv3UDgB04yuJtO8SFsdZKsFImvrZt/5Dwr+llaKwQ0sh1nQV68BC35Qx4nf7RTyf
         Kk1JYg+C/1A3pD7hVjP46Y3e/ehRCWcy6grmMmg6v/K/OfrNz572JLeyuJnMI5+YLL1Z
         xOubECCRLhIDNI7jtRIDG84EoaOGYMZxbOPpnDfPBE0/i0KwYx12VPeypJ0KQtXqJWPM
         SXbOwxZzqMnJlS152eXuH+Tg0sjX6UXTOEJj6QDyVxN/532rtHT76s6kgzlO5WRb0hTK
         WSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nl4OYmv9YuQQ6cekAX/d8VH6rON0g3qhC7O/Vawr8PA=;
        b=o8e3oogrFM6XOIRXebIaf/fRFvM1YAiVHex1nTWGnZzKMT5kFX+jXh7rKMMVjcC3eW
         acY8Bsw+Py7g5w77XZjJh+CGD75PvFCiu4yfZDWQgw1vMnVRYVPhkmUlTn+ZQzavZ2tc
         CnsAX09JUXAImALdYwZh2RLQJwtqPrIUxJBKMKwYvZf2k5Ko3IAKqknY/LtWVXczk4B3
         zePiI+rwatz6IVRq0VADUsFIWKaYa6tnc/4/fdVmAiCpzuIU8mtERmsHJ3aCUoMmMQmH
         2UFtUXWm2XBQUBSG55W9DtRtP8Iwmns6HonSUzwXeyjnNuPxNOsIIRSDE2AIbNo7qIva
         d+Rw==
X-Gm-Message-State: AOAM532wVN/0osR7nyXbMmC9yUVlnIx+7OgS0YLKjVmsespH34Ql/GCx
        AQVIhBVqrIguV/fceHZo4b9XbOYrjIk1zCxekT4=
X-Google-Smtp-Source: ABdhPJx7eyLpFs8kDeEV7ipBeo9HzjTZp/4wNuLsBNWeo3M0AsEtBUFSeBJPugswQBSxCAbXXkByGwgdWHVYFefp3Fw=
X-Received: by 2002:a25:d94b:: with SMTP id q72mr20098976ybg.135.1616374912665;
 Sun, 21 Mar 2021 18:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmOe3SaBn9+XzjhZC8QxmZnHQkvB0R=nV4NaRRyMRF6EfcvvA@mail.gmail.com>
In-Reply-To: <CAMmOe3SaBn9+XzjhZC8QxmZnHQkvB0R=nV4NaRRyMRF6EfcvvA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Mar 2021 02:01:41 +0100
Message-ID: <CANiq72m=kDd97+n1Zxwi5+7M8cwreoq1P_u5YZ25Dcyx40jNdA@mail.gmail.com>
Subject: Re: drivers/char/rust_example fails to load
To:     Joshua Abraham <j.abraham1776@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

On Mon, Mar 22, 2021 at 1:13 AM Joshua Abraham <j.abraham1776@gmail.com> wrote:
>
> $ rustc --version
> rustc 1.52.0-nightly (61edfd591 2021-03-20)

Please give a go to the nightly from a month ago, i.e. 2021-02-20.

Cheers,
Miguel
