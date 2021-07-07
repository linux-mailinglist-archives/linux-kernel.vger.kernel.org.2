Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8AD3BEF99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhGGSos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhGGSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:44:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36989C05BD3A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 11:41:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id v14so6551189lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxAo9Z+NfK/0Q59CfSTtwoUE9/K2RLiu9K5W52RV+OM=;
        b=BpavuCZn/1s0z2kAplcxX42t0Vq1bQdliof7t1INnc/ZDRCn5OlJWVsQqF/6EoeEd3
         grLsqTuMlYXYS9f0+wZpPL1015scLpzRTUT6p/3aqaIdkUJ9/sXtF6vIT7zkrGFINN77
         eUA1xCvv2CA4aTrcYoFxhVj4uy+gchjzEj0Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxAo9Z+NfK/0Q59CfSTtwoUE9/K2RLiu9K5W52RV+OM=;
        b=TpcVHIbu2guHh+ofZwTabxUBBX9g7TO3O8MKjl9qXeANIaumTQ2ZUtCnU2CyyH9Xd6
         UxQ7uAxinX+ihvHODGHuhDW80CHgbqylhEOyriuCLC0GVZU/OmmOHpIskcbVSvYo7HlE
         qUw89kAupPcqT1+JAXX2HWabdkrbXQrJQYO3wNA7ExjSzTdc4RirxRpCgRh5lJz44Xje
         X5rID7nGNvHjI1WUM4h46c2Oz5wLGrrX57GiqZmz2VxSr5On4+sNlbph0LQ+HbP+Nz8a
         X9JnbItTnPcgaEaGNKgvCcW6vkMltYPZHxbUAm6Ph4SEVvSyj3/FtkQZ2fNmOImBLBwZ
         A2FQ==
X-Gm-Message-State: AOAM533IF2+pcckLtsqB0VTuODHTZALybHUh4TS1tv0LW6odU+7BVF4O
        T2EY2amSeoMk/xtV/TKx+Qy7vTVhzdcGHs1Yg04=
X-Google-Smtp-Source: ABdhPJykU3Z2CX6WoEAShvhLN57oFzm9ay0QQd4PmCn3DGsmWaALwL7UCCuHZVId4UHZomoLJciiXA==
X-Received: by 2002:a2e:9c14:: with SMTP id s20mr19619186lji.393.1625683262377;
        Wed, 07 Jul 2021 11:41:02 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id z21sm2113365ljm.52.2021.07.07.11.41.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 11:41:01 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u18so6512130lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:41:01 -0700 (PDT)
X-Received: by 2002:a2e:bb98:: with SMTP id y24mr7659535lje.507.1625683261571;
 Wed, 07 Jul 2021 11:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <YOWld9O5CZpzOUKA@google.com>
In-Reply-To: <YOWld9O5CZpzOUKA@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 11:40:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMnammhbrevngFKwP31k9fO2npok26XnVCR0B3HJOUqQ@mail.gmail.com>
Message-ID: <CAHk-=wgMnammhbrevngFKwP31k9fO2npok26XnVCR0B3HJOUqQ@mail.gmail.com>
Subject: Re: [GIT PULL] percpu fixes for v5.14-rc1
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 6:00 AM Dennis Zhou <dennis@kernel.org> wrote:
>
> This is just a single change to fix percpu depopulation. The code relied
> on depopulation code written specifically for the free path and relied
> on vmalloc to do the tlb flush lazily. As we're modifying the backing
> pages during the lifetime of a chunk, we need to also flush the tlb
> accordingly.

I pulled this, but I ended up unpulling after looking at the fix.

The fix may be perfectly correct, but I'm looking at that
pcpu_reclaim_populated() function, and I want somebody to explain to
me what it's ok to drop and re-take the 'pcpu_lock' and just continue.

Because whatever it was protecting is now not protected any more.

It *looks* like it's intended to protect the pcpu_chunk_lists[]
content, and some other functions that do this look ok. So for
example, pcpu_balance_free() at least removes the 'chunk' from the
pcpu_chunk_lists[] before it drops the lock and then works on the
chunk contents.

But pcpu_reclaim_populated() seems to *leave* chunk on the
pcpu_chunk_lists[], drop the lock, and then continue to use 'chunk'.

That odd "release lock and continue to use the data it's supposed to
protect" seems to be pre-existing, but

 (a) this is the code that caused problems to begin with

and

 (b) it seems to now happen even more.

So maybe this code is right. But it looks very odd to me, and I'd like
to get more explanations of _why_ it would be ok before I pull this
fix, since there seems to be a deeper underlying problem in the code
that this tries to fix.

                 Linus
