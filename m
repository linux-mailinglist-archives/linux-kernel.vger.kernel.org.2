Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C229B442E9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhKBNB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKBNBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:01:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EFBC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 05:58:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f8so54108278edy.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oS5P08rKOHmHVOqFsv1wlAiyj1NrRmUfampI9oL2V64=;
        b=n5PHQAW9dm9kSkiLYV9daCoVja0+TvWv0SvPUz8RC2NAWnAS31ToFveGA1/UPb7uYB
         f2DFw4kpYFhgjAav2FZdaU4krkdZ7po9IsPMKSRj4oEE7vb5V/lMQlEBKVfIZlCwUM6y
         W9aK0lSYkAOZmx8r4UpzYRovgJbgvMlb7iUfZ+YUBflrQE4/62VAeOfpv26y5Xn0Gm3J
         q3zC3SpxcC96EDC1+fvOA9T2Wf5EiD6cs6axCkiyJICxLsJq6xHYZRb0RShO3obZkJMU
         aEtStNkbcZgbr2ZF4OuZBneJBBa0HWbEyaYhLCSyNlaANsI6r0GVcXsUG8TWX1fH649s
         W1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oS5P08rKOHmHVOqFsv1wlAiyj1NrRmUfampI9oL2V64=;
        b=fQ2/mjsIcoH3VJj3W2G50N3BZInhgvHpU/GLjIt6/Ko5A70z/w34b/GMuHa1aOOdcD
         VwUdrElxdtzsqKiEdwrsfmU5t57kjcVeIGg6vphbqVHLMHAu13mbArLUDdQQse2ghSD9
         KiYPFRAUoYaEEEHDxSaE39b/xZEarxPnwpUQf6TLWZTkmGFyO+weq3f9Ntc44uGGVUgt
         1ELf5Mv2nHgCSaB8gr3FmXLjU7Wd7RI+LCYLA4OFeLxNA0opPM5SQZETkZL6IIdTFJ79
         ZtRgWPLq58GdimqLW3kDpVtnu67kwGznWdct8SBkw3JLMYmB7TnZpkkncr7n0UKOjd/B
         QcEg==
X-Gm-Message-State: AOAM530AqDxjhPgds/V1WJpsqrS1+tKC3grGRqHZlk5Ea/QB6O2w96gK
        I7G5yaC/+TqwMtO35ObnoptZYC6I/PMPUwVRlGiO
X-Google-Smtp-Source: ABdhPJydRuxERCqDLUerKHEo8hrEbU94yrYYszodlvCbnReZNWzPvF4WrAzB6P1x8AOkiMpqhUts8Pw23pMvedkoZ/M=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr25449694ejc.126.1635857926118;
 Tue, 02 Nov 2021 05:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
 <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
 <CAHC9VhS3LfGvuVyXW5ePTQNtQ0KeQ7vz3wLinoZrbGVjU6GuoQ@mail.gmail.com>
 <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com> <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
In-Reply-To: <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Nov 2021 08:58:35 -0400
Message-ID: <CAHC9VhTZW-thM3rhMArYNQYD1PjLWh3Y3XBQ_XGv86TqkN3GVg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 12:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Nov 1, 2021 at 8:55 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > This follow-up was sufficient. In fact, the original should have been
> > sufficient for me.
>
> ... and as you saw from the pr-tracker-bot, it's all merged now.
>
> Sorry for missing that part of your original pull request.

The important part is that it is now in your tree, thanks.

-- 
paul moore
www.paul-moore.com
