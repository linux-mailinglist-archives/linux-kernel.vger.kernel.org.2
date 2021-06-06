Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE939D19F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 23:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhFFVZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 17:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhFFVZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 17:25:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A78C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 14:23:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e2so19308803ljk.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mJNIfuVAxCNYBc6IddSNVh1jF7eplIdFKdsjIJGwSM=;
        b=XGTum73bgSDtdP2ynbXodGST1CTGtY4OKprhQtHIOXQ8OyH4WDH4EnXS4tB7l2ilSt
         jvg8qp1e4dcWkf6nuX+p5XbePG8fbWmSRcHJR871kjPN6EU1xxL1h1RkaYa8SED6StFV
         ovR/2eucfY7l96YpY342cNt/+E5PBIwJuM+tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mJNIfuVAxCNYBc6IddSNVh1jF7eplIdFKdsjIJGwSM=;
        b=Mu3IRazPO7kjuq84siQ4O2lsyl6uG5Ejy9XfUlinPgyDgCchaPx1OAATkcit5Cl/Vr
         /GZ/GrWhdGQlGPZrWulZLjZgn3Jm4CtqMQM4Uiy1L3x7VujKeZhUnLvCVw16wuXW9Zjp
         IAkPwtX8QNA7V11DGjf8dJ2FTju2r3iwCoTJpXPG1knJZUrqbE23gWprshSf/2bLtnVK
         frq20bFek6p74kNN0vQ5gJ3E7BmXxVbmJkuQxVP5YAtinzx4gbZCellXdEo7l9Ndcwbd
         YGtQskh/aISJziNn59gq4fu5ixgSCy5GupfB8Mg4Gi3lX6O1glZqoKzXP+Nzty9t8yEp
         1/Hg==
X-Gm-Message-State: AOAM532/FlHzm0JM9LG9a6fMN+1RLYD/SbvCXg+uS7rPtNWF7XB29g0Z
        /11XqFXOCs9zXUY2C4aqomGXzsE9AXoVmXNIR+c=
X-Google-Smtp-Source: ABdhPJwQzDLjTUdQ5O5IdX5Jkng42+dx8Ou0qUeUXgP2BlXK3lHTE7NveBss7Tln4El7Yl1qev6PLA==
X-Received: by 2002:a2e:bf10:: with SMTP id c16mr12710580ljr.289.1623014618237;
        Sun, 06 Jun 2021 14:23:38 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id k8sm1259503lfe.89.2021.06.06.14.23.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 14:23:37 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id d2so15112581ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 14:23:37 -0700 (PDT)
X-Received: by 2002:a2e:c52:: with SMTP id o18mr12142201ljd.411.1623014617608;
 Sun, 06 Jun 2021 14:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <YLx/iA8xeRzwhXJn@zn.tnic> <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
 <YL029aQZb09G3ShY@linux.ibm.com>
In-Reply-To: <YL029aQZb09G3ShY@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 14:23:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
Message-ID: <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 1:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> A while ago hpa said:
>
>         As far as I know, Windows 7 actually reserves all memory below
>         1 MiB to avoid BIOS bugs.
>
> (https://bugzilla.kernel.org/show_bug.cgi?id=16661#c2)

It would be good to have that checked somehow.

I don't think this matters on any machine with gigs of RAM, but I do
wonder about the people who want to do small configurations. Maybe
they've given up on x86?

It also eats into that somewhat precious legacy DMA resource and eats
up a fair chunk of that. Again, not an issue on modern hardware, but
..

> I believe that reserving everything below 1M after the real mode trampoline
> is allocated reduces amount of hidden dependencies and makes things simpler
> overall.

Simpler, perhaps, and _I_ personally don't care about about 512kB of
memory any more on any machines I have, but ..

          Linus
