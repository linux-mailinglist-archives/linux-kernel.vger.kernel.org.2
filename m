Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9801431EEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhBRSvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:51:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233701AbhBRQs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613666820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c8kK7O2XFWT/eVjA2G4ZhQxAThbCihj5vo5giTyH6Us=;
        b=SKpo8kUbcjwpxs2tyBZOmbMKZPHbvaNi5IpBUD0/FE+zzrHThLmBuyb1LGlbcSnhbY1MyG
        Fxh454vil4msNeD0rvyY5Vs6E2gJ0JyhJw0qMcHvj0hACopXMAwjWdyIALjrmm9MghQMqH
        wTl4lBpNKQithrAoMGGLLEKWgU44yb4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-ToASY3-eONeQ_28l_sBz-A-1; Thu, 18 Feb 2021 11:46:58 -0500
X-MC-Unique: ToASY3-eONeQ_28l_sBz-A-1
Received: by mail-pf1-f197.google.com with SMTP id o14so1673722pfp.16
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8kK7O2XFWT/eVjA2G4ZhQxAThbCihj5vo5giTyH6Us=;
        b=VZVcHYKpFG3xjyKYRlunEnk9oQYfl6LRuxaJnJAcuuUZncW0YX3vBpuf9K+R6IrDJt
         2+g1bEojewMsGsJChIvGolmIzFwT7HCGFWlcFkBGikrlWiGyuyvgRaV5EspEFzh5xDcg
         3HR3sa/SkKTsuaBLccgjbUf+6OPk0WuS99A6+KEYhsuAD48ShUV2+PCH+PpJ7JYWQE0Z
         jxcKMKZY00bBa4yh/7C/FaGfbMziqQSz6FktQ48um43RRLeEHZ3NtyXmO50zkvTLtbyU
         xDn2gWxKLvLBr0EHl8Xodnmq+RZoGdA7z8Fcp7nbY2qYsZyXArr2RBp6JgMrDc11l1ui
         Z02Q==
X-Gm-Message-State: AOAM533PN9eLpgY/INxz76FH8myIDKvL6dzcm/5MAKBuGIrgNC5NP/jB
        EWSDeS5jj65WsoNJNBkg879KwRKkTjtW60moCrYYD8aTTst/apttCXwb3gz9SdAk6QNrXmO0GjK
        8X9U4FHD3xCUH/ChQB/METr3P02hIQX/y8nfT4llv
X-Received: by 2002:a17:90a:990f:: with SMTP id b15mr4895033pjp.56.1613666817736;
        Thu, 18 Feb 2021 08:46:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdyu4WNLMmaqUjN4rAG9EzejD9obPkN/ruOJr8J3NxXuOJi2e6pn17dRuvLTo9jfwYc4G/lM1zpktGFjjSKH8=
X-Received: by 2002:a17:90a:990f:: with SMTP id b15mr4895014pjp.56.1613666817519;
 Thu, 18 Feb 2021 08:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20210217173158.3122868-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20210217173158.3122868-1-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 18 Feb 2021 17:46:46 +0100
Message-ID: <CAO-hwJKEDEDvMcdvSBq3tx_tibEnhFzFm7wq2AQ3SZwgQyfm4Q@mail.gmail.com>
Subject: Re: [PATCH 00/11] HID: playstation: revert LED class exposure
To:     Jiri Kosina <jikos@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-leds@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 6:32 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> [sending those patches on behalf of Roderick]
>
> There is a current thread on LED LKML which basically means that
> we have to revert the LED class exposure until things are settled.
>
> I am sending here the full series that will end up in linux-next.
> But with some git magic, the final PR to Linus will not have the
> reverts in it, just the plain patches.
>
> I am queuing in for-5.12/playstation patches 1 to 6 immediately
> (the reverts).
>
> I am also queuing in for-5.12/playstation-v2 patches 7 and 8 on
> top of 51151098d7ab8 immediately. Those 2 patches have already
> been reviewed the usual process.
>
> I am waiting 1 day for others to chime in regarding patches 9 to
> 11 before applying them to for-5.12/playstation-v2. They are
> basically the same patches that were already reviewed on the
> linux-input LKML, but without the LED class bits.

And I just pushed those 3 patches to for-5.12/playstation-v2.

Cheers,
Benjamin

>
> With all that, we should have more room to discuss the exposure
> of the LEDs to userspace through the LED class.
>
> Roderick, I made small adjustments compared to the series you sent
> me privately:
> - added the 2 missing reverts/re-add, so I can have clean merges
>   for our for-next branch,
> - re-ordered the `if (ds->update_rumble)` block in
>   `dualsense_output_worker()` to match was was in linux-next
> - removed an extra new line to match the current linux-next tree.
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (2):
>   Revert "HID: playstation: fix unused variable in
>     ps_battery_get_property."
>   Revert "HID: playstation: report DualSense hardware and firmware
>     version."
>
> Roderick Colenbrander (9):
>   Revert "HID: playstation: DualSense set LEDs to default player id."
>   Revert "HID: playstation: add DualSense player LEDs support."
>   Revert "HID: playstation: add microphone mute support for DualSense."
>   Revert "HID: playstation: add DualSense lightbar support"
>   HID: playstation: report DualSense hardware and firmware version.
>   HID: playstation: fix unused variable in ps_battery_get_property.
>   HID: playstation: add initial DualSense lightbar support.
>   HID: playstation: add microphone mute support for DualSense.
>   HID: playstation: add DualSense player LED support.
>
>  drivers/hid/Kconfig           |   3 -
>  drivers/hid/hid-playstation.c | 177 +++-------------------------------
>  2 files changed, 12 insertions(+), 168 deletions(-)
>
> --
> 2.29.2
>

