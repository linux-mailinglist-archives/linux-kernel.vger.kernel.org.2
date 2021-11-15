Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4E1451899
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350959AbhKOXDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243049AbhKOSxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:53:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A871C0432FF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:53:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m20so29770414edc.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PymqKAT8jBOP1Mo+xJBJ36Dll43y3cdob3LlqUO0Tpk=;
        b=VlcPNl6avI2n8njh+6VbgsPTfsPoKKvmzNeqo3iVUP1Fo7LnDq1+IZJV2jxtE7dwWK
         RwKmv+FHfzMUGbCbKXthO8khsRhNC2d4wLJQX9m+UhETQWouIuail1qJCrORpgHhevNp
         JkWhrG8R81qTbUc55y6Q0Z8uREPILtllpQAqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PymqKAT8jBOP1Mo+xJBJ36Dll43y3cdob3LlqUO0Tpk=;
        b=oPB4biYhX+6PeCT9OHlOq5zxhtPFdUwl9Kx1TLygr5e90dtAZyuLhzP7VtPWfXVxCI
         PcU1fkCpSMvZB8XAP6j7TrWGOneAFbr8z4tO8EzlJuo+dx81JUuo7xmKDxaSFZb/WrDJ
         JrLSpYlEp0tSNiZvnyX6UF4fb3FFIbRpOiXwkhMP9UnJEyZigEmMP7TTuypR/XCUkOL9
         WJoLj3hJVqK9htQOTqR0sDriNszRy4E07SI7offYql/zGCpilP0dWD78eJLP7JxV9eu0
         erulgK8y5JEOT04SCBZ1AtkJbs4I2rMTKQWCxnpoom4+iAwQUcLYJiGE/auG5frzFFFu
         TIKg==
X-Gm-Message-State: AOAM533qrAjUU0MNWwOMXUyxDguO0hgJA/8QI8aC2eg8VoSdb6BVQADp
        fgitm/F3aZX+Yv/bkzsElYUKSidT4mc3IUUo
X-Google-Smtp-Source: ABdhPJwQb618Z8qIZJ45djWS3RUvIbQ7y/43g2BP5EHORbWm4eGkjlPgyFIUqBnUFUDW01OhIMz2rA==
X-Received: by 2002:a17:906:fcba:: with SMTP id qw26mr1021258ejb.448.1636998823170;
        Mon, 15 Nov 2021 09:53:43 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id j17sm3478101edj.0.2021.11.15.09.53.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 09:53:42 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id a9so6145641wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:53:42 -0800 (PST)
X-Received: by 2002:adf:cf05:: with SMTP id o5mr1032879wrj.325.1636998822078;
 Mon, 15 Nov 2021 09:53:42 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net> <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
In-Reply-To: <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Nov 2021 09:53:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgm-Co+ys0TQKZ8aRp-NGTb+ER-VFmEOEVamH724cWwFQ@mail.gmail.com>
Message-ID: <CAHk-=wgm-Co+ys0TQKZ8aRp-NGTb+ER-VFmEOEVamH724cWwFQ@mail.gmail.com>
Subject: Re: Linux 5.16-rc1
To:     Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 9:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Top of tree is a bit better:

Thanks for re-testing.

That doesn't actually look all that bad for -rc1.  Several of them
already have fixes, and most of the rest look "easily fixable".

Famous last words.

The most worrisome ones are probably the stack frame complaint ones
(libzstd and a couple of powerpc ones) that Geert also reported, but
they might at least to some degree be as simple as just due to the
same excessive inlining that was already fingered for the code bloat.

But it could be more fundamental - the kernel just doesn't like stack
allocations the same way user space does, so the sync-up to a newer
libzstd might be a bit more problematic than just "don't force
inlining".

Nick - you've been cc'd twice because you sign off your commits with
your work email, but then seem to actually prefer the personal one, so
I didn't know which to use and just added both. See

  https://lore.kernel.org/lkml/652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net/
  https://lore.kernel.org/lkml/20211115155105.3797527-1-geert@linux-m68k.org

if you didn't already.

               Linus
