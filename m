Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2953E409DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242793AbhIMUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbhIMUL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:11:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE512C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:10:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id l11so23616464lfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=146IDoLHsnlYB84TPDL7kqzW39fi+lkR3958WvJksNU=;
        b=gyRS8gjhHVDEJW3sWIFVBpPRc2KEVEPHvvR30CLnqsK+D0Cdnc2iMmALs9/mMesYTx
         DWIkQLMkgDI0IL1b4WvgD65bkxCoJcXYobVOE4MVrZsCt0d4JU3u0ngT8fARn6axUyBf
         W1N+PxcICKOZsZfThMM7E97Qm8F9LSOpst2ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=146IDoLHsnlYB84TPDL7kqzW39fi+lkR3958WvJksNU=;
        b=2DWZbYuyuCVSc4eLzARXHor+B93wKBSF/0ySh21OFPijcBcITuGRofEfFB1VPycQtg
         LUe7KpGHS/8u02TNtc+mChmueBUg+0OVnMWqhBBR1rO1se2dzK7m4pefbgDNBh3eNtnY
         hBfN2ZIJ2Y0qUcfvD94iMq1flFPGVMigEorgFqOJfNRTAprxCk5kwz54rc7rsoPurv6B
         cM2uuzwFpnYKcGt1WLDqgyMAfc5FNQL4R8lrFEkkz1Vs7bmU3O3N1pvG9ismYxqdQm3K
         h3NkLN42rdVozPXgFfKjg8qBC1DegPzL6dBqDyoICE+sDYap2oGnu2YhfhbkCG8gQd7A
         H4yA==
X-Gm-Message-State: AOAM531HzzaDbGENvmngmD3ed0AdbuLN14YbMYX8wqVZdtki4uUf19m6
        Q99FWXEFZBHlOTc94mHgGmc1xJJvb42oqmq6rS0=
X-Google-Smtp-Source: ABdhPJwSD8TNabFV0c9HoIUGBYhm/o8ebkQOrWC1BT2Z2yYAHrwfxYyRSW8rkNhgvmRINg7Q+OtUYw==
X-Received: by 2002:a05:6512:3b94:: with SMTP id g20mr10439356lfv.409.1631563840524;
        Mon, 13 Sep 2021 13:10:40 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id p5sm918272lft.302.2021.09.13.13.10.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:10:39 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id s3so19414833ljp.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:10:38 -0700 (PDT)
X-Received: by 2002:a2e:1542:: with SMTP id 2mr12239121ljv.249.1631563837811;
 Mon, 13 Sep 2021 13:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210913131113.390368911@linuxfoundation.org> <20210913131114.028340332@linuxfoundation.org>
 <CA+G9fYtdPnwf+fi4Oyxng65pWjW9ujZ7dd2Z-EEEHyJimNHN6g@mail.gmail.com>
 <YT+RKemKfg6GFq0S@kroah.com> <CAKwvOdmOAKTkgFK4Oke1SFGR_NxNqXe-buj1uyDgwZ4JdnP2Vg@mail.gmail.com>
 <CAKwvOdmCS5Q7AzUL5nziYVU7RrtRjoE9JjOXfVBWagO1Bzbsew@mail.gmail.com>
 <CA+icZUVuRaMs=bx775gDF88_xzy8LFkBA5xaK21hFDeYvgo12A@mail.gmail.com> <CAKwvOdmN3nQe8aL=jUwi0nGXzYQGic=NA2o40Q=yeHeafSsS3g@mail.gmail.com>
In-Reply-To: <CAKwvOdmN3nQe8aL=jUwi0nGXzYQGic=NA2o40Q=yeHeafSsS3g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 13:10:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwREzjT7=OSi5=qqOkQsvMkCOYVhyKQ5t8Rdq4bBEzuw@mail.gmail.com>
Message-ID: <CAHk-=whwREzjT7=OSi5=qqOkQsvMkCOYVhyKQ5t8Rdq4bBEzuw@mail.gmail.com>
Subject: Re: [PATCH 5.14 018/334] nbd: add the check to prevent overflow in __nbd_ioctl()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Baokun Li <libaokun1@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 1:02 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Ha! I pulled+rebased and this code disappeared...I thought I had
> rebased on the wrong branch or committed work to master accidentally.
> Patch to stable-only inbound.

Side note: for stable, can you look into using _Generic() instead of
__builtin_choose_expression() with typeof, or some
__builtin_types_compatible_p() magic?

Yes, yes, we use __builtin_choose_expression() elsewhere, but we've
started using _Generic(), and it's really the more natural model - in
addition to being the standard C one.

Of course, there may be some reason why _Generic() doesn't work, but
it _is_ the natural fit for any "for type X, do Y" kind of thing.

No?

          Linus
