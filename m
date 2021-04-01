Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DE23510C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 10:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhDAIVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 04:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25586 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230284AbhDAIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617265268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MM1VR6/A5jTsbab6p2eQODlayvRnz6tiru7uoQ/VlI=;
        b=C+FBlw/viuQs1/tAG+Ul/nX95YQc0DU8JnY2fY5UwMNBqbAHpLRzcSlsioWM5MJmqbtHTy
        gqhHtJFBThxPRzwNdPypUfL6XP1SZ4jm/CbFMsGC4Mi7u4jwz4F/Ke0m8ogLGL/JOsf63N
        hNmkoEgiqGo+EhV5A+wxa4fwNku25Q0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-Tvo-wod1NI6KDvFpcv18hw-1; Thu, 01 Apr 2021 04:21:07 -0400
X-MC-Unique: Tvo-wod1NI6KDvFpcv18hw-1
Received: by mail-ej1-f72.google.com with SMTP id mj6so1912736ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 01:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0MM1VR6/A5jTsbab6p2eQODlayvRnz6tiru7uoQ/VlI=;
        b=FNkCw6YxwBEI1ykKVtYHIH5lqtV1CY0o0dJ4402MOK+qnMzroBS4mjNBllDYwq72CN
         KK+y6xaZKvDGQZ+Br73Z7zs7ntNkFxy4RzDmTNxeR6+hFOeCfFiNROY7ID5idVMzcHkR
         foOYcviIvoAWD6ns+pjVYNwPgBIFzg1WM9wQIbmXiyTTeDTltSMNVIzy1abSz5XRB59D
         ekTehcKin+AoSCy+spRlUWq4fySFMNO3+yWqeu5b3zWgQ451o/uU6p8qkDsGRPDkZ7MY
         qCqZLNaAuQlCU8rkDinLSqMHzrLuFxzhIQUeg+bj8MsMoRcW6lgFiwZ0LfIp3UbW5Bos
         1QZQ==
X-Gm-Message-State: AOAM532oHOzZSgwcvYZR2aEEfX0C5gSJ+UALheCzkJDSAljjMK2gIYjs
        QbrqOam90F37lDTDU60fj/f73HMffTR938gCaJ1ZvfU8BgAYjzcvtcFKxZUVfpIccsiCoU0F6FA
        kl9kDpgUS9LnMNSi6+5krR7b6
X-Received: by 2002:a50:ee10:: with SMTP id g16mr8367960eds.215.1617265266053;
        Thu, 01 Apr 2021 01:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQd6v8W1tiSUNXdFnYdiBd5A2Pnx2X951i2gw6YNvs3Bp5MzyFCqdP4jJQZr0cvQIcMrEYjw==
X-Received: by 2002:a50:ee10:: with SMTP id g16mr8367945eds.215.1617265265929;
        Thu, 01 Apr 2021 01:21:05 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id gn19sm2352669ejc.4.2021.04.01.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 01:21:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Shixin Liu <liushixin2@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shixin Liu <liushixin2@huawei.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -next] ACPI: processor: Fix a prepocessor warning
In-Reply-To: <20210401023900.3114325-1-liushixin2@huawei.com>
References: <20210401023900.3114325-1-liushixin2@huawei.com>
Date:   Thu, 01 Apr 2021 10:21:04 +0200
Message-ID: <87pmzes9e7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shixin Liu <liushixin2@huawei.com> writes:

> When compiling with defconfig on x86_64, I got a warning:
>
> drivers/acpi/processor_idle.c: In function =E2=80=98acpi_idle_play_dead=
=E2=80=99:
> drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end of #if=
def directive
>   542 | #ifdef defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
>       |
>
> Fixes: bc5706eaeae0 ("ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_=
dead()")
> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 19fb28a8005b..0925b1477230 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -539,7 +539,7 @@ static int acpi_idle_play_dead(struct cpuidle_device =
*dev, int index)
>  		} else
>  			return -ENODEV;
>=20=20
> -#ifdef defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
> +#if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
>  		/* If NMI wants to wake up CPU0, start CPU0. */
>  		if (wakeup_cpu0())
>  			start_cpu0();

Thank you for the patch,

this was already reported by Stephen Rothwell and I suggested Rafael the
exact same fix:

https://lore.kernel.org/lkml/87czvfu9j5.fsf@vitty.brq.redhat.com/

It would probably be better if we fold the fix in (if stil possible).

--=20
Vitaly

