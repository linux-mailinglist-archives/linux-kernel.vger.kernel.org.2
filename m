Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D23370A4F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 07:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhEBFUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 01:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBFUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 01:20:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAA2C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 22:19:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x7so2131216wrw.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 22:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DLerzsoRF0eZbDDedtGe3u3kq/8q/AVf//j55Wc9560=;
        b=lo4NHWNGd16tL6yNlxynWoC7Nk0W6HYnID2ekCrHJhaXQdUQDCOCIkk68FSrsvbADi
         /LxFFp9DRmq4n1dOKmuFFFt/EotfxbQkxf5yQUYJxUkWksDR0iMlj6CzKBrKT2G4Dfvb
         X9nTmx/I/j374d8001bWv6W6cLja9oGOxP35n8NI+CsXRA7dtgHhLGbIKxrOOqjhL9Bh
         Mzpyiu3rRI1UqToes4U7pyUse44WEEgg1VsgYpksS7aDdwS2KNNVrQRcsg9Te7BgEohT
         VDFdMH5/maNPL2JaUvHGTjksMdA5kQIhu0vuxYDo06848zIOGNlGdr7ysRtWYLPL9mcQ
         Yomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLerzsoRF0eZbDDedtGe3u3kq/8q/AVf//j55Wc9560=;
        b=uAVFM3d7IA2m6Ou8GAWZx2kk3cpfb+BOuRnG3AncLJUGTOQxWt8FCymkd3TJN0Bdsx
         OFRygM0nOWPnyhb3HdXkR3QJAwE8HV1kF+2KKypXNt07BUdsRWFQaKSR4G8x+LsXNvKL
         HYmYe/Yu8Sn5jbyywLvLSiOJM1g6OIg4dMKBk9Zzc068PkLEmMVViI6HI7jJKzEYQRPY
         L8aybTwVMocopluL4aFVD/sPS4Czcc+SdvV+WW4EJZ0UKyVgWWD2p5XSkcM509ZlVZpc
         nyJbTzS4MVwecy14mCnxGOnf+N4TnJTqqZcBHQSofC/U+C+NzDxiCmuANlJ3mB769fNQ
         nC0A==
X-Gm-Message-State: AOAM530J9zhxrHaWuu4sry5DeeEhYcyVUTt1paWaCMXOJrGBew9U/zfe
        sXrADEy703Ndi/tITZTnCKCYQw==
X-Google-Smtp-Source: ABdhPJzOGUfDwp/0tTxSQMlHrq/rsmtGRg8rqELaX8OOekY8A4O3m7rXyrb2UPDgC972LyZUysvejw==
X-Received: by 2002:a05:6000:2ae:: with SMTP id l14mr16225032wry.155.1619932755439;
        Sat, 01 May 2021 22:19:15 -0700 (PDT)
Received: from gmail.com ([77.124.118.36])
        by smtp.gmail.com with ESMTPSA id u17sm17039897wmq.30.2021.05.01.22.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 22:19:14 -0700 (PDT)
Date:   Sun, 2 May 2021 08:19:09 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: Very slow clang kernel config ..
Message-ID: <20210502051909.pac2pycninc7fl53@gmail.com>
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 06:48:11PM -0700, Nick Desaulniers wrote:
> On Fri, Apr 30, 2021 at 6:22 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >    0.92%  libLLVM-12.so       llvm::StringMapImpl::LookupBucketFor
> 
> ^ wait a minute; notice how in your profile the `Shared Object` is
> attributed to `libLLVM-12.so` while mine is `clang-13`?  Clang can be
> built as either having libllvm statically linked or dynamically; see
> the cmake variables
> LLVM_BUILD_LLVM_DYLIB:BOOL
> LLVM_LINK_LLVM_DYLIB:BOOL
> BUILD_SHARED_LIBS:BOOL
> https://llvm.org/docs/CMake.html
> 
> I think those are frowned upon; useful for cutting down on developers
> iteration speed due to not having to relink llvm when developing
> clang. But shipping that in production? I just checked and it doesn't
> look like we do that for AOSP's build of LLVM.

There's also `-DLLVM_ENABLE_LTO=Thin` that enables LTO for building LLVM
and Clang themselves, considered they can be bootstrapped like this
using a previous version of Clang. Combining that with a non-shared
library build mode for both Clang and LLVM, the result is possibly the
fastest and most optimized build that is achievable.  Unfortunately I
see distributions neglecting to enable this in packaging this as well.

On a side note, I'm also a Fedora user and agree with Linus about this.
I'd like to see an opt-in bypass of the shared library policy via
something like `dnf install clang-optimized` that would install the
fastest and most optimized Clang build regardless of RPM install size.

-- 
Dan Aloni
