Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA7392C58
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhE0LJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232891AbhE0LJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622113658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1XhW08sDZVWxZiYy/i8EWcuBLiDBxFlQGPa+mYNy1yU=;
        b=gh/O/TNssZgnor1e+cezekhhMvvFtA72z0/Qn7CcDQLEXjnfMv4ZY4n0BG/hZnYd2ECd3G
        nsqQ12Efz7cDxK4hUKfxE13gTXXiVwaLbpllODW9vlZoDQMiXc/kkPIYXR8f2wnFoKP1hl
        P43Z9mNokvg4yaNIWAMlTGGVLwDmoGM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-IOJAIkMgOkeJ_o4efXOOAA-1; Thu, 27 May 2021 07:07:36 -0400
X-MC-Unique: IOJAIkMgOkeJ_o4efXOOAA-1
Received: by mail-ej1-f69.google.com with SMTP id i8-20020a1709068508b02903d75f46b7aeso1532367ejx.18
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1XhW08sDZVWxZiYy/i8EWcuBLiDBxFlQGPa+mYNy1yU=;
        b=IvnHl4MSUPCMHVkDhal8SrN9nH1Ah8/S+4pAlZ0xmc2SBuIjycwMohZZYM8LC0fy2j
         bykZ2Ei5Of0rMTWepNODjOd9MzvcmQ0q+o+tXbZVe2btqdHsBixjFAyHdjgHetL+dwaz
         Q52a5w82yYjrzWbeLsB7PvxC9nI+k4xOP/sPXUJsGAYYTLE4S7pCYZXwkFSB3RCb7Jco
         +xtLFe7fvc1QnWejbA1+E1B6iDZMelOGeiJKtJ6JiG78bp/CKbSICMDavfG2VQOAuoHq
         DPULOQYExuak7lxuW+Sve7CJQy7uHbYPfHAxXvQFXwCb+QcB7ggHus16nxyPA1z8YyiI
         1UoQ==
X-Gm-Message-State: AOAM5338NptQMIor9nL8es1yROIRgf0MrTiPwCyfUTWn6cuRva86B/xj
        Gmjayln4S/ya5qJHVYZYwWlgbSCERuZq5prGu+esN6NARLD5C5FjNJ/wJh5I9GUpiKhol/2Hdi+
        QbE8JHtjIwHM/569/GBOf3MTdghXMI1Pt8w5XfMrqqbAgda1damqpOSeLOli58QLtwv4fvyXu/W
        qQ
X-Received: by 2002:aa7:d598:: with SMTP id r24mr3550568edq.250.1622113655514;
        Thu, 27 May 2021 04:07:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPaK/q4ub1kN2A9tHP994MZMl4mjx8T6lXNgH5L1NTUvkcA2JJH3gHhyLPMiNiY/I/dkKnvg==
X-Received: by 2002:aa7:d598:: with SMTP id r24mr3550536edq.250.1622113655276;
        Thu, 27 May 2021 04:07:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id j17sm843956ejv.60.2021.05.27.04.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 04:07:34 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Add devm helper for work-queue initialization
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     hanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
References: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fbbfba71-bdcc-b78f-48be-d7c657adce61@redhat.com>
Date:   Thu, 27 May 2021 13:07:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/18/21 2:31 PM, Matti Vaittinen wrote:
> This series adds new devm_work_autocancel() helper.
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

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

As for merging this. Normally as the include/linux/devm-helpers.h
maintainer I would pick-up at least patch 1/5 and then provide an
immutable branch + pull-req; or just merge the entire series.

But since there are no other include/linux/devm-helpers.h changes
planned for 5.14 and since all the other patches are extcon changes,
I believe it would be best if the entire series would just be merged
through the extcon tree. Chanwoo / MyungJoo does that work for you ?

Regards,

Hans

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

