Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0542536BB40
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhDZVek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhDZVei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:34:38 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E28C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:33:55 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id q192so13090708ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIDuPmzhPxytj5Fxz8H+t6WOGUUiRZKI+5N5FdxPWcA=;
        b=f7Bsl2HRqgoSKtZA1OEo9CjCT7yvy46UVd9fQXeBhISTQCXh+fY6JC/QYdyS5RN/5S
         2TlcOziMAURGHaOkKR+bkpj3IpNiBEM07P2e+N5/r/lzOIBlCsvPUq5oDJvtY6luCpLO
         VgxFrD2QVn8Jd8DM/bbBKh+NDwDS3osI1AJncPFugFg8yMyqPX1bWqAHp1LyIcZfxGIt
         TgdxdvWy52Dx0dO3Qvcezrw2YDP4fhJigpUS9jG78TGzHN+SonPtLHnt+CbfPZZfg1VH
         VQRzjt/PWACZ8OM2Lbs3B/hIx3iJak8g87JjG+6bmfXK0Gtojx4tofqDdEGsMNLZ0gGH
         Gr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIDuPmzhPxytj5Fxz8H+t6WOGUUiRZKI+5N5FdxPWcA=;
        b=feYcDHTB/X3O+JrM8Hjjhef+zKgKYmUQc0uK9/8hoLLf5AWdTE4ESvMOv/ohK/uDSh
         SO0xuJS5A6IwjKWzbHcb17ffFWCztUkd+u1cSV0A5ZvhKjxpzHV0/icoRtvx8kzQJmDf
         DPklY879NPa6DuWY7pE0EytcODzpU6F5YHFrfMF0yFY+3nS0/JdhgTrGZO4c0a7G3VCE
         jf8z4/C8MXEmOysw/ME1CXmWAb5GEUEgoaWi4DdjLdXHmhQEGCvkTQUvSzF5XhHIfOwZ
         tS0G7Kr3B+phdR8G5I94X4M+uWoKpvzoGvDe63Em3+fGpEJOCUpOErxpuhtZCwvaW32H
         mKPw==
X-Gm-Message-State: AOAM5310p6vCkUxaGdD4XBAcLe4BO793W9raAM4yAKXDqx7FF1D/qDCA
        Tv01drXN7aT0zt0EJcHolIUZkQGHiGsD7+fKWf4JGg==
X-Google-Smtp-Source: ABdhPJwLl2VY0dtZA+suUEsn4n034jtV11uMqgYWkEuxAZMAl2kGLl4LAr2KIr24/m67fn946GYDX57/fmP//3k2dBk=
X-Received: by 2002:a5b:a82:: with SMTP id h2mr1115898ybq.20.1619472834555;
 Mon, 26 Apr 2021 14:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com> <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
In-Reply-To: <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 26 Apr 2021 14:33:18 -0700
Message-ID: <CAGETcx_ayXd1uDR6WHWxLmskYwOSjyynNi3Rt8irRUrfnr266w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by default""
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 1:51 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi Saravana,
>
> Adding Sudeep and Christian, Al and Jim.
>
> On 3/2/21 1:11 PM, Saravana Kannan wrote:
> > This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.
> >
> > Since all reported issues due to fw_devlink=on should be addressed by
> > this series, revert the revert. fw_devlink=on Take II.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This change breaks booting on SCMI-based platforms such as ARCH_BRCMSTB.
> If I revert this change or boot with fw_devlink=permissive, then our
> systems boot again. From a quick look, the SCMI clock provider was never
> probed which means that our UART driver never got a chance to get its
> clock and we have no console -> timeout.

We explicitly landed changes to handle this condition. So we'll see if
this is what is happening.

> Al, AFAICT you had started to analyze this before in the context of
> SCMI, do you mind sharing what you had found?
>
> Saravana, is there any debugging output that we can help provide?

Thanks for the report. Couple of things that can help:
1. Example DTS file (the final board file so that I can get the full DT view).
2. Point out the UART device node and the SCMI device node that you
suspect is causing the issue.
3. Boot logs with dev_dbg changed to dev_info in device_link_add() and
device_links_check_suppliers()

Thanks,
Saravana
