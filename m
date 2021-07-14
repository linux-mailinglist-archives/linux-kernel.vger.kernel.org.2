Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377373C91D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbhGNULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244370AbhGNULK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:11:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CFAC0251BA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:05:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v6so5690560lfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjVQmrIVGwltwK1r5dkwsbhATiXC528RkYBjqLevFP0=;
        b=Ox4QzPp+RQGEZBJFDxx5UYrPFN4p4RoiXXBT+FyFJWV6ZUXeoxj+gDImRM83J1ujqR
         ei6/kbKym7FZaiPdTn+r7szeDcTdbY6Zm6YmOauIZ3I7GkaFkjgekcuAsVzTmnnWq7SJ
         SFvm/+rZ1ixzb9T0YIytnbpcK0kdy+Pmpgir4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjVQmrIVGwltwK1r5dkwsbhATiXC528RkYBjqLevFP0=;
        b=TaY3ju+Sn0gP5QITKrA9NfPpdSRZ90mKREAxEg80HLB25lPTC+60tzL35NANseqDjy
         Keryk5mqB9aMnUYHAQMfVFP2Md1OvBwMb5+L3NkdtvZNvoibqcl+AO7CxtbYqXN4qrRf
         47GgsoFGZre8wAI9EIGQNYoHPBqM+SwphWq2PWlWzGT4iCvh8qIifvPl30go4k276hy9
         3TzgJpCXdQLcMf/nfLv1wYAoloPWRR+ip4Nt2JTODLBNlPz7bnMnEmvaVk0B/ouSj6o1
         zPEsufWhY+LXC4SkN8Uect+dzT5ej7Bu5nA2c+oNtqIFEFfx9huySFNdF7i8FWKyC8ah
         U6Cg==
X-Gm-Message-State: AOAM533//AvBKknNSFZbl8Re0OUz6YHtZcRfp6lacocZVkRyj7IuHHuG
        JcINDD3kbXsQjQEsuL2QppkhN2FBmbgI9WR+
X-Google-Smtp-Source: ABdhPJx5CZBwzTq49XkgydFt0x63U1kr0hhSs2biKAbIQsonOKXyxeWTwMe8/uJAJ0SJrV1HhMEQSA==
X-Received: by 2002:a19:5f06:: with SMTP id t6mr29909lfb.188.1626293125897;
        Wed, 14 Jul 2021 13:05:25 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id b15sm237500lff.186.2021.07.14.13.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 13:05:25 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id a18so5659131lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:05:25 -0700 (PDT)
X-Received: by 2002:a05:6512:404:: with SMTP id u4mr32339lfk.40.1626293124769;
 Wed, 14 Jul 2021 13:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <YO8Rw23KxCDjzKeA@infradead.org>
In-Reply-To: <YO8Rw23KxCDjzKeA@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Jul 2021 13:05:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuDBQdUvaO=XaptgmvE_qeg_EuZjsUZf2vVoXPUMgAvg@mail.gmail.com>
Message-ID: <CAHk-=wjuDBQdUvaO=XaptgmvE_qeg_EuZjsUZf2vVoXPUMgAvg@mail.gmail.com>
Subject: Re: [GIT PULL] configfs fix for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 9:33 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> configfs fix for Linux 5.14
>
>  - fix the read and write iterators (Bart Van Assche)

I've pulled this, but I'm somewhat disgusted by it.

The overflow "protection" is just wrong:

+       to_copy = SIMPLE_ATTR_SIZE - 1 - pos;
+       if (to_copy <= 0)
+               return 0;

because if users control "pos", then that "to_copy" could be a huge
positive value even after overflow protection.

I hope/think that we always end up checking 'pos' in the VFS layer so
that this isn't a bug in practice, but people - the above is just
fundamentally bad code.

It's simply not the correct way to check limits. It does it badly, and
it's hard to read (*).

If you want to check limits, then do it (a) the obvious way and (b) right.

Something like

        if (pos < 0 || pos >= SIMPLE_ATTR_SIZE - 1)
                return 0;
        to_copy = SIMPLE_ATTR_SIZE - 1 - pos;

would have been a hell of a lot more obvious, would have been CORRECT,
and a compiler would likely be able to equally good code for it.

Doing a "x <0 || x > C" test is actually nice and cheap, and compilers
should all be smart enough to turn it into a single (unsigned)
comparison.

Possibly it even generates better code, since "to_copy" could then -
and should - no longer be a 64-bit loff_t, since it's pointless. We've
just checked the range of the values, so it can be the natural size
for the machine.

Although from a small test, gcc does seem to be too simple to take
advantage of that, and on 32-bit x86 it does the range check using
64-bit arithmetic even when unnecessary (it should just check "are the
upper 32 bits zero" rather than play around with doing a 64-bit
sub/sbb - I'm surprised, because I thought gcc already knew about
this, but maybe compiler people are starting to forget about 32-bit
stuff too).

But even if the compiler doesn't figure it out, the simple "just check
the limits" is a lot more readable for humans, and avoids the whole
overflow issue. And maybe some compilers will do better at it.

            Linus

(*) Ok, it's easy to read if you ignore the overflow possibility. IOW,
it's easy to read WRONG.
