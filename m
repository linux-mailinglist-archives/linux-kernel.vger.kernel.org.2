Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3983FE4EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344693AbhIAV3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343833AbhIAV3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:29:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81640C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:28:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s12so1541780ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCael78eHTXtzN3Jeoe7P5VBsdIsgjl3tT58y4QUcXI=;
        b=TPQiuLqHwS06/WSYc3aqR2n6F/ZnAzPZ4cNqDMXlKyJHO71AdpC+c9mXY5rUoJ3NO4
         n+bQPZkg8zBYBQZ+JJoFiRBDUDni/OSVdlNcEk1xo7LgvQZvnhIuKPbZnMQqCW54neIR
         I9Fi7MrYRX5+XT9b7cJOyWiKEjBb8tb2adItA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCael78eHTXtzN3Jeoe7P5VBsdIsgjl3tT58y4QUcXI=;
        b=fzScfJskJdUDf5B/qh5d84kwn76pLaeRYMRf0BrPTGtF0Qf9/TuUnNVdR2/6Vyo4/y
         6NtyhB1U2hVNCfpbLLZA9Pi9t/AmoRuPN50gm1K2oErjmQyL5dKxPpcd1unhjELsO84i
         pvBFytWQaI3ED2AeBDtvUW4MqdHWLk8Vns0oR4xO/zchJjIPSRaQFWo9fYICefqCZXCC
         TikATHV2ct2O0qX7LwJqbuV1R7aHrw2/j6wHBJMghv/V8aoqBXOfR0RQ2tZtlgY9y3Cx
         Auco8D43cSUhlq9YIcHn4U2A0kmVkhHnffTc7VZRpBnAokI+LwmjLnEW5bmoWBAyTWR/
         NBOQ==
X-Gm-Message-State: AOAM530sJpzwew/RKZsInsYAkdoymN6V9/+/I1O/BQct17OWvLf4LP+7
        1UVt2amE2yPxfDZJ/60QjyVif4fLN84TpcbR
X-Google-Smtp-Source: ABdhPJwD31hvaTm+YoNbkxTjWRrWDPjkcRZg/9DoM3hkzOs0v313HiHpOOeK/3zwlvP7rtzlN7qv8w==
X-Received: by 2002:a2e:2ac1:: with SMTP id q184mr1282581ljq.373.1630531700465;
        Wed, 01 Sep 2021 14:28:20 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id n15sm71114lfq.270.2021.09.01.14.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:28:19 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id s12so1541664ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:28:19 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr1305255lji.411.1630531698848;
 Wed, 01 Sep 2021 14:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <YS+LXqoDGk0CqU1Q@kroah.com> <CAHk-=whqN1gAZk0ZD_4JxGemdbpnQkDaNFY9MjW==v-kb1J-fw@mail.gmail.com>
 <YS/pzJCV8MiwOPRB@equinox>
In-Reply-To: <YS/pzJCV8MiwOPRB@equinox>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Sep 2021 14:28:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzVVzA5Ng0BUZOvhxEjQiopjwWM5KQDhh6-dWKbD_=vA@mail.gmail.com>
Message-ID: <CAHk-=whzVVzA5Ng0BUZOvhxEjQiopjwWM5KQDhh6-dWKbD_=vA@mail.gmail.com>
Subject: Re: [GIT PULL] Staging / IIO driver changes for 5.15-rc1
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 2:00 PM Phillip Potter <phil@philpotter.co.uk> wrote:
>
> I left this code in when I wrote ae7471cae00a ("staging: r8188eu: remove
> rtw_ioctl function") with the intention of modifying and reconnecting,
> once the changes to struct net_device_ops made their way into the
> staging tree.

Oh, ok. That explains why the dead code existed.

Yeah, I guess y9ou can resurrect it now with the new siocdevprivate model.

I actually ended up doing that first as part of the merge, until I
noticed that the code wasn't connected in the staging tree at all and
then decided to undo my merge and just remove the dead code.

            Linus
