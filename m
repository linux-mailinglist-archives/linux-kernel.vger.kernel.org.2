Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1C53099ED
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 03:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhAaB4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhAaB4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:56:43 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14272C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:56:03 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u25so17901748lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcOVvyA1b5p+GquBk9DF0g2mtkUW8Gl1Nvne+f5M/hI=;
        b=R/4pYOeT878qmMD1uW6nI1IwMlZ0jL9G3DasqSYpiMP4oZ4ajeFWIL4wPn568xP5Z5
         HvCdAFO7FOJQzWmjhgwLuvvHcolXpVuZbm70qWdJNxG6gdBsgb9nSzwjYMr49U25NrZx
         fgnoZ/oynfxFxgwKzyUVmTulh81CdJl8f4LAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcOVvyA1b5p+GquBk9DF0g2mtkUW8Gl1Nvne+f5M/hI=;
        b=IojUV076/KOaJS5iY2i6zX3kDhQZA+jknwvMX/WGdrkEVeeXP3ZdEJTbrUKJRLhEvp
         lZzKZHKN4zQSJXrXKo3C+TWtFbGk2nyn99i9V/jO5/l+28sBEJFAliiP73CL6Sedbnmr
         IV/gNsoiIXE0Lls9rHthRvNbMSe4ZNXv9k0AbBBcwdjS5zz2lQSdN8h30huQzpsHqB4j
         fFOthCJubSLfTrune5ZhAoXMSB3I9XuDvIk/ANWq5nL1AgOz6J1h9L4bydFDKMqGQlGH
         DLP++kUJD8lU6wmekiaax8c2m1Acl4GjejN3QgsDXv+51gPkzSCHARyHXGe3z71PyNGa
         vtpw==
X-Gm-Message-State: AOAM530EpqLfKxtAbT0toal1ohGVa474H2tEzlVJ+pNaiSHwMJXZrsGI
        oM4/HnPcQLqqa6i2fD4rraKreDJfRX+3lg==
X-Google-Smtp-Source: ABdhPJwR12ZqteS9McaHer6bE+r4eLFdRc8YxAJKtqtXAY3+dEluzMhTkptKRFvZp70u+lIJzUFZ4Q==
X-Received: by 2002:a19:8805:: with SMTP id k5mr5304902lfd.567.1612058161128;
        Sat, 30 Jan 2021 17:56:01 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id o14sm2478624lfi.257.2021.01.30.17.55.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 17:55:59 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id r14so15182371ljc.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:55:59 -0800 (PST)
X-Received: by 2002:a2e:720d:: with SMTP id n13mr6780018ljc.220.1612058159294;
 Sat, 30 Jan 2021 17:55:59 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoL4=6L16Nxi4TW7Jt8dqNXBQTvZZOqBEBRRcZdHCQ_VA@mail.gmail.com>
In-Reply-To: <CAP045AoL4=6L16Nxi4TW7Jt8dqNXBQTvZZOqBEBRRcZdHCQ_VA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jan 2021 17:55:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqzP5UuZ4=F4ok18R5_1_vAZw9m_3G-W9Eodc1raM3TQ@mail.gmail.com>
Message-ID: <CAHk-=wjqzP5UuZ4=F4ok18R5_1_vAZw9m_3G-W9Eodc1raM3TQ@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Kyle Huey <me@kylehuey.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 5:32 PM Kyle Huey <me@kylehuey.com> wrote:
>
> I tested that with 2991552447707d791d9d81a5dc161f9e9e90b163 reverted
> and Yuxuan's patch applied to Linus's tip rr works and passes all
> tests.

There's a patch in the -tip tree that hasn't been merged yet:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent

(there's only that one patch in that branch right now, commit ID
41c1a06d1d1544bed9692ba72a5692454eee1945).

It should be making its way my direction any day now, but in the
meantime if you can verify that it makes things work for you, that
would be great..

            Linus
