Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B52836BFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhD0HH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:07:29 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:46636 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhD0HG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:06:59 -0400
Received: by mail-ua1-f47.google.com with SMTP id v23so18338609uaq.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yWrCnxspOEU09ohpANK8EFv8WKUiN9EYVnjphWtMlw=;
        b=t/v4BSL6nC1kIammWV8vnPz/mLlTUtGKlCc5/qCKmvIHOqQfp69YbO/stlL0RHLReR
         Gv+lrnhNsk8kgjleud/ma5QsGFbHm56JvqKafo2uGDrY4JDKVYeqtfV8uagqxV+DxuPy
         19nWhGe7S0GXGKKHyUjdIqnX06ukwrVGXfM7IEPQWBGv+lP6KL8v7wbIDf5hOj7hch5m
         biNcCrCvrpT/Yg2xiBPAXMgMXPyI7vmS0H59ztDYPDi1MDkbWrjVi7AI/5AHI8xO5xwq
         52x+nlF3r4m90Hiiv9CNLFCI9yHJJqlbE+7792X+LFwlSTMZIIuC+V7nOr/Lmm/NOoXn
         Q12Q==
X-Gm-Message-State: AOAM533fBIZOwP6ZxRw8qneB2ixV82yrbd2b42kwYb59zSQ+B80/h716
        M5Jpc+j0Pu+JaXI9zUrHvuUkMh3YyJOCRVkRIZ8=
X-Google-Smtp-Source: ABdhPJxIjPDCSt0n7tNtaZ/I7xFzjpALnneQCrum1cB6Xma8lOonZOpN7Ic3AsV6H0XDYOo0EAzHSCJg0j/fbCH5gKY=
X-Received: by 2002:ab0:6306:: with SMTP id a6mr16002889uap.2.1619507155105;
 Tue, 27 Apr 2021 00:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com> <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
 <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com> <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com>
In-Reply-To: <23ab7a11-330c-4d3d-00c1-984c5248464e@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Apr 2021 09:05:43 +0200
Message-ID: <CAMuHMdXS+GO=E26vaeNvQ+L7zm=mOK0FXoWGL79adL+9Hx1E3A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by default""
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Mon, Apr 26, 2021 at 11:48 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 4/26/21 2:33 PM, Saravana Kannan wrote:
> > On Mon, Apr 26, 2021 at 1:51 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >> On 3/2/21 1:11 PM, Saravana Kannan wrote:
> >>> This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.
> >>>
> >>> Since all reported issues due to fw_devlink=on should be addressed by
> >>> this series, revert the revert. fw_devlink=on Take II.
> >>>
> >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>
> >> This change breaks booting on SCMI-based platforms such as ARCH_BRCMSTB.
> >> If I revert this change or boot with fw_devlink=permissive, then our
> >> systems boot again. From a quick look, the SCMI clock provider was never
> >> probed which means that our UART driver never got a chance to get its
> >> clock and we have no console -> timeout.
> >
> > We explicitly landed changes to handle this condition. So we'll see if
> > this is what is happening.
> >
> >> Al, AFAICT you had started to analyze this before in the context of
> >> SCMI, do you mind sharing what you had found?
> >>
> >> Saravana, is there any debugging output that we can help provide?
> >
> > Thanks for the report. Couple of things that can help:
> > 1. Example DTS file (the final board file so that I can get the full DT view).
>
> Attached BCX972160DV.dts which is one such system.
>
> > 2. Point out the UART device node and the SCMI device node that you
> > suspect is causing the issue.
>
> The SCMI provider node is brcm_scmi@0 and its sub-node protocol@14 is
> the clock provider. The UART node is /rdb/serial@840c000.

I guess dependencies on SCMI sub-nodes are not handled correctly?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
