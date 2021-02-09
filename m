Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8AC314503
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBIAmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhBIAmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:42:33 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9B4C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 16:41:52 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f1so25843378lfu.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 16:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnyQftUsUdmfOLazvXtPW1VO1AUg/vKYWfKvMCCcu6w=;
        b=U6awMA4cXNtdet7bCDrR3Qk6BJBJ2ztV1rTJfubntFbyiL1QD1RXNk09yJh5/+OGbp
         foNv37aNd+SZMKQrJlDtlBVGy2WP0tS8b35RGtpzxLhYsVtwiIvBFf/rT763ScDdJB6C
         apGR0PqUc1TwgCUaZYL+eg+9A7ea4WyrU+6cIu/kyjyHympM3GvBKGUvL2rsVUfLXTyp
         FyjKrMSgdIWH/8C1EKc1m5yP0/WqouD9ba3g5OsEthm9asktTbQBoHQkGlNNryrXpvBu
         VFVk5DG0aZrSwRwqR37T5xWx6oOYuCBjdeDMZsSYuuwATOK8SY1FiYfSYEMrBwPKD7b2
         YU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnyQftUsUdmfOLazvXtPW1VO1AUg/vKYWfKvMCCcu6w=;
        b=Zj6M+moz3MQwQwbZCsYTgyXMzezIBPmml5Di3NNUettzbBhkLTrZ2RyxGRrdFA6hyO
         oK3ns4YnV4d0ViNph9jbrs1yL4IDV8ZTt2Tz1jSduv5pQs++wNHQdHDmSgxZ2c67IA2/
         6F7Tv3s5Wpmr6OaXhf3ojeoJFNDxqedEHUqotcZYPXK7VB5tPVgfRZocpXIdkJLyyzNu
         /uvMBhz3VySB2Mg7YnbJZbvhDXchz9GglT3ZlQzFrALJ+TYsdUSI3CrVF5j6kZZvKyLr
         NiAYPRVAvZVRKorvUxXyFFI2wW/gSXiSCg55vMaHuZ/qdoJJLih9io3T0pVKF/XNduIg
         TOsA==
X-Gm-Message-State: AOAM531vsLPFFf81dZmqC4gK1idfLzEl7S1CEYeJCzF+k4/GUrb28wT/
        /E1WnEgBYF1bURShEXrA3W7i3yQFSED9rjBE+pGdAg==
X-Google-Smtp-Source: ABdhPJxmvREYZe/j/mTilj3dXr4kXQEEgQvJ9oEP19f5WVJ+wvbVOuUZyBzc0YCy4VkLcvv4ywulg04905i8ILzhwmc=
X-Received: by 2002:a05:6512:38af:: with SMTP id o15mr1388887lft.70.1612831305577;
 Mon, 08 Feb 2021 16:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20210121213641.3477522-1-willmcvicker@google.com>
 <YBrFSLASG5yiqtZT@gunter> <YBrHPqlQHppzBPpn@kroah.com>
In-Reply-To: <YBrHPqlQHppzBPpn@kroah.com>
From:   Will McVicker <willmcvicker@google.com>
Date:   Mon, 8 Feb 2021 16:41:29 -0800
Message-ID: <CABYd82bb-BiY2pQ3ghNYV3wtPeR8vJR5-nH6GH=oHB+ALFAw5w@mail.gmail.com>
Subject: Re: [PATCH v6] modules: introduce the MODULE_SCMVERSION config
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Christoph Hellwig <hch@infradead.org>,
        Saravana Kannan <saravanak@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jessica for all the reviews. I guess we can let this die here
and I'll carry it downstream. At least it's all here for others to
see.

Thanks,
Will

On Wed, Feb 3, 2021 at 7:54 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 03, 2021 at 04:46:16PM +0100, Jessica Yu wrote:
> > +++ Will McVicker [21/01/21 21:36 +0000]:
> > > Config MODULE_SCMVERSION introduces a new module attribute --
> > > `scmversion` -- which can be used to identify a given module's SCM
> > > version.  This is very useful for developers that update their kernel
> > > independently from their kernel modules or vice-versa since the SCM
> > > version provided by UTS_RELEASE (`uname -r`) will now differ from the
> > > module's vermagic attribute.
> > >
> > > For example, we have a CI setup that tests new kernel changes on the
> > > hikey960 and db845c devices without updating their kernel modules. When
> > > these tests fail, we need to be able to identify the exact device
> > > configuration the test was using. By including MODULE_SCMVERSION, we can
> > > identify the exact kernel and modules' SCM versions for debugging the
> > > failures.
> > >
> > > Additionally, by exposing the SCM version via the sysfs node
> > > /sys/module/MODULENAME/scmversion, one can also verify the SCM versions
> > > of the modules loaded from the initramfs. Currently, modinfo can only
> > > retrieve module attributes from the module's ko on disk and not from the
> > > actual module that is loaded in RAM.
> > >
> > > You can retrieve the SCM version in two ways,
> > >
> > > 1) By using modinfo:
> > >    > modinfo -F scmversion MODULENAME
> > > 2) By module sysfs node:
> > >    > cat /sys/module/MODULENAME/scmversion
> >
> > Hi Will,
> >
> > First off, thanks for being patient and being responsive throughout the patch
> > review process.
> >
> > Personally, I am rather neutral towards this feature. We already provide
> > CONFIG_MODULE_SRCVERSION to provide a checksum of a module's source files and I
> > think the SCMVERSION is a nicer alternative. I can see how an optional
> > scmversion field might be helpful information for distro developers in testing
> > environments and in situations where it is possible for the kernel and modules
> > to be updated/packaged separately (for instance, the kernel selftest modules
> > under lib/ are in-tree modules that are provided as a separate kernel module
> > package in SLE).
> >
> > Generally, out of principle, I do not want to merge a patch that's been NAK'd
> > repeatedly; even if I take the patch it'd likely be contested all the way up to
> > the merge window. So this boils down to whether Christoph (and maybe Greg) are
> > fine with this being a debug option that's not enabled by default.
>
> I am neutral on this, I don't care one way or the other.
>
> thanks,
>
> greg k-h
