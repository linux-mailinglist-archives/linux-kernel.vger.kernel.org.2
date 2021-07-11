Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733273C3BF0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 13:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhGKLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKLlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 07:41:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A712EC0613DD;
        Sun, 11 Jul 2021 04:39:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id o201so8353373pfd.1;
        Sun, 11 Jul 2021 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WuN9YEdeKHzmcs5Gv+FngZF07X8K6zFoL5FtKiToRfI=;
        b=IyUXOQkjkFRBj+1C5YcmizL+iMY6nl24Fa15nZ0BOP3Xr5TOCkRZoMEzDwnX9LdLFT
         DmP25pxlaBLCDLqDcPJBiKmPSUucgLTyVR9Tyh7tseQWBpgi8qRw0IJul6bQcLga21rl
         wGeJf0niga0Lt1dbea2TXtoruGCMyB9FiZxGSvC3HzTgV1ZBsbmjw7BdhURaxVUTbfv0
         ujYosIlrthOSDBq89uCBWGrg7SvfGK4e/pbIaJi89lDgMBJwjRyiTlBHhsZ07k/yFAFU
         Mqd4Gz5lMrZukZTLeUKwXQiCe7jKUpw7NmCGPhbLQ341tezvfbHAOQl90B0pJtZbW7Dl
         eumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuN9YEdeKHzmcs5Gv+FngZF07X8K6zFoL5FtKiToRfI=;
        b=pjBuPVznMXlmOtha4czNKPQGMADzPAerxYfaGjmjFi0KhzzIJQJUaYbPFlUpa1jjDp
         Llx6mfK+4LBPxv37qErSpY8/Q5hMPJbsp8lkmTVmsZ2Y3ujtO70jm8S/I/X7f3RobE2A
         Z8aRto1gKV5t6ttToVS74/kmbxRYaFr5ZGPatdxbET8/g+0FXR2/X/XhfVX1mY0h4mEa
         /AppgneWcVq+IFl6S6V1Pis3mLCR1P4SfgoDntMuFcdk7nymJC3zxyVqyDFKzk7uXkWA
         IU+ne5vXFyqkzWDjANe0RS6vwnSgPMbj+dbQ1fkvWafBpKUJkl8RSxRYK5x1WPnnDHKJ
         sRrA==
X-Gm-Message-State: AOAM533vT42rKl0dFtVaIv6MyWIPi4iX1Xx/Viu6BFvKb2zSKTGhCjH0
        pAWVW8/3QkGaIAH8ryq6iQ8=
X-Google-Smtp-Source: ABdhPJxXdGnOH99gb8PNarkRMPZvuqMdr7vrgeHi4BTAOa4zYyRnyuGAboGEYNDtURkDJJWZLvC4sA==
X-Received: by 2002:a63:d347:: with SMTP id u7mr48317802pgi.434.1626003545170;
        Sun, 11 Jul 2021 04:39:05 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id a31sm13934551pgm.73.2021.07.11.04.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 04:39:04 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id 386D09011C2;
        Sun, 11 Jul 2021 11:39:02 +0000 (GMT)
Date:   Sun, 11 Jul 2021 11:39:01 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH v3 2/3] hwmon: da9063: HWMON driver
Message-ID: <20210711113901.1cfa948f@gmail.com>
In-Reply-To: <d41a36e4-c36e-b5ab-429a-91506768bf3e@roeck-us.net>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
        <2c24ef5953401e80d92c907704bffeff1d024de0.1625662290.git.plr.vincent@gmail.com>
        <20210710160813.GA3560663@roeck-us.net>
        <20210711025502.347af8ff@gmail.com>
        <d41a36e4-c36e-b5ab-429a-91506768bf3e@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 10 Jul 2021 21:22:35 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
> int main()
> {
>          unsigned int v1 = 247;
>          int v2;
>          int v3;
> 
>          v2 = (char)v1;
>          v3 = (int)((char)v1);
> 
>          printf("%d %d %d\n", v1, v2, v3);
> 
>          return 0;
> }
> 
> produces 247 -9 -9, so I don't fully follow what your (int)((char)tmp)
> looks like.

