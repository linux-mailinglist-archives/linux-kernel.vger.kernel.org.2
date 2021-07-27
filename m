Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DB53D72FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhG0KW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236102AbhG0KWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627381336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQZXv7YDIM5TQ5OrBLbbL+WGAuwVTroA459zUHGAT1o=;
        b=WNowBf+eIjVnEO6BnOc/0svskaX2knAQcP0IgKsRS/LEJ1bdpkNyz4+kFc+62XxiyOmznk
        z0A1o8tPmL1+32EN5/8h6jIjIyaVVBgjAsxcgUGWJGcDVrfJ0rl3zUnPwJdgyrW3VJgX6a
        hmGT4Ffz1tXj5RFQoiDoUOJTpN3Am4U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-CiYm1jwcOym6qzSfn0sm4Q-1; Tue, 27 Jul 2021 06:22:15 -0400
X-MC-Unique: CiYm1jwcOym6qzSfn0sm4Q-1
Received: by mail-wr1-f72.google.com with SMTP id d13-20020adfc3cd0000b02901531b0b7c89so5294649wrg.23
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQZXv7YDIM5TQ5OrBLbbL+WGAuwVTroA459zUHGAT1o=;
        b=nSVoslwEsHxFSQ8/m5sgM0Qj1uz+m8KdI7FqQT3lEYLfrbH8NiL+TLg4b/nR9qQWX6
         Vqz1z/w8jFVKfkuz4WtBefGD9n7hldlkSO/IJ5Dm0ZJJr+Qd5ChUPst2IUwCAWqV47KA
         wYUsIKUpmW3seKcFleWoWXx5SlshSxQtR8/dP8gGxNvc6tVmeMYrBNe3YmtXPQzFNhhZ
         4JrAVNV9FxDuuByIlS4KT71/wMYfwiIGmXAWy+G3a9Hao6HXwZvSlM/N4i8glCZpfofv
         OlShaM8X6Gi5I7FJzXM1FkJnen61xBbOCZBrnHk6d2k21QsXogMPInr0lY6PHUaEKsGL
         y3ug==
X-Gm-Message-State: AOAM531vS0o/IffrevAUbvYb6FTSlBKTWJQUenBerem9fmLoJh5iWGOj
        TsfIv1uk9yEFjkHPbIkix/n4BJZiKyYZ16Nf8ma3L7WKKC0jZXFgsXF+xaqvPcrWt976cPdhmP2
        xyz8Itir5iKo0843vrNY3H/eL
X-Received: by 2002:adf:fb05:: with SMTP id c5mr23489062wrr.55.1627381334046;
        Tue, 27 Jul 2021 03:22:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMDLvsPAQ3/6709sjhKocYSoBlg8BJ99SqGvfztQWeRAwUiHvmVo2wGEG1XsdFbpJKIe4grg==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr23489026wrr.55.1627381333707;
        Tue, 27 Jul 2021 03:22:13 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id p7sm2842383wmq.5.2021.07.27.03.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 03:22:13 -0700 (PDT)
Subject: Re: [PATCH v2] drivers/firmware: fix SYSFB depends to prevent build
 failures
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20210727093015.1225107-1-javierm@redhat.com>
 <CAMuHMdXXoHLO=jsjb+xtW7GDQsvu8Zuz=JmbaEXT49w5o4SJ9A@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <f9df82c9-1e1a-d657-d712-312f5f17cab0@redhat.com>
Date:   Tue, 27 Jul 2021 12:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXXoHLO=jsjb+xtW7GDQsvu8Zuz=JmbaEXT49w5o4SJ9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 7/27/21 12:03 PM, Geert Uytterhoeven wrote:

[snip]

> Thanks for your patch!
>

You are welcome.

>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -254,7 +254,7 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>>  config SYSFB
>>         bool
>>         default y
>> -       depends on X86 || ARM || ARM64 || RISCV || COMPILE_TEST
>> +       depends on X86 || EFI
> 
> Thanks, much better.
> Still, now this worm is crawling out of the X86 can, I'm wondering
> why this option is so important that it has to default to y?
> It is not just a dependency for SYSFB_SIMPLEFB, but also causes the
> inclusion of drivers/firmware/sysfb.c.
>

It defaults to yes because drivers/firmware/sysfb.c contains the logic
to register a "simple-framebuffer" device (or "efi-framebuffer" if the
CONFIG_SYSFB_SIMPLEFB Kconfig symbol is not enabled).

Not enabling this, would mean that a platform device to match a driver
supporting the EFI GOP framebuffer (e.g: simple{drm,fb} or efifb) will
not be registered. Which will lead to not having an early framebuffer.

The logic used to be in drivers/firmware/efi/efi-init.c, that's built
in if CONFIG_EFI is enabled. We just consolidated both X86 and EFI:

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=8633ef82f101

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

