Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ADD3160DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhBJIWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbhBJIWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:22:06 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DCEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:21:26 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id l8so1143361ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIqgcDLVoAGyNzTIfHbE7e7huwuc6dNEEW3mElUfayY=;
        b=ZMlMXKHb2IDsH2nmflNqtxbKxm/anDuvK4EdtH00w+xq+Cs62Ca05AsGNbswPdmLtI
         T70nN4QcivwcEdsLA1COlCFcdYI5Hl1yfoPSTGtd2eeIHnRYOyopk1QCCM5TyVfwsihK
         zb/xhAVPykGoXGHAHVOcuWou3IL8xnNM9k+ed4nP9y5BU+QjZWeduiErGAsS4lT9fnJC
         BxPnzYXvKT9hgjpNvRL8Yn27rtCNSL/rJsjS6To7a81t3B9AsGxISYt+3RVfbeB/hkLR
         /lYDt9k40+qNoky7XLIv4oewcqujE/kPjCvBsZ07zf2nVrEWHT7MKZYJct+lvJOUahWz
         7jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIqgcDLVoAGyNzTIfHbE7e7huwuc6dNEEW3mElUfayY=;
        b=In8bgwMSazPKMEAiBxOxUww1+Bnm9TO+qBX6vq/B8mkI9fJhRRiWnngKk+UGwM9ZNh
         TjqbSp8vtARrf7DyCffW8QE4k3M/NoBm+zoywdwvDMSiAhXhQv6zsodg0WChJObMGtY6
         4oRI8JB8QWPU40NIaanHo9065lVBnkFZqxP0WYwP87eI4PHnLb8DZNK6ZmhIgyMDpY7V
         XIaM85GCTbs0nK1gzdY575ieS++RH0MC8P8ME3C5gJ9p0g2zQeLPNB0+aW3+dLGh9CqT
         e/fgXyumwzfsz2YgnYcqhwjNOxdzLvyOJ1gcKzhryh7KH4wTnDvyWq0ahfbMI3MVbW7m
         NsYA==
X-Gm-Message-State: AOAM5319guuLc4BPF1T6BLqVbmasJ/xt2ZpWkGvNERYhUHjDZNNRXRHC
        criprjg7jDLqiSUEaovcr0IohmrVgOrzTzJ+GQSROHsI/Q9lzQ==
X-Google-Smtp-Source: ABdhPJxe4lMlmUPT3V9bnNumWyW0ZgHaz9kXcs1BB8jRN+k5h+W1A3CtJytvEe//kAbAfSLRMfqUMW+SXgsNvJeOpOA=
X-Received: by 2002:a25:b74c:: with SMTP id e12mr2914529ybm.20.1612945285197;
 Wed, 10 Feb 2021 00:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com> <20210210055430.GA73123@roeck-us.net>
In-Reply-To: <20210210055430.GA73123@roeck-us.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 10 Feb 2021 00:20:48 -0800
Message-ID: <CAGETcx-UaYEeYVXg0sd4=9t2zbBe8YH1LOoOms9ANGix=Zmypw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 9:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Dec 17, 2020 at 07:17:03PM -0800, Saravana Kannan wrote:
> > Cyclic dependencies in some firmware was one of the last remaining
> > reasons fw_devlink=on couldn't be set by default. Now that cyclic
> > dependencies don't block probing, set fw_devlink=on by default.
> >
> > Setting fw_devlink=on by default brings a bunch of benefits (currently,
> > only for systems with device tree firmware):
> > * Significantly cuts down deferred probes.
> > * Device probe is effectively attempted in graph order.
> > * Makes it much easier to load drivers as modules without having to
> >   worry about functional dependencies between modules (depmod is still
> >   needed for symbol dependencies).
> >
> > If this patch prevents some devices from probing, it's very likely due
> > to the system having one or more device drivers that "probe"/set up a
> > device (DT node with compatible property) without creating a struct
> > device for it.  If we hit such cases, the device drivers need to be
> > fixed so that they populate struct devices and probe them like normal
> > device drivers so that the driver core is aware of the devices and their
> > status. See [1] for an example of such a case.
> >
> > [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This patch breaks nios2 boot tests in qemu. The system gets stuck when
> trying to reboot. Reverting this patch fixes the problem. Bisect log
> is attached.

Thanks for the report Guenter. Can you please try this series?
https://lore.kernel.org/lkml/20210205222644.2357303-1-saravanak@google.com/

It's in driver-core-testing too if that's easier.

-Saravana
