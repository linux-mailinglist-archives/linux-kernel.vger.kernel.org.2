Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467763440BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhCVMUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhCVMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:20:18 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607F5C061756;
        Mon, 22 Mar 2021 05:20:17 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id x82so6324855ybg.5;
        Mon, 22 Mar 2021 05:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLboqwdvDy5Ya24NG0uQ1s3HVBBB0IuvSY1Y5nf+/pM=;
        b=j0BmQPQtoJvWHPDbTIIQMdRFVUFgF+L2R7Jtu0bCOPx1CIyLHELA1okgimeiNJd1mM
         /gc8gF+CZPoOze/eu6E2xD/rwuyXuO4WnFSj7ct09aA48cesvkk9axW6BIxNSIV4dO7p
         7okWlc5mwR209vqAf2l4dwiR0xh0cTwIQwPgFShBdCNiKgQbOYIyPJc7pOmodCUfkNiZ
         /14NnwJJDB7SYQrfVV5eLA6AY6TjiqluwHjikLFZpybzQz8dzuBqbAEJYL41lmkT1pQX
         pdVWVzItnw3L2EQr/sOJwEroB+ItQHha7Q9KyKNhf2UtlQMFvno4ysFXrq+891HCMJOu
         airA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLboqwdvDy5Ya24NG0uQ1s3HVBBB0IuvSY1Y5nf+/pM=;
        b=VJVthd1wOaruCBG4B/bdVoqwt8RntQY1bedEYeA6TtaTxO1xnGeqyf6bqWGVmJUljB
         TVpzAdPrNWz7ErX+1hfuBgnP/YJlshk/sLzlTSHpsH9QlZOggxXi5y1c8eRnA04jrUs9
         EzE7aFjX/BRJlL2idgFsLfAfau3qNINvIQcF5NqZlOrBZRhS64cfyX4cok/2L3ndDxx1
         jeR6exxcDKITH0KK663W81oKGgJH9Xd7pSR7B84fiM2DtUt9UFEW6sXEHfAQQ/ExwGQG
         VaHOuLXNLRopZxnZgdMlWtbDEkkC9TOx/UFF5iCMGXRgVNUCKiQERgh9zbSwGJF/z4Yr
         oRQQ==
X-Gm-Message-State: AOAM530326CxjLju0kR0kdx4mkSYPKMG+EIEZfiT8Tq8z7UFbRtrr7Bt
        PuKUdEi1IG4YNX9esRCgVm7nmQTXmc1rBu1sp+8=
X-Google-Smtp-Source: ABdhPJymjX/+xgValSXBACXJpo7aoZbVe5vGuGRg8b7iLx20YXaZuvQB9qyZGR2giK0X4vct7MX06tVyg5wkgEWWwew=
X-Received: by 2002:a25:e651:: with SMTP id d78mr24020871ybh.93.1616415616694;
 Mon, 22 Mar 2021 05:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmOe3SaBn9+XzjhZC8QxmZnHQkvB0R=nV4NaRRyMRF6EfcvvA@mail.gmail.com>
 <CANiq72m=kDd97+n1Zxwi5+7M8cwreoq1P_u5YZ25Dcyx40jNdA@mail.gmail.com> <CAMmOe3TNt2vgX=fp77yvOx7s3+CeDonkd=Unb-y2hau66M-fsg@mail.gmail.com>
In-Reply-To: <CAMmOe3TNt2vgX=fp77yvOx7s3+CeDonkd=Unb-y2hau66M-fsg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Mar 2021 13:20:05 +0100
Message-ID: <CANiq72kMnWWucUC1zy2x1GNqYOV5wS1HeHvK0xfUbFM5eTxrgA@mail.gmail.com>
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

On Mon, Mar 22, 2021 at 3:53 AM Joshua Abraham <j.abraham1776@gmail.com> wrote:
>
> Cheers, using rustc 1.52.0-nightly (9b471a3f5 2021-02-19) fixed the
> issue. Interesting that the newer nightly compiler creates these new
> relocations for the code!

Thanks a lot for the report and for confirming that worked for you!

I'll take a look at fixing those soon.

Cheers,
Miguel
