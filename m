Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2345C3F9E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 20:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhH0SF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 14:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhH0SF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:05:56 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3645CC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:05:07 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id a21so4156202vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88JiBN68KFkPvgUKvvgM6auDxOEjKddEpXMvH74tSU0=;
        b=OlwWwQfPg4x+JJlvPNh300Bq1LWQakwQ25UjGQSFu+e/ONGVka7NnKHJa+lgNw1pXV
         O/VaBhbQV0p5s2/S3HszX9pzR0SadV3bqBaL/0a48gJ9IGvbaB4+SIEcxTiCHR7KQJ8B
         J1a5QBQJPr4qWh90Oj3DuALxdosTczcnDdni2cSNTkI8cSuqR8wklMDBXc8ldGdEK46o
         0zcdpFqpN0s/xEFW3FLjXWWA1ZwBWL+8GLjzKkkgYnRZh7SCSIlTLkDqH2XmtErs4aPk
         1rqZ/YjPwLsXASog5KOY4AHNWfaWbxESg1O/qpwsb3e0lfivzJjauzD88S0GagWg5pQz
         pVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88JiBN68KFkPvgUKvvgM6auDxOEjKddEpXMvH74tSU0=;
        b=PnbqugcrP2GXRSOPHQtmsAvan2Cm46KKJQGWzQsp84uNpQSx1Axjqc4S0MmVzmfgjx
         97S5MJpMVBrpi+vZn++ZRMt74aWkeU8ArY3TdogBHE14TCFocLEPOR7+uS4tVMLjlukO
         KtK57NNHQVqQahjXkMygfHvs19jtjvnDmwYYdTjsWCAEnlWsR/llEcNwfhVnekey89fO
         gJU0NJYg/cD2wMW3feCjz7mJLGQHZWVNEHWEr70zDGxSugTe1b640Mbbuk7/aLpHv/bW
         Ioq2us42cY1KFJxq+Nb2Yncsgz3ntgbVvvNHiQYR4FNCF/98m94XNjsJwomXOLQvUHj+
         xS7g==
X-Gm-Message-State: AOAM533wsFggNKYmqrsII9+DbyBA7Gewni9DJSTHgYLN+Lptx4bLoccs
        BFs/TrZyrQ6nC0AE4CQpWdK/BXh4Rr5lbJhm5ZM=
X-Google-Smtp-Source: ABdhPJzGaciYM1/s8m8/B975vUfIbvCRz+B6Bp+lNCm9eTPHyZtDPjmUuOFML4/BZkts2fosFQFBO2nGMugI2IF9+i8=
X-Received: by 2002:a67:c789:: with SMTP id t9mr8673774vsk.60.1630087505693;
 Fri, 27 Aug 2021 11:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210822222009.2035788-1-jim.cromie@gmail.com>
 <20210822222009.2035788-2-jim.cromie@gmail.com> <c83b0814-b8e1-91f5-ba28-f9db3f363ce1@akamai.com>
In-Reply-To: <c83b0814-b8e1-91f5-ba28-f9db3f363ce1@akamai.com>
From:   jim.cromie@gmail.com
Date:   Fri, 27 Aug 2021 12:04:39 -0600
Message-ID: <CAJfuBxz83LUFqPmApV22d0R1pHxFH4ZhObi7PgQeQ75w4zvb7A@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] moduleparam: add data member to struct kernel_param
To:     Jason Baron <jbaron@akamai.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jessica Yu <jeyu@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 11:13 AM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 8/22/21 6:19 PM, Jim Cromie wrote:
> > Add a const void* data member to the struct, to allow attaching
> > private data that will be used soon by a setter method (via kp->data)
> > to perform more elaborate actions.
> >
> > To attach the data at compile time, add new macros:
> >

>
> I wonder if kp->arg can just be used for all this and avoid this patch entirely?
>
> define something like:
>
> struct dd_bitmap_param {
>         int bitmap;
>         struct dyndbg_bitdesc *bitmap_arr;
> };
>
> and then just pass a pointer to it as 'arg' for module_param_cb? And then in
> the get/set callbacks you can use kp->bitmap and kp->bitmap_arr.
>

yes, thanks, this is working out nicely.
I think I was thrown off by the arg name,
if it had been called data, it would have slapped me

> Thanks,
>
> -Jason
>
