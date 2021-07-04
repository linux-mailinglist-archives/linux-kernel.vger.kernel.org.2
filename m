Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3D73BAEA0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 21:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhGDTeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 15:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhGDTeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 15:34:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234C1C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 12:31:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v14so2893611lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67ZRK+iff2RKAllKt0E/4Jm8+26+NCtg681EtA5JJgQ=;
        b=doIHttyETiJif5MatFuoum9vTyW6qwXlA3VdVHRuVDftO7xNUzLCloaVsyerEYQRcL
         VmwNSzja3qdTDHZCx7XD03rnTkt/ExU/f4LRY90bCCe/cWFriPQ0u1VNwqQxRsM7zHUA
         vPxRTYVZwJB2Q6akMTldi2Qya/QFaD7C/db90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67ZRK+iff2RKAllKt0E/4Jm8+26+NCtg681EtA5JJgQ=;
        b=K0hgDnsj7JtJ8cWAfe4pD1gpNm4vSRYCOSEgkQxcGcGxzzx9kcMpE2aOBz5SNRAJAf
         M6W4yFEm/GV2lB1fOzacwDy0VGtHY1OeqibaCGMsCal1F252cicX7FtmP50bhEXfwFoy
         USNwLNLxD4A/guPrAkwkej+s1FRMw5fUWMWtkiPW5zxWrwrZvRXu7mzqwbyrrew/Afxn
         Di01zhFNeNq9YbN/I62nV0h6SUe6uFXxJ1uUWo1SDmdUGw/Z20drV6/9EKSWH+M5K1Pt
         xb4Fk408gNBl8JDIhD5KlmhPVmXuD5P4kle/kdbPJbfKpQ9fNg96xN9dKsbObT/1Xesl
         KG9Q==
X-Gm-Message-State: AOAM530sYrwKmwfrtDrKLreaN+hkI6ttTgwjXux0mOhyWx3tNenesw1c
        JsrV0gJtBYv9TA2oJUGvduD5VT6Luv99i3sH6UA=
X-Google-Smtp-Source: ABdhPJyDjJWmeKsMf836p6x8MuQpTQ3bjN0cnH+F+lQHkEoonsYwkN2RZtQpKuO11Ahg/E/8tMwwdw==
X-Received: by 2002:ac2:5c43:: with SMTP id s3mr7653689lfp.448.1625427087140;
        Sun, 04 Jul 2021 12:31:27 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r20sm1141668ljk.10.2021.07.04.12.31.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 12:31:26 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id d25so21553798lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 12:31:26 -0700 (PDT)
X-Received: by 2002:a2e:b553:: with SMTP id a19mr8179890ljn.507.1625427086306;
 Sun, 04 Jul 2021 12:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172912.GA2969733@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210704172912.GA2969733@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 12:31:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip1WgNAi-MfVUj0R+-BGch62dmJKdyWENpYw_xEq8GNg@mail.gmail.com>
Message-ID: <CAHk-=wip1WgNAi-MfVUj0R+-BGch62dmJKdyWENpYw_xEq8GNg@mail.gmail.com>
Subject: Re: [GIT PULL] KCSAN changes for v5.14
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 4, 2021 at 10:29 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Please pull the latest KCSAN tree from:

I've pulled this, but I'd _really_ like an overview of the changes for
the merge log and my own perusal.

Even if it's just something "Minor bug fixes and cleanups" because
there's nothing in particular that stands out, that's the kind of
thing I want to be able to then document for the merge.

             Linus
