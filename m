Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B9388EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353561AbhESNOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346621AbhESNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621429966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KazyqUhhV5jT22wuz5v/t4HTJczq9uF4wLpdlfh1A2s=;
        b=Gez2uf8umVJ1AIixGhFpbDc1xlfdEUoQXXYFKVvNS0e8KP9cW2bqq614jaqlJCijvPXK+g
        5DAIZmXruQv4ePfVsH1XyJYITXk/cU7UM4kPvFpHs7DUDsImrtaTTwBOWDllQ/f7y8E5be
        MLnD0Xx6jqIdhld2X1KmQ+1Ax4Lueo4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-4Z9pHrzWOOG7GnTR1Gfb9A-1; Wed, 19 May 2021 09:12:43 -0400
X-MC-Unique: 4Z9pHrzWOOG7GnTR1Gfb9A-1
Received: by mail-ej1-f72.google.com with SMTP id w13-20020a170906384db02903d9ad6b26d8so1803354ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KazyqUhhV5jT22wuz5v/t4HTJczq9uF4wLpdlfh1A2s=;
        b=UwLY+mX0oR3Cp+ZXDlZt1thkSG0bLFdYL7qfRLSjhTh+DNgu2lK5qxfak5ubBkSGTr
         dPOTucddrFUMgB13iBb7bOQ1qKuR+DBXOBu9ZjxXUGAhLX/jYjUZz2RU5Q+1dVn7CJOT
         9SEZ3A6unK5dWH+OSKuB+Z8Uj4LhmMPxVMSHMVLNPvFJUrXC5T2XuZFAHTrPbl/LGeJ4
         pWLX/ZMM27RfSwdTWuGQpClJzdLRasbcyHglYc9d/2p3Hqi3BrrrDAVY/nCMJalkw1rY
         aUY4YBVU+I/TRMGRjjDmz4G1pA6nliE7CJ9u6abraGgnl9ychb692h08ByZMcPkC6Qlm
         f5jw==
X-Gm-Message-State: AOAM530LW3Kr5Kvqc1U9dkB4EGj+oBI+uQWt0qVhgTvWLK7l3quB4Kll
        OYRV2pjA8eilUH9OwfMpZVRgIgH9Jam/eyGjjpDbJfEy630puP8c0qhJ55FuncXdYSiQ0/FN9M/
        tS8qH5pvhv5aKDPQoa+/eNyt2F8/KPXR2I5LYXeuvG/vMEfwnDUeYGx/b+EMfNHxfg85AthwvzC
        oZ
X-Received: by 2002:a05:6402:3446:: with SMTP id l6mr14509247edc.305.1621429962245;
        Wed, 19 May 2021 06:12:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhotFthNBjj5czxWagomPrmyGS3seaiwZPuLFxjD8ghUBX2/O/LFAhjvsT82NQjNT4RPS10Q==
X-Received: by 2002:a05:6402:3446:: with SMTP id l6mr14509231edc.305.1621429962090;
        Wed, 19 May 2021 06:12:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b15sm2306236ede.66.2021.05.19.06.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:12:41 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator: Add platform-drivers-x86
 list to MAINTAINERS entry
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210514221954.5976-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5b5cba19-984f-7f01-89f8-df61a482e5b8@redhat.com>
Date:   Wed, 19 May 2021 15:12:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514221954.5976-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/15/21 12:19 AM, Maximilian Luz wrote:
> The Surface System Aggregator Module driver entry is currently missing a
> mailing list. Surface platform drivers are discussed on the
> platform-driver-x86 list and all other Surface platform drivers have a
> reference to that list in their entries. So let's add one here as well.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will also include this in the next pdx86-fixes pull-req for 5.13.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c120f..57467b6046f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12180,6 +12180,7 @@ F:	drivers/platform/surface/surfacepro3_button.c
>  
>  MICROSOFT SURFACE SYSTEM AGGREGATOR SUBSYSTEM
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
> +L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  W:	https://github.com/linux-surface/surface-aggregator-module
>  C:	irc://chat.freenode.net/##linux-surface
> 

