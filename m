Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCB3423CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbhJFLhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:37:42 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46168
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238306AbhJFLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:37:39 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E2AC73F32F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633520146;
        bh=3fmM+3ryYWmUMhh0+YhTK1QvjKcGmEr05J1foyEEmgA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UYXbs3wtzn8T5QRsnlFdZsEW2ImEMzpzhTuMx0KKOu4z6M1TQYQ0aKSwVmzYLzsg1
         5jVz6IvZmNUAuYvKCNHSdI8G163WX9X0DG+chXf8m0JsUWDT3pnYognWmzHyIAHzcx
         7j0Xsn7zuoGaBzeV3wZzGOXlh/y8CpaUyj4G5tn9ba3tTCFmGV12c4z3vIDl+fVugc
         eleM5hf5AaiQU4qcQe+URFji1uLGSCaXGx0YTzPU+086AcwEIJUoLdzQXptrzg5N/c
         /47bBeH9X5JOFGPCaElMpUDh1yutaD6UEpK4CxTIGc7WriaqYz5iH63sBXZixwoe95
         9I/4jbvrfQ3WA==
Received: by mail-ed1-f72.google.com with SMTP id c7-20020a05640227c700b003d27f41f1d4so2320305ede.16
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 04:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3fmM+3ryYWmUMhh0+YhTK1QvjKcGmEr05J1foyEEmgA=;
        b=yhIv8gqnK5+hjGaMooKoc4ehxBAPjORkI/a0ZnQZy3VFvS2fYaFOgVrRQc0DbVajbB
         Vk8JMm6EnLrw6f2nB3UOAfZsH5h/JSn6tZcjWZ7al0nbULtehsS8VlTr/Kc62t9ZMO0z
         9u6miA5gGG3riXzvng/dtoM8CvrjoCfZ2+kqBuR1MG3Z1vpQMzcn+Hn7Hdpm7WQR/mey
         1WskF7GvZTntnaudJUOcHw0oRTjiM0yZw0jaFWsT0eJIUffnMDR2zQ3jQJEDuzFy9gMU
         FATTvGW8TqYRv6K3sAhBaRpxnPPHt7cQ2XE64a5m7qNPiLbH3KBe+Tq2NpWfluCKGmK2
         fN/A==
X-Gm-Message-State: AOAM532V+YVMzeWOLcKD4DiW8nsh1Ez+LaV4VUpiJ7vtsB0OnuyOczIP
        TadW5I5h7XCzl9llO8OsomDOzUtJbzDEWBEiaHxtw3ERxaoT9DZ7N90nawfNIXuZLuO2B5Cefmb
        nZbrm7/XgcAoH7Rj6rbxgX1CyQwPzU6hS4IkYNipzm1z9gPzoBzSA232U1g==
X-Received: by 2002:a50:da49:: with SMTP id a9mr34599525edk.281.1633520146576;
        Wed, 06 Oct 2021 04:35:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLknOWCMuxcOGH3YkviuzstqiEm0p7gGBKCgL4P7PJww+plJsVc6oPbjwAPUIL15mbEYcXZXELKgCxCT4/vqM=
X-Received: by 2002:a50:da49:: with SMTP id a9mr34599495edk.281.1633520146393;
 Wed, 06 Oct 2021 04:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
 <CA+zEjCtQN6c8bikg620PQwoPzJ6T4wGLvzQ413iPs1tCeHif0Q@mail.gmail.com>
 <CA+zEjCtVxDkg8K0iK32j4KO+Wgt+hTjXD15HdRhNeCV2Sjpckw@mail.gmail.com>
 <DB9PR10MB4652294AB444536BF57E320A80AE9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCsf6m8cctHNPBxJczg-J9XC-piAcdtNDO71qmtCtDj9gw@mail.gmail.com> <DB9PR10MB465270EA5D6F25C44E68D1E580B09@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB465270EA5D6F25C44E68D1E580B09@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Wed, 6 Oct 2021 13:35:35 +0200
Message-ID: <CA+zEjCvFO6Tz+D42wgnstx_TLNEt=HM0eeT5g0-zwaEscGj2vQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 11:30 AM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 05 October 2021 14:43, Alexandre Ghiti wrote:
>
> > > > > Thanks for the pointer! I have just tested this sequence from the
> > > > > u-boot shell, it resets the board correctly. But then if we try to
> > > > > power down the board by a long press to the corresponding button on
> > > > > the board within 16 seconds, it resets the board: so we cannot
> > > > > shutdown the board in the next 16 seconds that follow this sequence.
> > > > >
> > > > > Maybe that can be resolved by using the one-shot alarm as described by
> > > > > Adam, I'll try to find that in the datasheet.
> > > >
> > > > After configuring the one-shot alarm, I still have those intempestive
> > > > reboots if I try to power down the board by a long press within 16
> > > > seconds. The only thing I found in the datasheet regarding this timing
> > > > is in case of power undervoltage, not sure how this is linked to what
> > > > I see.
> > > >
> > > > @Adam Thomson Any ideas?
> > >
> > > Nothing immediately springs to mind. Can you confirm this is the nONKEY long
> > > press that you're attempting here, which is resetting the board rather than
> > > shutting down?
> >
> > Yes, this is the nONKEY long press that, if done within ~16sec after
> > the board is reset using the alarm, resets the board instead of
> > shutting it down.
> >
> > >
> > > Also, would you able to again provide events and fault log when this unwanted
> > > reset occurs, just in case there's anything there to give a clue. Can then
> > > discuss internally to see if we can ascertain what might be happening here.
> >
> > FAULT_LOG = 0x60
> > EVENT_A = 0x12
> > EVENT_B to EVENT_D = 0
> >
> > But I'm unsure of those values since they are the same after the reset
> > triggered by the one-shot alarm *and* if I clear EVENT_A, the
> > intempestive reboot does not appear!
>
> Thanks for the info. So we believe, based on the event registers values
> provided, it is the RTC event as that's not cleared by a power-cycle (it's in
> the always-on domain). The other test would be to mask this event immediately
> after an RTC based reboot and see if the long key-press then shuts down the
> device. I suspect it would in that case, as per you clearing the event.

Indeed if I mask the RTC alarm in IRQ_MASK_A, the intempestive reboot
disappears. But that's not something we can do: the reset driver will
actually be implemented in openSBI at some point where the devices are
probed on-demand (the same applies to u-boot I think), so we cannot
clear or mask anything at boot.

>
> I'm still curious as to the 16 seconds though. Would that be when the kernel
> finally starts and masks/clears events (seems quite a long time)?

No, the kernel is not up yet. Maybe 16sec is not the right value, I
may have been influenced by the discussion here
https://www.dialog-semiconductor.com/products/pmics?post_id=10052#tab-support_tab_content.

It seems there is some consensus about having this reset driver be a
SiFive Unmatched board specific thing: quid of the sequence I propose
in this patch then? It does not mess with the RTC registers, it
reboots reliably and there's no intempestive reboot: is it dangerous
to use? Or do you have another alternative?

Thanks,

Alex
