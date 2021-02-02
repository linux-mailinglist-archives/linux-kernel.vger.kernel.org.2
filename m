Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55CD30C94D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhBBSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233699AbhBBOGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612274719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LXlNwCxVBCnWTgIRZ67SF78i3D9tADdgI1TeYfcOFjI=;
        b=VLZRoVsolK/2n1dXJBvWfVCkC4+UjKsPhbQn8wMS9c8yHxdZTfdZji7B+oxQBXx1Ah9s0O
        cLumvxm45Yn/s7u7e+6oKGyxkEFImR01omu9UB3lsluQtdGZCvGg9lrSjJeVe9WbOWdYYi
        OfkPmJNUkR7qQDaRv8/lCriyP1jWIQ8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-TPezbrMXP72866FPkGrBYw-1; Tue, 02 Feb 2021 09:05:17 -0500
X-MC-Unique: TPezbrMXP72866FPkGrBYw-1
Received: by mail-ed1-f72.google.com with SMTP id u19so9596609edr.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 06:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXlNwCxVBCnWTgIRZ67SF78i3D9tADdgI1TeYfcOFjI=;
        b=DiEe3QvHRiLLhWtwGZ3lGBTTes/pAd6mFbALQz+B5Dlm5vdbr0Mw/vTKapQAlfwE6u
         75VlrVm/zSCAysJbyWRLo7dP9veJKbI9HjKJU8+t94WYnMAMZJfBFwQcHaKa4s92Huff
         h7jhvYZ8YOvsTogUqxJ10YC/5ZXfdvClVL01sfXvxkTvjZlq9k9cRU4LYX2zl7RoY9Bq
         fxycTe2r147P5BO1CyGWWd7s88sRCIl3oKrlkaXo/eO8ef5RahRrZ7tSO3D8WlV4vs01
         72VpywHm8dFcT7q1+FqeZyoOwJl/z5ToL+Xc9EqSODpgCnjK28HVu4uovUb6Iq6FL36+
         f6UQ==
X-Gm-Message-State: AOAM531KP7yxx29e9dUg/XAr8RTrk3rXQ4X8YsXnjh++Zz4J/ojO7ZWl
        5LRvmNCVBi0yOh+tPhq/OJ0PS8P7J9cC4CGyVk/me80OWI2Gd4XnBYzugcSIpyspv0wnWmZQAnF
        wP41NZovFiM21jwVczMBHe8BmqAwhvoqKDr2KYhb6y+7g7UAWFMdVz3OUes6G/5+Nkyto3w1nf6
        4T
X-Received: by 2002:a17:906:780c:: with SMTP id u12mr22282925ejm.125.1612274716018;
        Tue, 02 Feb 2021 06:05:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQ/DyaGLIBeJhjBFt5cegtfQ7kGKj1VDMfIj8k1n8QaRu28f438c65QA8HfxsXqI6Pm6fGcw==
X-Received: by 2002:a17:906:780c:: with SMTP id u12mr22282903ejm.125.1612274715788;
        Tue, 02 Feb 2021 06:05:15 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id ec18sm9321262ejb.24.2021.02.02.06.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:05:15 -0800 (PST)
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: rectify length of title
 underline
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nitin Joshi <njoshi1@lenovo.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210129040849.26740-1-lukas.bulwahn@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3b91a535-b818-09be-456b-c728838612dc@redhat.com>
Date:   Tue, 2 Feb 2021 15:05:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129040849.26740-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/29/21 5:08 AM, Lukas Bulwahn wrote:
> Commit d7cbe2773aed ("platform/x86: thinkpad_acpi: set keyboard language")
> adds information on keyboard setting to the thinkpad documentation, but
> made the subsection title underline too short.
> 
> Hence, make htmldocs warns:
> 
>   Documentation/admin-guide/laptops/thinkpad-acpi.rst:1472: \
>     WARNING: Title underline too short.
> 
> Rectify length of subsection title underline.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
> applies cleanly on next-20210128
> 
> Nitin, please ack.
> 
> Hans, please pick this minor fixup for your platform/x86 -next tree.
> 
>  Documentation/admin-guide/laptops/thinkpad-acpi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> index b1188f05a99a..0e4c5bb7fb70 100644
> --- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> +++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
> @@ -1469,7 +1469,7 @@ Sysfs notes
>  
>  
>  Setting keyboard language
> --------------------
> +-------------------------
>  
>  sysfs: keyboard_lang
>  
> 

