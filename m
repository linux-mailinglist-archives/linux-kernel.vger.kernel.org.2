Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8BF331269
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCHPj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhCHPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:38:55 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C030C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:38:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x9so15350729edd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfXciFrm9LrANnw4jRFQHfr5yM7gTFZNFbqfSpxA3eU=;
        b=huII2CRYfBBxRp+TSt6DR9t2UwZxbjxOpGH3MAVkk1BnDv20pE1cdQ/zVA4+f0uDUm
         82CPW7P0VPTRb5X5PnTKolPI/O+yGyVp+Hsgaf/xr+8BhX6gQ5GZB+O2hWMJ++waDA2A
         Z/4Q1igTU2kjwpuI5G34Hb2j3moQ4Tm7c6yanlvtutuxNLMTcHbNsP+s1SSiJV5Jhj1I
         wMVDvY95paC6fzZZoKBhIJwDNOoDICi4Yuq2+a78WhBpu1xGgajddgTXityW42qEJZH9
         tSSfruuLNp1PepcNzYWPH/tvJrgKDKb/Y1UUJHzHzv8o21rv8rnWbVfuzEx6VXOcVkhB
         Ki1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfXciFrm9LrANnw4jRFQHfr5yM7gTFZNFbqfSpxA3eU=;
        b=UD9VfzJAOi6oIIdUQIFZtHJwp5+ic5P3ehePG/TOTBNC4ehaozhH4RQY7r1nDxqExC
         kDEzK9th6v6OpU0JVWoYO1xM6gHx0IOXHDZvWc84ZaOKrCXIp/OF9xhtc9MKBGk7p/qP
         q6loDb85RdH77PizAbwuaA4NyAmLaQ/EFMmX4jW30tfBDEnC33rBnuJmEucfYtuSE8wq
         akCD0arl00TV/UsUNNvjvyMQV1bVxLyS3lzvS082G5AJjgkzriZo/04+v5LgSMLkpwoZ
         9U0u6CdgsE/qYqPSWvDY6TyhsNGd3HCO/jp5ZHAED3ckm6B95IuzQQxGfwNs/chkoMdp
         891w==
X-Gm-Message-State: AOAM53181M9mc23MW3rw/X9qmaZEa0poSEqSZDpq+k0HhpGFb+Cofkbe
        8u/TfGD2JOcoDhoH+2fWDnG0wITEpjPaIqh0sNjdaA==
X-Google-Smtp-Source: ABdhPJyFbeslDKCC5Ip/F9gtLk8ac8XRVolzAbiDXb1pLkM4kG607vQlaF5tE7wMFRu3lVdNspEOK63a7TF0Oan12fc=
X-Received: by 2002:aa7:db41:: with SMTP id n1mr22947600edt.186.1615217933815;
 Mon, 08 Mar 2021 07:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20210301165932.62352-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWLCE=qrpzDpZQAxCeCc6nxq74g_Q5hNs8ZG+_0p89kMw@mail.gmail.com> <YEC9oQENLVmVNzXz@smile.fi.intel.com>
In-Reply-To: <YEC9oQENLVmVNzXz@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 8 Mar 2021 16:38:42 +0100
Message-ID: <CAMpxmJWz+iEqC77ORCQ-tHHc0SiHCPoOR0VR=Te4LXBfMoCPng@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] lib/cmdline: Export next_arg() for being used in modules
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 12:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 04, 2021 at 09:53:28AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Mar 1, 2021 at 6:00 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > At least one module will benefit from using next_arg() helper.
> > > Let's export it for that module and others if they consider it
> > > helpful.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks Geert and Linus!
>
> Bart, do you want me to add it to my usual PR or you want to take it yourself
> (I have no dependencies in my tree on this anyway)?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Please send it with your PR.

Bart
