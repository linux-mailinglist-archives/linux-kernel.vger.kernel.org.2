Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F55444232
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKCNLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 09:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhKCNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635944951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iHMsC1oUCRsjBOtz0WOghUbDKMYwj98GGeuEKoCFpno=;
        b=abgZHe6Tw/GWZ3AK5JIx7HQmcDDmZYd/pczhOUfbDAkL6X6ImtpEQAo1gSgYmyhrRcYRES
        8fnCQ+3hhpBznoAzjDyIS35lVn0thYFgt+FMyFpANnBPqgIC7DE6N3G/V7JT7DoB+3qa68
        FR3CXzAtUi3NybSnUiqPUZ3BNZKJK3s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-MpVdHSkcOPaHWcy1LwaZYg-1; Wed, 03 Nov 2021 09:09:10 -0400
X-MC-Unique: MpVdHSkcOPaHWcy1LwaZYg-1
Received: by mail-wm1-f69.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so1033257wmg.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 06:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iHMsC1oUCRsjBOtz0WOghUbDKMYwj98GGeuEKoCFpno=;
        b=o9NkkErAMjntJTzqeRb8aHyuX0ESUR8nPpnU3aWFajuQadgn8+YY1tmwKRqzmGOeCO
         quboefZHvUVp6VsmnxSY8w9PJXK82C9+gqaVKBfAuSTUCM01u6Sy/8uPsWbfgX00Dry0
         NASvrceGC1ywFAJFhu1j2wdcFNvCLaquQmS5Mkn6eI/xO7adHHsrG8yGTmHmF9GrrqM4
         EQI0MefVsZTYVtgOmF3+RPvT3NJnESb4FIXAgFCWAdWajERnCMtTE3Wv4F5Hj5VDLhIm
         qyYfOl945rLv+KnDiqtcZZNGFSCsEkyOrk0/8YM65t0zLI6WhEqDAvqGqtlefpgoOpph
         RYVA==
X-Gm-Message-State: AOAM531DFvU4hajArqFSwMtoVpxcR6lC6gjywWqL3zdmfT78XEtkTcH3
        RSWTJYRtKlUMN323bj9LfRG0R5y9MDSlnLCk0ag/1mxuPpTHSggRnGB4J+aMy12tbyH0ETJNPdf
        YTT5GgFrjx0N8iQg2lr5APASa
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr31884083wrw.312.1635944948877;
        Wed, 03 Nov 2021 06:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHrEigoCAeSjtml4DqbOgRDb3rC6POB4cYQ/OE3/fS74/sMET7hHGSgDw+3c9Pc+WnqHoSzQ==
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr31884038wrw.312.1635944948667;
        Wed, 03 Nov 2021 06:09:08 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id c11sm2186397wmq.27.2021.11.03.06.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 06:09:08 -0700 (PDT)
Message-ID: <33807d3c-9dd1-241a-ad23-0e0d4fba13e1@redhat.com>
Date:   Wed, 3 Nov 2021 14:09:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RESEND PATCH 2/5] drm: Move nomodeset kernel parameter handler
 to the DRM subsystem
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20211103122809.1040754-1-javierm@redhat.com>
 <20211103122809.1040754-3-javierm@redhat.com> <87tugtbdob.fsf@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87tugtbdob.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jani,

On 11/3/21 13:56, Jani Nikula wrote:

[snip]

>>  
>> +obj-y += drm_nomodeset.o
> 
> This is a subtle functional change. With this, you'll always have
> __setup("nomodeset", text_mode) builtin and the parameter available. And
> using nomodeset will print out the pr_warn() splat from text_mode(). But
> removing nomodeset will have no impact if CONFIG_VGA_CONSOLE=n as that
> leads to vgacon_text_force() always returning false.
>

Yes, that's what I decided at the end to make it unconditional. That
way the same behaviour is preserved (even when only DRM drivers are
using the exported symbol).
 
> To not make functional changes, this should be:
> 
> obj-$(CONFIG_VGA_CONSOLE) += drm_nomodeset.o
>

Right, that should work.

> Now, going with the cleanup in this series, maybe we should make the
> functional change, and break the connection to CONFIG_VGA_CONSOLE
> altogether, also in the header?
> 
> (Maybe we'll also need a proxy drm kconfig option to only have
> drm_modeset.o builtin when CONFIG_DRM != n.)
>

See my other email. I believe the issue is drivers/gpu/drm always
being included even when CONFIG_DRM is not set.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

