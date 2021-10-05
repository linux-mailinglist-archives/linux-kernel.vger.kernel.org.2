Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612124221FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhJEJUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhJEJUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:20:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACA5C061745;
        Tue,  5 Oct 2021 02:18:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f9so13332523edx.4;
        Tue, 05 Oct 2021 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rj+oAzgC66Qe4QKG9+z5cKi2AHZOILfEGPSW29imrpI=;
        b=CHQHokDEoACabVhVf2NKf65knXyhFZScgOfTwJRmF1hEETjM6lI9kBgiDxJBuq7iY3
         8+WMKbCj2PKR8WVu9yQbmVL5mSc6+0mjavM0lg/ip2oxsUoT1Cwij0G2KWAEMdHGbaP0
         pzXpPgiKR/DsMHTRMT4a8Z6e38kfKBRCAKJHTUH1yifV1lS9Sm31oEVS7nCAOIOYFevN
         OUIH0nIYHmBcPbKOISuze/32sxV+XeJ3xKpY3D4L9C7OPj7/TrvxT6zuED/jLI3v50Io
         vuFGro4gfj5xfixqhhsVD2kk7uyBbUDE4GuMFbfGcfuXjJrX58xrIB7z7uBiFdB7yruV
         T0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rj+oAzgC66Qe4QKG9+z5cKi2AHZOILfEGPSW29imrpI=;
        b=31J4ag73kEGHa4aierOs6Fr9zuVwQuSfZ44BqDCEbdc+Y9ZtO0xK+ALh+wdIbeNzFx
         eP+e/MIU6hI05oEXrUeHMfQRW9Pw8bt2lWVea1vN9xjcSi1hH62LFSDY1QVpG1KROqoA
         c1K16txZLgz1JxLwJqPB0mxDc/2GObLlDLNmzgaB5DI4nEt8OKU2odmvwkhZvkZOzMBL
         uxlJ2ImFPAOf5C+88qVl9CH+V1FhV3dlhEnfwonAQEwIHglkPDhhTtgteBYIvmTwKI45
         DoH0GbXDqtUwB9VK7ONwHESH9HIwOPPOUD+z1JN3LFUICyfglUdyyE7zDI4j1lryj+Iw
         Km4w==
X-Gm-Message-State: AOAM533gCtozw+R8jUw1TQ6Dv/uiyinPvOUW0t+AJlbz4qX1TYKoNPYp
        wp0Uyvac48+8ZfOINpezb8AXDHiCCucsh5sEXyM=
X-Google-Smtp-Source: ABdhPJwXWslNGbECLTCutNYrjGjEsl1aqNqGLMo9C/wOQ1gaGhlwWqJtSbJKX13zz/WyVDNqbzTjcB6RzNztSiPudws=
X-Received: by 2002:a50:e142:: with SMTP id i2mr24359986edl.107.1633425489213;
 Tue, 05 Oct 2021 02:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211004141839.49079-1-andriy.shevchenko@linux.intel.com>
 <7019ca3e-f076-e65b-f207-c23a379ade29@gmail.com> <20211005085100.GB17524@pengutronix.de>
In-Reply-To: <20211005085100.GB17524@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Oct 2021 12:17:32 +0300
Message-ID: <CAHp75Ve6cpNkF3BB7LQhaXdQcW5j6X8QVbPj9aQy2JLgDppBfw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: dwc3: gadget: Revert "set gadgets parent to
 the right controller"
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     Ferry Toth <fntoth@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 11:52 AM Michael Grzeschik <mgr@pengutronix.de> wrote:
> On Mon, Oct 04, 2021 at 10:35:57PM +0200, Ferry Toth wrote:
> >Op 04-10-2021 om 16:18 schreef Andy Shevchenko:
> >>The commit c6e23b89a95d ("usb: dwc3: gadget: set gadgets parent to the right
> >>controller") changed the device for the UDC and broke the user space scripts
> >>that instantiate the USB gadget(s) via ConfigFS.
> >
> >I confirm this regression on Intel Edison since at least 5.15-rc2
> >while in 5.14.0 it was working fine.
> >
> >This patch resolves the issue as tested on 5.15-rc4.
> >
> >Tested-by: Ferry Toth<fntoth@gmail.com>
>
> NACK! Why should we resolv an issue by reverting it to solve not working
> userspace.

Huh?!

It is
 a) used to work;
 b) stopped working after your commit.

To me it's a clear regression. Whatever deeper problem is there, I
really don't care. The change broke my _user space_ case!

> We already have this patch as a solution for solving a deeper
> Problem, regarding the allocator addressing the right device.

Then rework it. You have still time. Your case wasn't working and one
more release of not working is not an issue here.

> >>Revert it for now until the better solution will be proposed.
>
> So, I think fixing the userspace would be the right fix,

Huh?!
https://www.kernel.org/doc/html/latest/process/4.Coding.html#regressions

> not changing
> the kernel. Otherwise we should find a proper solution.

So, please do. v5.15 should still work on our devices with
distribution that uses ConfigFS, no?


-- 
With Best Regards,
Andy Shevchenko
