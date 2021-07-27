Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441AD3D749B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhG0LyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231856AbhG0LyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627386861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtEQPY6uW+5xma5Ar89LyNdD4KnBU2eYWcwEqgy6rCw=;
        b=PaQmkc3CXHMIv89Q8I01ZFEQpfN1UArgYSNs5EzcpVb1SVfOodakntsFiG9wgz4OSjhMGy
        eHw3+sVJ9rxeRbAgQrNaXegepTtlsEORB/2CdrTYhZ0cQvWL1/pxkvfsDJ8JcNys2yt5wi
        SXcgEONSvyn7sF1GB65a55VTsiF3M+Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-D05j8AsgPeayyb_UXxtGCw-1; Tue, 27 Jul 2021 07:54:20 -0400
X-MC-Unique: D05j8AsgPeayyb_UXxtGCw-1
Received: by mail-wm1-f70.google.com with SMTP id j11-20020a05600c190bb02902190142995dso588401wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LtEQPY6uW+5xma5Ar89LyNdD4KnBU2eYWcwEqgy6rCw=;
        b=b3DZ9v2+iiTWZ5vMUqrkNWqUUmIHYNqSIQFzcjV7GJCTGrgaBzEniept8Vc+NKfJZU
         Pyg7JQr4BCvzI59oQjFKCBksHUO9qaHSc23dMVLST2jVaHxAPnlBHaj7PGxjr6UENUoO
         ixKz6fw66LQ5iP/qq2qr9CsxfZgrnHOiQqHVMgmmUdD3+FMHG8prBdlw3EsPYKCAPSFA
         c9QoP+UD5Z8Gy8Hs/NtGaQ2evBujke5tniTlYu1Yia8UKCPsMPlnlKIKqT7fDOWLMrBT
         R6tTcV4wkQySOgymffac34IHVMUrIOu50bctPDmY1oGLydVYJc3TG3NtRI90hRz+79Wo
         K/Ag==
X-Gm-Message-State: AOAM532Ya5CXHlS5MbQOIclFrZiO7waSW9ya7VOBvvoheAGlR+NtBrpv
        pJGpSt8A71U97C4fydsjt3bvK75hr8IMFyugJdEK6fuTKVqLyIyGQbQf12F61FKbzdRGzy7Gi+N
        b0SDXYQToFQtDUpHXyo2rabr5
X-Received: by 2002:a7b:c934:: with SMTP id h20mr21724438wml.59.1627386859150;
        Tue, 27 Jul 2021 04:54:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8hKxMimbBJI2/gsrfN+EOSzugqFuQQA+bNQ9lMvpdcSm+pXDDcJjGJb5sKa3uIjytVPfidw==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr21724419wml.59.1627386859005;
        Tue, 27 Jul 2021 04:54:19 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id d14sm2840806wrs.49.2021.07.27.04.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 04:54:18 -0700 (PDT)
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
 <e3f0f7a0-2130-18be-48a4-af1918017eca@redhat.com>
 <CAMuHMdX+hsXeoY8jNdDvyiw2HxhwcQw60LJddsaOGZBcHT=a=A@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <5ee9e008-a395-56c2-f57f-e3567d6b648b@redhat.com>
Date:   Tue, 27 Jul 2021 13:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX+hsXeoY8jNdDvyiw2HxhwcQw60LJddsaOGZBcHT=a=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 7/27/21 1:39 PM, Geert Uytterhoeven wrote:

[snip]

>>> Perhaps SYSFB should be selected by SYSFB_SIMPLEFB, FB_VESA,
>>> and FB_EFI?
>>
>> It's another option, yes. I just thought that the use of select was not
>> encouraged and using depends was less fragile / error prone.
> 
> Select is very useful for config symbols that are invisible to the user (i.e.
> cannot be enabled/disabled manually).
> 

Got it. I don't have a strong opinion on this really. In fact, the first
version of the patch did use select for the arches but I got as feedback
that should use depends instead:

https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg351961.html

Granted, that was for the arches but you are proposing to do it for the
drivers that match against the platform devices registered by sysfb. So
it does make more sense to what I did in v1.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

