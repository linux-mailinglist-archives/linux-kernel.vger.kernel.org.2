Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DDD40B778
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhINTGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhINTGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:06:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7171CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:05:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s3so468529ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZPcMq2Hb13StlpBoTh3xS6OrGfp+EgulJJy1eLr5r0=;
        b=XO4ua4Ix1R55uPvvcLfYeENkJdajgMzCMttxK0rirjrnB+uez/EZVDyBwrebVhLEOU
         uht2FvtVxKXkdSOwRaro4VB6MpfB/URjuBOVq9mpV7XPlwlk7/0O/mPYC/DlDQsDgGjO
         Nsig2aEerkFFdFomQhYrEgNeddfmTxML3FXVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZPcMq2Hb13StlpBoTh3xS6OrGfp+EgulJJy1eLr5r0=;
        b=hhxrG//MjMVA8p8MNPhdPNY+e6OFlkECq9OMnH2Is5sSa7wShC20/N+tDiIPAj6nH7
         R+SKXQe79yVK+kak9xpu0E+FHDmpEQhi46bElvuF2eRGVzzrQma6feIbb4KfPygJLSrq
         9Mrt83s7778ifcnSeppTuM/BycRGs0KnbDZIWE1sIy6O2aiP6Q4Y5Gb6VrctsjtRFcnF
         /PGTGNMi2VxN87VufPYMpa3fRNPX5NI8Zb/ZTK49fs7zrZKVZ7Px0/T1hqu0oIg9/7zR
         3DmUoWnf2PENKf8o0+mupT/XgO6tB/6cJubRLbF9cLqVyv+TQAI6z1EhWlqKhKjAa9Mu
         lAXw==
X-Gm-Message-State: AOAM530GPY0Mip+rcPbfdJM/YnoOckirYD786Rtop1mLqA8+qBZz+gcb
        5uD/MqVuQt0dO/btTFFs0cwTrnPu4oOH8rUFYFU=
X-Google-Smtp-Source: ABdhPJxz2KZNqv6aKZ4lK/5LGRglsIX3D6auDtY7f5qRvJdUgIqe8wd9nlgpvyQ0atMaWwqRBEhtag==
X-Received: by 2002:a2e:1510:: with SMTP id s16mr13317708ljd.119.1631646326545;
        Tue, 14 Sep 2021 12:05:26 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id b14sm1419580ljr.111.2021.09.14.12.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 12:05:25 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h1so490994ljl.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:05:25 -0700 (PDT)
X-Received: by 2002:a05:651c:158e:: with SMTP id h14mr13221321ljq.56.1631646325487;
 Tue, 14 Sep 2021 12:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210914105620.677b90e5@oasis.local.home> <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
 <20210914145953.189f15dc@oasis.local.home>
In-Reply-To: <20210914145953.189f15dc@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 12:05:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
Message-ID: <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:00 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, they do fix a real bug as shown by:
>
>   https://lore.kernel.org/all/e5c7ce5b-93f0-b305-de32-c99d0390eb28@suse.cz/

Ok, can you send me that NULL ptr check as one separate thing?

> Should we hold off until mm has fixed this issue?

Yeah.

That would actually fix the NULL pointer issue too, since a _proper_
memblock_free() would just be a no-op for NULL.

That whole "do __pa() on a random pointer to pass it to
memblock_free()" is really just complete garbage in _so_ many ways.

                Linus
