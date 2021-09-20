Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666A241176B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbhITOsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhITOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:48:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2562C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:46:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v24so62397304eda.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7j6srl8/3xZKjxyWacXYbIEtIpxDFLQTimtSKuIoENk=;
        b=kyGncLMMgPtE20GLkmXsc7UM/MZ+9OoYC1mCd9RZR+H+DKNUxthdAI7YIy3UULS1Ij
         RqADjFkwY9wAsiTq4h9+xay+CQAlTOGDQtk3oRJquzoyaOnaMNFf4rix0wNw1Es8UOps
         jhrwsRuhAWYe27amG5pRPOSVWFXCAkFAPwK8VjN5yOA8r/+DCRP8CAze6Rx4QzcAjC2B
         QejLx5s+wgd/hLJCIv/htrVjd5sftxiyPvhvAoVU2752q4QY+L4kz3KxLnjTrN6ekXzl
         e3yLACHESS3bKkQlGfYnxSBoI9QG0GDexBJfZUcGe7yyKb3l9vd4q5R4ly8U2I5qUsDU
         iyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7j6srl8/3xZKjxyWacXYbIEtIpxDFLQTimtSKuIoENk=;
        b=URNZm2e5dTmcMUVlEHcmak3hBksSSJpNIEoJCNbxhNMKgMya1mirNjNiVoWPzmhQlI
         J7zYiOdzmi8CJ+kH2cRr2c5dxT8g1gV3PSnc13f4J4gWDl+cE07+wmL9HT/I+tsLwic8
         Tgkk9aPeTZyipnzQicuFe/5mheRS+DsGu/rGi2di58p3RRwlMcoqwWrZxLCJUbuhkfqL
         0V/KZcN98f0yOmcxHTqWgkd4VjPypSVfiLlms58wl4fVX4lO8LMKohti4Ka8t7DZsp/A
         llhz9pU35VoZUGj2Qv1GTlyWhlMBO1ENyr0+MNJUl7BBd/zYOoIXSQh5F9SuqHq0JHp5
         3YHw==
X-Gm-Message-State: AOAM530MiYcKWdO7yQu9dAN6juMxQQscdzf7mLs0M7zJzlIMyh+/EbTg
        FiFJLShAcbgJ3QiGd7ljb/8wPYLnyqRTksgt/AwD1A==
X-Google-Smtp-Source: ABdhPJyaEw/eUpjG3ulFa2EQFG6rh8w6JkYCqdetDbXc7XjD9luokV7sIfFz/prDMKhitjYaTvW0+QO2SjCHFP2FZ9E=
X-Received: by 2002:aa7:c9cd:: with SMTP id i13mr30083192edt.178.1632149169591;
 Mon, 20 Sep 2021 07:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210920140509.5177-1-brgl@bgdev.pl> <20210920140509.5177-3-brgl@bgdev.pl>
 <20210920140938.GA24424@lst.de> <CAMuHMdXoZdhSydMpbW8B6oQJNnpYpTxmhHrV5CJNTUP7T1KsoA@mail.gmail.com>
 <20210920143046.GA26163@lst.de>
In-Reply-To: <20210920143046.GA26163@lst.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 20 Sep 2021 16:45:59 +0200
Message-ID: <CAMRc=McQoD=cUHLu6TMyW85fdtXOm4x38tHVnEGjkVfcfX0mfA@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] configfs: use BIT() for internal flags
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jack Winch <sunt.un.morcov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 4:30 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Sep 20, 2021 at 04:29:30PM +0200, Geert Uytterhoeven wrote:
> > Hi Christoph,
> >
> > On Mon, Sep 20, 2021 at 4:09 PM Christoph Hellwig <hch@lst.de> wrote:
> > > On Mon, Sep 20, 2021 at 04:05:03PM +0200, Bartosz Golaszewski wrote:
> > > > For better readability and maintenance: use the BIT() macro for flag
> > > > definitions.
> > >
> > > NAK.  BIT() is the stupidest macro in the kernel and shall not be used
> > > ever.  And I'm pretty sure we had this discussion a few times.
> >
> > Care to explain why it is a stupid macro?
>
> Please look at the previous thread.  I'm tired of this discussion.

Hi Geert!

The only previous answer from Christoph is this:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2399968.html

Bart
