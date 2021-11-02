Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC07442BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKBKaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhKBKax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635848898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KIXqG/+aRX3VfX0pbGv7+LnUyCe/jR+SgkDGe77Qco=;
        b=RcB6/AoP5ufEJM4FMgOedu2rd1TVAgl/LyZCmM6jHk4M7YtEbo/Jh1A0qZ6J/JassYC2DR
        2UeFSsL54MV3KGhPwWoL2yzzEs0Ibx/1sCYT2hV5cv5/Y//nBDQdDGhxfyO+PTQC9pPUWZ
        ELUTgDSnXBNUoQ3KXeNNVbCpqCxVqQQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-b9DxUo5bPfOgwyNflbPw9A-1; Tue, 02 Nov 2021 06:28:17 -0400
X-MC-Unique: b9DxUo5bPfOgwyNflbPw9A-1
Received: by mail-ed1-f70.google.com with SMTP id s18-20020a056402521200b003dd5902f4f3so18315754edd.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 03:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/KIXqG/+aRX3VfX0pbGv7+LnUyCe/jR+SgkDGe77Qco=;
        b=v23LyjQeOryol8M4OC6XklT8lEUViqh794OJJxAf4UGa7gtjmFoBu4FOxbaLOjN3RK
         hP99rPFe4BXS7ne2jKg9kXEa3JOKT42s2mCIg5mA3uNP/eK5df8M1xEpwi4xiEnDNZ63
         b1Pi6xjY8lYDGoaVeqWTwLLE76lLuyTvPBwGj6V+IXulAb/2zBomtgGUW7rn2qg5bxA1
         3/k7ED4i4hvkxAkuvjpR3EzjZN8iC/cyaT3JXv3Yi+Dcnh0/gCMAHUHPxeqZZibbPW+N
         eXMPhdFytfqHElKoxHRjDR1Nr+Ny3/zzDuUsSuHmnhRS4f65pl1/+NPOf/yx8NKu/PJd
         uI/A==
X-Gm-Message-State: AOAM533r5cKnyPP21qPtvJ0eSZULsCjj5WEMgI7vV6qdXanlEc0YT8Wm
        E/FHusvE2MqP8qNxbTaloEn0rLGHyuImH/F6uPZvuo/IRDtjySkxbTE5NoYVIDcIDq1SK0kDlUh
        XVUxVlHjESXjLvnG8GPs6Chdj
X-Received: by 2002:a05:6402:40cf:: with SMTP id z15mr48998770edb.138.1635848896645;
        Tue, 02 Nov 2021 03:28:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygd/kOa0LmQJO7gJ7dW3kSjTVBWPteQe1G8nO+W/t28YcbO7eaHan+3AORZNhaEB+zJqth9A==
X-Received: by 2002:a05:6402:40cf:: with SMTP id z15mr48998748edb.138.1635848896467;
        Tue, 02 Nov 2021 03:28:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id rl1sm577976ejb.90.2021.11.02.03.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 03:28:16 -0700 (PDT)
Message-ID: <f16d7cb4-7ac9-382e-ea9b-45433f5b8299@redhat.com>
Date:   Tue, 2 Nov 2021 11:28:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: linux-next: Fixes tag needs some work in the drivers-x86 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>
Cc:     Tim Crawford <tcrawford@system76.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211102083724.5e6c8d68@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211102083724.5e6c8d68@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 11/1/21 22:37, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   7885061a10f4 ("platform/x86: system76_acpi: Fix input device error handling")
> 
> Fixes tag
> 
>   Fixes: 0de30fc684b ("platform/x86: system76_acpi: Replace Fn+F2 function for OLED models")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
> 
> Also, please keep all the commit tags together at the end of the commit
> message.

Thank you for reporting this, I've fixed up both issues and done
a forced-push of my for-next branch.

Regards,

Hans

