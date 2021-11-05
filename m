Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38955446883
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhKESjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230291AbhKESjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636137414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ZqJJ94oU4rIIn7ad690SLeofOW7jTYT7bPz74IpFsA=;
        b=St0NNshBxSENrfgKmhLMCM9WfYELay0IqLYQ7KnvZjq20qoY/3nA+9IR3xx/BPFqzmcI8R
        KGqBMkdnICtF/yE3izWCOYLmpJ7Ga1Q2EMtWF3hXsew8Y33urU32h5s4Heooy/8HDO8RLf
        RPZ5OVP0nl4fVtEF1nLyV1OcysQwqW0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-Yopb6tH2MBqhF85KiR-cIQ-1; Fri, 05 Nov 2021 14:36:53 -0400
X-MC-Unique: Yopb6tH2MBqhF85KiR-cIQ-1
Received: by mail-pg1-f200.google.com with SMTP id p35-20020a635b23000000b002cc3b82cc32so6188833pgb.14
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 11:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZqJJ94oU4rIIn7ad690SLeofOW7jTYT7bPz74IpFsA=;
        b=erCDq8oUQq+LhEueKyOTLudV8BsejEBNrL+KnPjOdKbjk7crOE3oornLCDtsuGwIbz
         CVT2yDV9ThgoYFua2nYL4LIsK8J3S0fT0vXwvyrssUSfEiWS5czNVv/hionor8uRZg9N
         mae9gVxo/CqWgrGysHs3hzBezhZzgPryOPjw8KHpd2uGUky6fYHeZ3MC4O+53FdbKK6y
         Io8WzuP7ydCfIskSE0qB3DI04LylYiBXSOXSbqfYdgkJg4k88SsbBf20MnRV6lCPDxeZ
         5U5yh78+MB61jJuOzzvL4Tmh0+rk+V9Wpt0luOS1aZM7El1Va+6R/hmHdpeQ2DPi8smn
         dsSw==
X-Gm-Message-State: AOAM533awobmgKR12AdXqjFCgfSm9iz0aHs3ShY4WUnGVhbvj7dC+FES
        B75nyIXLBYYC3o86xyKCWJvseFHgbCoGLuz8u1jf6mnbo9DaUrWWBE4ZY8VansXpGSO3+MnDrgL
        8MTqpngGsQ1F6UEWRb/KLnnZQMaXtP84hARAia+T3
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr32682223pjb.113.1636137412293;
        Fri, 05 Nov 2021 11:36:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2nx0R4aJ59MdBs9NUPkUpgytBiBqWfxblcMr6bzi4FPNQ0ndp0LpvnlVgwkDoESuf6frh4c/Fni3tL3p/3og=
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr32682186pjb.113.1636137412049;
 Fri, 05 Nov 2021 11:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <1636011944-3424006-1-git-send-email-jiasheng@iscas.ac.cn>
In-Reply-To: <1636011944-3424006-1-git-send-email-jiasheng@iscas.ac.cn>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 5 Nov 2021 19:36:40 +0100
Message-ID: <CAO-hwJJZdSnJ1ysOk_UACsxwhg-1u3SEg8rvykCEaHzqY5-pmQ@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Add parse before start
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

On Thu, Nov 4, 2021 at 8:52 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> It might be better to add  hid_parse() before
> wacom_parse_and_register() to ask for the report descriptor
> like what wacom_probe() does.
>
> Fixes: 471d171 ("Input: wacom - move the USB (now hid) Wacom driver in drivers/hid")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/hid/wacom_sys.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 57bfa0a..48cb2e4 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2486,6 +2486,9 @@ static void wacom_wireless_work(struct work_struct *work)
>
>                 wacom_wac1->pid = wacom_wac->pid;
>                 hid_hw_stop(hdev1);
> +               error = hid_parse(wacom1->hdev);
> +               if (error)
> +                       goto fail;

I am pretty sure we don't need those calls (everywhere in this patch).

hid_parse() has the effect of requesting the transport layer to pull
the report descriptor and then parses it at the hid core level.
However, we are called here in callbacks after wacom_probe() has been
called already once for those devices (wacom1 and wacom2).
So basically, hid_parse() is called in wacom_probe(), we store the hid
device in a shared space in the driver, and then when the work is
called because a new device is connected, we just pull that hid device
(already parsed) and present it to the userspace.

Another fact that makes me think we are already doing the right thing
is that if hid_parse() is not called on a hid device, we have a
segfault while processing the events. And here, we don't.

Cheers,
Benjamin

>                 error = wacom_parse_and_register(wacom1, true);
>                 if (error)
>                         goto fail;
> @@ -2498,6 +2501,9 @@ static void wacom_wireless_work(struct work_struct *work)
>                                 *((struct wacom_features *)id->driver_data);
>                         wacom_wac2->pid = wacom_wac->pid;
>                         hid_hw_stop(hdev2);
> +                       error = hid_parse(wacom2->hdev);
> +                       if (error)
> +                               goto fail;
>                         error = wacom_parse_and_register(wacom2, true);
>                         if (error)
>                                 goto fail;
> @@ -2710,12 +2716,18 @@ static void wacom_mode_change_work(struct work_struct *work)
>         }
>
>         if (wacom1) {
> +               error = hid_parse(wacom1->hdev);
> +               if (error)
> +                       return;
>                 error = wacom_parse_and_register(wacom1, false);
>                 if (error)
>                         return;
>         }
>
>         if (wacom2) {
> +               error = hid_parse(wacom2->hdev);
> +               if (error)
> +                       return;
>                 error = wacom_parse_and_register(wacom2, false);
>                 if (error)
>                         return;
> --
> 2.7.4
>

