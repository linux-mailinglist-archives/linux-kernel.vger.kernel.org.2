Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4953263ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBZOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBZOP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:15:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD68C061574;
        Fri, 26 Feb 2021 06:15:15 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b21so4070698eja.4;
        Fri, 26 Feb 2021 06:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9l+3BZETuAdB+apeVzqHpst3kL/611qF17fjEEfDPUo=;
        b=eM+MyqF5sqSIFTdzCtorsv8yUQKamOOEwOje4kumaUSf6LnZRQaRe4bz9bJkjZctVZ
         ih1mMFYZNJntFLAfx1dIQvfcv5+kU3oTqaMX2K89bDoWHpZR/pMz5eeoMm5sUEW+box7
         iIUmPzXW/mgLw5csgH5QSVMgodVtGO7Su0kcuMvcnJd0CFgvR10NIUZgZguo6fE8oaeg
         FqxRJI7O9tRc8opzzkejmfVj5Ri0x6n7rtti8bXKZrJHin6cq6Daj9lObWWX8Zj5yMUy
         gsDqY0KNENEnT1doiSFPuEVttzHBAKeQI0bM9ii6HvCz6uyYXdjrmA6KeAH27O0Zj2Gk
         WXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9l+3BZETuAdB+apeVzqHpst3kL/611qF17fjEEfDPUo=;
        b=BTrWVQcLKNxakkRaT3dRlernO+vlnzC40yrzwSTC3wEvzlGdd/HjMwJS+xrsJgYUCL
         yLhDHuxJhlhEgcmAx50EcAOyTdkq/Bp4n6yQIDC9yf3STZwDuG86mA6IgfFtXoQIZJ0s
         +GJ/3mRzGbEVugM/q6jm6pU1WzG1/6rZPdkcR/k4fJfhm5X1Ez7kAW+wKlNSHaFGRdJr
         yhdecGZvKDbGsTmjKGbUiysiOwLHLpJo87z6xEMcu3Sarb62P8Ef5NC1QkgywY3x34SN
         5PK3SdU3U2RIbJNQYrQ5pJN+thgTWY2QFDqxQ7lTCP6Z9/7RowDeztiQaDocI7ox3MWH
         5IFA==
X-Gm-Message-State: AOAM532y8uasO3ksuBGlRrPvbvD4+c8jp6bUd81P32QqsGnctOil6kTf
        E7aLRR7IoTskQHRlkv4w66gfvJnH9diXK1EkPXw=
X-Google-Smtp-Source: ABdhPJwka2N97gMh7fc6+s0EpkhK43Eab7WY4zfuii/FBuAJZSs74sIoQx0O41Kaar0ZHsbVJ0peDoPhI/DPRRLRPMo=
X-Received: by 2002:a17:906:9888:: with SMTP id zc8mr3716523ejb.310.1614348914441;
 Fri, 26 Feb 2021 06:15:14 -0800 (PST)
MIME-Version: 1.0
References: <CAH+2xPCmZNW0ct8XoBmAnd0QK53guv2e4HLn40NvWrEA7pj3qw@mail.gmail.com>
 <CAH+2xPCkKRhXJSqMx7kzsO53JwXbrmYPLLL-_ANO9waNJREDWA@mail.gmail.com>
 <777991bb72f8842e3e730f9b600b2086478f5d36.camel@suse.com> <CAH+2xPAB4bWN9NiTQr4WggUX6eDXzMikzYJySx3sAj3Ho3AdxA@mail.gmail.com>
 <b71b85a588c3e27d2de129723468263d932ab435.camel@suse.com>
In-Reply-To: <b71b85a588c3e27d2de129723468263d932ab435.camel@suse.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Fri, 26 Feb 2021 15:14:58 +0100
Message-ID: <CAH+2xPA4yUwbcOaO4OH-LaAwC820ZoFmAf_eUdf6+xgiTPWz8g@mail.gmail.com>
Subject: Re: usb: cdc-acm: BUG kmalloc-128 Poison overwritten
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-usb@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bruno Thomsen <bth@kamstrup.com>,
        Lars Alex Pedersen <laa@kamstrup.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tor. 25. feb. 2021 kl. 10.57 skrev Oliver Neukum <oneukum@suse.com>:
>
> Am Mittwoch, den 24.02.2021, 16:21 +0100 schrieb Bruno Thomsen:
>
> Hi,
>
> > No, this is not a regression from 5.10. It seems that many attempts to
> > fix cdc-acm in the 5.x kernel series have failed to fix the root cause of
> > these oops. I have not seen this on 4.14 and 4.19, but I have observed
> > it on at least 5.3 and newer kernels in slight variations.
> > I guess this is because cdc-acm is very common in the embedded
> > ARM world and rarely used on servers or laptops. Combined with
> > ARM devices still commonly use 4.x LTS kernels. Not sure if
> > hardening options on the kernel has increased change of reproducing
> > oops.
>
> OK, so this is not an additional problem.
> According to your logs, an URB that should have been killed wasn't.

Thanks for looking into this bug rapport.

> > I am ready to test new patches and will continue to report oops
>
> Could you test the attached patches?

Yes, I am already running tests on the patches.
I have not seen any oops yet and it seems the USB cdc-acm driver is still
working as intended.

The only notable trace I have seen is this new error from the cdc-acm driver
but everything kept on working.
kernel: cdc_acm 1-1.1:1.7: acm_start_wb - usb_submit_urb(write bulk) failed: -19

Other then that I see this common error (should probably be a warning) during
device enumeration:
kernel: cdc_acm 1-1.2:1.0: failed to set dtr/rts

I will post an update next week when the patches have survived some
more runtime.

/Bruno
