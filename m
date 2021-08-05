Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C73E1C4C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbhHETSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhHETSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:18:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7DC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:18:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso12005650pjo.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfxIlM1xTFcQt+BzwsoHgiuGLJYmYmn3zdsmmDcf8Z4=;
        b=FvpYLsAbx2kTcixaoUDS0/KJ53nB4910QGL62KRJJ6ZWSgF2eqbWYr2v0O8J03806i
         6eW+C8d67EFYvLP6hYYO6h0psP+0BTBB9F48MfQ5fG77sl9PqriCE+uyrH8lNg7uAr8R
         yBANau4Rh6lSjBJj9PJxxiB00CPjIzc9H6B1mhmKhQT+EtxwwciPim4+Ee14PnZSj73K
         hTXfWDMRDtgVRiilr/vDpM0XBCBtpKuhxdm8lYlsW7h07/+8kvqd2bCxqJPmlCcyRY7h
         YpEhSgcdxBeEsfPZJLe/AvmuUNESysWTG6DeN3Y2iT6BXIrwlO5QLvJM0NebyUPuaNKn
         7ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfxIlM1xTFcQt+BzwsoHgiuGLJYmYmn3zdsmmDcf8Z4=;
        b=gwH0UGDJq5yS5C4aEr4cyjWzUJTL4ym7FuEKNZVINxkc/RFf+Xj3AyA1ABkkvUKJ59
         J0b1WcvVqerUvm8dGbEWGvAqyDNIhohTaBqzC8JYFBL47Jz/ZXbuBemCbSmzlqySBa7H
         R0Qg6dWSnNF5q2KQaVjuSyYWPgluwJT3bgvvK+DSWdW2Jr44vjAjbUaiMZ5ByxuG6yJG
         DrNnKTbV81jV8wc5PiHE62aWlpRajDZ5Vik09XRuP5hB/LYYPJPwSjQ+kzFTsJShJe9c
         3bpn6W2fzG1VUp+4GEYiMrKdp2r45bJsI7q5nCAW1+u1JKuuIvs5ASGtdALlig0VrmCP
         y8iQ==
X-Gm-Message-State: AOAM530fozNWRi1ZnxP01yfKg/L+wcOX6oP8WTjD8xWCLi9EF6VooHAK
        ZuuiB0GhvVM52xLzOSHa3dfrekaepLzJBZ/qDFvORw==
X-Google-Smtp-Source: ABdhPJy/8fUQjgNc4DqetCdJsM0DETjaCMPsDUdsSJrsKUOreKBp29Tx1eNK0CRhptKBhESIXgS6JGEW1kpDx7bjNxI=
X-Received: by 2002:a63:311:: with SMTP id 17mr693465pgd.450.1628191103511;
 Thu, 05 Aug 2021 12:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <YQrqhYEL64CSLRTy@kroah.com> <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com> <YQuZdVuaGG/Cr62y@kroah.com> <YQuaJ78y8j1UmBoz@kroah.com>
 <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com> <YQwlHrJBw79xhTSI@kroah.com>
 <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com> <YQwpa+LAYt7YZ5dh@kroah.com>
 <7d6751b1-c476-51d3-25c6-b65c0e93d23b@linux.intel.com> <YQw4AEwIUGe3RpCx@kroah.com>
In-Reply-To: <YQw4AEwIUGe3RpCx@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 5 Aug 2021 12:18:12 -0700
Message-ID: <CAPcyv4gV9GK93rgtoHxhshzDGk0ueJn0d9LXYitJ8=wJWzmWHg@mail.gmail.com>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 12:12 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 05, 2021 at 11:53:52AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > I am not sure how USB and Thunderbolt "authorzied" model works. But I
> > don't think it prevents built-in driver probes during kernel boot right?
>
> Yes it does.
>
> Again Intel created this framework well over a decade ago for busses
> that it deemed that it did not want to "trust" to instantly probe
> drivers for and made it part of the Wireless USB specification.
>
> Then Intel went and added the same framework to Thunderbolt for the same
> reason.
>
> To ignore this work is quite odd, you might want to talk to your
> coworkers...

Sometimes we need upstream to connect us wayward drones back into the
hive mind. Forgive me for not immediately recognizing that the
existing 'authorized' mechanisms might be repurposed for this use
case.
