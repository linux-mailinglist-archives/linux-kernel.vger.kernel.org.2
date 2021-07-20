Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A503CFB12
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbhGTNGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:06:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238700AbhGTNCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626788570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wm1/1+rm0pNTec68SF0ULMEoMpPgTZgtvpTbWM+bk38=;
        b=fG+LIy8oP1CN1RjxGLffxzgglVKC1l4Zx7+1f/r/Aik039kNwmQn5rtXoGGSFVyKQEMoyx
        2oCLF742VwGBFDuwj22DjX7z9YGxPIMUq9eXbVd1MRhzg+y8AbAI8AEgeU8lPWmcQZ83UF
        3wQ/vDC2VBpH7Qvx0td5OghcJDsHLQI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-fJM9WJsLMkap7nBr6KifyA-1; Tue, 20 Jul 2021 09:42:49 -0400
X-MC-Unique: fJM9WJsLMkap7nBr6KifyA-1
Received: by mail-wm1-f72.google.com with SMTP id m6-20020a05600c4f46b0290205f5e73b37so1271005wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wm1/1+rm0pNTec68SF0ULMEoMpPgTZgtvpTbWM+bk38=;
        b=ae5W/U7UYW81A/dUQ0EiaaGQ7TvTlp1/iaUqtqg5bCszPNSLPFPdT3I2xzO9e4gmY6
         wJvWStSYUwAoyYolbXP0hUE9bgxsaSyPKfrZ3ylFaHMXf9jO/VRvCRsfqUDX2h8mzvXo
         dhY+O58sfLT9hH0P5DJm8naUX9vYNRgBuPDbiSmBXBxFYLHbDoijCyNWstFs15VjEvuj
         qnh7pbXzTeP4wlSYCn1nHgw6e3wIEhe6CEND7vdMzlwXhJM+Gjn3W9g6aeJkDu98fNSI
         gqzp3B5aP+D5U/giPoemWBHSQRwoTDqll0S7ME/hvhelXg5PHcQQ7/BoUniGWE+1PYFw
         WLPQ==
X-Gm-Message-State: AOAM530v+bvwa2auHTQearo88EK4G1DsJzZAmPg/Sy7DAf+MoyLWWCDJ
        u7kBoQeQ+1NXpqY0bimvUgnCwopxrt2jR1yxqdW5dEKMvuibOgGVg45tny0bAlLr3HhxjXzmLXk
        CpRRTddZyNt7jOyQTCJqn9dfJ
X-Received: by 2002:a7b:c844:: with SMTP id c4mr37859296wml.107.1626788567976;
        Tue, 20 Jul 2021 06:42:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPDFoW1ztyceGEmsvaxxt+vRNnwbErZ3TkLOyCXvoT5YQ2hwIH+j61ex10oljV9GpyUb7Cpw==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr37859268wml.107.1626788567798;
        Tue, 20 Jul 2021 06:42:47 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id g15sm19533112wmh.44.2021.07.20.06.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 06:42:47 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
To:     Ard Biesheuvel <ardb@kernel.org>, Dave Airlie <airlied@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Russell King <linux@armlinux.org.uk>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20210625130947.1803678-1-javierm@redhat.com>
 <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
 <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
 <CAPM=9tyfNPa2f5PDBLm4w_H_riEQ5P3rEhX73YGE1y_ygRox+w@mail.gmail.com>
 <CAMj1kXErHteZ+MKYvp=yYmwVxV3A=vjtnG351hZHV+3BPwDQvw@mail.gmail.com>
 <YPbJJ/0tSO/fuW7a@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <03f0edef-e54e-8a2a-4b50-683d3d42e249@redhat.com>
Date:   Tue, 20 Jul 2021 15:42:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPbJJ/0tSO/fuW7a@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/21 3:01 PM, Daniel Vetter wrote:
> On Mon, Jul 19, 2021 at 09:10:52AM +0200, Ard Biesheuvel wrote:
>> On Mon, 19 Jul 2021 at 04:59, Dave Airlie <airlied@gmail.com> wrote:

[snip]

>>>
>>> Can we just merge via drm-misc and make sure the acks are present and
>>> I'll deal with the fallout if any.
>>>
>>
>> Fine with me. Could you stick it on a separate branch so I can double
>> check whether there are any issues wrt the EFI tree?
> 
> It'll pop up in linux-next for integration testing or you can pick up the
> patch here for test-merge if you want.
>

Thanks a lot Dave and Daniel!
 
> And since Dave has given a blanket cheque for handling fallout he'll deal
> with the need for fixups too if there's any.

I also plan to look at any regression that might had been introduced by these.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

