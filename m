Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A613D7462
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhG0Lcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231781AbhG0Lce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627385554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BaUI7/MGdUeu9aK6r/10GV5Uw/sttnvzMU+KPJUYtJ4=;
        b=IeLsWQ71nujWHdwLWStdGoic4AcBqVmxe7iXXIYmGL6Cy2d7wdmmFpV3/EVeAoj4YQe5cK
        pe8/Hka8HTbIJISJMuax6FcxQKz2sJiUhm9/c6hucq9GGIN6AAYUK4G8pJutg5aWGmSV0J
        qCoTbkhkx4gCo1+lkiuQ55rqY6AaGuQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-QNTFJodkPi2JetmD8jM5cQ-1; Tue, 27 Jul 2021 07:32:33 -0400
X-MC-Unique: QNTFJodkPi2JetmD8jM5cQ-1
Received: by mail-wm1-f70.google.com with SMTP id j204-20020a1c23d50000b029024e75a15714so1263436wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BaUI7/MGdUeu9aK6r/10GV5Uw/sttnvzMU+KPJUYtJ4=;
        b=GwPXRHwKL3mE/oga9jNQVjvmdLUoEkAeDxAARqmE2TmLeu0BvQ71E+Iiegip8Z8KeD
         IQF3OGXB9hoF37Z1GJjF6jXt1H+5vrf2sP13Hkp+jpRfgFVUKwbhHkjFsc8Q8sUUjUdV
         /NdQzk1+3bmQbU1rGi5GODejcU6Dt+wAbu4wOGmkhT2i5MwRNkItsnb3kT1SaDljhiIu
         9Mmoy3a2RFlZO8yw0GFMeEZOvZGeuRitQmuXivgIa6BiCzw6khVcSa1uIlrxv0ZDG7Ws
         LPZj3EHCQeFy4VxwvsFOKtYsGMLMYR6Xgh8Ah7Q3r+HEMwruuWJI6Jjeae6KWRgvKK7j
         clCw==
X-Gm-Message-State: AOAM533RNwMptApeanBefSpk11Rh4onGO8c1VS/vUJds7nfINbFUM3FL
        4bJsZzpBXlXB0SurGzrxNukaDbjZfPtxSl1OG9ELvQYC+i6dP6YmDqijl39PE0MNgcIJv+wVGDC
        ijxSCBs+xKREo7+H2hywcOFWQ
X-Received: by 2002:a05:600c:354a:: with SMTP id i10mr3625986wmq.171.1627385551913;
        Tue, 27 Jul 2021 04:32:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhE4cnozKr8xVw/EzcVfHMxN7aC5PXugco7yEF7nBIklqrOTaYs+t5SrVxBZFKP7Pap/DUZQ==
X-Received: by 2002:a05:600c:354a:: with SMTP id i10mr3625962wmq.171.1627385551713;
        Tue, 27 Jul 2021 04:32:31 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id t16sm2455697wmj.16.2021.07.27.04.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 04:32:30 -0700 (PDT)
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
 <f9df82c9-1e1a-d657-d712-312f5f17cab0@redhat.com>
 <CAMuHMdVh4XgXeaLXXTmPxMuWM4C1mTDnhSmDmff6T37PwNxupg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <e3f0f7a0-2130-18be-48a4-af1918017eca@redhat.com>
Date:   Tue, 27 Jul 2021 13:32:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVh4XgXeaLXXTmPxMuWM4C1mTDnhSmDmff6T37PwNxupg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/21 1:17 PM, Geert Uytterhoeven wrote:

[snip]

>> Not enabling this, would mean that a platform device to match a driver
>> supporting the EFI GOP framebuffer (e.g: simple{drm,fb} or efifb) will
>> not be registered. Which will lead to not having an early framebuffer.
> 
> Do all (embedded) EFI systems have a frame buffer?
>

That's a good question. I don't know if all EFI firmwares are expected
to provide a GOP or not. But even the u-boot EFI stub provides one, if
video output is supported by u-boot on that system.
 
> Perhaps SYSFB should be selected by SYSFB_SIMPLEFB, FB_VESA,
> and FB_EFI?
> 

It's another option, yes. I just thought that the use of select was not
encouraged and using depends was less fragile / error prone.

>> The logic used to be in drivers/firmware/efi/efi-init.c, that's built
>> in if CONFIG_EFI is enabled. We just consolidated both X86 and EFI:
>>
>> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=8633ef82f101
> 
> Thanks, I'm aware of that commit, as I was just about to reply to it,
> when I saw the patch is this thread ;-)
>

Ok :)
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

