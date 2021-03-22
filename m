Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522E9343F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCVLWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCVLW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:22:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4900D6198E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616412148;
        bh=7O5Y064sMQOOqOMY6OVkzxT800PL2d3moQtD+GZ6tnQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BQ9GjdMI6QpoEYrjTgKYbYorgs0l3IkOz+yPJRKtEu0XYXsdX9Q8E65Xh+/x8n25d
         KG0eWUPs4PHOT/10cQfUgGb1wgX7Ihvl3KRyjASrVE3uKY2Nl94VaCB528haqpc5nq
         DlnJPsoE3tm83dW4quDpZZHzbmEVZhhyoaZ7KlpLhhptYeLMEj/OrzhC0aumO82JB5
         yDBrCnyRvPDS/OeUMpH0tu1j4YAL6Ifdjy5ATvmZrbeFTyvnL72M4LaA7cZAF3z8pr
         nsyIulqAq9RAwVLNkSF8Yaf2SLdfz3TRgWAvp5GQJOcQC9rJuDg3UnCfo9Z1UhsXhm
         T5RSmP7EvHCHw==
Received: by mail-oi1-f178.google.com with SMTP id n140so12639586oig.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:22:28 -0700 (PDT)
X-Gm-Message-State: AOAM532nHDYNWXSeDvWRoLkaGEo4OoSLllD4EYN3MsPAmL5zjgb0y2ft
        LKojcA/K6FTfpk8CXLdNdv/4d4OWoVF25GeRI08=
X-Google-Smtp-Source: ABdhPJwufCrfVhjdpJ6yEaYN/r05FrmAE5SWGZfTHqEo8IjCyEFrO+tYBa7BSbfsZMkQ7O6hVatQPDMg+Muv+B4zehU=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr9170398oie.67.1616412147659;
 Mon, 22 Mar 2021 04:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210322102002.28990-1-arnd@kernel.org> <YFhxhyXLyTqp4ppH@kroah.com>
In-Reply-To: <YFhxhyXLyTqp4ppH@kroah.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 22 Mar 2021 12:22:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2B4X98VMy-1E=mNX+96Dmika8Y-YdTn5E-_uWqK9JnWQ@mail.gmail.com>
Message-ID: <CAK8P3a2B4X98VMy-1E=mNX+96Dmika8Y-YdTn5E-_uWqK9JnWQ@mail.gmail.com>
Subject: Re: [PATCH] devcoredump: avoid -Wempty-body warnings
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:29 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Mar 22, 2021 at 11:19:53AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > +      * These should normally not fail, but there is no problem
> > +      * continuing without the links, so just warn instead of
> > +      * failing.
> > +      */
> > +     WARN_ON_ONCE(sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > +                                    "failing_device"));
> >
> > -     if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> > -                           "devcoredump"))
> > -             /* nothing - symlink will be missing */;
> > +     WARN_ON_ONCE(sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> > +                                    "devcoredump"));
>
> We do not want to reboot machines that have panic-on-warn set,

Fair enough.

> so if this really needs a trace dump, please do that instead...

I don't think the backtrace is needed here, if it ever happens it's either
going to be -ENOMEM or completely reproducible. I can instead
do the cast to (void) that Linus suggested, or a simple if(...) dev_warn()
or dev_warn_once() to have some indication of the failure.

          Arnd
