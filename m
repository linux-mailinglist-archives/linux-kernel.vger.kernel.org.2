Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A002E38F9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhEYFKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 01:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhEYFKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 01:10:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CBBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 22:08:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b9so10019443ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 22:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gugbK3GuzJfswuusq4RJrhrh84MP7SfEG2HwlvTjBS8=;
        b=HfQBKA0PZvggbiJvcfoUX5ZHlxZkF8uTSfI7G8eLzMk6zrI/wztVjwMjWZihGYzBRN
         lCvUYCYAQ/kqxrjAhst8WVNcnQCCYkuhhmgn9XnTIfY7XcL+qVU4S33guotrj8w81y1v
         Dq1kuHAbY8TWlhieaY4cuqg+b3Gyiql1WCyJhB4KEKI/S/6QXcs18YsGG8xxZPYRizbK
         gXiO16e/QsgYYiyJg5A39pRP7NWUb8AKfr56L97ZMedFTZJ1suXLQd5tWORaSz3V8XMw
         +b6HiaaXA3+SqosL6NsH+shedR5bygx92iBijecjxd7Euf2v7ZrGZ4YbNuKYPh/gvv1Q
         9ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gugbK3GuzJfswuusq4RJrhrh84MP7SfEG2HwlvTjBS8=;
        b=jMgg8biduCtT3MSZ5nU0Ai+pjB52NxKefMckQWH6q/8ZpscCmw1vEZqaMZcsp1n7Ds
         kxQTNa0E6wSqObcqHGh2tR+cw4OfQ2sKZzea/hiLXxpXFKkZqVeB+MnKNaUQRup+gnqg
         YWefGcCxtxcQshhMtSQirebM8CiPT9jbj67CqOvFmbFlxkjjyubKftlclkVeODgzvAs1
         VGnsax8rEfPFnkA/VzqtGtbfVot6Oq70SjN4R5HvDrztw+XdPyMupSZ+GmJWlfxUiPTF
         CIDwpKmpLHCuaS3l6TzGy1VS7mNZDVQeqGeQwRwAJRr5SnVt68vXzRMW6OyAEre6lJtM
         HZyg==
X-Gm-Message-State: AOAM531JoIJilpVsn45DoZyLlMbS9Fu+0x5U4yeXdtjDpAhdcdCrIqnO
        8vPxQnWPsCK/9Ll/gux2E6da5PrYHG3WdaeekbQ=
X-Google-Smtp-Source: ABdhPJz8jf3g2jOCUYmW4eaZBAACOPG2cjRnMDsfwyaOp8HKwo+Bh1+GaD5muGVBxlpj6Sbrb1/a0oWbZpOh7MjftAo=
X-Received: by 2002:a17:906:1d0a:: with SMTP id n10mr26609823ejh.341.1621919318592;
 Mon, 24 May 2021 22:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210523001806.3927609-1-tpiepho@gmail.com> <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CAGS_qxoKTyNBxoezkEVVrACGsFuzJwteepVpDzp+4KH+CgbMsw@mail.gmail.com>
 <b5511f68-814b-1f8c-08d2-a7dbddce4e8d@infradead.org> <CAGS_qxrZAxvRD5Scvd-dMahnf-27npMjbzKKjG-+Bk7hZgZj5g@mail.gmail.com>
 <bd3fceb3-4d49-befb-ee3b-bc01ef5d6827@infradead.org> <CAGS_qxrUGW4uyMUQtEYWX710LxPs23B=uOJfhZSvMV1yaVa6jA@mail.gmail.com>
 <CABVgOSnB2_WVtedhE+EPMM9v+ePOp2KMFze84oxGS9Pgf31HxA@mail.gmail.com> <caaab2dd-b1b6-b105-6b2f-9a2bc8438a82@infradead.org>
In-Reply-To: <caaab2dd-b1b6-b105-6b2f-9a2bc8438a82@infradead.org>
From:   Trent Piepho <tpiepho@gmail.com>
Date:   Mon, 24 May 2021 22:08:27 -0700
Message-ID: <CA+7tXihZZy8i48aLAKAPptFc3Ktggve3V-8b1ugB9Ch1khMOJQ@mail.gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 6:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> > Personally, I think that RATIONAL is probably an okay thing to select
> > here: it's not as heavyweight as drivers/filesystems/etc, and our
> > general guidance here is "avoid select where sensible to do so", not
> > "don't use it under any circumstances".
>
> RATIONAL does not have a prompt string, so depending on it would not
> be reliable.  I.e., it is meant to be selected.

Yes, there are no out of tree or userspace users of it.  The only
possible way to use it, is if some code in the kernel uses it.  So
that code can select it.

If it could be used by out of tree modules, then there should be an
entry for it, like some of the compression and crc routines got so
they could be turned on for out of tree modules when nothing in the
kernel config used them.
