Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D1735710D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353948AbhDGPv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353937AbhDGPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:51:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9493C061756;
        Wed,  7 Apr 2021 08:50:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k128so9285899wmk.4;
        Wed, 07 Apr 2021 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh/87BYi0eaEyCci0l5cohZcATknrUCSdTXAmW5tRTk=;
        b=BW1Sv/mgEVzCHcRK7FmlugeuxTs9w7UiaOVLKxF/5RImEsJ09fFc78sxgmgX6nlRbm
         dOR1zmbMnO4ZZZIrAyz8yHWlv531XGLuzFU33z5BspQ9bkbY+qW4xeV9U/ei9lg/V6RY
         8X3hHgw2iGQd8n+p0evg5PpLEcNNlikdLIABT50X0ZBSD20cI62XSVurBazSM0uAhb1J
         T0Q0hQtfGKCgPGZE93pqXRcqWbtTQy/7enFRWFYAXAx0kkjha+jbfNX3AAm5OgwvB0fn
         xGrHCoxcfEFE1rHzLHeSkw3ZvZWqPUThuMRHzKgPhTXH+88ceLxA2MTzWkp6At5G9gSt
         YGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh/87BYi0eaEyCci0l5cohZcATknrUCSdTXAmW5tRTk=;
        b=dGhyxRYH8FhyWGuoFWn4i/rKfwbU5o0MWpkEM3DatoBLY6VOnuUO4U+zarFtAMuvys
         6Wi/wv/14jI8/IdN8GNlv0iZE4lVKcV8TyqboitozggRx62XeWnIF0gZRouiL+eLmYOn
         G8ORV3jU3DsZy1eRSHzSvprz06r4VWyaILZAsgqCusAdfQ47xDDdILYtAs6mF7ivRYIu
         Alypq7MUtWYO3M6aQQeEORKJkAO/RDWtjTPuKShWpvLinAS87ywpOT49pPGri12bpmKY
         IqToq4V1NFntmoE0sxh3PqXjp8GjnUdzOA0Va6nLo/TwMajIwzY6JrPDc5QxFcqw1YEE
         zFhQ==
X-Gm-Message-State: AOAM530EAzcMyK+UYAyZ4fKK+x++moHPD8SkXgRsA+AIHw1ZxppUXeJ3
        4LmCy6XKh+PjW62lwuIbIiflwAyzv4LjPlTJgao=
X-Google-Smtp-Source: ABdhPJxjEwRjvqH1EtYAuhcElo5SxGRy8NQExskhYp3Es+YNzxfcKDo3GLcLjnNvHWZgcDAEBWIUT8TvruXoBOgzTH8=
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr3682385wmj.46.1617810658456;
 Wed, 07 Apr 2021 08:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
 <20210401030558.2301621-9-david.e.box@linux.intel.com> <CAE2upjT6X1cNvoX8HNFkGHP_aDA1t=JngHFPDUjQ1Y0teuErvQ@mail.gmail.com>
In-Reply-To: <CAE2upjT6X1cNvoX8HNFkGHP_aDA1t=JngHFPDUjQ1Y0teuErvQ@mail.gmail.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Wed, 7 Apr 2021 11:50:32 -0400
Message-ID: <CAE2upjQjEGtQeXbTvegxtpHDGnCywaTRhNRq0kXKG8Qgcy3Rvw@mail.gmail.com>
Subject: Re: [PATCH 8/9] platform/x86: intel_pmc_core: Add LTR registers for
 Tiger Lake
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore the typo in my previous email and use this tag instead.

Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>

On Wed, Apr 7, 2021 at 11:48 AM Rajneesh Bhardwaj
<irenic.rajneesh@gmail.com> wrote:
>
> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
>
> On Wed, Mar 31, 2021 at 11:06 PM David E. Box
> <david.e.box@linux.intel.com> wrote:
> >
> > From: Gayatri Kammela <gayatri.kammela@intel.com>
> >
> > Just like Ice Lake, Tiger Lake uses Cannon Lake's LTR information
> > and supports a few additional registers. Hence add the LTR registers
> > specific to Tiger Lake to the cnp_ltr_show_map[].
> >
> > Also adjust the number of LTR IPs for Tiger Lake to the correct amount.
> >
> > Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/platform/x86/intel_pmc_core.c | 2 ++
> >  drivers/platform/x86/intel_pmc_core.h | 4 +++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> > index 458c0056e7a1..9168062c927e 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -383,6 +383,8 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
> >          * a list of core SoCs using this.
> >          */
> >         {"WIGIG",               ICL_PMC_LTR_WIGIG},
> > +       {"THC0",                TGL_PMC_LTR_THC0},
> > +       {"THC1",                TGL_PMC_LTR_THC1},
> >         /* Below two cannot be used for LTR_IGNORE */
> >         {"CURRENT_PLATFORM",    CNP_PMC_LTR_CUR_PLT},
> >         {"AGGREGATED_SYSTEM",   CNP_PMC_LTR_CUR_ASLT},
> > diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> > index f41f61aa7008..634130b589a2 100644
> > --- a/drivers/platform/x86/intel_pmc_core.h
> > +++ b/drivers/platform/x86/intel_pmc_core.h
> > @@ -192,8 +192,10 @@ enum ppfear_regs {
> >  #define ETR3_CLEAR_LPM_EVENTS_BIT              28
> >  #define LPM_STS_LATCH_MODE_BIT                 31
> >
> > -#define TGL_NUM_IP_IGN_ALLOWED                 22
> >  #define TGL_PMC_SLP_S0_RES_COUNTER_STEP                0x7A
> > +#define TGL_PMC_LTR_THC0                       0x1C04
> > +#define TGL_PMC_LTR_THC1                       0x1C08
> > +#define TGL_NUM_IP_IGN_ALLOWED                 23
> >  #define TGL_PMC_LPM_RES_COUNTER_STEP_X2                61      /* 30.5us * 2 */
> >
> >  /*
> > --
> > 2.25.1
> >
>
>
> --
> Thanks,
> Rajneesh



-- 
Thanks,
Rajneesh
