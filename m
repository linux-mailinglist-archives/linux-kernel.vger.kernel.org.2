Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAFF383D87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhEQTeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhEQTeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:34:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A234C0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:32:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z17so7611878wrq.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NI7fG+Iz42tCTRW4FnFZEbmA6acgFeQJ4sXoAsYOays=;
        b=VPCiE/4FqXs81DF9CoNcuueDHeNNUjkvCfoCRnWBVPQjLW0j0pQz5y5NaRVERJMCpf
         B1DwT4s6SLMGXniu9FL9gxnGwYyUUM2smZUQvt2Qb1gXnj2J8YcJovyJWWPR0mD+OPsa
         UdPanHaQSl/KBZuSjumBEvbmgDHeFdUFZ1Zw8HAdGciyhOpy9GsqxNApeCXuh+jyv3yA
         Uvd69dvTrhNJosq/Y4Z/wTfokI0qDtUWTcFL2CObaB4e6cQq0wMs4pDqCcH+o5doJSFT
         vFNyRl4SS/PCni3LqTTPlsjiRG6H0yExQJtvROhJjO+ODsPp7FcMZMNTUONnclFrr4qG
         2Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NI7fG+Iz42tCTRW4FnFZEbmA6acgFeQJ4sXoAsYOays=;
        b=mZPCC9PzF5yLE6f1r3BmKn6FG6WWnehguThk1vpqk/oeh1CEseHn4o+9FbviFY9RIR
         zlsj/iO+kD4agrj7cDB5c9pShdpAzuB+21lBZTkpgRMjDgJ4yT4o5FOcqhRa1z/Ol/oX
         ZgwKyOz8Hwp0C1gVJMgsiSKHT1yoWTMKF1oJN5x5FE5noYkH5l87NvEK52b+tc8Arpdl
         fnjaigrZdnqRfv83sYjb9WV1lz/Go1VerPe7dEZ8RaO2uhof9iY4AmCrZvN94B0A6rw/
         1mw50IrYOHPVFLxcyKgqRY2nZGrnoWe9dbVcZ5gOj4vjBCUN3axvRd36IgsM0KO+6ZgL
         d5tA==
X-Gm-Message-State: AOAM533JKQGrpX2y507hw2rQMTz2EQMBRBD1pHRHWr/chKt1FxLVLXtg
        8AGqs4TtrxUAybscjmtpJgZ1x/gE5MECC5t6vONnjw==
X-Google-Smtp-Source: ABdhPJw13Z70zQiULTMByvvk76vtGj/6H/7RaAlGaSiPA1JN5oUYA3Uxd1gKghjbNVX4S49IhfOKd1J6WUKFBD1aB8o=
X-Received: by 2002:a5d:570c:: with SMTP id a12mr1526197wrv.354.1621279974949;
 Mon, 17 May 2021 12:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <YJ42MEgwDZrAEQLl@kroah.com> <CAK8P3a0pcBHfrwu9fHHRWim5WgQuCqpROpMM83yCCpjjwu1FJQ@mail.gmail.com>
 <YKIeBdwFb9Ng275X@phenom.ffwll.local> <503d101d-7273-757a-2809-e272db93c45d@suse.de>
In-Reply-To: <503d101d-7273-757a-2809-e272db93c45d@suse.de>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Mon, 17 May 2021 20:32:43 +0100
Message-ID: <CAPj87rMqYNdHMT5v9fiMuDzcB8462nJuthB9To70JOsORgxk=w@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 May 2021 at 20:12, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 17.05.21 um 09:40 schrieb Daniel Vetter:
> > We have, it's called drivers/gpu. Feel free to rename to drivers/xpu or
> > think G as in General, not Graphisc.
>
> I hope this was a joke.
>
> Just some thoughts:
>
> AFAICT AI first came as an application of GPUs, but has now
> evolved/specialized into something of its own. I can imagine sharing
> some code among the various subsystems, say GEM/TTM internals for memory
> management. Besides that there's probably little that can be shared in
> the userspace interfaces. A GPU is device that puts an image onto the
> screen and an AI accelerator isn't.

But it isn't. A GPU is a device that has a kernel-arbitrated MMU
hosting kernel-managed buffers, executes user-supplied compiled
programs with reference to those buffers and other jobs, and informs
the kernel about progress.

KMS lies under the same third-level directory, but even when GPU and
display are on the same die, they're totally different IP blocks
developed on different schedules which are just periodically glued
together.

> Treating both as the same, even if
> they share similar chip architectures, seems like a stretch. They might
> evolve in different directions and fit less and less under the same
> umbrella.

Why not? All we have in common in GPU land right now is MMU + buffer
references + job scheduling + synchronisation. None of this has common
top-level API, or even a common top-level model. It's not just ISA
differences, but we have very old-school devices where the kernel
needs to register fill on every job, living next to middle-age devices
where the kernel and userspace co-operate to fill a ring buffer,
living next to modern devices where userspace does some stuff and then
the hardware makes it happen with the bare minimum of kernel
awareness.

Honestly I think there's more difference between lima and amdgpu then
there is between amdgpu and current NN/ML devices.

Cheers,
Daniel
