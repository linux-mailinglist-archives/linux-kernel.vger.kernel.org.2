Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE8438BD1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 22:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhJXUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 16:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231394AbhJXUfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 16:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635107560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=foPZLVboh7onbXg8RJt10aqr10vmq7ONgcIyRXku74s=;
        b=UobQe2sqgQJSRKt+33qT03PenqRaHFCx/uCIeqON1y1spZfL5p6zZtf8baTqbvrqa/WhBU
        RIBIijqaeEzZQv5NnPNsopBR55x32ShGp7WRvW4n3sH/nlX8u6acuh/lSN+pupuvEd1sIZ
        x9bGAW3UuLIDH5tirnr/UYN0mDnjg/U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-hmEPZYRgNeK8ALP5ajQVxA-1; Sun, 24 Oct 2021 16:32:38 -0400
X-MC-Unique: hmEPZYRgNeK8ALP5ajQVxA-1
Received: by mail-wr1-f69.google.com with SMTP id f1-20020a5d64c1000000b001611832aefeso2418908wri.17
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 13:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=foPZLVboh7onbXg8RJt10aqr10vmq7ONgcIyRXku74s=;
        b=rIVt9HNyeVVn0i9LpLwnUX5s+GN8o/CxAwlKYQqncUdqM7Xbk0WFMk72dYkHgUh5QK
         PhiKm8xYwE4GWxj+5BrYF35RGvouTN3m4YA/SBCphGen1jWRiBoKpT04FcyQCw/I4D7Z
         dCOrkHe6pdpl5JQVDec5e4uH2bu5rO7pEnDE99qzd9DhsyhJR4iN9iYbFmGXWcqg5TgO
         NZ0Ln7s4MancV0I6FgEMRcHD94mrfTwhiKvyrompooDeUCWfMFQ5VqzsVO+b0rqqNFwg
         GNAH9FlDWSpCW+5gH95L76Bz83nEAueyR+xFZszdDl0NX0P2jo1OlmrVhiQhJOkp2/7u
         qBEQ==
X-Gm-Message-State: AOAM533t70XmL+jCdXsmWe14o4XaY1Atc0j9LEXya6TM8KG7GQqOzHU6
        d+TdXR+D4sZUjjX2vPzj8jW6glSSLFL3JGSj40sEcxEpXNLVcg2PEfg75+vdf5PEetXGlAkdQxe
        hxHNDJFGO/YOYcUcIdW26nBOu
X-Received: by 2002:a05:600c:a43:: with SMTP id c3mr43191917wmq.193.1635107557478;
        Sun, 24 Oct 2021 13:32:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTb7WRG4PUnpVolCGCFaAjk037qGckuhGFDnVdfuykBRH4F+Vw25gbwIjHO7F2pE4LEgFYBA==
X-Received: by 2002:a05:600c:a43:: with SMTP id c3mr43191886wmq.193.1635107557159;
        Sun, 24 Oct 2021 13:32:37 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id r39sm8142731wmp.2.2021.10.24.13.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 13:32:36 -0700 (PDT)
Message-ID: <c1d1f245-7bcf-16e5-c3f4-c13550843e02@redhat.com>
Date:   Sun, 24 Oct 2021 22:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH] drm/aperture: Add param to disable conflicting
 framebuffers removal
Content-Language: en-US
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
References: <20211022144040.3418284-1-javierm@redhat.com>
 <YXMNOfBS5iFenmx8@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YXMNOfBS5iFenmx8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ville,

On 10/22/21 21:12, Ville Syrjälä wrote:
> On Fri, Oct 22, 2021 at 04:40:40PM +0200, Javier Martinez Canillas wrote:
>> The simpledrm driver allows to use the frame buffer that was set-up by the
>> firmware. This gives early video output before the platform DRM driver is
>> probed and takes over.
>>
>> But it would be useful to have a way to disable this take over by the real
>> DRM drivers. For example, there may be bugs in the DRM drivers that could
>> cause the display output to not work correctly.
>>
>> For those cases, it would be good to keep the simpledrm driver instead and
>> at least get a working display as set-up by the firmware.
>>
>> Let's add a drm.remove_fb boolean kernel command line parameter, that when
>> set to false will prevent the conflicting framebuffers to being removed.
>>
>> Since the drivers call drm_aperture_remove_conflicting_framebuffers() very
>> early in their probe callback, this will cause the drivers' probe to fail.
> 
> Why is that better than just modprobe.blacklisting those drivers?
> 

Because would allow to deny list all native (as Thomas called it) DRM drivers
and only allow the simpledrm driver to be probed. This is useful for distros,
since could add a "Basic graphics mode" to the boot menu entries, that could
boot the kernel passing a "drm.disable_native_drivers=1" cmdline option.

That way, if there's any problem with a given DRM driver, the distro may be
installed and booted using the simpledrm driver and troubleshoot why a native
DRM driver is not working. Or try updating the kernel package, etc.

Currently what most distros do is to pass "nomodeset" in this mode. But now
that we have the simpledrm driver, would be nice to just use the frame buffer
set by the system firmware in those cases.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

