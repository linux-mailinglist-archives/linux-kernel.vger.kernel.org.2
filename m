Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9D31D3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 03:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBQClT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 21:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBQClR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:41:17 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 18:40:32 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 133so12395900ybd.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 18:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUcVGYY2T8COLXWf6KYbS5KlqkoxN41Uds/NSZJ0Uns=;
        b=aZqHkbAUjarZjank3nasl1AXd8paRJD0j0nREMCpvoYnZrX3bvJc2uCN0WmJ73p7Ju
         cNNIXAnVm/Hfy/VB+RtCCkmgAgM+EdcuH3VBnMqNRexb/vYTo4K7IP7so/9u6ZlxZm8k
         Nh2c++c2n9grCDBKbN8wFL5hdJO963PIohkeFPcTEQl8bWPk9nEu/uaMgIZgFVL0351k
         U7jdjRb0xwH4UCKhPmyPxR2u7OpRaK9t1IM/0MxayhnVvcMkPHcaQj/i+4Fk4UAMKjbW
         kx4XvWp2mPOkgm8Cbi7gZeWiynGng0bdEdGQflnmqwEkVvB6G77LgWBkNw/dVoj9ekAJ
         gFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUcVGYY2T8COLXWf6KYbS5KlqkoxN41Uds/NSZJ0Uns=;
        b=gqIX5oIHUro1oji5INFvsRSU+oOYMtXxLx5z88LrAz7YqP7s8J1Fx5dgOZaPKnsEDe
         oB+EQCP8vvyk7vfDPrU2Me0/kdLy/9MWTuTMTxLVS/xbKFzOz8NyfYCFa4glMfzOq2I4
         TyKLVu7HkjaFeodF4v7U9K97P6BMSwpZoRfrtZfb0/Uo8lX0KviFraeHc1Tp7BGv3TQV
         nFd6q0t1Xp9K1naR5AsJTvVuVkLKKvCYfad20FLPU/iMX7RnCNSgSQeFPc95GVnRvElH
         4UeQ5j8NGtR+GTI//UTkE5EKZUfRAv4q3wuic73kJ5yPpjrJ34PkmteYupsJELYdamZi
         o6IQ==
X-Gm-Message-State: AOAM530tooUvYb0pB0azL2hL10B1ki75SpgKp9tnkVkS2xQ9mgxkjSy3
        1PaAJVIQ93OewfuP8IMFaC8FAIXxj+fqLMPQPAYaQA==
X-Google-Smtp-Source: ABdhPJzc5IUD8AQDnq5SwSXZGmfoTiq1FEx8gK8eGZizJI6DxmQEyjwcuq7B8/Nqui9TJ6xeXrMXjmukNp8Z6fxOrFY=
X-Received: by 2002:a25:b74c:: with SMTP id e12mr37054200ybm.20.1613529631400;
 Tue, 16 Feb 2021 18:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com> <20210210055430.GA73123@roeck-us.net>
 <CAGETcx-UaYEeYVXg0sd4=9t2zbBe8YH1LOoOms9ANGix=Zmypw@mail.gmail.com>
 <33f643b9-9f6d-e59a-64e7-2d2b7d3e71a4@roeck-us.net> <CAGETcx8QRDo2t==Ng2Cvs_+ZXXnM2SjMzo+A1b78XXAj1iYKSw@mail.gmail.com>
 <db598d8c-cf59-8478-2248-2ad2ab065c37@roeck-us.net>
In-Reply-To: <db598d8c-cf59-8478-2248-2ad2ab065c37@roeck-us.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Feb 2021 18:39:55 -0800
Message-ID: <CAGETcx-fQWJUyDS9HbHzBpb-1dSNX1B7jqOF9696D0rZXnBHFQ@mail.gmail.com>
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

On Wed, Feb 10, 2021 at 1:21 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/10/21 12:52 PM, Saravana Kannan wrote:
> > On Wed, Feb 10, 2021 at 7:10 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 2/10/21 12:20 AM, Saravana Kannan wrote:
> >>> On Tue, Feb 9, 2021 at 9:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>>>
> >>>> On Thu, Dec 17, 2020 at 07:17:03PM -0800, Saravana Kannan wrote:
> >>>>> Cyclic dependencies in some firmware was one of the last remaining
> >>>>> reasons fw_devlink=on couldn't be set by default. Now that cyclic
> >>>>> dependencies don't block probing, set fw_devlink=on by default.
> >>>>>
> >>>>> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> >>>>> only for systems with device tree firmware):
> >>>>> * Significantly cuts down deferred probes.
> >>>>> * Device probe is effectively attempted in graph order.
> >>>>> * Makes it much easier to load drivers as modules without having to
> >>>>>   worry about functional dependencies between modules (depmod is still
> >>>>>   needed for symbol dependencies).
> >>>>>
> >>>>> If this patch prevents some devices from probing, it's very likely due
> >>>>> to the system having one or more device drivers that "probe"/set up a
> >>>>> device (DT node with compatible property) without creating a struct
> >>>>> device for it.  If we hit such cases, the device drivers need to be
> >>>>> fixed so that they populate struct devices and probe them like normal
> >>>>> device drivers so that the driver core is aware of the devices and their
> >>>>> status. See [1] for an example of such a case.
> >>>>>
> >>>>> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> >>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>>>
> >>>> This patch breaks nios2 boot tests in qemu. The system gets stuck when
> >>>> trying to reboot. Reverting this patch fixes the problem. Bisect log
> >>>> is attached.
> >>>
> >>> Thanks for the report Guenter. Can you please try this series?
> >>> https://lore.kernel.org/lkml/20210205222644.2357303-1-saravanak@google.com/
> >>>
> >>
> >> Not this week. I have lots of reviews to complete before the end of the week,
> >> with the 5.12 commit window coming up.
> >
> > Ok. By next week, all the fixes should be in linux-next too. So it
> > should be easier if you choose to test.
> >
> >> Given the number of problems observed, I personally think that it is way
> >> too early for this patch. We'll have no end of problems if it is applied
> >> to the upstream kernel in the next commit window. Of course, that is just
> >> my personal opinion.
> >
> > You had said "with 115 of 430 boot tests failing in -next" earlier.
> > Just to be sure I understand it right, you are not saying this patch
> > caused them all right? You are just saying that 115 general boot
> > failures that might mask fw_devlink issues in some of them, right?
> >
>
> Correct.

Is it right to assume [1] fixed all known boot issues due to fw_devlink=on?
[1] - https://lore.kernel.org/lkml/20210215224258.1231449-1-saravanak@google.com/

-Saravana
