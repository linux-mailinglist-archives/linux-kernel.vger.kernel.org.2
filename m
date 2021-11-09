Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF02D44AEFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 14:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhKINqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 08:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbhKINqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:46:49 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA41EC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 05:44:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r12so76662811edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 05:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQ0tDWDw1iitsubB5oEYifHdan/J9VCxhr/62i02x54=;
        b=B8uUleYLpZylVlr3H8NOx3u2w7EMXc8Il0zFJWaENnBbXE6Vvx3znJN2jTw3YIWxJd
         VGSZfZcipYInEm1uS1qPDhKq92rViKpPDZexE7u1hQPPWwhQQJ9rSXQ75K9gZD4ZpnOH
         SDwiFiS6BnpunWUH/pTpADkfi4FnWmMPjSV5BRH6gfBQxVVHBX7JcSS5a39p5VK4e4JE
         /H4RN6VB3np5gepZwOQngnoVzxep6JnXwcDb0Yd7VEW2GHlsZju5vJJzAVTNt+L9ZE8w
         ozZJV0GTiKgTATeJRbPeNe4EtqCEES0rFQoCOhTKuNDl4SuIzCZCwIB2qbnXK3vVp2Nl
         ZTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQ0tDWDw1iitsubB5oEYifHdan/J9VCxhr/62i02x54=;
        b=7HAc2sy+EpxDM1cLNgUqcnpLQjVAF/AQIBs3hMOgyr20WplogYTFXsOZg9EykpjSGj
         sjMgthYAjJFN9p0jq2+KmpZ4xTgaW4piPA+R9kyX4AmnX0EDsf8en2lK60cLtPh0lfTn
         z4L807E0ERVq8gMeNtd7XdEDmizhagOn9UUbPL+Pm+cJKZ1Ov/yKDM9oZaCDYSwVwn8V
         e5aGv1Ypn6BbLYVVM9k/qen2W8jLpbXVPYqpSQgVbjHSXAHut5N1jDgPqv96r/Shkdr8
         wxBQBFMuzJkvr4EWHnE2V1sVNbf+Tz0zY33qWTp5hm0LyjoxJ+QCJ8ecTzzCxk6LIFok
         +gHw==
X-Gm-Message-State: AOAM533gQ2hGkEYA8whqGlgzGon98dj4kCDcmZV/rOtjLyxIVW2ZGx4p
        T7TiV/7qRzn4LdmIGK8d8vYpQ25EIlS/JoYm9kE04Q==
X-Google-Smtp-Source: ABdhPJxd1OAPk9lPb1IXfAWS18rtXuj5RXZlGicAJrjEjxajGRieHrKEXO9qkwG+iefklFFDZkiP3ksQq8HLNOxZ5h0=
X-Received: by 2002:a17:907:6da9:: with SMTP id sb41mr10317906ejc.88.1636465441947;
 Tue, 09 Nov 2021 05:44:01 -0800 (PST)
MIME-Version: 1.0
References: <CADyq12yY25-LS8cV5LY-C=6_0HLPVZbSJCKtCDJm+wyHQSeVTg@mail.gmail.com>
 <cb682c8a-255e-28e5-d4e0-0981c2ab6ffd@intel.com> <85925a39-37c3-a79a-a084-51f2f291ca9c@intel.com>
 <CADyq12y0o=Y1MOMe7pCghy2ZEV2Y0Dd7jm5e=3o2N4-i088MWw@mail.gmail.com> <472b8dbf-2c55-98c9-39ad-2db32a649a20@intel.com>
In-Reply-To: <472b8dbf-2c55-98c9-39ad-2db32a649a20@intel.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 9 Nov 2021 08:43:26 -0500
Message-ID: <CADyq12whSxPdJhf4qg_w-7YXgEKWx4SDHByNBNZbfWDOeEY-8w@mail.gmail.com>
Subject: Re: XSAVE / RDPKRU on Intel 11th Gen Core CPUs
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <groeck@google.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Tue, Nov 9, 2021 at 1:49 AM Dave Hansen <dave.hansen@intel.com> wrote:
> Well, gosh, it's making it back to the software init value.  If you do:
>
>         echo 0x15555554 > /sys/kernel/debug/x86/init_pkru
>
> do you end up with 0x15555554 as the value?

What's interesting is that writing to init_pkru fails with -EINVAL for me,
and I've traced it down to get_xsave_addr() returning NULL on the following
check:

  /*
  * This assumes the last 'xsave*' instruction to
  * have requested that 'xfeature_nr' be saved.
  * If it did not, we might be seeing and old value
  * of the field in the buffer.
  *
  * This can happen because the last 'xsave' did not
  * request that this feature be saved (unlikely)
  * or because the "init optimization" caused it
  * to not be saved.
  */
  if (!(xsave->header.xfeatures & BIT_ULL(xfeature_nr)))
     return NULL;

And that's why I thought this was possibly related to that erratum
that I shared before.

> Does your system have any more XSAVE support than mine?
>
> > kernel: [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> > kernel: [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> > kernel: [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> > kernel: [    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
> > kernel: [    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
> > kernel: [    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
> > kernel: [    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
> > kernel: [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> > kernel: [    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
> > kernel: [    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
> > kernel: [    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
> > kernel: [    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
> > kernel: [    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.

No, it's pretty much identical

INFO kernel: [ 0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87
floating point registers'
INFO kernel: [ 0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE
registers'
INFO kernel: [ 0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX
registers'
INFO kernel: [ 0.000000] x86/fpu: Supporting XSAVE feature 0x020:
'AVX-512 opmask'
INFO kernel: [ 0.000000] x86/fpu: Supporting XSAVE feature 0x040:
'AVX-512 Hi256'
INFO kernel: [ 0.000000] x86/fpu: Supporting XSAVE feature 0x080:
'AVX-512 ZMM_Hi256'
INFO kernel: [ 0.000000] x86/fpu: Supporting XSAVE feature 0x200:
'Protection Keys User registers'
INFO kernel: [ 0.000000] x86/fpu: xstate_offset[2]: 576, xstate_sizes[2]: 256
INFO kernel: [ 0.000000] x86/fpu: xstate_offset[5]: 832, xstate_sizes[5]: 64
INFO kernel: [ 0.000000] x86/fpu: xstate_offset[6]: 896, xstate_sizes[6]: 512
INFO kernel: [ 0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
INFO kernel: [ 0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]: 8
INFO kernel: [ 0.000000] x86/fpu: Enabled xstate features 0x2e7,
context size is 2440 bytes, using 'compacted' format.
