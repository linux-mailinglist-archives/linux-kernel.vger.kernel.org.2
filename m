Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8135C412B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbhIUCHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhIUBvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9C5C0612A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:46:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g41so41287991lfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSvzruZ7yrH3cGppBMPI3R0ozg6uVIR6o4wSeRhpPb4=;
        b=LDjsVKKmmK9IHt+0xSI4WhrZQsDZOajyP74jFpI8bn/RHKfwdF3Ntdcp/J0brBth6M
         rTFcXjE1Q4MISd6lo+ge52o8NsB3m0d7+jizr2EyMR9RJyZIV7tZwLV46WUCc9pBPv23
         ITXPDL/fZ/d87T0+EoSZ8Tgcw0UMBm/5jCT2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSvzruZ7yrH3cGppBMPI3R0ozg6uVIR6o4wSeRhpPb4=;
        b=HGddwrPb1oyOMQxH9Uax2LxQQc49l9EV5tOfYh0ytSOeaBeoRaLq8H6Eh4EGyLPa3V
         xR5v51G6+r/GIbFJ5ZoWvr6B4PqxbBTYXXpz6Yx20P8JdEykkHj3rTmsIUbeG+wFa7sz
         /w5YR+Zdgh8zXCa2V6T8L+9TlifF298lmSlxybLeOlpTEWY2Dcs4NKqM3henSSUvdgvy
         F5xH9W5595DwQJ9XZoqqNAw1hKwAKWCN/PtzhuHRO5QJAyf9lZYeL7PEoL4h0+pO7scM
         sTEvptjtgei0twIekDlxv5oGfendCww/al06603lLPPk+p5KxbarjUXymtGziRS40Rrd
         btAQ==
X-Gm-Message-State: AOAM531DpsV/CNmHlbvJEHl7TDc96Eh1zxCCDqtj6DAyAOo9nOGvm07Q
        MD49kwcvUo6IC00xvXgIVDoe3UjCl4/mkIHJM3U=
X-Google-Smtp-Source: ABdhPJxXXxmZKEV7SMUsbZehNlbdWP2GlqLo6IamLATxI73bkrIeY+71silP+8Rt6PZm4oX9YcXVEw==
X-Received: by 2002:a2e:858e:: with SMTP id b14mr24369792lji.508.1632177964548;
        Mon, 20 Sep 2021 15:46:04 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id a26sm1365436lfg.193.2021.09.20.15.46.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 15:46:04 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id t10so67562666lfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:46:03 -0700 (PDT)
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr1896311lfg.280.1632177963635;
 Mon, 20 Sep 2021 15:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mvu5wTcgoR-EeXLcoZOvhEiMR0Lfmwt6gd1J1wvtTLDHA@mail.gmail.com>
In-Reply-To: <CAH2r5mvu5wTcgoR-EeXLcoZOvhEiMR0Lfmwt6gd1J1wvtTLDHA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 15:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6_m_d88kx7wWYQS+waEk6hv5szwFYvy2PjP1naj87Hw@mail.gmail.com>
Message-ID: <CAHk-=wi6_m_d88kx7wWYQS+waEk6hv5szwFYvy2PjP1naj87Hw@mail.gmail.com>
Subject: Re: [GIT PULL] ksmbd server security fixes
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 7:22 AM Steve French <smfrench@gmail.com> wrote:
>
> 3 ksmbd fixes: including an important security fix for path
> processing, and a missing buffer overflow check, and a trivial fix for
> incorrect header inclusion
>
> There are three additional patches (and also a patch to improve
> symlink checks) for other buffer overflow cases that are being
> reviewed and tested.

Note that if you are working on a path basis, you should really take a
look at our vfs lookup_flags, and LOOKUP_BENEATH in particular.

The way to deal with '..' and symlinks is not to try to figure it out
yourself. You'll get it wrong, partly because the races with rename
are quite interesting. The VFS layer knows how to limit pathname
lookup to the particular directory you started in these days.

Of course, that is only true for the actual path lookup functions.
Once you start doing things manually one component at a time yourself,
you're on your own.

                   Linus
