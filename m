Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D436F256
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhD2VyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhD2VyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:54:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF8C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:53:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 12so106790478lfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Zbt5Vlv/Alx31b/vvnYikUY4tIX1dxiM5eoc7l+5rps=;
        b=W+ycA9wZCo5gKoUz/8ORyQ0pQlfDQ+B/jeB2IVZa3Mkjsnqci1OSTopvwUO7KOfZpC
         eD9dHANwdb7U1qc55ucBV9mPg3mg95YWANYRnTWqKipG7me92aVnlS6w2M2Qzwuae7fD
         ktxpC/lk7YlHVrL2n8cPDyIg1aJAjyB2noi/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Zbt5Vlv/Alx31b/vvnYikUY4tIX1dxiM5eoc7l+5rps=;
        b=U2J64dT5VmTBJbesI5EQWUzi6fV2RzEeUNRsu8lKUeYzKfL6A85gjb7CvI/70OI6UT
         9YxiRIas3ysVogPsNmVtXPiCSOZMHSgcSQM4k8GV8SxOzHPyNiJk9oe7K0G0p7UyBj0v
         NcSdhXznBD40rVHbyp1vWzGkZ1g4HrWYVmAQAVRPVvf2SIReypNFL9IL/31GJbJ9echg
         3lhdwbxD/IUpIAc+fHAjWdX+CJlniMrUqkxZTp5tYXlC3lpG0/6EmbD+kvLJZ7qXnGQx
         XKiem4dmOt1kjVf5Mu+vxOwQRFUSByjl3IMXa31PR0nU840feHYqFAgemorsV592bsgx
         52Sw==
X-Gm-Message-State: AOAM531tLO6kmuhD1pGhvxi8231v3f+hOV+CTDX4Njj5BMLl0g+pKuaO
        cRtwCRnNaMHp8eChgWJla0Iq2ppoeQCin7w7
X-Google-Smtp-Source: ABdhPJywzQKJ2yHjsHsCcYEf3STmnDm5zLkBYBu/UxoTYzVK+ZhlHv3T06pQufWBFtsBkdtjFp5/2A==
X-Received: by 2002:ac2:5fcb:: with SMTP id q11mr1128569lfg.248.1619733205872;
        Thu, 29 Apr 2021 14:53:25 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id p18sm97510lfu.52.2021.04.29.14.53.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 14:53:25 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id x20so76828435lfu.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:53:24 -0700 (PDT)
X-Received: by 2002:ac2:5f97:: with SMTP id r23mr1053760lfe.377.1619733204581;
 Thu, 29 Apr 2021 14:53:24 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Apr 2021 14:53:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
Message-ID: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
Subject: Very slow clang kernel config ..
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't looked into why this is so slow with clang, but it really is
painfully slow:

   time make CC=clang allmodconfig
   real 0m2.667s

vs the gcc case:

    time make CC=gcc allmodconfig
    real 0m0.903s

Yeah, yeah, three seconds may sound like "not a lot of time, but
considering that the subsequent full build (which for me is often
empty) doesn't take all that much longer, that config time clang waste
is actually quite noticeable.

I actually don't do allmodconfig builds with clang, but I do my
default kernel builds with it:

    time make oldconfig
    real 0m2.748s

    time sh -c "make -j128 > ../makes"
    real 0m3.546s

so that "make oldconfig" really is almost as slow as the whole
"confirm build is done" thing. Its' quite noticeable in my workflow.

The gcc config isn't super-fast either, but there's a big 3x
difference, so the clang case really is doing something extra wrong.

I've not actually looked into _why_. Except I do see that "clang" gets
invoked with small (empty?) test files several times, probably to
check for command line flags being valid.

Sending this to relevant parties in the hope that somebody goes "Yeah,
that's silly" and fixes it.

This is on my F34 machine:

     clang version 12.0.0 (Fedora 12.0.0-0.3.rc1.fc34)

in case it matters (but I don't see why it should).

Many many moons ago the promise for clang was faster build speeds.
That didn't turn out to be true, but can we please at least try to
make them not painfully much slower?

              Linus
