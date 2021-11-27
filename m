Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2021045F7D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 02:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344648AbhK0BSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 20:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344446AbhK0BQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 20:16:33 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB75C061748
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:13:20 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t11so21874097ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AO9HLiYoJwB3QlxrZnbBFb6xGzf6WT/h97sqqvL5fWE=;
        b=UhHGX1z7l13n04osAUXesCcrOyPPObEmUe8O7MsAPfed2Udi9QDQ9OPG+Rhy/zLYZl
         vQizmqPvsYUo9lSLjOd3fNa0q4fVH6Mi/atFWPbRCCFaAGYWlFTskAqcWeGpVZryrP7b
         A7E13zPDF85SyKHyKB/HalBT39RfZtWXuJbA1zKC98J+OaqXlr7NrNbjbWNbbyGOOwUU
         ecrxwaQxeCbeRO6UulE9JSqCKCZOTHzfpIWmerK5Fma5FakFKV1oH0Z7qDB2GxNKo6jr
         zrfuUD49GVWtSKtVDC+AgYFOVLZh7kXyPHu4tWh6V80xh89vEAW22qIVT4vNH2JHmJYJ
         ZgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AO9HLiYoJwB3QlxrZnbBFb6xGzf6WT/h97sqqvL5fWE=;
        b=7YoKVHO3XjuX/j1EM6uDbk41csM2GIPPd1KKCRCPjSlyS1qWmZpHaNV8eoHI8WuXiV
         v7FvwfSUQreRzR3bRS46z4OLWTyUjnb0kce8krodlG9clHgr9uCxjZn84ltzLQRdqtXu
         LFeme7rnV38Jpg/uTDwIPVtIhZboQGY2C/QsxQI97CiHO5GRH1Jgq5w1ocO0Uu95kf89
         hfjn7+ZLrmmoMZF+cFbQNU+Ob0aTLh87kegnbZSfCGp/pnKMFV2DAKdqRhRYRTHUah7C
         i6T0jQVV9XYvU5E2ONHU9PeEFcdqanSmPcgHmzL9VSuBu2OSiVE0O2r9y0aRc4G877T6
         CpEQ==
X-Gm-Message-State: AOAM530QbyNmpZohYWQ/T2OtRrakOfsb1MgXgp67i0+J+ZmvvZoOCoYy
        XxH7TXwADS2tixinyxgHlUAR4WrVzpgFG98WvzU87w==
X-Google-Smtp-Source: ABdhPJxYNZmdCUliZJOvsz8fSpPToRFs44lg7xD62YV+YO3tLMrzxkG7LHTBVF7STBGKgQ6+cZvCcomXYTY6W2QvmKE=
X-Received: by 2002:a2e:a78c:: with SMTP id c12mr33608112ljf.418.1637975598254;
 Fri, 26 Nov 2021 17:13:18 -0800 (PST)
MIME-Version: 1.0
References: <9821f60a-c562-12e8-bdd4-45dbfe88a117@linaro.org>
 <20211126230820.3441863-1-daniel.lezcano@linaro.org> <9e81f795-6d3a-2078-5ef1-13b965e89a2a@linaro.org>
In-Reply-To: <9e81f795-6d3a-2078-5ef1-13b965e89a2a@linaro.org>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 26 Nov 2021 17:13:09 -0800
Message-ID: <CAAYoRsWEXoe_LjuHuQUL3Tdov0JVW887T4ciUTVOC410mZjgvA@mail.gmail.com>
Subject: Re: [PATCH] powercap/drivers/dtpm: Disable dtpm at boot time
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 3:10 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Doug,
>
> I was unable to reproduce the issue because I don't have an x86 platform.
>
> Is it possible to check if this fix is ok?

Hi Daniel,

Yes, confirmed.

Tested-By: Doug Smythies <dsmythies@telus.net>

>
>   -- Daniel
>
> On 27/11/2021 00:08, Daniel Lezcano wrote:
> > The DTPM framework misses a mechanism to set it up. That is currently
> > under review but will come after the next cycle.
> >
> > As the distro are enabling all the kernel options, the DTPM framework
> > is enabled on platforms where the energy model is not implemented,
> > thus making the framework inconsistent and disrupting the CPU
> > frequency scaling service.
> >
> > Remove the initialization at boot time as a hot fix.
> >
> > Fixes: 7a89d7eacf8e ("powercap/drivers/dtpm: Simplify the dtpm table")
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  drivers/powercap/dtpm.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> > index b9fac786246a..fb35c5828bfb 100644
> > --- a/drivers/powercap/dtpm.c
> > +++ b/drivers/powercap/dtpm.c
> > @@ -471,9 +471,6 @@ static int __init init_dtpm(void)
> >               return PTR_ERR(pct);
> >       }
> >
> > -     for_each_dtpm_table(dtpm_descr)
> > -             dtpm_descr->init();
> > -
> >       return 0;
> >  }
> >  late_initcall(init_dtpm);
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
