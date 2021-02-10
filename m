Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA63171BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhBJUxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhBJUxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:53:47 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72A0C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:53:06 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id l8so3379184ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsB5KRJaGcVhcZiseIo9XXgOJ7KRckf1RNXqQ8o+K1c=;
        b=Yc469+QXefSui1tifcqA/p8KFWOiXopacGJDqvWnRhTpKQINREc+ZxaGRpuQ/WM3d6
         zJ8Swxlie5zX0zsN4cbkwZzSQFygwI91ioP3117sBFrGVPm8hFRNZWuyQsTTXI9Nlxev
         nTO9eyc04R0YG3GMyYsqgrecQlToDk4zwi5cnxJIvAL8icU12ThURwW5hQBcolgp9cmD
         YmD8nfo/VJUo5ArYG3a3WHo57QUOlZxXtkW7IE+FQ/6CEy+vLo7k2ihl6cTO7y5x2NMp
         +hGiRiwubF7X+wX6p63hJ0XFQaoZH3TJWpCbckBz+34vV2dH67qwN3YnYOwjC5q/8Bxn
         o9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsB5KRJaGcVhcZiseIo9XXgOJ7KRckf1RNXqQ8o+K1c=;
        b=ATxFC6Tjtpr1TFIRUe2ghLNmF5l6dhV5ZKPnCHyUdOCCE97vsKfBhUy9s8e1kSOX6R
         0nRzrHfa+FAKSKsxZlIhD6Sur63PquFH1mNBqA3/wW/iiNw8noGFR1anCmaiQazvKEyo
         FHrP/+qkNBFtnzOhR8d8ikDfpUsh2zor08frTylTBiKPQntinY1jXAgqf3buTiz0maBw
         9+T2dlQ+7+tCrsgZ/RkhL3UriKFb2LU6jPnwf3jBvPd1x3iBXwwHIU4/VZcWd9ajRSFe
         yZYCIacGaiJKgBvQBNfrUgy4AWIqSQa/8kUU+k86uoCa06Gg5nDdM+dM7VM0qOIDFIMX
         numg==
X-Gm-Message-State: AOAM531vZ4EDtkhpxsFh3lXpHUFb+EyKzlDRaqXsbwCP7QD78x+acKeH
        GJ6AVVqpz52zEX8ia2L50e8uNiVxbfZuqRliMfNsWg==
X-Google-Smtp-Source: ABdhPJzEGxYC0unQUTM6P37ospZaYOv+0k2jZfrKXozXK0JtOdqej1WQKJcuMy6yvyuW4YUWZ24TmviLiiq7jBgw7D0=
X-Received: by 2002:a25:718b:: with SMTP id m133mr7085877ybc.412.1612990385982;
 Wed, 10 Feb 2021 12:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com> <20210210055430.GA73123@roeck-us.net>
 <CAGETcx-UaYEeYVXg0sd4=9t2zbBe8YH1LOoOms9ANGix=Zmypw@mail.gmail.com> <33f643b9-9f6d-e59a-64e7-2d2b7d3e71a4@roeck-us.net>
In-Reply-To: <33f643b9-9f6d-e59a-64e7-2d2b7d3e71a4@roeck-us.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 10 Feb 2021 12:52:29 -0800
Message-ID: <CAGETcx8QRDo2t==Ng2Cvs_+ZXXnM2SjMzo+A1b78XXAj1iYKSw@mail.gmail.com>
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

On Wed, Feb 10, 2021 at 7:10 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/10/21 12:20 AM, Saravana Kannan wrote:
> > On Tue, Feb 9, 2021 at 9:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On Thu, Dec 17, 2020 at 07:17:03PM -0800, Saravana Kannan wrote:
> >>> Cyclic dependencies in some firmware was one of the last remaining
> >>> reasons fw_devlink=on couldn't be set by default. Now that cyclic
> >>> dependencies don't block probing, set fw_devlink=on by default.
> >>>
> >>> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> >>> only for systems with device tree firmware):
> >>> * Significantly cuts down deferred probes.
> >>> * Device probe is effectively attempted in graph order.
> >>> * Makes it much easier to load drivers as modules without having to
> >>>   worry about functional dependencies between modules (depmod is still
> >>>   needed for symbol dependencies).
> >>>
> >>> If this patch prevents some devices from probing, it's very likely due
> >>> to the system having one or more device drivers that "probe"/set up a
> >>> device (DT node with compatible property) without creating a struct
> >>> device for it.  If we hit such cases, the device drivers need to be
> >>> fixed so that they populate struct devices and probe them like normal
> >>> device drivers so that the driver core is aware of the devices and their
> >>> status. See [1] for an example of such a case.
> >>>
> >>> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>
> >> This patch breaks nios2 boot tests in qemu. The system gets stuck when
> >> trying to reboot. Reverting this patch fixes the problem. Bisect log
> >> is attached.
> >
> > Thanks for the report Guenter. Can you please try this series?
> > https://lore.kernel.org/lkml/20210205222644.2357303-1-saravanak@google.com/
> >
>
> Not this week. I have lots of reviews to complete before the end of the week,
> with the 5.12 commit window coming up.

Ok. By next week, all the fixes should be in linux-next too. So it
should be easier if you choose to test.

> Given the number of problems observed, I personally think that it is way
> too early for this patch. We'll have no end of problems if it is applied
> to the upstream kernel in the next commit window. Of course, that is just
> my personal opinion.

You had said "with 115 of 430 boot tests failing in -next" earlier.
Just to be sure I understand it right, you are not saying this patch
caused them all right? You are just saying that 115 general boot
failures that might mask fw_devlink issues in some of them, right?

Thanks,
Saravana
