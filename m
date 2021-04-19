Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47807364487
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbhDSN2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbhDSNUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:20:34 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FC8C061342
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 06:19:19 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id e89-20020a9d01e20000b0290294134181aeso6725493ote.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 06:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jp9Pcez93qGZ5reNVbwtcmr+nLORdx/Yd3wWh5Qgx2o=;
        b=KQqOsS89wDFCfqapC4naTu7ASzy5k4mTZctFB53yx8RvGbtHOdKD68mC19SQfto1Je
         y9mrOg19/DUScsyHi8miYHiQNm0sBdCIJBPAoTA7v7pwslqkHDR2rPVt+mbyp7s+cDZN
         +PpHwM6jOJpxQ50Y+SvLl0M/gnP7HdO2axENOfnWmL9Ko3eB2ed50fkpFA0376M6BAdH
         U2Twzzo7ohriHFovrZTv2nPhZVpmtjsaHUMdiHbiPoOI6L4lhM99O3KrN3/GNUX07E6v
         442Stb25IrsVpnYiNFeI7FXXjHIujDbP7sr90tFAlvGUYQNEALXw6DSbAQo3L+EpdAT8
         jcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jp9Pcez93qGZ5reNVbwtcmr+nLORdx/Yd3wWh5Qgx2o=;
        b=OBlLT4TU29gqrdJ2zSnmU/7oPcBi3vmonCZtKs971X0dI6kuT5fM/9pEQjZYQvYAW+
         LII0CQQyV/KQYqBrCzfj9dhY+ZBpwQxSnZzUzUKbMgPIQ/EYr7cr0MZsmqdTWlaEH4PZ
         29Y+GtqciKf6ZxN69ox2p7pss5a80B2rg8+O+5QV/+/NuMqpzATwWy8Vya1izPsO95HG
         FHzah+hCcgJC+l2Hsu5SQus0iC3Vd+Vhg1bdVqNJwK/SLzujvRtDlSVy/JmVxXxdBFnw
         EFJHa2H8OlfLW+sjGwBvVWH5y8zVExrOwADMKEXXOzOsnRx72gZFlcV61ZlpDtU7wZ8s
         4ZSA==
X-Gm-Message-State: AOAM531OMJsT/3vjWT4mo9mwajipCJqF3cKd9d5Ob6Fhi3M1aEbxo9GJ
        /QBY/LQjsAmsg3BUwlXaQRkUqOlVdUqJ9ftbXDG7nw==
X-Google-Smtp-Source: ABdhPJyp694CeqoCgojaqO613gVaqhvuT70RappifCY5R6a7fYkKcs3+MjQOX26oJwTVtubqzoDlcS3k4Lb954RmHYE=
X-Received: by 2002:a9d:5f8c:: with SMTP id g12mr2327882oti.283.1618838359199;
 Mon, 19 Apr 2021 06:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210415145857.34183-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44FWJiL1yzHR0jwL2VJG_4t_O6An48v47gORitcaahwmYw@mail.gmail.com> <YH1xHDbFyJ1URYYV@smile.fi.intel.com>
In-Reply-To: <YH1xHDbFyJ1URYYV@smile.fi.intel.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 19 Apr 2021 15:19:08 +0200
Message-ID: <CAHUa44GqTNoLbwfqPrWFVLV3=M2d-2hE1uDY=CHpCcZgzMu5Og@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] tee: optee: Provide special parameter field for
 UUID values
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 2:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Apr 19, 2021 at 01:35:51PM +0200, Jens Wiklander wrote:
> > On Thu, Apr 15, 2021 at 4:58 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> Thanks for review, my answer below.
>
> > >                 struct optee_msg_param_tmem tmem;
> > >                 struct optee_msg_param_rmem rmem;
> > >                 struct optee_msg_param_value value;
> > > +               uuid_t uuid;
> >
> > It's nice to get rid of the cast above, but I'm not that keen on the
> > change in this struct. This file defines the ABI towards Secure world
> > and adding dependencies on external complex types is a larger problem
> > than the cast above in my opinion.
>
> I understand.
>
> So, the cast is simply wrong there. Can you add a comment above that cast to
> explain that and make it is marked as FIXME? Because there is no guarantee that
> internal Linux types can be 1:1 mapped to the ABI of something.

We might as well fix it directly instead. How about storing the
intermediate result in a proper uuid_t and then export it as:
export_uuid((u8 *)&msg_arg->params[1].u.uuid, &myuuid);

>
> What you need, perhaps, is a middle layer function that will copy u64 data
> to uuid_t or so. Also, u64 is not an ABI type, why the respective __uXX
> variants are not in use?

Does it make any difference? The file isn't shared with user space and
I need to sync the file manually anyway since OP-TEE doesn't have the
same include files.

Cheers,
Jens
