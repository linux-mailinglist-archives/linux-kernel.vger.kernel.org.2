Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55A4321011
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 05:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhBVEtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 23:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBVEtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 23:49:15 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEA2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 20:48:34 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u4so8829523lja.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 20:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9VDWpnb5lfzit8yS6WyeZO6cXnnRi0ASXtFAlOXtGQ=;
        b=ZQoECtYg95T1WUJ7rlkNUoB2fEylQMU7nwAvu80LUOe9PriPH731NwSWpIt3UMdrwy
         q2TZkMl+WJUbgbyN4Y7yRP71IC+3SNBAlZi5a7lDpiNaCS6L1BDgdeD8aL+ys9cS98s9
         BySvhwM1g7Tx9AOfo3eIoWJ6VNN42rMKoJBZgv+GDc2hQyZP29/uHQ7NuXRJ9qk1DRQM
         VcmLLBO28lo/fl48XKkL+VMaweH8G9GCftKvoz143k++SiUEIJ5YOLIeJq2Vw9QrF2y8
         /VEvOioie6CNb/v6xawdP2amBGcX2VuVGOND59Pwm7xAFt+t9OwZzs4RIRbaO3PaeU9J
         JaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9VDWpnb5lfzit8yS6WyeZO6cXnnRi0ASXtFAlOXtGQ=;
        b=dQmwFS2pFuLaxY6kQoVVMJMYb9V+qk0HuGU+JztHi5jNRJEpOeMEEhT86lGBCqo0at
         tPHnu7BQYe5jllIlfmAVVUaOsE7HJTvr7qTPxPycWAsbMss3+Q7++XB1mZJiY6q+xPLX
         fjXjZZi4oXL+EudxPPdbdr7ZDT3Dc1t27mrWtx7l14/oaRVnN/EMk3GPWdiZQLPBm/M/
         PDTyRfm0MQz5LJmuz4OOmtSLjSW0dWG4KoBUheWXbE/5tfXYWw55M+z1CsYK+KKmPVpx
         u+ibDfhTMtbqBt1srTEyf8SQ+sDf6vvOs0AVGrG/T5sFjRNc5+h5kfO6GNL7COmXbRvY
         AL6g==
X-Gm-Message-State: AOAM531KIzXdAnO+WWmZBfPH1iMzT77yoqVrrV18zNqom+qVNZfBvKCR
        O1BS5fEzxweZotpwdUMmDSLyBun0u+FKwxE0Wt99kH1dSWk=
X-Google-Smtp-Source: ABdhPJzlpPEGc66709Uzvnm1Zpg1ZXQG6r4s65eRlBlZOsGe+xlTtKrspZuH9YpF0jiHOjquWIq8/vtjeAmZojXDg80=
X-Received: by 2002:a19:c194:: with SMTP id r142mr4959749lff.342.1613969312967;
 Sun, 21 Feb 2021 20:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20210221115802.19788-1-dwaipayanray1@gmail.com>
 <20210221115802.19788-2-dwaipayanray1@gmail.com> <46c3b16602f36858b194b22dfbdb2150e25f5d94.camel@perches.com>
 <CABJPP5CJKUeaxUqKzuJD5pd2HsHKcAx9x3iCm6W+Z8AuXiR5Rg@mail.gmail.com> <7bd4520e2552e1a9ae7eccb812c197d6a955e85c.camel@perches.com>
In-Reply-To: <7bd4520e2552e1a9ae7eccb812c197d6a955e85c.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 22 Feb 2021 10:18:33 +0530
Message-ID: <CABJPP5BkFj1N+PNpLmT4J_kNuD0q14EvmOQoLEkA8760iG4TfQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] checkpatch: add verbose mode
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 8:14 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2021-02-22 at 00:05 +0530, Dwaipayan Ray wrote:
> > On Sun, Feb 21, 2021 at 11:36 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Sun, 2021-02-21 at 17:28 +0530, Dwaipayan Ray wrote:
> > > > Add a new verbose mode to checkpatch.pl to emit additional verbose
> > > > test descriptions. The verbose mode is optional and can be enabled
> > > > by the flag -v or --verbose.
> > >
> > > OK, maybe add color coding to the list_types output.
> > Okay, nice idea!
> []
> > Sure, I will do something like this.
> > Are there any other improvements you can see right now
> > or will the coloring thing suffice?
>
> A lot more descriptive output for the .rst file and
> of course a lot more of the types documented...
>

Sure I was hoping to do that over time after getting
this series in...

Nevertheless I will send the v7 in right away with the color
code changes.

Thanks,
Dwaipayan.
