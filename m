Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CA329FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574821AbhCBDu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243675AbhCAVkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:40:55 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBDCC0611BE
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:34:59 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a17so21322784ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvDP25u8oTuXv7zpQhtX2lv8UkIEZbcpsAj2zW682xU=;
        b=N14mrZ/qed2HPpFdjxuq6Z/O4ojGjw0oxx0Y4oW+HGi73n/SRisLcpzLhx7jy+daQt
         22xXELqTquWTdwTUw76P2X4D4PxBuY8OQzcme1CySohzf3Od0rD28irXTDqYta601xox
         teTSIzZhHQ4JOlYenv2Q9JLtnTYtahPizI9oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvDP25u8oTuXv7zpQhtX2lv8UkIEZbcpsAj2zW682xU=;
        b=FldP30Tf12OHQZHnK+9zS6OjgiITmdMglp5hBQe1+yX3ZZ366i4ZHZFSyA3krPRDzX
         NujGHhSZFLOJqlBfjn17VimR5CVIY60Q6t4Ndv/KraiEEKL9eN9fO58TDbbrHYmlI/Xp
         m92WvQK2fRJvZhovp6l0O2Zh3BqGiyIj863ROlXnUeeEHuV6C+moUBJP9kRHKrZ4kGjX
         Vl7DMy5tCbq/ynyUw+UXdAXvcVhpO4mpD1yP62wnaEmo9Ucl4wkbN4mGWkxyQffs+eTc
         0U1Bi+M0OwDrfC7EMtBwfs/90VTlUVzLZrIe5cgLSXQ9mr/DRrWTfpJ7sGLRy3lBN1h5
         1cxg==
X-Gm-Message-State: AOAM531BBaUE9aWAfMoVnw2wPPzbqJV2WsJYrVT0qtclKQyZtttyzbIm
        72+FB7r40QT1/mqRu4yUW/gK7exW03o5Hw==
X-Google-Smtp-Source: ABdhPJy0jdc1UZmCQY72clmiYkSD4LgX0s1v1wPk9XLzPPF/lrScIpwEfMpdfv1w37o3Kkb7HpggGg==
X-Received: by 2002:a2e:9118:: with SMTP id m24mr10324237ljg.415.1614634497812;
        Mon, 01 Mar 2021 13:34:57 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id k9sm2581069ljg.59.2021.03.01.13.34.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 13:34:57 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id e2so14126173ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:34:56 -0800 (PST)
X-Received: by 2002:a2e:864d:: with SMTP id i13mr7426349ljj.48.1614634496518;
 Mon, 01 Mar 2021 13:34:56 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUjVnBjC4AJTT9LYS4J+QbuQZUVj5XdW+iPmjxxuODVmA@mail.gmail.com>
In-Reply-To: <CA+icZUUjVnBjC4AJTT9LYS4J+QbuQZUVj5XdW+iPmjxxuODVmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Mar 2021 13:34:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wivYUWarZQNObmi7ZbO5rz1SPD1YmTJhne-8E352Ab=eg@mail.gmail.com>
Message-ID: <CAHk-=wivYUWarZQNObmi7ZbO5rz1SPD1YmTJhne-8E352Ab=eg@mail.gmail.com>
Subject: Re: Linux 5.12-rc1
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 12:35 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> I wondered why there was approx. for 6 days no commits and got an
> answer from an LWN posting "5.12 Merge window delayed".
> Unsure, if there was a posting to LKML?

There was no posting to lkml because lkml doesn't take html emails,
and I only had mobile data (and not even that for the first 24 hours
or so - even cell towers were down).

I did send updates to several top-level maintainers and to the
users@kernel.org mailing list, so a lot of people knew about it, but
they in turn probably only ended up mentioning it on a need-to-know
basis. As you mention, LWN did have a mention of it, but you'd have to
find it.

In normal times I would have just taken a laptop to the nearest
Starbucks and worked that way, but not in the pandemic. Plus the local
highway was actually shut down for three days because of downed trees
on the road (this was not a Texas-style electricity generation problem
- it was literally thousands of trees falling all over. We had one
miss our house by a couple of meters).

Two weeks later, and the roadways are still littered with trees and
tons of branches everywhere you drive.

And I didn't have a generator because our local power lines are
actually buried, and we very seldom lose electricity. But when all the
feeder lines are down because trees fell over, and it takes a week
first for the tree crews to clear the roads and then the electric
crews to replace literally miles of electric cable, it doesn't really
help all that much that the local lines are buried and all in good
working order ;)

> Anyway, if you are not able to make your work someone else should jump
> in like Greg did once.

It was an option, it didn't seem worth it.

And part of _that_ was that it looked like "ok, a couple of days", and
then it just kept being "one more day" for several days.

A lot of people lost power for just a day or two.

The area I live in probably wasn't a huge priority, because it's
somewhat sparsely populated, and nice and wooded.

Which is really nice most of the time. It's not quite so nice when you
can hear the trees keep falling around you, and you know you have a
few really big ones right next to the house.. ;^p

                    Linus
