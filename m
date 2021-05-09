Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8223137793D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 01:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhEIX30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 19:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhEIX3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 19:29:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D46C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 16:28:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m12so21786188eja.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 16:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBFJrqe7bHT5+gn4IcxMShBG7BogSn9qx16JG59uH0Q=;
        b=X3WBc/yNTPCTAZal/4i8kU9SAkAsXd24twdgeu0i2VNzHRnu6ILggUBX2B5jrDB3DE
         1mZ1INALsjCd60UsD7iqEjCo0xsidaHBlKQJrnyqnbK6jvf7sLeIUaFRDVIaQh3Y/WsV
         vUZtjCa1Ha0TE8iKg9mZVJ4iZo9qcrzV520qDzmgqDpfiEgeUzPRhn9HxXaEiw9btMUL
         AMCKiN6sy8+uciNwxOHB1IoreTFJIcxiKcg8stM6+UF9O+Vt/iyfOH5X3i4PTBCuCIA5
         nvQvhpn9SoZoYsc6MHXBrW1YNmCHqcucWfvwPKBlwf2s9Vz1WSEwhiJ5EUVNRMxtzrUE
         /Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBFJrqe7bHT5+gn4IcxMShBG7BogSn9qx16JG59uH0Q=;
        b=Wed8X1AqgfcA1GPvH9oGHgpL9NZ/JJ8pYynSiG1VoLtvjiOVQd6BIF8FQDm1vT5Giw
         TYGT+o9L1kLOvIS3ueaGFb5Op7LIEyHSNsjnZmBes5fp01iv9XWyimArzQb8AodjNrEh
         B70aNs/aOqx7BDJHQnmCWmjsGlL+vKrgIalBP9w6JK2JVYtoAE8UbMHqPaxGMfOfgcyn
         AZC1vL/25l+nuqB2/jBJNAeBEo8wMO8Fn52CNiUMoRnJy1THGBb6Ux87KMNMCySF/PQ0
         Ci46LUGeAsrN994sZ5NfBWbrJij7nAs0eTsWSgjr8LApGdmly5IRMzY+dZA/G4s74nup
         cuJQ==
X-Gm-Message-State: AOAM530sqINeIQxQ6qoJE0X/08abcpOKxU3qA8O4IClxoUgkQAFGdTPg
        5ghq3Ybk8pRnYVIeorvPhhLbhuxluGks+kY3lFcIemYx6nc=
X-Google-Smtp-Source: ABdhPJyp04FFC+8e4/ADV5BBAh+WBx9ZhIH7+RLgA7JIHlPGdBi+MXd809EgfD4TLG8+f1ElZoVm6MNK3c80tDba6Rs=
X-Received: by 2002:a17:906:8285:: with SMTP id h5mr22488211ejx.456.1620602899126;
 Sun, 09 May 2021 16:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twAN82gkzrfc2CGQopjkjEdWtBKMF2DgBOtw+6RsZ++fw@mail.gmail.com>
 <CAHk-=wgf+kHeSZbpkZumWcTXUD7ordqTMvPRNL6aQVG1DSBDnQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgf+kHeSZbpkZumWcTXUD7ordqTMvPRNL6aQVG1DSBDnQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 10 May 2021 09:28:08 +1000
Message-ID: <CAPM=9tyji5UqZu4hV3gGNKpm5aTgau7oED9wMWqK8bjVvon_NQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes round two for 5.13-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 at 07:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, May 9, 2021 at 11:16 AM Dave Airlie <airlied@gmail.com> wrote:
> >
> > Bit later than usual, I queued them all up on Friday then promptly
> > forgot to write the pull request email. This is mainly amdgpu fixes,
> > with some radeon/msm/fbdev and one i915 gvt fix thrown in.
>
> Hmm. Gcc seems ok with this, but clang complains:
>
>    drivers/video/fbdev/core/fbmem.c:736:21: warning: attribute
> declaration must precede definition [-Wignored-attributes]
>    static const struct __maybe_unused seq_operations proc_fb_seq_ops = {
>                        ^
>
> but I noticed it only after I had already pushed out the pull.
>
> I'm actually surprised that gcc accepted that horrid mess: putting
> "__maybe_unused" between the "struct" and the struct name is very very
> wrong.
>
> I fixed it up after the merge due to not noticing earlier..
>
> Maybe the drm test robots should start testing with clang too?

My current build, test + sign machine " 09:23:22 up 419 days", running
fc29, has clang 7 which is my current blocker on implementing a clang
bit in my build cycles.

The machine is in an office, that due to RH not being able to fathom a
country where COVID isn't rampant, I have to fill insane amounts of
paperwork and high management intervention to visit, I'm afraid to
remote upgrade or reboot it unless I really have to.

I've some rough ideas to update it to f33/34 which would give me a
good enough clang, I suppose I could just build my own llvm/clang I've
done so for years for other reasons, if I can't come up with an update
plan soon I might consider it.

Dave.
