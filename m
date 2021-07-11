Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB06F3C3D90
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhGKPRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 11:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhGKPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 11:17:06 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87254C0613DD;
        Sun, 11 Jul 2021 08:14:19 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x70so9608846oif.11;
        Sun, 11 Jul 2021 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oe5ZzuvcKM2HmALVrOLPxP8KtWJbDZUxFNp+rle9/fc=;
        b=SDVYcDTQ1pIbzPFIrd/WMyhULvjHGdkY/YATZMDry8Zj1l5W59L4fGFsMIXKgIY2K/
         ORe5WE4JwVhfJ0fsmUhIFiMt9LVqjIEhEIv657NfMmaLh+MrIFxSkTas4pBhMWtnIiPy
         NdN3dWyZ49IOj+6bYziNEKnfw1w2UEYXAW1jLOMlbQAmO+Grb9scH44B7bo/EWdeZj9M
         pmTdPEFynv9wo6HI0KsRlNVAhAOyi/fIKaz/LEb9DXpDZ6oC6q5jPFts9hwrv80JfZ9x
         cEP/h2YATvqfolc7DOR0GYnMZb/jHHUSvIMHGh+qA+ecjQrdYvfWimTQz7Xe6+HjAry3
         s1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oe5ZzuvcKM2HmALVrOLPxP8KtWJbDZUxFNp+rle9/fc=;
        b=kBcNZfM/AGYHZYNvNSCTOfR4GRFrhfRzuK655VfxL0W479p2A3zBpV5JcTjv+ifjj9
         jmPsL3PoOYEwl18PXrIhVVLJZ9HNFrKcaY+I4dB7MoGUEyHLJZMXci4oekO0YlPoxCZq
         NAGcDnUKQ3c6vPqVKnhtYAVytRaSi+0FGOg6e3v3LIZQYIrLAAOUbaiG4VPbVIeWf+5c
         IhRPdHmzUsJ23L8FPXHB8ya0bFFth7emmFeFGJFYoWb2AZ8Ti8Gc4W2AGGSaXQprJGK7
         CyIvl24vhQaBa/5cqzol1KHZSTxPP7mjF4RMjqMyBDq1p9ds/Li904uvqMSY6CQRCda8
         trjQ==
X-Gm-Message-State: AOAM530CkutxbQyUfmx3onrrhB3wJnPdRIbW/3+QVVB8wQPXNeYaCS1K
        1RzCUEYen9TQwgQoYkSji0o=
X-Google-Smtp-Source: ABdhPJylNxLsxmlffr0P1Wf02iIzYLMTQrf6JOXxiSxZLNGbtitBazVIdw/l8ZhxOVUcF5FQheEZgw==
X-Received: by 2002:aca:3204:: with SMTP id y4mr25364208oiy.112.1626016458851;
        Sun, 11 Jul 2021 08:14:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r8sm190379oti.35.2021.07.11.08.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 08:14:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
 <2c24ef5953401e80d92c907704bffeff1d024de0.1625662290.git.plr.vincent@gmail.com>
 <20210710160813.GA3560663@roeck-us.net> <20210711025502.347af8ff@gmail.com>
 <d41a36e4-c36e-b5ab-429a-91506768bf3e@roeck-us.net>
 <20210711113901.1cfa948f@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/3] hwmon: da9063: HWMON driver
Message-ID: <a61a1416-879e-9f74-f3e0-794607aec0a6@roeck-us.net>
Date:   Sun, 11 Jul 2021 08:14:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711113901.1cfa948f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/21 4:39 AM, Vincent Pelletier wrote:
> Hello,
> 
> On Sat, 10 Jul 2021 21:22:35 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
>> int main()
>> {
>>           unsigned int v1 = 247;
>>           int v2;
>>           int v3;
>>
>>           v2 = (char)v1;
>>           v3 = (int)((char)v1);
>>
>>           printf("%d %d %d\n", v1, v2, v3);
>>
>>           return 0;
>> }
>>
>> produces 247 -9 -9, so I don't fully follow what your (int)((char)tmp)
>> looks like.
> 
> On the riscv machine I am writing this driver for (and the only one I
> have with this chip), I get:
>    $ gcc test.c
>    $ ./a.out
>    247 247 247
>    $ file a.out
>    a.out: ELF 64-bit LSB pie executable, UCB RISC-V, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv64-lp64d.so.1, BuildID[sha1]=0a146933fa8f9ab982a7aedb91b6e43b1bd8c668, for GNU/Linux 4.15.0, not stripped
> 
> It turns out that "char", without specifiers, is unsigned in the riscv
> ABI:
>    https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md#c-type-representations
> 
> And indeed with:
>    v2 = (signed char)v1;
>    v3 = (int)((signed char)v1);
> I get the expected output:
>    247 -9 -9
> 
> This means I will be leaving a (signed char) in the code, and I am
> unsure if it needs anything else:
> - someone eventually dropping the apparently useless qualifier will
>    break the code on riscv, so a comment would be good
> - OTOH, if this is an ABI-level specificity and not something unique to
>    this driver, then such comment would surely be needed in a lot of
>    places, which would just get in the way.
> 
> What is your opinion ?
> 

If char, as it appears to be, is not well defined in C, it should be
avoided to use it to express a number which could be negative.
Fortunately this seems to be the only place at least in hwmon drivers
where someone insistss using a char to express such a value.

>>> With this in mind, could the time from regmap_update_bits() to
>>> {,re}init_completion() be longer than the time the IRQ could take to
>>> trigger ? In which case adc_ready would be marked as completed, then it
>>> would be cleared, and wait_for_completion_timeout() would reach its
>>> timeout despite the conversion being already over.
>>>    
>> ... but what I do know is that I don't understand why you insist having
>> the reinit_completion() _after_ the  wait call.
> 
> Sorry that I gave you this impression, as this is definitely not my
> intention.
> I am rather trying to understand why moving {,re}init_completion() just
> before the wait call is enough to fix the issue, as I am under the
> impression that I may need to do more:
> The hardware IRQ could have been received before the DA9063_ADC_MAN
> write, and I guess the threaded handler can be delayed. So what is
> preventing the interrupt handler from running right between
> {,re}init_completion() and the wait ?
> 
> I'm leaning towards masking the interrupt when outside
> da9063_adc_manual_read:
> - acquire measure lock
> - if ADC is not ready, return some error (-EIO ? -EAGAIN ? -EBUSY ?)
>    as there does not seem to be a way to cancel an already triggered
>    conversion, so no way to prevent an interrupt triggering at an
>    unexpected time
> - clear any pending ADC IRQ
> - unmask ADC IRQ
> - clear completion
> - trigger measure
> - wait for completion
> - if timeout, return -ETIMEDOUT
> - decode measure
> - mask ADC IRQ
> - release measure lock
> 
> (plus a few gotos to cleanup code, and register read/write error
> propagation)
> This looks race-free to me, at the cost of a 3 extra register writes.
> 

Seems to me that da9063 is similar to da9052 and da9055, except for
conversion constants, and that it should be sufficient to follow the
guidance from that code.

Guenter
