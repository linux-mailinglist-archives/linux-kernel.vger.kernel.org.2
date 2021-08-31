Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB393FC4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbhHaJIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240370AbhHaJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:08:35 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B02C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:07:40 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id f4so1602804ybr.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9WReO737XvBGcFweYL9X7AjJlBEgD6o3hCVwVj5PgA=;
        b=dFSImeZWMvygJT+lci3mTcdU6P09+HPgNnkK9qhPbUelu7+o9Jbqhm61zCmm+jdVwx
         63nWBmng9QWYl31TAuLDq3sGsSv+TCrs8ZsMlmIVu9IrEd1UwnrUTZp1/62N8HBggsFr
         OJUPvAWhNgRVd0JwerCKryOytWbZ7uCRccDw/6WknPFAYnKmQH/9Mff9JjWiZ7Vl4S1f
         hqTarpQDYErTJ/im/3A2sRM/1ywMYN1nSz0Iu+3HV5NSaQje+QlwFiatgJXWW4ecETGz
         JW7u5AxeGhgxqiRI6IfqE1qvUd3tpKZihVzja1qm78S5vXJshBpbHb52RxBU60RhODNs
         KlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9WReO737XvBGcFweYL9X7AjJlBEgD6o3hCVwVj5PgA=;
        b=kRKx5IfSH20NmEK7+gj6mGM0LApWYuKGMsrZOUl495PfZtkwfyfohomEMwAX1J9hPZ
         RpxR2BULaySFx1Px/zfeFKKPnfDKAhofjlMRhRIRjzx+aLWLn/fGSDli9jPfSJHEhve7
         Hj+PU96AKLzn51QK55wFQuFeKZyWSb5EfgO9MC1WJJwpBzEnigIDG0m2pvqi9YD1bsuK
         rVZPC7LEK4geXbEBIsXpR37DdUSlrBnUz1w86l2Il/jKoFu0g8J+8aUI3RfGssiKnnh2
         cRhQuwp54QnQa+d1+ymUJpELVRuaYxx6pIwLqaOtC9EhHODHcR58S9/i9+3LKnnd/noG
         celw==
X-Gm-Message-State: AOAM530JJzgi0ph1R4nP9d7b1FMoOqiC23RS4rcVWrin5oHbC9UYbT2M
        gxqktpGyCqRbnm2mCqRfPd6NHgpiSh1s6r2hc1LGAPV8ivo=
X-Google-Smtp-Source: ABdhPJyMNMvSs4tK/E9ZN1j+n8cnxhnu8pdH1dz1/PqYf57AN6v9ljrv28r/XlDtmmfeqEUnSkw1EogGewK24oOrmYw=
X-Received: by 2002:a25:48c7:: with SMTP id v190mr28471081yba.312.1630400859621;
 Tue, 31 Aug 2021 02:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <32ab7b833743449b21f529cae41f4cbb60dc863c.1630387746.git.viresh.kumar@linaro.org>
 <20210831022224-mutt-send-email-mst@kernel.org> <20210831063149.gcctzqtn635mn3wb@vireshk-i7>
In-Reply-To: <20210831063149.gcctzqtn635mn3wb@vireshk-i7>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 31 Aug 2021 11:07:28 +0200
Message-ID: <CAMpxmJWeYTf4yVTJmnHf8Lqrf=J9rGxq54rPFGMYjLaKhH6fdA@mail.gmail.com>
Subject: Re: [PATCH] gpio: virtio: Fix sparse warnings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 8:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 31-08-21, 02:25, Michael S. Tsirkin wrote:
> > On Tue, Aug 31, 2021 at 10:59:25AM +0530, Viresh Kumar wrote:
> > > Fix warnings reported by sparse, related to type mismatch between u16
> > > and __le16.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > I'm not sure which tree has the above commit - can this be squashed?
>
> It has gone via the GPIO tree:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/log/?h=gpio/for-next
>
> I believe it can be squashed, Bartosz can confirm the same though.

I just applied it on top of my for-next branch.

Bart

>
> > Also, the driver lacks a MAINTAINERS entry - we want at least
> > L:      virtualization@lists.linux-foundation.org
> > on all virtio drivers.
>
> Sure, I will send a patch for that.
>
> --
> viresh
