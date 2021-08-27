Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9FA3FA159
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhH0WDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231906AbhH0WDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630101746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6xavDxclU2457G1Vw6lUkX39komt2IDfPFEDUjuZSY=;
        b=fsjO1Mue/JzuzabqY4fPvM7IGJnaENDcRL9WilQsbLASZKAYekQDWqGP9ASJxcIj5/JrmX
        if8rEtNgXtkJnF8mkIqDOEgfNzX2DMP8Fu5msX/ywMDdW+cPZv3k9cSYczvbt8GzL9D21F
        Q3ce1wadtEK9U5kiauVVhRvaCZMjV2M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-lo4vSzA8PSGoe0L-2Ye0pA-1; Fri, 27 Aug 2021 18:02:25 -0400
X-MC-Unique: lo4vSzA8PSGoe0L-2Ye0pA-1
Received: by mail-wr1-f70.google.com with SMTP id r17-20020adfda510000b02901526f76d738so2284256wrl.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F6xavDxclU2457G1Vw6lUkX39komt2IDfPFEDUjuZSY=;
        b=BPcek2TqvUQYE4JfJCnBylb7iIONh4OPv6gUT88/tHuo0P02voCheDkiGNcnAve3u2
         +RxjdyR51se+SLlgzLeluimoBAL5iRadmb1e3vrH5fwjT4MGdFc2VqGzJjBVYYNRxm1v
         EkJKcVMkY7hk2topznwfPr/8wgJTtvKULbkLIzayy8hy1XICCrMTT5fEUJYk94hZpsSB
         WtuxT0GD7dzzAYPvuDSvVoHwEkQywtszzIpvaNMK/ZOZkQ29eBz/GRaJBcX+qRyuCkG0
         h7sR3lg/LfqXgJpfTqYs4j58GL9Xhx1YvSa6TZNjaUUGT90qEMrc9K03jg7OZTff5SQc
         KIvg==
X-Gm-Message-State: AOAM5329cbjxNQVo93afgwDqbJblDjzVakRdmYmGXxM7IPJvm5oomoHz
        L/O13Te3CeiqlT3c8JlZPLvKeFRpnTSQ0SOJXhStZcMsWDnh/KmjA6lck73MKjTH9tCxXQQpd76
        EVotssu4S37J4vQIf2EqLA9sM
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr11883629wra.245.1630101743869;
        Fri, 27 Aug 2021 15:02:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0sjJPekqAFrzI+I21wArpuNqneRzwvRM7qmHiOpufcRJPM7zXryENkyja4nv3/Jn1chky2g==
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr11883596wra.245.1630101743658;
        Fri, 27 Aug 2021 15:02:23 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z126sm6853997wmc.11.2021.08.27.15.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 15:02:23 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] Allow to use DRM fbdev emulation layer with
 CONFIG_FB disabled
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>
References: <20210827100027.1577561-1-javierm@redhat.com>
 <bb5d045c-c9de-b6df-cf45-32b1a866264a@suse.de>
 <YSlI+ryYqoRxM7aB@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <a7395626-f022-5c89-07cd-c30d0d52d3dd@redhat.com>
Date:   Sat, 28 Aug 2021 00:02:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSlI+ryYqoRxM7aB@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel and Thomas,

On 8/27/21 10:20 PM, Daniel Vetter wrote:
> On Fri, Aug 27, 2021 at 07:50:23PM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 27.08.21 um 12:00 schrieb Javier Martinez Canillas:
>>> This patch series splits the fbdev core support in two different Kconfig
>>> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>>> be disabled, while still using fbcon with the DRM fbdev emulation layer.
>>
>> I'm skeptical. DRM's fbdev emulation is not just the console emulation, it's
>> a full fbdev device. You can see the related device file as /dev/fb*.
>> Providing the file while having CONFIG_FB disabled doesn't make much sense
>> to me. I know it's not pretty, but it's consistent at least.
>>
>> If you want to remove fbdev, you could try to untangle fbdev and the console
>> emulation such that DRM can set up a console by itself. Old fbdev drives
>> would also set up the console individually.
> 
> Yeah given the horrendous security track record of all that code, and the
> maze of handover we have (stuff like flicker free boot and all that) I'm
> wondering whether typing a new drmcon wouldn't be faster and a lot more
> maintainable.
> 

We talked about a drmcon with Peter Robinson as well but then decided that a
way to disable CONFIG_FB but still having the DRM fbdev emulation could be a
intermediary step, hence these RFC patches.

But yes, I agree that a drmcon would be the proper approach for this, to not
need any fbdev support at all. We will just keep the explicit disable for the
fbdev drivers then in the meantime.

Thanks a lot for your feedback.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

