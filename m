Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B4F447FE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhKHM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:57:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229966AbhKHM5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636376058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFXqlwY3MOW61Iy5t5GDa7bdxm1Y6ZhUyYK2YPVZvAI=;
        b=dVeKm75KlHxLnTLinzVqdvPsoLy0T0A8mW+8FzXTutNLnkSUjvzuM+zA6L9qO9mj9nglDH
        nIBwJ4UNaDpRfYriOoNvkhOjUwPaqbjPAJdkaryBBwUtUwRqr+Inhc7DwENsAhi7Lbbdl5
        mfIf58XZK2qaSTVQe7/7bst5vrmQLrw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-2VZflZqrPu6tG79gDEb5Gg-1; Mon, 08 Nov 2021 07:54:16 -0500
X-MC-Unique: 2VZflZqrPu6tG79gDEb5Gg-1
Received: by mail-wr1-f71.google.com with SMTP id f3-20020a5d50c3000000b00183ce1379feso4000893wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 04:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EFXqlwY3MOW61Iy5t5GDa7bdxm1Y6ZhUyYK2YPVZvAI=;
        b=2R0to3OOlWpSDfUzou60X+9cG2dog7tgPxf736czJbLmG2/T13Pa9WpxTZkacFJzo9
         nQ9cZ4DaTky1lLS2yzXvNGB5dJ1xOYhhmvJ3ZyapzPp0VSBgQqqAbu5p6sZWMTBpKtqe
         fxfYJyeEZYHit3GuU2w01WBxhqzZNsQCLRPRJusXSX550VaBK3bRJ4zQfIF5yAbcIeQl
         wdeoV3gJC6xlcajKyMdkaBk2VcYILHohcb+REnEFrKRx+aK3pfTSRfgnXW8OnBUc++N5
         /YN8hAPhIS+OgRrjXYgzblXBMYZxUkeoupgbYovooZDhhj4jawk9N+BQ7VeYTos3D2QC
         8YpQ==
X-Gm-Message-State: AOAM530CCSaGTg3BjWKndhBhiuDC0vbzt7rKd8i3mH9k7E/sRE1XWmlp
        ihO7FA7btwQ+1kzGEcxLCEO6tovV3Qmz2cfJDz0+HOgppYbltjnPboeTwnxroCYlZK/LbmWkz84
        WCaiUXOJVd3pq1WL3HEvH+ORa
X-Received: by 2002:a7b:cd03:: with SMTP id f3mr50838591wmj.16.1636376055508;
        Mon, 08 Nov 2021 04:54:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmqDlXtLEwAqWdRiXbSgRWUzhJtq4A3VbDkcMqhE2d089skY95iOLrHAVYiMf3G4b4ArNl7w==
X-Received: by 2002:a7b:cd03:: with SMTP id f3mr50838558wmj.16.1636376055266;
        Mon, 08 Nov 2021 04:54:15 -0800 (PST)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id c5sm13509067wrd.13.2021.11.08.04.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 04:54:15 -0800 (PST)
Message-ID: <7047ccc5-0927-f304-4d60-181d61344f8b@redhat.com>
Date:   Mon, 8 Nov 2021 13:54:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/6] Cleanups for the nomodeset kernel command line
 parameter logic
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        dri-devel@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>
References: <20211108121544.776590-1-javierm@redhat.com>
 <509f58a5-5276-5608-e3ba-4694956f6c50@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <509f58a5-5276-5608-e3ba-4694956f6c50@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 11/8/21 13:50, Thomas Zimmermann wrote:
> Hi
> 
> Am 08.11.21 um 13:15 schrieb Javier Martinez Canillas:
>> There is a lot of historical baggage on this parameter. It is defined in
>> the vgacon driver as nomodeset, but its set function is called text_mode()
>> and the value queried with a function named vgacon_text_force().
>>
>> All this implies that it's about forcing text mode for VGA, yet it is not
>> used in neither vgacon nor other console driver. The only users for these
>> are DRM drivers, that check for the vgacon_text_force() return value to
>> determine whether the driver should be loaded or not.
>>
>> That makes it quite confusing to read the code, because the variables and
>> function names don't reflect what they actually do and also are not in the
>> same subsystem as the drivers that make use of them.
>>
>> This patch-set attempts to cleanup the code by moving the nomodseset param
>> to the DRM subsystem and do some renaming to make their intention clearer.
>>
>> This is a v3 of the patches, that address issues pointed out by Jani Nikula
>> in v2: https://lkml.org/lkml/2021/11/4/594
>>
>> Patch #1 and #2 are just trivial cleanups.
>>
>> Patch #3 moves the nomodeset boot option to the DRM subsystem and renames
>> the variables and functions names.
>>
>> Patch #4 removes the relationship between the nomodeset parameter and the
>> CONFIG_VGA_CONSOLE Kconfig symbol.
> 
> On patches 1 to 4
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks!
 
>>
>> Patch #5 adds nomodeset to the kernel parameters documentation.
>>
>> Patch #6 improves the message when nomodeset is enabled to make it more
>> accurate and less sensational.
> 
> See my comments on these patches.
>

Yes, agreed with your feedback on these. I'll improve it when posting a v4.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

