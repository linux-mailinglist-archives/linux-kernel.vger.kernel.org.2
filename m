Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E198038C48B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhEUKZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhEUKZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621592657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQf/Hh2l4u5gnRu5DSKsYeaXSP/3LChq3DuXAPax/WQ=;
        b=e24ZireIHFg8XW1RvdIcI4xkUnadGbp6HZs7MS0nn22twLQO3Ol3lY3eVG2UXYuZ18bVki
        Qr9kGigPG1iuXmipBE0kAjmma67mXXoVNg4j5b7HuRT+kgf2iaF2ta5fkLAl5uo0pf+1ad
        0kwxGLZOao5EzJ8qYcvV9M+jkAFlytA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-M0axtZ1KPYmMavjWiIwUAg-1; Fri, 21 May 2021 06:24:15 -0400
X-MC-Unique: M0axtZ1KPYmMavjWiIwUAg-1
Received: by mail-ed1-f70.google.com with SMTP id y17-20020a0564023591b02903886c26ada4so11113686edc.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 03:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQf/Hh2l4u5gnRu5DSKsYeaXSP/3LChq3DuXAPax/WQ=;
        b=Vg+q/EzYaqBYBKwOv3N2JlFOX0uWmLzLwqiDhNTHVVnh9idM93yRyR5fauhywZwWk/
         63pk1UAEfzD6ejsIyFPH9njGvFwhSPGjEI+yb5BBgfXWuFHq/Z/ekK120nLnP1NVeq2e
         AT61dZ/wnMOwlnMDuoS5F41oQYDbLjgKWBhAsfduoTMUZi5lcLNGDHAZPf74ABLkti0p
         MHkcYtTxIxg/0kBNOM1WMAkv9VQHwuLbxuAIXyY1/kzNZj5klK13+gl0Ezz+LUp2UKzZ
         DFYSmHM4fZ4Mb0d6QLvECbMuOTCJ5ktjE6zWCQzRKGyUpwjh4975d9AhbNOPJTed3v3w
         gLgg==
X-Gm-Message-State: AOAM532P5i1C6/OmgK5P9APc5w8ysz3LQPnpQ3UlU+B61+LWYGchuKAw
        eA565CIKNZoNQZsWFpVx0QRi6FzzwNCiqYhhUAvJMN5y0cieJ7Ku+0hNBZDDYfah2GolpOIDmaJ
        4zkL1CRSYOhl7JcY6dBqFmb/Fpz69eylOkpCumApVuHXY8nF1WTjqe8gCtEY2huoWTOBAb0Jn/s
        to
X-Received: by 2002:a50:fe8c:: with SMTP id d12mr10444301edt.336.1621592654300;
        Fri, 21 May 2021 03:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbNzpuYFAHecQ+LXIx6j20OJOBqJXyR+Z5LZNynWWpMjm/IYwUm8EET6Q8qgoiCvrvsN7N/A==
X-Received: by 2002:a50:fe8c:: with SMTP id d12mr10444283edt.336.1621592654118;
        Fri, 21 May 2021 03:24:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t19sm3779587eds.4.2021.05.21.03.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 03:24:13 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove GA14/15 quirks to acpi/video_detect
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210419074915.393433-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3559f449-7d43-bf6f-0047-3138fd303db8@redhat.com>
Date:   Fri, 21 May 2021 12:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210419074915.393433-1-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 4/19/21 9:49 AM, Luke D. Jones wrote:
> Revert two commits to allow a patch to acpi/video_detect to correctly
> set the backlight control as native.
> 
> Luke D. Jones (2):
>   Revert "platform/x86: asus-nb-wmi: Drop duplicate DMI quirk
>     structures"
>   Revert "platform/x86: asus-nb-wmi: add support for ASUS ROG Zephyrus
>     G14 and G15"

Thank you, since the matching drivers/acpi/video_detect.c have been merged
by Rafael, I've added these to my review-hans branch now.

But there is one problem, these miss a:

Signed-off-by: Luke D. Jones <luke@ljones.dev>

In their commit message, I assume this was an oversight, so I've added
this. If you can let me know if this is ok, then I can push these to
for-next.

I've also rewritten the commit messages to explain why things are being
reverted, see:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Regards,

Hans

