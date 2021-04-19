Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B069363D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhDSIBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhDSIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618819239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/CsA/+8HH9a7KCUXcVEK/cZvS2NUuqovpCA8jFjYW4=;
        b=DL6gStI9brrBX77X9tGxFSi4mJOhU/i6n544crO7FaYoMb3tjYJMuuOpojd3DcLuS5Gwls
        TmAa+5fo/xj/fqmGJ/uTrL72oDqqz8/RZhhXpB7I8o4IFfwdNQrQDBBZJpt+jeYNz89aXf
        bMeB3Zu3JtxNhqyF3CToaRcNHIdpfkg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-6H66ahvqMp-GnV5fapr3Jw-1; Mon, 19 Apr 2021 04:00:37 -0400
X-MC-Unique: 6H66ahvqMp-GnV5fapr3Jw-1
Received: by mail-ed1-f72.google.com with SMTP id d2-20020aa7d6820000b0290384ee872881so6666645edr.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e/CsA/+8HH9a7KCUXcVEK/cZvS2NUuqovpCA8jFjYW4=;
        b=KT4wau/kf/zjv2wbnUYsKHsdrF/K1hWpocAGyEmYGYuAIZy0uwBJkM+YIJD8m0zbQM
         2OXAsvYK65vzY/EG0DrvDtk+O/wiWyDGLD0qX24/UwOAW2PRGioaaXq3wnpD8XRaj9YC
         d9g6Z2QQzdT/MOa4pgF/DzWlyfWdTMyPXYsm3wcCcoyiZd5g+JvU3diuB0JeuVZLFj/2
         kQ94+fwj5WMWXvPC//rdpsEEkmIXTVWgqGDi1/k/naiyBkPkDroeFGQDDkrL870nkEr4
         jyrnlD6bhRvQAQWmlt2AaAI9sPkvwwCDXcOD3yZ0OIcH63K4AJzl/W3viUqPclumJul0
         foTg==
X-Gm-Message-State: AOAM531ff+4iiFGz9Gf28K/PwY8eIJKXLxmURCOSCpJOOkeFycjH6RQv
        MPhIL2MmG4pqxeUM1AgpHgHAf6SMo5d148rjzOvDzU567BaMCK1D7TC8YdU1HLN81juwbfCYxE0
        PPKFZLRj4nIUNMO5XOzxWjgE4+VLs3Ys6pVSb5S/NpkLh0CQWFh4YQOoVN52VLCGjuTqbjHC42U
        TI
X-Received: by 2002:a17:906:c35a:: with SMTP id ci26mr21751026ejb.79.1618819236266;
        Mon, 19 Apr 2021 01:00:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwDHXTyaW0U8o9dflqoMzqPnHaf94uYCIYvb25tL2sQ6MGRgROe65/tTzUJa61hUgRQqzgBA==
X-Received: by 2002:a17:906:c35a:: with SMTP id ci26mr21751012ejb.79.1618819236144;
        Mon, 19 Apr 2021 01:00:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z17sm712608ejc.69.2021.04.19.01.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 01:00:35 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove GA14/15 quirks to acpi/video_detect
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210419074915.393433-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c16dcaa8-83a3-2027-6335-52689eee5622@redhat.com>
Date:   Mon, 19 Apr 2021 10:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
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

Thank you for following up on our previous discussion about this.

I'll merge this as soon as Rafael has accepted to matching
drivers/acpi/video_detect.c patch.

Regards,

Hans


> Luke D. Jones (2):
>   Revert "platform/x86: asus-nb-wmi: Drop duplicate DMI quirk
>     structures"
>   Revert "platform/x86: asus-nb-wmi: add support for ASUS ROG Zephyrus
>     G14 and G15"
> 
>  drivers/platform/x86/asus-nb-wmi.c | 77 ------------------------------
>  1 file changed, 77 deletions(-)
> 
> --
> 2.31.1
> 

