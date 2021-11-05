Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC384461CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhKEKBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232955AbhKEKBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636106340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAYCTLIu4BclXd+cEViyuoXMMG/fW8iPDkQUaON6iK4=;
        b=CqULCLW89Y0wGu31R3NUuP46hlTKi/ghcATCHNKGuooAnf92HOGa8RXgcCxZ7jMVY7MDMR
        sNt21nF/zwsGfTM6PA4W+NdhHnmvNHRXR1BAkrCY50jmLQnDewAPk9nPFk95630/4EDhy+
        Zs8nlZ3hvna5oSB9/r6GShAM+II7NZU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-7578yrBzNcSfM7ZRhBZXQg-1; Fri, 05 Nov 2021 05:58:58 -0400
X-MC-Unique: 7578yrBzNcSfM7ZRhBZXQg-1
Received: by mail-wr1-f72.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso2149127wrc.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 02:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PAYCTLIu4BclXd+cEViyuoXMMG/fW8iPDkQUaON6iK4=;
        b=UVoWtaXQhpRKpqJCX2NRz2MDHc8RheelZO8u/rcPkfPcFUSnyoglSkE5u/1z5//QMF
         z8a7Rsb13aAeb4DSUmhmpy7a24hMf9OY10fSQOZVR9xcytETtH0mRtAbNKuH2fGbb7cf
         CkOp7fHTxJJ1OFRCs99VBqNgyLBg5hi2xpQs2Pgu3neElX555Avkdr8G4X9oZgxxBw1a
         +ACLSLXrRA//mM5r52wATnstHWLPTieKHwbJ5IEdn+dCng19He/TBcJRegAIoLMnf+70
         eK5iCkpWKwwkpPxSGKIyoeQcO2DHzM0rpiNwgTY+r18SL23MD4uhVXKs3p8DqABnsKFH
         Bduw==
X-Gm-Message-State: AOAM532bjmiGA4Y6yGrszKnyCKHh6VNzqf0hdwMAHSGhYc0RvrNIGPi3
        03gv/qAxn3/jC9QnnDIXQwSH6fzenGJVSq7GBfZFdAP02CJu3XpVjkQmCniad13asSf9OXyd6sB
        DDL+XGyRJ3QRRdd32tFIJTTnH
X-Received: by 2002:adf:ec90:: with SMTP id z16mr46047438wrn.247.1636106336897;
        Fri, 05 Nov 2021 02:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVMn64qcflGLedLN5EhsNM7GWU6o/3vwDL3aOoAYuCZV9//84CDnDeN1gsW9919fwpqQaOmg==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr46047414wrn.247.1636106336738;
        Fri, 05 Nov 2021 02:58:56 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id c17sm7678095wmk.23.2021.11.05.02.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 02:58:56 -0700 (PDT)
Message-ID: <87a6bb4a-01ef-4979-f5c2-c0bb0d0a29f9@redhat.com>
Date:   Fri, 5 Nov 2021 10:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] drm: Move nomodeset kernel parameter to the DRM
 subsystem
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
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
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-3-javierm@redhat.com>
 <f2c40b22-04bf-e8f2-9839-36d6d26189a1@suse.de> <87cznf9cty.fsf@intel.com>
 <2698c680-6d05-f58d-d7c2-ea76aeb0bb47@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <2698c680-6d05-f58d-d7c2-ea76aeb0bb47@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 10:39, Thomas Zimmermann wrote:

[snip]

>>>>    
>>>> +obj-$(CONFIG_VGA_CONSOLE) += drm_nomodeset.o
>>>> +
>>>
>>> This now depends on the VGA textmode console. Even if you have no VGA
>>> console, you'd want drm_nomodeset.o. Simpledrm might be built-in and can
>>> provide graphics. Non-PC systems don't even have a VGA device.
>>
>> This was discussed in an earlier version, which had this builtin but the
>> header still had a stub for CONFIG_VGA_CONSOLE=n.
>>
>>> I think we really want a separate boolean config option that gets
>>> selected by CONFIG_DRM.
>>
>> Perhaps that should be a separate change on top.
> 
> Sure, make it a separate patch.
>

Agreed. I was planning to do it as a follow-up as well and drop the
#ifdef CONFIG_VGA_CONSOLE guard in the header.
 
> We want to make this work on ARM systems. I even have a request to 
> replace offb on Power architecture by simpledrm. So the final config has 
> to be system agnostic.
>

Same, since we want to drop the fbdev drivers in Fedora, for all arches.
 
> Best regards
> Thomas
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

