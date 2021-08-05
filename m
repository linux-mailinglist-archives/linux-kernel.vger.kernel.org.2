Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF583E16BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbhHEOOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbhHEOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:14:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B4C0613D5;
        Thu,  5 Aug 2021 07:14:37 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k65so9144284yba.13;
        Thu, 05 Aug 2021 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RK1qIQUMLDg26C++g8PqjRfyq8ZGyPCSWDvxnpYfF8E=;
        b=QFvAV2RCqJkzoxy7/W3L7MVfZqX3besaGBVzK05YOrnnOwyEmlws+PFW9OL/RMDCzT
         NYDqsmuTEVLewksne2ox5GqyJr+a5Oq6XuQQjHWFj6OotFRhzMTKqE6EufJMGZAb8Du2
         E6pTfj499rC36OliUWBBAXqtg6a1pCriuU47DKL118KBYkF+gZQVap+r8XKWypEI5Zv3
         jjNoRgL7OLhqRfsaYjmJbZ1+HWFRtZgnIPtuRqc93xiBPeaKaoSuiEsc/evKWm060DiX
         qm1KoOR6c0yIWO4bW12EoFD+tTF7CdnG3qBkfo2zg6KUaYoGYsxMIEM0DY8vW6MJ14+L
         XBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RK1qIQUMLDg26C++g8PqjRfyq8ZGyPCSWDvxnpYfF8E=;
        b=BK7VZsLumrhystWmtLnca2cOrghaX/W10XcVxF9KGk1gOBrFZ4n5mo7+BS6Xt8XAq/
         q+LnTKkd+l3F2eTr0csoGL0sGB5jSZO17QkvTISwSTaQjiZRg6C9KGtIVarAULzIeNAk
         3TbirX2/71ja57cCostN8s/Dlg1RqxL+SnUXHSenxwH2eVdIwGyzi2TtYTkVPGX4RR42
         VGY5nPAjsBUMNsSv7kNiXzmkFIolqbu5T2wjyabyqeT0m8548vynSW+Tt1VR3cW79NQp
         YUScDBUvzbJA3WNEPX7epXFOmS3DWNXy8OZXHgWt5t9328PzNTT99bg1HUKxKIidI20L
         rcDA==
X-Gm-Message-State: AOAM533Zlc6J3F6q1ieuOuKqfuMYXB81Wa21PKyF/yme+zOGgOLFTNvj
        /HLKXuuZR+Nfnkv7wMj6MrzoUjFZmSMzYR6IN+o=
X-Google-Smtp-Source: ABdhPJwRz3wgEoQPBbgKhhXkeK2ovD55mNvz/+/sT0GE7D2gSwrAphc8StUK2qzf3Q7v7Gq/Ri/AR/VzzcrC0eR8QBQ=
X-Received: by 2002:a25:b948:: with SMTP id s8mr6272708ybm.281.1628172876679;
 Thu, 05 Aug 2021 07:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210805133213.700-1-lukas.bulwahn@gmail.com> <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3aNuxaEtAiewd+Wjc8hKtca0NrcV2kykkNC-qKT_HhzQ@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 5 Aug 2021 16:14:25 +0200
Message-ID: <CAKXUXMxsx5V-ONCxaNaLd3mw_=Epca1eUg3SRsf3+QrTK07yXA@mail.gmail.com>
Subject: Re: [PATCH] rbtree: remove unneeded explicit alignment in struct rb_node
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mete Polat <metepolat2000@gmail.com>,
        Jesper Nilsson <jesper@jni.nu>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 4:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 5, 2021 at 3:32 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit e977145aeaad ("[RBTREE] Add explicit alignment to sizeof(long) for
> > struct rb_node.") adds an explicit alignment to the struct rb_node due to
> > some speciality of the CRIS architecture.
> >
> > The support for the CRIS architecture was removed with commit c690eddc2f3b
> > ("CRIS: Drop support for the CRIS port")
> >
> > So, remove this now unneeded explicit alignment in struct rb_node as well.
> >
> > This basically reverts commit e977145aeaad ("[RBTREE] Add explicit
> > alignment to sizeof(long) for struct rb_node.").
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: Mete Polat <metepolat2000@gmail.com>
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > applies cleanly on next-20210804, but only x86 compile-checked.
> >
> > Michel, Davidlohr, Jesper, David, please ack.
> >
> > Mete, you might want to re-run your RBT test suite for this change.
> >
> > Andrew, once acked, please pick this minor cleanup into your tree.
>
> Do you know why it needed the extra alignment on cris at the time?
>

I basically only know what David Woodhouse wrote in his commit message:

"... allegedly it was necessary for struct address_space on CRIS,
because it otherwise ended up being only byte-aligned."

> The revert would appear to change the alignment to 16 bits instead
> of 32 bits on m68k as well (not 8 bits as on cris), but I don't know if that
> can cause problems there.
>

I guess this patch would need to be exposed to testing on the various
architectures. I personally can only serve with testing x86 and maybe
with a bit of some arm architecture.

Should we CC the various architecture mailing lists and maintainers on
such a patch, or is that just noise for these maintainers?

Or could we just quickly pick this up into anyone's (Andrew's) tree
for linux-next and expose it to wider testing on other architectures
that way? If we see the patch cause failures (rbtree is widely used in
mm, fs, etc. and hence boot up would probably already fail), then we
know and we can adjust the comment with a patch v2 to know for the
future that this alignment is also relevant for other architectures.

Lukas
