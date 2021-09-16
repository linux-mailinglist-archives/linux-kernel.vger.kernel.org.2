Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D6D40EBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbhIPUqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbhIPUqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:46:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F175C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:45:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y28so23580417lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qwzy+297MpTw6J10aqvJFNeCoPb2Hsq/HoDCJ04Iyi0=;
        b=UQT4LUXanXzIv6i76WjnZoGUBx77DR1gj/NDE/AAvbmvqhMaRD4BR84cblIoFUukSX
         xcXi25EeZSsuXV/SbO80dPtAhEGi48DIkV9B+0vpGefzrOvHHVM6BM1uBAdRvQsJ7cSh
         CswpHvePGUE9HD4vzmg0wVOCCib6FmDi5MVGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qwzy+297MpTw6J10aqvJFNeCoPb2Hsq/HoDCJ04Iyi0=;
        b=tKXqCKGGJCTC92M6XmAqphQ69djDlT5jBaiScTCoQtvW+l+i4Wy21WVwnosDbQiKYt
         eS5j4qMhClmT//am3amraS1Wq60QNXwaRwRogPlJv1C4/c803kBv6PLigiNURnDQKoWT
         sHy2T9ZwfHsN6Y0DKdGh9C+Nrh9i9OoAK/QeWQZYhsQs2nFd2lcT9oheE6yECIc++xoT
         YruNdFEGyYkO4KZhxnFDTtIbiZvhJW0CT93hEJB8ViOksSta2ssMCfp8nK4hE7oUkFZ9
         OVlG5k36i+yQn8pGGOYaliH0rcpzKrYGvS7cG0ttm997rM2EH2jVcLZZmva1DKmK/U9i
         YrwA==
X-Gm-Message-State: AOAM533lz/3hTqlAm8Pla9p74lFB4qYvy/uIbW1b6WLkZcvW9GQUSagM
        /TeF2EAAimyL+KgtjyzLkdfs6fVIWYo5IpwcA4M=
X-Google-Smtp-Source: ABdhPJwro5mtSS+GJW4bHRxnJxFDqiwi74PgkGrKGvqQ19myTzTBIu2AsUwDuMJnq7tCxDjUFH8Vdg==
X-Received: by 2002:a05:651c:154b:: with SMTP id y11mr6571854ljp.205.1631825101332;
        Thu, 16 Sep 2021 13:45:01 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id s30sm381091lfb.90.2021.09.16.13.45.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 13:45:00 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id i25so23865037lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:45:00 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr5405742lft.173.1631825100363;
 Thu, 16 Sep 2021 13:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiFC8Az2wD5_DCeysw+DV4srAj3sCbVP4asPPEJbOpqQ@mail.gmail.com>
 <64b88941-9ec0-8552-d05d-6503497f6f9d@MichaelLarabel.com>
In-Reply-To: <64b88941-9ec0-8552-d05d-6503497f6f9d@MichaelLarabel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Sep 2021 13:44:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcPrGW1=A9XetuUZv_QHf1p7znUUGbm7UCcawbboxRCQ@mail.gmail.com>
Message-ID: <CAHk-=wgcPrGW1=A9XetuUZv_QHf1p7znUUGbm7UCcawbboxRCQ@mail.gmail.com>
Subject: Re: memcg: infrastructure to flush memcg stats
To:     Shakeel Butt <shakeelb@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>,
        Michael Larabel <Michael@michaellarabel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the kernel test robot complained about this commit back when it was
in the -mm tree:

  https://lore.kernel.org/all/20210726022421.GB21872@xsang-OptiPlex-9020/

but I never really saw anything else about it, and left it alone.

However, now Michael Larabel (of phoronix) points to this commit too,
and says it regresses several of his benchmarks too.

Shakeel, are you looking at this? Based on previous experience,
Michael is great at running benchmarks on patches that you come up
with.

           Linus

On Thu, Sep 16, 2021 at 2:55 AM Michael Larabel
<Michael@michaellarabel.com> wrote:
>
> Are you still looking at aa48e47e3906 around performance regressions[1]?
>
> With 5.15-rc1 on multiple systems I am seeing timed software compilation
> tests regressing compared to 5.14. A variety of different software
> builds are all slowing down by several percent when running on a 5.15
> kernel. The bisect led back to aa48e47e3906 as the first bad commit. I
> can't seem to find any discussions around that patch in more recent days
> so figured I'd ping you in case something was missed.
>
> Thanks,
>
> Michael
>
> [1]
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org/message/MS2J5FCYQD62W4E5LHHPWC7YH7TWKUSV/
>
