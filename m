Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCF3242C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhBXQ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbhBXQ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:57:54 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2820C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:57:12 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u4so3221115lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2k1Z1KHQhPS6WoJe+BX8BiMyyV7TbQcuJMW9050RZ30=;
        b=G9s9WrPn/BYyD4pXO7/Y+y4SLJcCR4rGbkgcgBOqjlOFQzgO+NyMH//tmBIp0zW2fi
         OwjK6AJcwq/+rILICYlIaurQtM2BNfYKB9JHmC47fKlPSy+yx2xcmquobOLdm3w1OG3L
         EKS4xsFEh52ECiY39axCOMU6gZoWSjCGGK/cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2k1Z1KHQhPS6WoJe+BX8BiMyyV7TbQcuJMW9050RZ30=;
        b=NpZZbkFvrhcTVjiIU7MeBCjKtQDfdeSVm1SiJZtVTTZb2wSWw1E4aeNwGq7wxiL083
         h/V+/he+aGrP0CMdb5qhGBFVq3OXX0DfMe+uYjyfK7lH38nWqHUoazzLcylMaq8VpzrA
         JVzlww/MYsGYrWvr//XxaxFXldu43Ubi7bFJNklNoVIhH2mwxLgmyUSe0P7drMoe9j7U
         7XX8ajePu44uyAMG9ONK41uAeage325nwg0YpMnbs9azb8V/Xe5Htmeg4Y/xO1tF6MuH
         DEac0mnfYItvPLXmtgKPWebhO6XPi1Yn38J2ExARFlMojhd4CykgFwXZmzsw+7Nd15rC
         S0cw==
X-Gm-Message-State: AOAM532gz/VxKs5VJMhivdr8eHBvAs9n0njkA01DBp2IcnoGe6G/LG0y
        dVfJV2rl2HFAApJeP1fhk6vyR1JQv6HBDw==
X-Google-Smtp-Source: ABdhPJxjeaD1gS+21hREnj1cCTvjxMukZTaMv7NjRF5ulqcAJJfWshPasuxmOg3J1/lfwemk6QGXcA==
X-Received: by 2002:a2e:b8c9:: with SMTP id s9mr4340032ljp.187.1614185831171;
        Wed, 24 Feb 2021 08:57:11 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x14sm589534lfg.165.2021.02.24.08.57.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 08:57:09 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id j19so4022870lfr.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:57:09 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr19088032lfu.40.1614185828813;
 Wed, 24 Feb 2021 08:57:08 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de> <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
 <CAHk-=whudLzx0zmn+xLDmC1su6DF4oMQT6uEgjDEq0RsHRsDwA@mail.gmail.com>
 <20210224075220.GA546@lst.de> <YDZfGFhgZl0xBlZl@gunter> <CAK7LNASjyTjqoJG=EtPFTUzYv2v96qYBaaymSirS2HLGoRLpGA@mail.gmail.com>
In-Reply-To: <CAK7LNASjyTjqoJG=EtPFTUzYv2v96qYBaaymSirS2HLGoRLpGA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Feb 2021 08:56:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggYtFhyqE02vfJ=fFB_Mku8=g1+k5XfdMh51CgZN_t_w@mail.gmail.com>
Message-ID: <CAHk-=wggYtFhyqE02vfJ=fFB_Mku8=g1+k5XfdMh51CgZN_t_w@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=EF=BF=BCMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 6:47 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I prefer a one-liner, 'depends on !COMPILE_TEST'.
> !COMPILE_TEST is not super elegant, but
> it is used in several spaces.

Yeah, I'll do that.

I'll also make it an EXPERT-only question, which is what we tend to do
for a lot of special "only for people who really know what they are
doing" things.

            Linus
