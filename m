Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6134F8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhCaGXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233797AbhCaGXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617171779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g4ICpfzKawskWqyoXOf04XIrhL57vtdTL1S0kFY4oik=;
        b=eUq2vsgHDZ+as8Yci1rHFFLFejNf+QbY9kBLHy6n7SGV8gDqyvMndReccXWkzA55OL6BLU
        qy1AWw+sG1DacS64ri/tZZrFDObIlJh9QpRnO2fnEUttFIz2pv8gpaO8ujWsFsEjTYlkxp
        1dt/XgsBHfCCfvac09FGTt/Rx+l2XIs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-TPHi69ddPZSA61XD9JUIUQ-1; Wed, 31 Mar 2021 02:22:56 -0400
X-MC-Unique: TPHi69ddPZSA61XD9JUIUQ-1
Received: by mail-ed1-f71.google.com with SMTP id i6so558492edq.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 23:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=g4ICpfzKawskWqyoXOf04XIrhL57vtdTL1S0kFY4oik=;
        b=KUWMYQTW9+PzrqLL4XaXJhFhgGegWUf478IfltVa2U6F0DiujVRjpCjSM6tdmY06nh
         A/l0VfqlbUzDkomsxjXMWONNTH5KMTA9GsqECj0aBv3BGbrH3p+qp0V13Njbm1O1HNvr
         eMoaE41o8HS6STu4c+yRySmtjFASKVhE5CH/Jdm6l8kdEUL++NsG2LMIS2LEINusfltw
         9g54wLng+/ip7YtEZb0o/HNtYfb2Gw+IDOBu3UeuLLmVESUdvVEpK5n5pExu5K70+DXz
         6Bt6P4NBmvqp5tJoB0N5ua2pNjNrT0K5G/SNvyNUnRzNf6RVHkh6ljCeEvXjrM9SABj3
         NbaA==
X-Gm-Message-State: AOAM533PqIEIExNt+DTULT8NceLn9+GF1MrnKL1RuwFOJXDGWPWC6TWK
        eNq7W4Eezot71T9bW23Aq7Lu8H9JJOqU9QJaO6ZYtwcY3qicUFMljKqagmQ6JNX/+nMKZYX5Ojc
        L+FuzwfgJmYXs5lREtX+gPnl1
X-Received: by 2002:aa7:d917:: with SMTP id a23mr1773562edr.122.1617171775698;
        Tue, 30 Mar 2021 23:22:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt91ZGqgI9E6PwQ2pFH8O1bf52QYeYumenXD/hJNGA/aAD1Zg+VlQDBoSBdo/RTmr6u/Z7Ew==
X-Received: by 2002:aa7:d917:: with SMTP id a23mr1773555edr.122.1617171775503;
        Tue, 30 Mar 2021 23:22:55 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s6sm526361ejx.83.2021.03.30.23.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 23:22:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build warning after merge of the pm tree
In-Reply-To: <20210331112945.11aa88f5@canb.auug.org.au>
References: <20210331112945.11aa88f5@canb.auug.org.au>
Date:   Wed, 31 Mar 2021 08:22:54 +0200
Message-ID: <87czvfu9j5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
>
> drivers/acpi/processor_idle.c: In function 'acpi_idle_play_dead':
> drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end of #ifdef directive
>   542 | #ifdef defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
>       |               ^
>

Sigh, smaller the patch, more iterations it will take to make it
right....

Rafael,

something went wrong when you folded in my "[PATCH] ACPI: processor: Fix
build when !CONFIG_HOTPLUG_CPU" here. This line should be:

#if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)

(not #ifdef defined ...)

> Introduced by commit
>
>   bc5706eaeae0 ("ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()")


-- 
Vitaly

