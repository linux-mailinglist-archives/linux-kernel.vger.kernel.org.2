Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6927831652C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBJL05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhBJLQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:16:50 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D4CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:16:32 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id v17so455315uat.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KesY18AcWLGUy1+xAu93YHQU7oPPXOAxrMzYm03zej0=;
        b=MKsFyk7FCs5EVbtBRB4+bpYnfoOa7GQDvT62yJUnSuDW1Y3ay929Yc/0yEAnGtRnOP
         tbfBvt2jXZEMHBFGaQICQVpcJ3ahkVX1GlDnykXyOKd5M9CYD9sXJQvjPyQy6fpFS9gj
         DHcEvppD4kEh36ucyTSaIZ4QR5Gyjt1ENqkg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KesY18AcWLGUy1+xAu93YHQU7oPPXOAxrMzYm03zej0=;
        b=eoytP7Wyn5KPBrCQoOza6bdbGrebdl2SV2JuFYDhT+ZxhPB2dJQ5Y7MMy283bLJ1g5
         Is36N7A3CuaeQqL7TRDLAuFDkf2b08X5ed2ZxXW77z51Cl51Kqv+Yu8LrE21RsF7Vywl
         96ZflAwJVGG+02Zy/ckChWbDannXWiCan3P/USvxDmnh5F7mkLK7fnkfeq8ep8yrl/Gh
         BgQJmxbxod4LFYK/PrcSFdf/69RzOdgXhXUsNfV7YdAYn/1rskRWN0XdC1LVlD4OuUwm
         DkCaa3MwV1CiBNQjwuktL7nY8o+UgL12Jb5LF5KZ9udsY5AMQSwnc89y86H64ienTVn/
         r4nw==
X-Gm-Message-State: AOAM530lTYQQlM/P5rR+IyEUwxCWae5C0cIZJ9YW/H5tODBWUxzsmWU0
        LzS/B3bHglHmnec3CD8289QIdwU9XNQTCzRdylD7kQ==
X-Google-Smtp-Source: ABdhPJw+znjMus7CT/o2Zjx7x1TnmdaxLQKXbNQeO9qunOH9MES6E+RLMHCPQV7J1YVHg6pzJwwqikVGSpgZk+baFkw=
X-Received: by 2002:ab0:3c91:: with SMTP id a17mr1253415uax.9.1612955791144;
 Wed, 10 Feb 2021 03:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
 <563952295.378372.1612881357746.JavaMail.zimbra@nod.at> <1923896038.379134.1612901174023.JavaMail.zimbra@nod.at>
 <CAJfpegufojx4q_CfR6L-fzSyQw9QXJZKy5xKVZZWaepADkL=Kw@mail.gmail.com>
In-Reply-To: <CAJfpegufojx4q_CfR6L-fzSyQw9QXJZKy5xKVZZWaepADkL=Kw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 10 Feb 2021 12:16:20 +0100
Message-ID: <CAJfpegv-UDcgzkFiZXdoif2qjws5_xXh2bQSNbNdviQHhxzZHA@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 11:12 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> But this is just a start.  From the big structures still left in
> <net/fuse.h> CUSE only uses the following fields:
>
> fc: .minor, max_read, max_write, rcu, release, initialized, num_waiting
> fm: .fc
> ff: .fm
> fud: .fc
>
> Dealing with the last 3 is trivial:  create and alloc function for the
> fm, and create accessor functions for the accessed fields.
>
> Dealing with fc properly is probably a bit more involved, but does not
> seem to be too compex at first glance.
>
> Do you want to take a stab at cleaning this up further?

On second thought, I'll finish this off, since I know the internal API better.

Thanks,
Miklos
