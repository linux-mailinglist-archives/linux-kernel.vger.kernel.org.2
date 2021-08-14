Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA60B3EC26D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 13:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbhHNLlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbhHNLlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 07:41:19 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F94C061764;
        Sat, 14 Aug 2021 04:40:51 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so15220002otu.5;
        Sat, 14 Aug 2021 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVLxEjda5D29Pt6xaEnOJAaMILEeaysFTL2PyZG0dws=;
        b=tPdb5ZbX5iFAOtJNNBC8HM4aOyIejf6LOFK5tAezBDDAW74fn3x9f9cGtr2pw3FnNi
         NZtgZdauz1EoiJDo8ePAS6gtEYFTEMS54fvcsTPAzBUDK1EkrGhSPnkN15jfaBvgaSH6
         vuhj+YeGT8tCfWzsNdbuVXRj0je6t4Bchy2yv5wdeig4vmtd7xLiSbPvtcue23whLkDW
         8XxNZu8LlqGPXzhWAx41deJLrgqOhI4zetebRYtvub3klt2688d+dn/YAKq+hgNGnGYH
         ffXWwA3TmAH+ihsfiHqwHceE11v+pXbJ7a3MvXtHx/Rrd3s7MM7ukSV9VBflWmJ+Jbv/
         BkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVLxEjda5D29Pt6xaEnOJAaMILEeaysFTL2PyZG0dws=;
        b=EdvMmr3BuVqjVRNYBW0J/0cuXMkU0bBl/UOMzJq3NlXg33RZa33/Lz0f08Iv6XI7F6
         7z0qbN90Qo8XCqlmJ9U+cIJ2fTemDKf0S/yVm6FangICg+BtN6zT2jEs7Kc3ACXnj3iQ
         qGWle1OFDZfmBsV3vr9NRTZ6MHTyYfjMURvbATxIUkn99Qx7JKlL64uMhNAYjKXPrcJk
         7lfZjFQsRc5dy9VX7U4O75K4Ucg0cCw+2OCIsoumT4/64ZASpRV9C6dVmdUorNbNcQxw
         dz8iG2oMz0LzBJHKnUTAi5nqRniIa/ywVLUz8tTyG5qpOfMwsUmHI+KE1lw2xiDINovK
         qb1Q==
X-Gm-Message-State: AOAM532KZsm7HtO+xlknAdCQqsp3NOsQp/U0TYxOum3RTyVI9PuZH1AF
        2H/gkwRwQh+Jpmkk96HEajqb2H8cnvshYMuIbFM=
X-Google-Smtp-Source: ABdhPJya8kzDZmc+7fqeltjb0glf4wYeofy0PJ3huxBs99yFsY/nzHGMfQcZeN+mCWYepCxMH1Qmy3yLFu87mbKxJiY=
X-Received: by 2002:a05:6830:544:: with SMTP id l4mr5718649otb.164.1628941250605;
 Sat, 14 Aug 2021 04:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210812125307.1749207-1-jafar.akhoondali@gmail.com> <77aab2df-b3c3-541d-461a-8755277fd425@redhat.com>
In-Reply-To: <77aab2df-b3c3-541d-461a-8755277fd425@redhat.com>
From:   Jafar Akhondali <jafar.akhoondali@gmail.com>
Date:   Sat, 14 Aug 2021 16:10:39 +0430
Message-ID: <CAMW3L+3WUCXx60fALT=2J8TjK_BO3jOTb+8+JQQrKA1_F9pLTQ@mail.gmail.com>
Subject: Re: [PATCH v5] platform/x86: acer-wmi: Add Turbo Mode support for
 Acer PH315-53
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     jlee@suse.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mgross@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Hans,
Thank you for your efforts on the patch, I've sure learned a lot from
your comments as this
was my first contribution to Linux kernel.

Just an extra question, for the next patch I'm gonna send turbo mode support for
14 other Acer Predator laptops. The only required change is that I should add
"quirk_entry" for GPU and CPU fan count, and match product names to their quirk.

12 of these Predator laptops have exactly 1 fan for CPU and 1 fan for GPU,
but two of them have 2 fans for GPU and 1 for CPU. So my question is should
I add the quirks per product (which will end up to have 14 quirks,
same as current patch) like:

static struct quirk_entry quirk_acer_predator_ph315_53 = {
      .turbo = 1,
      .cpu_fans = 1,
      .gpu_fans = 1,
};

or should I specify the quirk per fan count like this one:

static struct quirk_entry quirk_acer_predator_gpu_fan_one_cpu_fan_one = {
      .turbo = 1,
      .cpu_fans = 1,
      .gpu_fans = 1,
};

and then set different matched DMI product names to the above quirk?

The first approach is more verbose, the second uses less code.
If possible, I would like to know your thoughts on this.

Thanks in advance,

Best,

Jafar

On Fri, Aug 13, 2021 at 3:52 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 8/12/21 2:53 PM, JafarAkhondali wrote:
> > Hi,
> >
> > The Acer Predator Helios series (usually denoted by PHxxx-yy) features
> > a particular key above the keyboard named "TURBO".
> > The turbo key does 3 things:
> > 1. Set all fan's speeds to TURBO mode
> > 2. Overclocks the CPU and GPU in the safe range
> > 3. Turn on an LED just below the turbo button
> >
> > All the above actions are operating using WMI function calls,
> > and there is no custom OC level for turbo. It acts as a flag
> > for enabling turbo mode instead of telling processors to use
> > a specific multiply of power (e.g. 1.3x of power).
> >
> > I've run some benchmark tests and it worked fine:
> >
> > GpuTest 0.7.0
> > http://www.geeks3d.com
> >
> > Module: FurMark
> > Normal mode Score: 7289 points (FPS: 121)
> > Turbo mode Score: 7675 points (FPS: 127)
> > Settings:
> > - 1920x1080 fullscreen
> > - antialiasing: Off
> > - duration: 60000 ms
> >
> > Renderer:
> > - GeForce RTX 2060/PCIe/SSE2
> > - OpenGL: 4.6.0 NVIDIA 460.32.03
> >
> > This feature is presented by Acer officially and should not harm
> > hardware in any case.
> >
> > A challenging part of implementing this feature is that calling
> > overclock function requires knowing the exact count of fans
> > for CPU and GPU of each model, which to the best of my
> > knowledge is not available in the kernel.
> >
> > So after checking the official PredatorSense application methods, it
> > turned out they have provided the software the list of fans in each model.
> > I have access to the mentioned list, and all similar PH-iii-jj can be
> > added easily by matching "DMI_PRODUCT_NAME".
> >
> > Creating a specific file for the Acer gaming features is not possible
> > because the current in use WMI event GUID is required for the turbo button
> > and it's not possible to register multiple listeners on a single WMI event.
> >
> >
> > Signed-off-by: JafarAkhondali <jafar.akhoondali@gmail.com>
>
> Thank you for your patch, I've applied this patch to my review-hans
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
>
> Regards,
>
> Hans
>
