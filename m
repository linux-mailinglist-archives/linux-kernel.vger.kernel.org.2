Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBC0432867
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhJRU0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:26:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC1FC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:23:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so2356714lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hShfojEUzBmMpgkHo84N+Rx+m8nkMxhA7mhDB+mvFaE=;
        b=PbSI7ZoxcTaW+kuQhPAk08kUDA6N4JkNzx4JdtEeIvmRiHWaCGCWKDwS6p4LCIWlXV
         mvD7jM3y71g8Pb8XfdxTsh+BKwVysAHHeT207AAb+9UJuUFmHz03UBHo4F3/Y6MRBOqP
         JyKGcbWzISB31bAwOjKCH781k5O7U0waP5sUjdWWgPH1t+CVYLVLvffMdChMKQuSNrmM
         9slw4pVuAkNtXHI+PLvWKlNLboIYurC6OSS56c0Aa4egniPotDX5SSKnfWaitw6TyGcy
         O28Td5+5q41UXITz1jHSf9JIC3gfhf0JP2FNj4fPTjxvUIMm8FmqoTzFF+pCMfOfu/e2
         lp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hShfojEUzBmMpgkHo84N+Rx+m8nkMxhA7mhDB+mvFaE=;
        b=dWfXmLZOLjKja3ROfD0WuStPTw9jgcbJZm6hU5UgeOVJjGNT3rKYPgIXmdnrgaaBje
         Lx74Ip5d9/jXZ0ve4IFGJp/UcTZGUy/hLiyW/GgnT1lSamQ4KXmsNBz2HhApBqRXcux/
         rMY+dkp8M35k7Xdp1rPyzRtFHabi7RBSoKSzEJ4QfdPHbhuXblL1vFDIWMtNZMHZeZgT
         omdAqEgN7ESL/f0qAucYDiZwYGs7dPvutrTOJM4LzCRN7sQrDHrJ8EDQ01bq/Sd3lJu7
         wlBwv959IFTEH7a8vgH/cFgnfgteae6MRB8pnMe7mqrAhXfdcURLqjVp/kbsu5R1hpFm
         9yUA==
X-Gm-Message-State: AOAM530m5O6ZVQC/J9qpos1Q/QV7Moh1woLtyjqhX2IhRIWlNzauxbVV
        CWPegC87UFbOqM+coYBgWDdBDegHK/EMVPNrUlm3Qg==
X-Google-Smtp-Source: ABdhPJwjKPLIPfugo5bCl1yL9FaR5TR9KfXNjC/xdkmmFJeIpEjJBmqvBNClLTAWZwu4fkrYtjC39/7x016c69XVKyU=
X-Received: by 2002:a05:6512:2284:: with SMTP id f4mr1819811lfu.489.1634588637140;
 Mon, 18 Oct 2021 13:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211014215703.3705371-1-nathan@kernel.org> <20211015094344.GQ8429@kadam>
In-Reply-To: <20211015094344.GQ8429@kadam>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Oct 2021 13:23:45 -0700
Message-ID: <CAKwvOd=eEyjLMSEiBd25-Jkvm0DTFtvcB_EmuRVwqWYjQEvD5w@mail.gmail.com>
Subject: Re: [PATCH] staging: wlan-ng: Avoid bitwise vs logical OR warning in hfa384x_usb_throttlefn()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 2:44 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Oct 14, 2021 at 02:57:03PM -0700, Nathan Chancellor wrote:
> > A new warning in clang points out a place in this file where a bitwise
> > OR is being used with boolean expressions:
> >
> > In file included from drivers/staging/wlan-ng/prism2usb.c:2:
> > drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
> >             ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
> >             ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: note: cast one or both operands to int to silence this warning
> > 1 warning generated.
>
> Both sides of this bitwise OR are bool, so | and || are equivalent
> logically.  Clang should not warn about it.

Not when the LHS AND RHS of the the binary operator have side effects,
which is the only condition under which this warning is emitted.  RHS
potentially sets a bit, and potentially would not be executed if `|`
was replaced with `||`.
-- 
Thanks,
~Nick Desaulniers
