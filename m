Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA4F4118CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhITQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbhITQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:04:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDC0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:02:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g41so37054564lfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpjotW8bLVMH2vSH9tzMaoS14FhokAUiOoLrKOvnBaw=;
        b=iPV4qzdlJ6k5QPU8jK9UiJNdM+ADtK5pfBp/C4Y1y7xOCt78xeOZ/ONlkV5paTLNS6
         AyGwNIe4l1GgGB57g+gy7PGDptUrq5m9LJSFCmG0IMdfm3Sz99Z3ZlknBkEEeCgtGJyJ
         U44NjHmGCN/deOuKfhu+h53Dzvy5m1KYdrtmLU/Z24RXEaY+DwHNxgBCabAzzALNeIpH
         or9D8jMaYgJfOzDNRgW74V7rVYu0lLggcO64L+vXh/hto9ILR/08zVGH6i/ebfm9GsKt
         vKTy3RWFBG9i+uU/xIn8O3baRpre+JtX8yUgu5XbRATlZh0olc3/acjQ8eBv0eP6wjb7
         HHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpjotW8bLVMH2vSH9tzMaoS14FhokAUiOoLrKOvnBaw=;
        b=dMqV2VXQXOX8SfTWEFMVdnH6DOyLevX548nEiMSm6TOJUiaBFt9mEdot314MkAsKSD
         wRETen4QhXz4uayDcUjP2aOaBhIUTlY/kLxWBDKwj4J0tOJna6DX7SY5P6w8aBtmjHQo
         BYgDPnsqe5mkwYcIQDm2kmiBNcuYHz9Xs+Ob5uwQrN3w7N+SCMEsQZzLUxlkbUzPCkO1
         4nZI0E9+vckCqkU1zodUQ/nqiAqIdXwYPMlAQSZ8HsR8UrdaQqU6LcSUF5vnMeqDR7Ua
         o0D127EiaRjoeU34Kp8m8dQzJspillgytkuL1CiBqzi6JXIAL5bNgTK91iw3nY0rMzWf
         JkiQ==
X-Gm-Message-State: AOAM530+J6pSGjbZqXbjJjl2zPhzs/Jf3a4H1OjgpDVTuaEteHVXwZ2K
        JMNfnXtlZPy1dPirkPQOm5vZnRnHhPBx/FvPuXg=
X-Google-Smtp-Source: ABdhPJxIgXytj5e2TG4Idy+IOTWcAJSBcsW/UQ1cJ/YMKCGF6y3kfvshcvIjynf6VRQZSQUvgMmN4qRCAme2R9/BpIM=
X-Received: by 2002:ac2:4c4e:: with SMTP id o14mr13246681lfk.224.1632153680527;
 Mon, 20 Sep 2021 09:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210920124416.7063-1-zboszor@pr.hu>
In-Reply-To: <20210920124416.7063-1-zboszor@pr.hu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Sep 2021 19:00:43 +0300
Message-ID: <CAHp75VdTJ825JP51p24XJmpQORUhoTJ2=7_HOpqw-EGT1fFEOA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl-intel: Fix NULL pointer dereference
To:     zboszor@pr.hu
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 4:00 PM <zboszor@pr.hu> wrote:
> On an Elkhart Lake based POS hardware prototype, I got this Oops:

Thank you for the report, my comments below.

> [    1.587455] BUG: kernel NULL pointer dereference, address: 0000000000000000

First of all, do not spoil the commit message with unneeded lines of
the traceback. Only ~4-5 is usually more than enough.

> It's probably a firmware bug, so be overly protective:

Patch is simply wrong. While Oops will be gone, the driver won't work correctly.
Yes, it's either a firmware bug or the driver is outdated (depends
from which side you look at this issue).

I have heard that new firmware is on its way to the customers, but I
have no more information right now.

-- 
With Best Regards,
Andy Shevchenko
