Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD023F8876
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbhHZNOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242457AbhHZNOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629983615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RPnshDEQ3mW6HcBjYV6tIMWhsB6P2M9YaadavMQia0=;
        b=GasQLc3MzXPCUp/UEGMjZF58gtLMZ/bKgjNopKv+mdj84q0R++1A22nwyBlnYDfDwqmsHr
        5Yxeh8ZRHNRieIbvORvaT25xp2jhlA+tbt/nxkbfdTi/F7uPFIkwdMXdgilYEYw/UbUTKt
        G4vVYB2FJ/9syyQanZ3lpipVvdc21xg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-WI1dcZlJPJmJPDdgXpd_Jw-1; Thu, 26 Aug 2021 09:13:34 -0400
X-MC-Unique: WI1dcZlJPJmJPDdgXpd_Jw-1
Received: by mail-ed1-f70.google.com with SMTP id v13-20020a056402174d00b003c25d6b2f13so1507060edx.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8RPnshDEQ3mW6HcBjYV6tIMWhsB6P2M9YaadavMQia0=;
        b=jiezJFse8FcgKP9ZX9qCjmTkHARZZ6Oajyz6I5G5JHRTRjiyITdy9m47VYWuCDvCou
         E4bYMcZNiCKdobPsUEf6DyKhhUVFRbP+e1jmpZIbvBfG+Xs/bZhohD7igAFX/XPEPVz+
         qE4yiXkgnBwVEdjyc59Yu1eTgItLHfvdyrZ8Io6FDEhVEHMBoWxwq/hoydPtr/+e8OF8
         YMBcQpQmSoIYF/PdoqVdpeydPAE2xu60XjgPzL+Z+dKm6aYFORmAgYOl4n7b/VLgIluU
         b+ThiwSkE7dMSkKMOyT3ZLrK1kqPnU2S5QVobXqHDlEnImW4gzUDBwLDt2iQ/pvzWHMq
         RD8g==
X-Gm-Message-State: AOAM533pyMW3E/r5P1zc6qHInM78DTOz0i4B3pfFbEbD68zvErmtLiwB
        7rx1Ip1CrL0qQ5NRRjEhkUlket0YH3FyN2l2IC0gZbHdFP1SjMIv2+fWxvBE6K5N0SRln2fTiAc
        wzau0jm3mYeMrrcQH0uiWwlEJ
X-Received: by 2002:a17:906:9a04:: with SMTP id ai4mr4359106ejc.453.1629983612907;
        Thu, 26 Aug 2021 06:13:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHtHoZUIPL2TeOuH0U4DCMPSC7TYCviF7IQchIv+kccoowEOZSeAcqycZhZIO9zVJ6uAI59Q==
X-Received: by 2002:a17:906:9a04:: with SMTP id ai4mr4359085ejc.453.1629983612762;
        Thu, 26 Aug 2021 06:13:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y32sm1890655ede.22.2021.08.26.06.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 06:13:31 -0700 (PDT)
Subject: Re: [RFT, PATCH v2 0/2] platform/x86: hp_accel: Clean up and convert
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>
References: <20210823093222.19544-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2da3faa8-b642-bb58-32f4-6aea8bbfd291@redhat.com>
Date:   Thu, 26 Aug 2021 15:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823093222.19544-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/23/21 11:32 AM, Andy Shevchenko wrote:
> The pure ACPI drivers are not needed since we have a platform glue layer in
> place. This allow to drop a lot of boiler plate code and duplication.
> 
> Patch 1 remove confusing call to _INI method and citing myself from v1:
>   "Not sure what buys us to run _INI on PM calls. It's against the spec
>    AFAICT. In any case ACPICA runs _INI as per specification when devices are
>    instantiated."
> 
> Patch 2 converts to platform driver.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

