Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4435331264
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCHPhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCHPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:37:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5BFC061760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:37:22 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id c10so21182209ejx.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjHfcAXY88yF8tNbjJtkmDUGnU+swDxc27GpD7p9UQA=;
        b=Iub5yJdpOGm9mEiEIh1q9/Q+9Bs8dvvUxWsQHTo29W+sAERu2/clpPH5quQvPUcJQ9
         ha7uoMf4Ehox4DQgT2c4M1GtX2bHxm8RfUQcas4mFrbs8Ungu3/4Hc/r1ANJ/P8vD1VJ
         ySwh0SiPaFSfYmAITK8jfrP7rYjhvndQa8Kq/sJOJ6td69GgFhRwZ7JcVYaN2niDcGf+
         P3JJft2jubop/zBjHLb0uL0A3jG9JYCJXIrBjMOF/hoxcjgchCH5PjrIqLfpbmTeHV1k
         EtsuqFLy5awWOxakAjXyTZ9MqPuUo2OI9pvrSTtKlqMMewnrze9GXSKTWqQ6KawaBJy2
         SC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjHfcAXY88yF8tNbjJtkmDUGnU+swDxc27GpD7p9UQA=;
        b=pcuXLXxp1gDIqHtN9pwX8U88O/tnUPMO9M1wxMiPFLneLBx/FEma/Wosw9jELOPI/F
         xHAdVJUhPUUgJPt5N8arvS1QLfln5Qw0bVwJUoOf3VeZmc6xTa6FGcx1yJYJ8/YAZYcE
         ZArJN4lY1NnpmeZGfdz8u0gK6wJJ9ny579VpDfVZE2Il86cA/Nd1bTnwpvFUaeqZGdpD
         LGtQ6nUd66G9JI6IgakUK2Rm+nGP2hr5hsDUTrjpAozTiYBVUAfJ6bEPjVDcC5YpVHQ4
         RCCG3ZBaZzrnCUQFohYT5oFp0VI4GWL8Pl54VNFRxK0+kIBydZGQM4h5sKp7s+tkyWiB
         9xgQ==
X-Gm-Message-State: AOAM530ydTVg69wfmTQlGz98TWOPkBOsQe4FMXYGv64Z/fwjLZ1df9y9
        0V1wzm9h5a0wNV6PFqaBlI+SV9RaMn01xjnwvTS4gQ==
X-Google-Smtp-Source: ABdhPJxkgaHYtZwgo6uZK1AWumBj4Oo/xv5tOsU4La0Q6aOKgoDqhl6nK8SA2fSAJNoy/gDoIQRjsb49U0G9eESJcio=
X-Received: by 2002:a17:906:d938:: with SMTP id rn24mr16289501ejb.87.1615217841387;
 Mon, 08 Mar 2021 07:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20210304102452.21726-1-brgl@bgdev.pl> <20210304102452.21726-10-brgl@bgdev.pl>
 <YEDdbfbM9abHJpIO@smile.fi.intel.com> <CAMRc=MdRxXzoZuyLs-24dXfOft=OQqDneTHa4-ZKqFE1kMBWcg@mail.gmail.com>
 <YEIE1nG8lZ4V2MXq@smile.fi.intel.com> <CAMRc=MekGnK17rYf3Bx_UHumVVrpmJphOnMfO352NB9SaOJCGw@mail.gmail.com>
 <YEY9DFk6NEcnEWGE@smile.fi.intel.com> <CAMpxmJVTUfveuaY9yhP5PLXoOdrkYQ2WbE5-P+4XRi3=VdQKjg@mail.gmail.com>
 <YEZDod11xb0LT043@smile.fi.intel.com>
In-Reply-To: <YEZDod11xb0LT043@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 8 Mar 2021 16:37:10 +0100
Message-ID: <CAMRc=Mf4kmDadRgDiX=p2DuKjBXng8FWvouToQMJBNsfX2zckw@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] gpio: sim: new testing module
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 4:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Mar 08, 2021 at 04:13:33PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Mar 8, 2021 at 4:05 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Mar 08, 2021 at 03:23:31PM +0100, Bartosz Golaszewski wrote:
>
> ...
>
> > > I have strong opinion not to open code "yet another parser".
> > >
> > > So, grepping on 'strsep(.*, ",")' shows a lot of code that wants something like
> > > this. Interesting are the net/9p cases. This in particular pointed out to
> > > lib/parser.c which in turn shows promising match_strlcpy() / match_strdup(). I
> > > haven't looked deeply though.
> > >
> > > That said, I agree that next_arg() is not the best here.
> >
> > Shall we revisit this once it's upstream with a generalization for
> > separating comma separated strings?
>
> How can we guarantee it won't be forgotten?
>

I will add a REVISIT comment, so *obviously* it ***will*** be revisited. :)

Bartosz
