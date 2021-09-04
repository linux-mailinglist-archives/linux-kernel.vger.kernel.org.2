Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DD6400C33
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 19:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhIDRBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhIDRBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 13:01:10 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF41C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 10:00:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y6so3794691lje.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnf5faxyLrEqjdcUUDuhtCXKtxh7WY/dd3BQVqLbWmI=;
        b=VuzbLbYwY7mn/j5Q2BwBTMWzOa50i3Z7gG4gprzZ1fGq1km4YgA9t8MyPhdntFhTqe
         CjY+PMylfPTyqmFmubrUZzDxB7TWYhIe7roENyj3+zK8gMUo022nVdcZY2uVcuaDMYEL
         imNUIhOdDzPqMkuY3ROzj41fVyrbafUK4SqJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnf5faxyLrEqjdcUUDuhtCXKtxh7WY/dd3BQVqLbWmI=;
        b=jCysR9bpuLd1Im2BsYH89U71bcGFKp9w/0cOVlm/0VKH1UCC8QNReNsb/W2RiQY6BV
         4GYmqz+9e+eNAGjAJpf6/Rmqo5XRiSeiSqhWgDLnC+WjnvyxKv06662WDzyPWvGKhJO1
         1mCgZdXkaklh/RMw/D+LcIRYcFM66K/+wnu0tLRRhv/PsAJPmktPgIG2TwmZrdn/Cy2i
         277rQB6PfWrkwW9uEObtNUWxAjQiqdx0Gu49TtXb+z+6t0DGvsZKDJvQhqvQRkHH09vR
         np/wYRT5Nn9EvO7TT1PiAVnmzWvCJUjXlE6I2S64rUbHxcgTdJ8FZikYKmUU6x7bTvuC
         2baQ==
X-Gm-Message-State: AOAM533G02+Q7r51Fd4SmZ2KIwmfe3fXYy21vMKBsYP6KQn/SDCd8Dn7
        vs493OzHplc8EVem9FR+muY32WUVMXvYzFuq
X-Google-Smtp-Source: ABdhPJx7Oyqf0MyflzmL7eTJwyFm2pOi7QULa5hP1pOc5jGiwZr0HJCqlFwZpF6SD+f1gqky2f+tdQ==
X-Received: by 2002:a2e:b4a5:: with SMTP id q5mr3344010ljm.11.1630774804336;
        Sat, 04 Sep 2021 10:00:04 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id n3sm285838lft.63.2021.09.04.10.00.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 10:00:03 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id f18so4675667lfk.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:00:03 -0700 (PDT)
X-Received: by 2002:a05:6512:3d28:: with SMTP id d40mr3379362lfv.474.1630774803313;
 Sat, 04 Sep 2021 10:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <YTOF8VYTYNFYpB7O@zeniv-ca.linux.org.uk>
In-Reply-To: <YTOF8VYTYNFYpB7O@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Sep 2021 09:59:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whho2pj4Au+rVpTGkoj7nJCEJwSfikLQVHDZ8kbKG7U1w@mail.gmail.com>
Message-ID: <CAHk-=whho2pj4Au+rVpTGkoj7nJCEJwSfikLQVHDZ8kbKG7U1w@mail.gmail.com>
Subject: Re: [possible bug] missed wakeup in do_sigtimedwait()?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 7:45 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Looks like that __set_current_state() should've been done before dropping
> the siglock.  Am I missing something subtle here?

I agree, that seems like a bug, and your fix seems the trivially correct thing.

The bug goes back at least before ther bk history (in 2002).
Presumably since the introduction of the system call.

         Linus
