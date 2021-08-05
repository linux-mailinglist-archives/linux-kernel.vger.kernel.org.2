Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD963E100D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbhHEIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhHEIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:17:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBD6C061765;
        Thu,  5 Aug 2021 01:17:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso7449314pjf.4;
        Thu, 05 Aug 2021 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLbA3pgLzbzCc3X933M7ARwzctVjqF+Nf5QOnSHEp98=;
        b=IUESRdTzFXaOquIZZ4ewtVnhUnMqT/P0njRRvWcD3Zq2uCgn+tThkF2AOVCfvRxK2Y
         7SSPkBjGv9RUJU4DD4kyQoZwWmeRORRI2aLAxxzp7x+kxhw4JjIgLlWomI1gQ9rG4A/l
         rJdpPUXzDF5g4ZGuqHsar2aCWeQvBjUy4blnt7cIKrM6dCyvI9LaxZXGwHXD81rt4GNy
         R38b5snEdQV8kaWXCudVG2F2uGfMJ3YSCaJO3rMnXO8qXKQOY6/KeieFODhps2TqqXa/
         nZ0eRfz+P2ihCAHLYvQ6jd7XnhWzLVZR80FMNRS+0E/cKoAe1HqimOFKckraTCp/cMMe
         HGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLbA3pgLzbzCc3X933M7ARwzctVjqF+Nf5QOnSHEp98=;
        b=Qo5tjtbxEy939QEYIR6W0ZosYhIyjnALxjfbsFu2+/qnQ+vjuy4y4bkMiekFYMdRQd
         dN5tsLKhgeeWcjYNW6rTOyYt1PTsKYR/+14e4UOvd1Wsg33Ec66FFDXoZfKwJlqUyyTX
         kc3x0CqB+FW/HpPquz7L5qku69r8ZKMOIJfFKtYQm9c2BAN+s7v4pHp5ZhiSfSIyENzR
         +k3Nt0Ri0x4kbq4ceklkr+uKRNiqvW2VJpN7bdYijoBqgUC0PoZ+w/NwZWL90m1xNhpF
         vp5i1Ty81kkYIKocN1r0yj/NLG/bnh2zgm9DdoVFfLoCF2qoQHMThbOdeDZ8DEfLYlkr
         e2zg==
X-Gm-Message-State: AOAM5324B+gr77Lef0jaYk0BhUm7GXbxY/F5z1Eos0auVYdItogqgaw4
        ZLFXGAu8BC761cFmp7/fYZVA1fcq+tXcpdPrqxk=
X-Google-Smtp-Source: ABdhPJy2U8fgEiATTBwkiHyAXSrvD9p45K+VRxiZceHSAtwBpFLi2doKXU6y/syUM84A4X4tcbK84TFXLB2aExO9np4=
X-Received: by 2002:a63:40c1:: with SMTP id n184mr203926pga.74.1628151435574;
 Thu, 05 Aug 2021 01:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210804213843.498937-1-david.e.box@linux.intel.com>
In-Reply-To: <20210804213843.498937-1-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Aug 2021 11:16:36 +0300
Message-ID: <CAHp75VdCy5P4DKj5EWdG=wsNbfg3XfyOPrW5pELVnoF=qTxqvg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel_pmc_core: Prevent possibile overflow
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Evgeny Novikov <novikov@ispras.ru>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 12:40 AM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Low Power Mode (LPM) priority is encoded in 4 bits. Yet, this value is used
> as an index to an array whose element size was less than 16, leading to the
> possibility of overflow should we read a larger than expected priority.  In
> addition to the overflow, bad values can lead to incorrect state reporting.
> So rework the priority code to prevent the overflow and perform some
> validation of the register. Use the priority register values if they give
> an ordering of unique numbers between 0 and the maximum number of states.
> Otherwise, use a default ordering instead.

...


> +       if (!bad_pri_reg) {

Not sure why you need three separate blocks each of them with the same
conditional?
Perhaps you need to refactor this code, because like this it doesn't look good.

Yes, after I read more I see it, but i think something like

bad_pri_reg = foo1(..., bad_pri_reg);
...foo2(...);
...foo3(...);

might be better (or variations of the above).

> +               /*
> +                * Each byte contains gives the priority level for 2 modes (7:4 and 3:0).
> +                * In a 32 bit register this allows for describing 8 modes. Store the
> +                * levels and look for values out of range.
> +                */
> +               for (mode = 0; mode < 8; mode++) {

> +                       int level = GENMASK(3, 0) & lpm_pri;

Yoda style?

> -               lpm_priority[pri0] = mode;
> -               lpm_priority[pri1] = mode + 1;
> +                       if (level >= LPM_MAX_NUM_MODES) {
> +                               bad_pri_reg = true;
> +                               break;
> +                       }
> +
> +                       mode_order[mode] = level;
> +                       lpm_pri >>= 4;
> +               }
>         }
>
> +       if (!bad_pri_reg) {
> +               /* Check that we have unique values */
> +               for (i = 0; i < LPM_MAX_NUM_MODES - 1; i++)
> +                       for (j = i + 1; j < LPM_MAX_NUM_MODES; j++)
> +                               if (mode_order[i] == mode_order[j]) {
> +                                       bad_pri_reg = true;
> +                                       break;
> +                               }
> +       }
> +
> +       /*
> +        * If bad_pri_reg is false, then mode_order must contain unique values for
> +        * all priority levels from 0 to LPM_MAX_NUM_MODES and this loop with properly

proper? property?

> +        * overwrite our default ordering. Otherwise just use the default.
> +        */
> +       if (!bad_pri_reg)
> +               /* Get list of modes in priority order */
> +               for (mode = 0; mode < LPM_MAX_NUM_MODES; mode++)
> +                       pri_order[mode_order[mode]] = mode;
> +       else
> +               dev_warn(&pdev->dev, "Assuming a default substate order for this platform\n");
> +
>         /*
>          * Loop though all modes from lowest to highest priority,

throught

>          * and capture all enabled modes in order
>          */

...

>  #define LPM_MAX_NUM_MODES                      8

> +/* Must contain LPM_MAX_NUM_MODES elements */

Instead of the comment the static_assert() against ARRAY_SIZE may be better.

> +#define LPM_DEFAULT_PRI                                { 7, 5, 2, 6, 4, 3, 1, 0 }


-- 
With Best Regards,
Andy Shevchenko
