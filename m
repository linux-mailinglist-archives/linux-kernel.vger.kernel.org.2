Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE4357DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhDHHwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhDHHwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617868324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H58uU+VyGQGX8F+tsLBzPKkX41NF14uglhKP8Fct0B8=;
        b=dkxu5MbJh1+Zmn21KJonKu6WAVOZR5s54bpV3OgbCm7TATo4tzPOe7FL1Q1eb77SUlwYQ9
        mtBVZa0CZuhcrbbmOxUvLSuhNKz3xovsqbjn2DZbRQ/zu1++kVgkyQoeDvKw/wqjHKQ5nf
        gEYsruWAeNrNkL+rnA9FUb+Ussxga+4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-386QK0a3Mlm6oPWABazXHg-1; Thu, 08 Apr 2021 03:52:02 -0400
X-MC-Unique: 386QK0a3Mlm6oPWABazXHg-1
Received: by mail-ej1-f70.google.com with SMTP id jx20so472965ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 00:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=H58uU+VyGQGX8F+tsLBzPKkX41NF14uglhKP8Fct0B8=;
        b=EBHEhfF81DP/ZkBFKSt2dVoXVSTpXEEhmW8u0P4LQdW5+OiH4zH1AeMpfKdbzUx/FZ
         PXOCHW39QoM9Oq7HwFgVOnG6jku3491X6ZWmw7VIakdejclsteuAYuiljqdLR5BjK5pv
         cT4NBSgjoPRI6nTgTurGwJJcdTel+Ss7g18LYde/ECK5gxQZLLx9VHoUKgayF3VEsPXB
         +jd9f2Pxc6d4NsPhRt17EbMuilehH55ZT9CcQ65V5ZzDjEVsA3LM5OgcNp7ztLdMDIn5
         P11cYxpso0pcfh7NuAvYx6xGXFa9lHogVZ87GiRcbd+8W4fe3epQmWvbFmLGQX5npqDh
         obGQ==
X-Gm-Message-State: AOAM530+DMQy4NKv1GDD57fvWKYJtZePdir3GIoIrXsqeBKwnNob1+0U
        EaFyIfoSyY1QE/P3WU2ve7CtOipbz2noEOJbB4f2zyGs8iwApaikbyhP4nsMPpWcRmssdFD0qet
        KGuCcVLWLvLrDISHgZyTVBfPi
X-Received: by 2002:a17:906:2710:: with SMTP id z16mr8676007ejc.176.1617868321512;
        Thu, 08 Apr 2021 00:52:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx40NhaN1xYNuVVALA7D7BrRd/i6hx0VscNnkGed+hN1RYSJT1/OKpgHzEL9Cpv8Cmbmbv2kg==
X-Received: by 2002:a17:906:2710:: with SMTP id z16mr8675994ejc.176.1617868321367;
        Thu, 08 Apr 2021 00:52:01 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id lj21sm3592377ejb.64.2021.04.08.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 00:52:01 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Fixes tag needs some work in the pm tree
In-Reply-To: <20210408083836.39c4063a@canb.auug.org.au>
References: <20210408083836.39c4063a@canb.auug.org.au>
Date:   Thu, 08 Apr 2021 09:52:00 +0200
Message-ID: <87zgy9b4db.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> In commit
>
>   fa26d0c778b4 ("ACPI: processor: Fix build when CONFIG_ACPI_PROCESSOR=m")
>
> Fixes tag
>
>   Fixes: 8cdddd182bd7 ("CPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()")

"A" in "ACPI" seems to be missing

>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'

This is an extremely unlucky fix :-( 

-- 
Vitaly

