Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2242935721C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbhDGQ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhDGQ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:26:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60855C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:26:47 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u4so21436712ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0Mui9yDr8G87XIz6Tef+nFdSKP7HaRLCXsnomp+h9Y=;
        b=GB2/I9FsJxZ7Onx+dDzbRONjfxL4W0expSW3vhQa7XTxIeM+3VOfYKKZO4NbdqpJaR
         WF1sKRbosBt2WczkgD7Iic4fGzGhVs4bmZztbJyNA7Nm0BMdk68ulsoSjgzN+T6OzBdm
         jKlLD80P59E142f0vYSdMdoGW0RG2rzDABHBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0Mui9yDr8G87XIz6Tef+nFdSKP7HaRLCXsnomp+h9Y=;
        b=Azcddz0nyEhWPECTgPtRxgxaaUTutX3mN08n6uzaAZDbnhYZodPsonF7Be7wCQyPYP
         uUIH40USZ0hD3YBXRZ9xuHKLF1ti6Uxh4HRjCJWoNwhYCZuo1vfxjVQldGA1ERFyir8S
         B5frfiLd2PBX6wVg7FzRk7MqZkEm5dVUCe0hKo3QOJHPqxjIn/pXshSbiE1J9MSR+Pjn
         OGMw0U5zGxAzCLVp/9WslOdDq1d9ovdWvuqh3gxOXAy3wfMUplOlW6xtXaWmPgxoHCeT
         9YQnD676+9MIANI8+s3lvG75DW10EdzHbjx1hX77TcbZnKlOy9gP9Drd7uRWw/BV250G
         Xzgg==
X-Gm-Message-State: AOAM533IrQOPIZyj8JikWOCnCcEZ/liRi9AA4iAPjSEvE8XQW/j1z/DU
        tWUzhIRPbtmYrfxouEU3CE3RWZMm2GuDog==
X-Google-Smtp-Source: ABdhPJyuAgAfj7vYx/MvawR9F7trZq4V64m8kk/YwcOewIokJgZQyNagJAdMk/kzSKgHLHcacbdyxA==
X-Received: by 2002:a2e:7d04:: with SMTP id y4mr2702951ljc.94.1617812805596;
        Wed, 07 Apr 2021 09:26:45 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id b25sm2576768ljo.80.2021.04.07.09.26.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 09:26:44 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 15so21474100ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:26:44 -0700 (PDT)
X-Received: by 2002:a05:651c:3c1:: with SMTP id f1mr2662932ljp.507.1617812804185;
 Wed, 07 Apr 2021 09:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <YG12tezhGsQ5R/lG@ls3530>
In-Reply-To: <YG12tezhGsQ5R/lG@ls3530>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Apr 2021 09:26:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmtbLVB4RYfmjSbYXTxiOsEsXzkkpShRN4NZpe2cAVTQ@mail.gmail.com>
Message-ID: <CAHk-=wjmtbLVB4RYfmjSbYXTxiOsEsXzkkpShRN4NZpe2cAVTQ@mail.gmail.com>
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.12-rc7
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Gao Xiang <hsiangkao@redhat.com>,
        Wan Jiabing <wanjiabing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 2:09 AM Helge Deller <deller@gmx.de> wrote:
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.12-3

Not technically related to this pull (which I just did), but doing the
pull did remind me that you're one of the people who don't use signed
tags for pull requests.

I don't require that for kernel.org accounts, and it's not really a
problem, but I do encourage it.  So I thought I'd just mention it in
case it would be something you'd be willing to do..

You're certainly not the only one not using signed tags, but I'm
looking through my recent merges, and _most_ of them are from signed
sources these days.

           Linus
