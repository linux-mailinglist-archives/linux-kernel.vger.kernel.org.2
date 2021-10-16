Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCABE4303A4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbhJPQYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 12:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhJPQYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 12:24:39 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D755C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:22:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y26so56139367lfa.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOYjIwrVZxhUbNWSGTQPnQPa/h8wJ1cvVqLz000cP50=;
        b=RnZYNq5deahqF01JorNo22IZo2i8ysNNiNOa7QuqWi+bPIs1TQECok+eoWk5bxsUFr
         nG3rC4+Zz9gNN6vy6x8T1639Koh+kjmu4maD7WJMZ7JbO1SyKYRirbyxzpqoc+tkXtus
         PXV704d2Amol+dm+IepBLYoQ39r9DR9bpVeqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOYjIwrVZxhUbNWSGTQPnQPa/h8wJ1cvVqLz000cP50=;
        b=JzCwy9RCHeOvm3JfAmJTTqCHCc6XQVRPH5HFx26sfXG+goAMhG+UhrApgD7AJlXuUT
         eCGMR3t3/RO57wKMY9igy+jwrm3FXXdpO1WXLnCcnc1l3eQkaOmiXrthCSGD0xzI3LH/
         FiG0AatMZLE/YgCp9BDRTL057qG2r/IemiVfGVN11q6bbW3ts0R0M4YTcBMTSxJqZHGh
         ceFV3wy5GmJoIKHcFMDcNxSKwkrROa8DOQW9hYj2uZZpxtk39T9FZpCcPLp0G+HFD85B
         Gn9ME6C2v9NzZR72TYmLo0HOK7Pdabw1dLS8bz27vLZZNn+ayLn/Wy0vlbrLf3uTHREj
         c9pA==
X-Gm-Message-State: AOAM533Iqk0KJdqvpWjoQOvAZOJx1hWOoYI6tOhu/nhVCAAZ/CIPR7BB
        c3yVhZLh2U0oEp54TquAKGpNhnNGfQsFAG/L
X-Google-Smtp-Source: ABdhPJyjqJ39NGm2J65S0m1UW+gbof4p87ZxLquUhKDbDvceihB0SIdxF/0Cj0JmIJPz+fAYbzHsLA==
X-Received: by 2002:a05:6512:e94:: with SMTP id bi20mr18758739lfb.384.1634401349363;
        Sat, 16 Oct 2021 09:22:29 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y16sm966999ljn.74.2021.10.16.09.22.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 09:22:28 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id p16so56165973lfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:22:28 -0700 (PDT)
X-Received: by 2002:a2e:934d:: with SMTP id m13mr16917423ljh.191.1634401348513;
 Sat, 16 Oct 2021 09:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01634376368-ext-7035@work.hours>
In-Reply-To: <your-ad-here.call-01634376368-ext-7035@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Oct 2021 09:22:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoe211F8ND-9hZvfnib0UA4gga8DZJ+YaBZNbE4fubdg@mail.gmail.com>
Message-ID: <CAHk-=whoe211F8ND-9hZvfnib0UA4gga8DZJ+YaBZNbE4fubdg@mail.gmail.com>
Subject: Re: [GIT PULL] s390 updates for 5.15-rc6
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 2:26 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> - Fix broken strrchr implementation.

I pulled this, but had to look at this commit just because it struck me as odd.

Is the generic strrchr() implementation so bad for s390 that it shows
up? It looks like the s390 implementation wants to avoid checking
separately against the final NUL character and basically uses the
optimized strlen function to do so, but when strrchr has to walk the
string _anyway_ this all looks a bit odd.

Not a big deal. I just get the feeling that s390 (and probably other
architectures) might be a bit too eager to make their own helper
string functions for reasons that may be historical ("we didn't have
generic string functions at all long ago") or misguided ("we'll do an
architecture-optimized version even for things that don't matter").

          Linus
