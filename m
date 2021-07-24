Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7043D4571
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 08:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhGXGPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 02:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234060AbhGXGPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 02:15:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF70360EB0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 06:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627109748;
        bh=B80hoZZe2OO2rx4q7PEXznNCfVJkARWnoc3HG9wphzQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TPKBM4kCRjp6Dl8ERLme76Rqlot6iiRhwW3z4TPWOVwJ2+9Fs7xi3Zn1wR65TDQzs
         +ShXgwh64Rr4gLPIR4VuUZkIz0OY9RiIfMRMXzp7UfbQ4TYAxMB/6h+FkH5YixH7Mt
         lrpas+gEwhRV+I2mWemvQGFGlFEwDMXGatnDxi6EAfXWE4PiZJCSn0skFbJHbX35Xl
         /gaXVW99pnGOl9cTVxwf+iOWbIy6bs8vzvD3ASuwS+WbTB4SaclRIJXThFKv8svHYe
         6WcRzdgCguxxYdkGK98bznKXi0tNj6T25JyB7YFOlFtiVg89XECJFR7br5nvLe+etP
         MBb+1mV8DeOnQ==
Received: by mail-wm1-f48.google.com with SMTP id j34-20020a05600c1c22b029024e75084404so1938214wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 23:55:48 -0700 (PDT)
X-Gm-Message-State: AOAM533OqaQJUq4+hdtDODUPyl96AgRBpxIWN+ApOFjOHFl7XWLDuP4O
        lB/oR/YWLhm44Sq4g+xFW2A12gnfWRNUqDYsO1w=
X-Google-Smtp-Source: ABdhPJyR72GsEjxAav2mThfrkDdq7Q7rsOokZHAxvRhxua1hNtotzPz//554fpJOxQYtC+mHVkp1i/zd0EA29NRxVbU=
X-Received: by 2002:a7b:c385:: with SMTP id s5mr7491845wmj.43.1627109747390;
 Fri, 23 Jul 2021 23:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210723224617.3088886-1-kherbst@redhat.com>
In-Reply-To: <20210723224617.3088886-1-kherbst@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 24 Jul 2021 08:55:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3u_jsxQW4dPXtsdKkw1mjKXL-h=qN1SGHytvUMPf3fPw@mail.gmail.com>
Message-ID: <CAK8P3a3u_jsxQW4dPXtsdKkw1mjKXL-h=qN1SGHytvUMPf3fPw@mail.gmail.com>
Subject: Re: [PATCH] nouveau: make backlight support non optional
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 12:47 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> In the past this only led to compilation issues. Also the small amount of
> extra .text shouldn't really matter compared to the entire nouveau driver
> anyway.
>

>         select DRM_TTM_HELPER
> -       select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
> -       select ACPI_VIDEO if ACPI && X86 && BACKLIGHT_CLASS_DEVICE && INPUT
> +       select BACKLIGHT_CLASS_DEVICE
> +       select ACPI_VIDEO if ACPI && X86 && INPUT
>         select X86_PLATFORM_DEVICES if ACPI && X86
>         select ACPI_WMI if ACPI && X86

I think the logic needs to be the reverse: instead of 'select
BACKLIGHT_CLASS_DEVICE',
this should be 'depends on BACKLIGHT_CLASS_DEVICE', and the same for ACPI_VIDEO.

We may want to add 'default DRM || FB' to BACKLIGHT_CLASS_DEVICE in the
process so we don't lose it for users doing 'make oldconfig' or 'make defconfig'

The rest of the patch looks good to me.

       Arnd
