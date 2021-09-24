Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC68E417857
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347357AbhIXQTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:19:07 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38382
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347297AbhIXQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:19:06 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8E23740291
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632500252;
        bh=KBx9ZIG9pk67r6r2VuWSGeMfVxfkgdUANVfh9snsj/w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=thmtv8WZyn11cCz9dHHMJRlNnbznN8wfo3yKe377RyYPr/E4Odd/D1SVArTJuaTDh
         ErLEmvDdS5FX5tqvX2fdfzTBB1Clu+ROjtlpffHQnZf3WNkalD+wiorUJpdfyatV4o
         aeY9/EzcThEBrpiZW2g4k8Eg2RonvcypXlkEAg27SaU0bnZ8Gbcu6xC8DbdLvLhwux
         1R5ieKIEusPj8E6qZFUwMO1lxIvQt3FpyU5OhGmcQ+FMOdEN+rsMIO8QasXmIpfIbN
         C49xQSd7Z9l7VxBjFARsvrGS4ajdhpPtADC+hwlWvkB97YYR8nTf2Vso7qs/BQnz0B
         0OFK2mnAL9vSw==
Received: by mail-ed1-f70.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so10756946edy.14
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 09:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBx9ZIG9pk67r6r2VuWSGeMfVxfkgdUANVfh9snsj/w=;
        b=B6ufP3RXE2nAdQwYSCawabo1vOHU8VWHw46HmtMtyubo0ARj7BSyN0e0UFbatTuNiY
         uAukBVXneKyQsjxV503I1s3g5ZkkZ/DaNH2yuKpUn7Cqc6mQgD/awudLN6w3LYGjRjqf
         wMjqF/1g0eShyyMx7Djf/qkELDD1T2DwSQbwPF3hpKVXLo4Fdp7p/KhD9DMSgJXNHmtG
         I1OnAieQulbm/aTZIY6zQn695v1zU+EibldflmAelzsfRAchHTOyk7e3UqQvLRF8fnf8
         wsvm3NjH43pzW3n9nwIQanS25/1Ji7h8/AKMoq2VPI8leefoyULbAW0NhHsLppgxMBcz
         /PRg==
X-Gm-Message-State: AOAM532F8QzX3tkXl4IZqzji+F5IUU2hFYXu0pc7rQb4LRcE44kVd9AJ
        KH0eZPDQZB1F6vZ6SgFyb2ZqEC5qH3cxxo7n6MkhR+Ycw72+qBTV0aec31Q2doiR6Ye6KHn64Co
        uxwKW2Tyc2IWXewzbbpccS8BeBv2VvL7orrUS4lOBu+dpO5X3bvXesq7eUw==
X-Received: by 2002:a17:906:6d9a:: with SMTP id h26mr1977395ejt.96.1632500250644;
        Fri, 24 Sep 2021 09:17:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwku+XUwuiLJ01GyS7qt08lWT0BlPKeGf2p9ERVpv0HQ7csZAV1Ggp34V7Bt8BIK//306rSX3iJJt7v7/BJKo8=
X-Received: by 2002:a17:906:6d9a:: with SMTP id h26mr1977374ejt.96.1632500250436;
 Fri, 24 Sep 2021 09:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com> <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Fri, 24 Sep 2021 18:17:19 +0200
Message-ID: <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
Subject: Re: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Fri, Sep 24, 2021 at 5:04 PM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 21 September 2021 06:34, Alexandre Ghiti wrote:
>
> > The SiFive Unmatched board uses the da9063 PMIC for reset: add a restart
> > notifier that will execute a small i2c sequence allowing to reset the
> > board.
> >
> > The original implementation comes from Marcus Comstedt and Anders
> > Montonen
> > (https://forums.sifive.com/t/reboot-command/4721/28).
> >
> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > ---
> >  drivers/mfd/da9063-core.c       | 25 +++++++++++++++++++++++++
> >  include/linux/mfd/da9063/core.h |  3 +++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> > index df407c3afce3..c87b8d611f20 100644
> > --- a/drivers/mfd/da9063-core.c
> > +++ b/drivers/mfd/da9063-core.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/mfd/core.h>
> >  #include <linux/regmap.h>
> > +#include <linux/reboot.h>
> >
> >  #include <linux/mfd/da9063/core.h>
> >  #include <linux/mfd/da9063/registers.h>
> > @@ -158,6 +159,18 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
> >       return ret;
> >  }
> >
> > +static int da9063_restart_notify(struct notifier_block *this,
> > +                              unsigned long mode, void *cmd)
> > +{
> > +     struct da9063 *da9063 = container_of(this, struct da9063,
> > restart_handler);
> > +
> > +     regmap_write(da9063->regmap, DA9063_REG_PAGE_CON, 0x00);
> > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_F, 0x04);
> > +     regmap_write(da9063->regmap, DA9063_REG_CONTROL_A, 0x68);
> > +
> > +     return NOTIFY_DONE;
> > +}
>
> I will talk with our HW team to clarify, but this sequence looks to be very
> specific to the needs of the platform in question which doesn't feel right to
> me. As was mentioned on another thread as well, the watchdog driver already has
> a restart function to reset the device (and thus the system), so I don't believe
> we should have multiple of these.

From the discussion that happened here
https://www.dialog-semiconductor.com/products/pmics?post_id=10052#tab-support_tab_content,
it does not seem possible to use the watchdog on a chip whose OTP does
not set AUTOBOOT. But anyway, I'm looking forward to hearing from the
HW team :)

Thanks,

Alex

>
> For board specific sequences, there are machine quirks I believe which can be
> used to handle stuff like this, if this really isn't a generic solution to fit
> all cases.
>
