Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956D93E425A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhHIJTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234186AbhHIJTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628500721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAFeJp1HT6+s+364cYIIHh/YF/jbHLGKQX4nxR3WHeg=;
        b=TEvlyMhNYlVza7XIpFry9ZJk7oCtSGFJ0ICoIw3kl9w0lRoM7Jfokcf8F5jh9JejbdcDcQ
        xpIW/ltYeEChe2Kx/nBdz+pbWAo0RCGmKiMOC6ejoMp4Jtj84yPYzSnB+PKDMmtIK4wUM2
        O+0EkhYckRS61xfCEXp74oLmSrJXRls=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-0H8w_ScgMXihokibNSC-3Q-1; Mon, 09 Aug 2021 05:18:40 -0400
X-MC-Unique: 0H8w_ScgMXihokibNSC-3Q-1
Received: by mail-ed1-f70.google.com with SMTP id y39-20020a50bb2a0000b02903bc05daccbaso8579676ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 02:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RAFeJp1HT6+s+364cYIIHh/YF/jbHLGKQX4nxR3WHeg=;
        b=Mi6gpjOnngRTd1Rw2uriiyKx4yuSLdC5D1BFs4Bsv+DOtiXozlFceYrHo7uR9PLHiO
         GqNu2zIzUN5WMqDX1yToiZQA7w6zwuDjfZNI1QFJ6Ms7PvuN3UWu9L/WMgbLY0xTZQlN
         v+3HJ3p2RZQNFESBcfaQha1lR4RzNC81GPg22tQgWsIzkCvC5GCjG9Yy5tmQfzxHBQhZ
         DfYJbIJEONCohW4/q0xAPFIObNzV8B6ZXmK6ip/br0x/2mnwZVi1yAln0V7bE2efkhEA
         Rt+IgvDrN4nzb4BrXy4/s/aRuu3uit+Al8/oo8ZkXwxc/rDndvN6SzBiHE0tFrcKNf9c
         OK3Q==
X-Gm-Message-State: AOAM533YxJHUsuOAi0xnN+vtBw5C1zpq9lAsVnz9ZQiQ2jplMHlh5d7R
        sAZ6q4S/LOQF9Gbr4hHJ4H0Fu3C4LpLVj/NKG28XHve4gvMDyyEB/Wx4yYN+5taQRECoKxgt4G8
        Fdi/T+W0XrrUfte8ltbnRsHYP
X-Received: by 2002:a17:907:1b29:: with SMTP id mp41mr21797302ejc.459.1628500718983;
        Mon, 09 Aug 2021 02:18:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLwJD2YGXef8GN40w03iNe9nvMyBlrPLmp4Ks2TsdER9vHsf02MrR8UmHC5Imv19I4Q+hAVg==
X-Received: by 2002:a17:907:1b29:: with SMTP id mp41mr21797296ejc.459.1628500718801;
        Mon, 09 Aug 2021 02:18:38 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id b25sm7934261edv.9.2021.08.09.02.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 02:18:38 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Support for ASUS egpu, dpgu disable, panel
 overdrive
To:     "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     mgross@linux.intel.com, pobrn@protonmail.com,
        corentin.chary@gmail.com
References: <20210807023656.25020-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aec7b518-0979-7b7e-f776-a2ebb0fc19fc@redhat.com>
Date:   Mon, 9 Aug 2021 11:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807023656.25020-1-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 8/7/21 4:36 AM, Luke D. Jones wrote:
> This patch series adds support for some functions that are found on newer
> ASUS gaming laptops:
> 
> - Panel overdrive: Some laptops can drive the LCD matrix slightly faster
>   to eliminate or reduce ghosting artifacts
> 
> - dGPU disable: ASUS added a function in ACPI to disable or enable the dGPU
>   which removes it from the PCI bus. Presumably this was to help prevent
>   Windows apps from using the dGPU when the user didn't want them to but
>   because of how it works it also means that when rebooted to Linux the dGPU
>   no-longer exits. This patch enables a user to echo 0/1 to a WMI path to
>   re-enable it (or disable, but the drivers *must* be unloaded first).
> 
> - eGPU enable: The ASUS x-flow lpatop has an iGPU, a dGPU, and an optional
>   eGPU. This patch enables the user to echo 0/1 to a WMI path to enable or
>   disable the eGPU. In ACPI this also appears to remove the dGPU from the
>   PCI bus.
> 
> All of the above patches have been tested over the course of a few months.
> There is a small possibility of user error perhaps, where the user tries to
> enable or disable the dGPU/eGPU while drivers are loaded which would cause
> a system hang, but it is expected that almost all users would be using the
> `asusctl` daemon and dbus methods to manage the above which then eliminates
> these issues.

Thank you for the new version, all 3 patches look good to me, but I miss
a changelog in this cover-letter.

Specifically I'm wondering what happened to the following,
which you wrote about in the v1 patch-set thread:

"""
Proper enable of the dGPU again as far as my testing goes works such that:
1. call the ACPI method
2. rescan PCI bus to ensure the device is powered
3. call the ACPI method again to save the setting

But it appears that recent work in-kernel for many things AMD related has broken this for us...
"""

?

Regards,

Hans



> 
> Luke D. Jones (3):
>   asus-wmi: Add panel overdrive functionality
>   asus-wmi: Add dgpu disable method
>   asus-wmi: Add egpu enable method
> 
>  drivers/platform/x86/asus-wmi.c            | 289 +++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |   7 +
>  2 files changed, 296 insertions(+)
> 
> --
> 2.31.1
> 