On the riscv machine I am writing this driver for (and the only one I
have with this chip), I get:
  $ gcc test.c
  $ ./a.out
  247 247 247
  $ file a.out
  a.out: ELF 64-bit LSB pie executable, UCB RISC-V, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv64-lp64d.so.1, BuildID[sha1]=0a146933fa8f9ab982a7aedb91b6e43b1bd8c668, for GNU/Linux 4.15.0, not stripped

It turns out that "char", without specifiers, is unsigned in the riscv
ABI:
  https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md#c-type-representations

And indeed with:
  v2 = (signed char)v1;
  v3 = (int)((signed char)v1);
I get the expected output:
  247 -9 -9

This means I will be leaving a (signed char) in the code, and I am
unsure if it needs anything else:
- someone eventually dropping the apparently useless qualifier will
  break the code on riscv, so a comment would be good
- OTOH, if this is an ABI-level specificity and not something unique to
  this driver, then such comment would surely be needed in a lot of
  places, which would just get in the way.

What is your opinion ?

> > With this in mind, could the time from regmap_update_bits() to
> > {,re}init_completion() be longer than the time the IRQ could take to
> > trigger ? In which case adc_ready would be marked as completed, then it
> > would be cleared, and wait_for_completion_timeout() would reach its
> > timeout despite the conversion being already over.
> >   
> ... but what I do know is that I don't understand why you insist having
> the reinit_completion() _after_ the  wait call.

Sorry that I gave you this impression, as this is definitely not my
intention.
I am rather trying to understand why moving {,re}init_completion() just
before the wait call is enough to fix the issue, as I am under the
impression that I may need to do more:
The hardware IRQ could have been received before the DA9063_ADC_MAN
write, and I guess the threaded handler can be delayed. So what is
preventing the interrupt handler from running right between
{,re}init_completion() and the wait ?

I'm leaning towards masking the interrupt when outside
da9063_adc_manual_read:
- acquire measure lock
- if ADC is not ready, return some error (-EIO ? -EAGAIN ? -EBUSY ?)
  as there does not seem to be a way to cancel an already triggered
  conversion, so no way to prevent an interrupt triggering at an
  unexpected time
- clear any pending ADC IRQ
- unmask ADC IRQ
- clear completion
- trigger measure
- wait for completion
- if timeout, return -ETIMEDOUT
- decode measure
- mask ADC IRQ
- release measure lock

(plus a few gotos to cleanup code, and register read/write error
propagation)
This looks race-free to me, at the cost of a 3 extra register writes.

> Also: a return value of 0 from wait_for_completion_timeout()
> already indicates a timeout. The subsequent regmap_read() to check
> if the conversion is complete should not be necessary. If it does,
> it really indicates a non-timeout problem. Are there situations
> (other than the race condition I am concerned about) where
> an interrupt can happen but DA9063_ADC_MAN is still set ?

Not as far as I know: only the ADC triggers this interrupt, and only
this driver should trigger an ADC conversion.
The chip can trigger the ADC internally, but these should not trigger
the IRQ according to the chip's documentation.

> If so, I think this needs a comment in the code, especially since there
> is an extra i2c read which, after all, is costly.

I was curious about the cost, so I checked with regmap events in
debug/tracing (hopefully this is representative enough). Here is the
breakdown (as of patchset v3, so without the IRQ masking scheme I am
considering):
- writing to DA9063_ADC_MAN to select the channel and initiate the
  measure (3 reads, 1 write): 3.5ms
- ADC measure, based on the time between the end of DA9063_ADC_MAN
  write and when the GPIO driver masks its interrupt line: 1.6ms
- clearing the IRQ in the DA9063 (3 reads, 1 write): 2ms
- reading DA9063_ADC_MAN back (2 reads): 1ms
- reading the conversion result (2 reads): 1ms
Total (including scheduling to and from the threaded interrupt
handler): 9.3ms

Regards,
-- 
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
