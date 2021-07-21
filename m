Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E0D3D1822
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhGUTrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhGUTrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:47:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102DEC061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:28:16 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y7so4639850ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Wfplf+fD3sAhG/xYw9pABvgaxNvCuT0joqilD8I+WIY=;
        b=Cy+092dUMFCuH1x/9wzZLNPpohYwL5mLJ+XoNI+Yu8Va3rjvRxkCDSxK4HdOBvSFlS
         0734f+bWrs/te02P8ApPWN8u9tATzWG8YVMRzmGI/BbmcsJ1RHcmjpVboynFKJRBL4z9
         CEy0kwsNhs6vH5oTOf6B4dDodN/vfPbEOpwUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Wfplf+fD3sAhG/xYw9pABvgaxNvCuT0joqilD8I+WIY=;
        b=UviO/yxM2QgQy/w/a0QA0RzmUpMMshDEkfks3W/j6Ra7bXafZ5CyLcSEWyKPdG2A7/
         Moa+QeuD+iy12XGLSYlGNY7UZaTyaUIT6l7iXAlPC3ywBIXaVN4EZlJQdkF/UHfcZQmE
         Z4nEo6mno7TDfMD0hXT5x4S+q7qbFSYFB4FNGz2GCW9YCcg3heFed3kOiY0MZDYpkXRU
         lYgPpEetFs5YyU33QyFfOL3rdKL8dB0NUMP4t2SApORpmbJ7KB6SGDpJSC9fVwetFq6E
         0sshJwZZCabl8sIi9Q0Crecf5TUiHuwgseB0Nmjdan+sWKamYun2Zd/Vh6sJTfOqf2WL
         lXaw==
X-Gm-Message-State: AOAM533LV74kk+fM6SGGTc29WmUgeolT4aEJlb0fdF+VSSNO1uW/T5TU
        1kxWGmpLGUD1I1pEnIC4OwU57xKOv1Zx+5Dp
X-Google-Smtp-Source: ABdhPJxYfZdaYbtzUM5HCA1EvHKZfyTopnzIjYPfeVoeCJ0hy7FpykwY1iajW71M0GalMBsvaj1eQg==
X-Received: by 2002:a2e:b0f6:: with SMTP id h22mr33709453ljl.274.1626899293909;
        Wed, 21 Jul 2021 13:28:13 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u17sm1820221lfg.306.2021.07.21.13.28.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 13:28:13 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id e14so4598448ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:28:13 -0700 (PDT)
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr32086757ljg.251.1626899292773;
 Wed, 21 Jul 2021 13:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210721135926.602840-1-nborisov@suse.com> <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <20210721201029.GQ19710@twin.jikos.cz>
In-Reply-To: <20210721201029.GQ19710@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 13:27:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCygw44p30Pmf+Bt8=LVtmij3_XOxweEA3OQNruhMg+A@mail.gmail.com>
Message-ID: <CAHk-=whCygw44p30Pmf+Bt8=LVtmij3_XOxweEA3OQNruhMg+A@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     David Sterba <dsterba@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 1:13 PM David Sterba <dsterba@suse.cz> wrote:
>
> adding a memcmp_large that compares by native words or u64 could be
> the best option.

Yeah, we could just special-case that one place.

But see the patches I sent out - I think we can get the best of both worlds.

A small and simple memcmp() that is good enough and not the
_completely_ stupid thing we have now.

The second patch I sent out even gets the mutually aligned case right.

Of course, the glibc code also ended up unrolling things a bit, but
honestly, the way it did it was too disgusting for words.

And if it really turns out that the unrolling makes a big difference -
although I doubt it's meaningful with any modern core - I can add a
couple of lines to that simple patch I sent out to do that too.
Without getting the monster that is that glibc code.

Of course, my patch depends on the fact that "get_unaligned()" is
cheap on all CPU's that really matter, and that caches aren't
direct-mapped any more. The glibc code seems to be written for a world
where registers are cheap, unaligned accesses are prohibitively
expensive, and unrolling helps because L1 caches are direct-mapped and
you really want to do chunking to not get silly way conflicts.

If old-style Sparc or MIPS was our primary target, that would be one
thing. But it really isn't.

              Linus
