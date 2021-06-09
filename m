Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710F63A1950
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhFIPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232458AbhFIPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623252207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7r3YpjfY15K3g48OrujqDYQDOPyWp2wSpWjzmNEuVQ=;
        b=fr+NP/EBCEmmpmoZFqVq6bjG3rgSIjYZ78w6KDon2O4bVmnLY9QShyYJ3WAOFnNCDLTpgf
        H7G3i3gChCalWNcB3hAGgITvHrXeLFHhRzU6M0UDEffkGinZk056d+XVP402Y1pv6JEpoI
        IVYB4AD7Ws5l+QE1iFxqi8E5dW8UWbE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-4-8Bbw2ZOCy4OaycF-RspQ-1; Wed, 09 Jun 2021 11:23:27 -0400
X-MC-Unique: 4-8Bbw2ZOCy4OaycF-RspQ-1
Received: by mail-ed1-f71.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso12620133edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 08:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7r3YpjfY15K3g48OrujqDYQDOPyWp2wSpWjzmNEuVQ=;
        b=DFjLnw/NXyraiAw4BMZ2y+uHHXW0HVIMxAvEnnFVnod9K03nOQXuJrrMuIj9Zzx1ls
         4GO6hah0yAi1hgAj4733rWA6HkEBhI4WmBKXDbBvJzXbXLTpqxovJ8XMHtmC15yBqnlL
         i3d+ccCB5iXZnxozkkVQ3Q+UeXKTzrtqBpHzIBE623n/jrjQKKaE9+7QDztTuDR3WIqk
         GBIPEFVjXgmfV/9zOuC2yvXtADjcVafMGcirKLdIJQj8b3v7LZf3Z5XfnjR6sUGu9PHO
         slUsZXxnEY8mNW+7gXRTLunO1n05OQa+PomD7kkZBFCjmmHmwb5nXzRYKUopNWWOoRY3
         IJEA==
X-Gm-Message-State: AOAM533pyeOM8Tx8EEbW7HFGhZE0Yezn0jkaTjlFtgpuJDDtvUs3gAJy
        9wX+VVQHp6n++S5c4BH0jcIzrXqQNbVuVBqyCH4ok0Lr16PUD0Q85F+c1AiP5PLHYq29CcA2cdM
        i/ssPMZLtfcEz+otrp/ImYt4nREyyBwer2Czajqdjw4UIPD/r6sXr3uUk641pq8EISaHV6KekBn
        WM
X-Received: by 2002:a17:906:660c:: with SMTP id b12mr459258ejp.86.1623252205608;
        Wed, 09 Jun 2021 08:23:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxENoNet7wbOz8SCkAec3i87+0hhGeX43cLDQgiU3p4HoaIZo/cEiPjZbuOLsyJK6XHlo3Juw==
X-Received: by 2002:a17:906:660c:: with SMTP id b12mr459235ejp.86.1623252205394;
        Wed, 09 Jun 2021 08:23:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s2sm26253edu.89.2021.06.09.08.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:23:25 -0700 (PDT)
Subject: Re: [PATCH RESEND v2 0/5] Add devm helper for work-queue
 initialization
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
References: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2ab1589e-a14b-3058-5582-ac5c304f7e80@redhat.com>
Date:   Wed, 9 Jun 2021 17:23:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cover.1623146580.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 6/8/21 12:09 PM, Matti Vaittinen wrote:
> This series adds new devm_work_autocancel() helper.
> 
> Note:
> "The beef" of this series is the new devm-helper. This means that
> normally it would be picked-up by Hans. In this case Hans asked if this
> series could be taken in extconn tree:
> https://lore.kernel.org/lkml/fbbfba71-bdcc-b78f-48be-d7c657adce61@redhat.com/

Yes, and given that most of the changes are in the extcon code I still
believe this is best.

Alternatively I can create an immutable branch with these 5 patches on
top of 5.13-rc1 and then send a pull-req to Chanwoo and MyongJoo.

Chanwoo and/or MyongJoo can you please let us know how you want to proceed
with this series?

Regards,

Hans



> 
> Many drivers which use work-queues must ensure the work is not queued when
> driver is detached. Often this is done by ensuring new work is not added and
> then calling cancel_work_sync() at remove(). In many cases this also requires
> cleanup at probe error path - which is easy to forget (or get wrong).
> 
> Also the "by ensuring new work is not added" has a gotcha.
> 
> It is not strange to see devm managed IRQs scheduling work.
> Mixing this with manual wq clean-up is hard to do correctly because the
> devm is likely to free the IRQ only after the remove() is ran. So manual
> wq cancellation and devm-based IRQ management do not mix well - there is
> a short(?) time-window after the wq clean-up when IRQs are still not
> freed and may schedule new work.
> 
> When both WQs and IRQs are managed by devm things are likely to just
> work. WQs should be initialized before IRQs (when IRQs need to schedule
> work) and devm unwinds things in "FILO" order.
> 
> This series implements wq cancellation on top of devm and replaces
> the obvious cases where only thing remove call-back in a driver does is
> cancelling the work. There might be other cases where we could switch
> more than just work cancellation to use managed version and thus get rid
> of remove or mixed (manual and devm) resource management.
> 
> Changelog v2:
>   - rebased on v5.13-rc2
>   - split the extcon-max8997 change into two. First a simple,
>     back-portable fix for omitting IRQ freeing at error path, second
>     being the devm-simpification which does not need backporting.
> 
> ---
> 
> Matti Vaittinen (5):
>   devm-helpers: Add resource managed version of work init
>   extcon: extcon-max14577: Fix potential work-queue cancellation race
>   extcon: extcon-max77693.c: Fix potential work-queue cancellation race
>   extcon: extcon-max8997: Fix IRQ freeing at error path
>   extcon: extcon-max8997: Simplify driver using devm
> 
>  drivers/extcon/extcon-max14577.c | 16 ++++--------
>  drivers/extcon/extcon-max77693.c | 17 ++++--------
>  drivers/extcon/extcon-max8997.c  | 45 +++++++++++---------------------
>  include/linux/devm-helpers.h     | 25 ++++++++++++++++++
>  4 files changed, 50 insertions(+), 53 deletions(-)
> 
> 
> base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
> 

