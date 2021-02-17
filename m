Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA5931D425
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 04:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhBQDGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 22:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBQDG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 22:06:26 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BD5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:05:46 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id e4so10857887ote.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZebNEJ1lImmmwpebh5XbCXjAhuyB+srcG7Rw7XuCIIs=;
        b=e23dDm4heQcJYZq/AVTJZGdTFPBlfuFY51puS38KGLDZ0iRD7kMSWnHs31kcmkzOTQ
         neMqD4GFIEy0+EoR/AuMXyi6sQPdmV096K9FpOc9kc7MvwjdojVUGCAYGno9vrGh7Jta
         AKkTpeB7wPIP3F9mm1oROk75rboLQ5ABvKuEELgJGzSYyEjRFwPKNKtoWIl6nMP8TfpD
         TZaGWkLqdxT9uj7+NNj+Ti6GYMDG3ZSrl4GVWKTaE2z7rstPfqZDw+pkRGz0JScaru7t
         1eaVdzkMhY1CjOhyLrvVujQ/kI8r88PgNbU+SMzykaa4RK6JNGoQeJ5hsdhHUmzKYE3M
         kR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZebNEJ1lImmmwpebh5XbCXjAhuyB+srcG7Rw7XuCIIs=;
        b=oSKU6kE3lWnRxu2cCYrDCLab4CsvHB+A2Q8yy702gCRdsmjggyBGdJddaytVp/LO8d
         +vDEUZHE6Y84FFgswk2JJqj2zEs4uOkPb+/ITtutNJHpiOogNHSKKDOWAu1IBxbh7+sT
         oIIvpt9U5hUnuWazKLZhVDy8Ydmlp0WhY+2gdl4JWO37mM8lTG5CN3/6ha6yGKEEkSoB
         FOvP8MyxkpCJyBMzE4mtx0GazV63jS0+C0b99C5UCcf37MYoAN+a2omymgNmdjsc8esv
         NY4GDthOtb+jWPLSoEPcYKFe6ErthHsvjORzZAmsWbk5gYqfJGX9Jw8z6z5tdYuiFQW0
         hC+Q==
X-Gm-Message-State: AOAM5320fUNhLyt/k1Da8zfQI/e7NR29R+Iecii6ETLMm2ei4mAJdDk2
        1wtiyOayTh3LW63lIAQy0spb1i8yYz0=
X-Google-Smtp-Source: ABdhPJxV3iRinEuQcIRX9JY9ze8Vm1Uwdt1pAYnQdL+qS++weKPRyvrQfdnqDIb1yMj81pXhMMTkww==
X-Received: by 2002:a9d:4d85:: with SMTP id u5mr16671413otk.47.1613531145624;
        Tue, 16 Feb 2021 19:05:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 97sm163323oty.48.2021.02.16.19.05.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Feb 2021 19:05:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 Feb 2021 19:05:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
Message-ID: <20210217030543.GA189612@roeck-us.net>
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com>
 <20210210055430.GA73123@roeck-us.net>
 <CAGETcx-UaYEeYVXg0sd4=9t2zbBe8YH1LOoOms9ANGix=Zmypw@mail.gmail.com>
 <33f643b9-9f6d-e59a-64e7-2d2b7d3e71a4@roeck-us.net>
 <CAGETcx8QRDo2t==Ng2Cvs_+ZXXnM2SjMzo+A1b78XXAj1iYKSw@mail.gmail.com>
 <db598d8c-cf59-8478-2248-2ad2ab065c37@roeck-us.net>
 <CAGETcx-fQWJUyDS9HbHzBpb-1dSNX1B7jqOF9696D0rZXnBHFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-fQWJUyDS9HbHzBpb-1dSNX1B7jqOF9696D0rZXnBHFQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 06:39:55PM -0800, Saravana Kannan wrote:
> On Wed, Feb 10, 2021 at 1:21 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 2/10/21 12:52 PM, Saravana Kannan wrote:
> > > On Wed, Feb 10, 2021 at 7:10 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >>
> > >> On 2/10/21 12:20 AM, Saravana Kannan wrote:
> > >>> On Tue, Feb 9, 2021 at 9:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >>>>
> > >>>> On Thu, Dec 17, 2020 at 07:17:03PM -0800, Saravana Kannan wrote:
> > >>>>> Cyclic dependencies in some firmware was one of the last remaining
> > >>>>> reasons fw_devlink=on couldn't be set by default. Now that cyclic
> > >>>>> dependencies don't block probing, set fw_devlink=on by default.
> > >>>>>
> > >>>>> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> > >>>>> only for systems with device tree firmware):
> > >>>>> * Significantly cuts down deferred probes.
> > >>>>> * Device probe is effectively attempted in graph order.
> > >>>>> * Makes it much easier to load drivers as modules without having to
> > >>>>>   worry about functional dependencies between modules (depmod is still
> > >>>>>   needed for symbol dependencies).
> > >>>>>
> > >>>>> If this patch prevents some devices from probing, it's very likely due
> > >>>>> to the system having one or more device drivers that "probe"/set up a
> > >>>>> device (DT node with compatible property) without creating a struct
> > >>>>> device for it.  If we hit such cases, the device drivers need to be
> > >>>>> fixed so that they populate struct devices and probe them like normal
> > >>>>> device drivers so that the driver core is aware of the devices and their
> > >>>>> status. See [1] for an example of such a case.
> > >>>>>
> > >>>>> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> > >>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >>>>
> > >>>> This patch breaks nios2 boot tests in qemu. The system gets stuck when
> > >>>> trying to reboot. Reverting this patch fixes the problem. Bisect log
> > >>>> is attached.
> > >>>
> > >>> Thanks for the report Guenter. Can you please try this series?
> > >>> https://lore.kernel.org/lkml/20210205222644.2357303-1-saravanak@google.com/
> > >>>
> > >>
> > >> Not this week. I have lots of reviews to complete before the end of the week,
> > >> with the 5.12 commit window coming up.
> > >
> > > Ok. By next week, all the fixes should be in linux-next too. So it
> > > should be easier if you choose to test.
> > >
> > >> Given the number of problems observed, I personally think that it is way
> > >> too early for this patch. We'll have no end of problems if it is applied
> > >> to the upstream kernel in the next commit window. Of course, that is just
> > >> my personal opinion.
> > >
> > > You had said "with 115 of 430 boot tests failing in -next" earlier.
> > > Just to be sure I understand it right, you are not saying this patch
> > > caused them all right? You are just saying that 115 general boot
> > > failures that might mask fw_devlink issues in some of them, right?
> > >
> >
> > Correct.
> 
> Is it right to assume [1] fixed all known boot issues due to fw_devlink=on?
> [1] - https://lore.kernel.org/lkml/20210215224258.1231449-1-saravanak@google.com/
> 

I honestly don't know. Current status of -next in my tests is:

Build results:
	total: 149 pass: 144 fail: 5
Qemu test results:
	total: 432 pass: 371 fail: 61

This is for next-20210216. Newly introduced failures keep popping up. Some
of the failures have been persistent for weeks, so it is all but impossible
to say if affected platforms experience more than one failure.

Also, please keep in mind that my boot tests are very shallow, along the
line of "it boots, therefore it works". It only tests hardware which is
emulated by qemu and is needed for booting. It tests probably much less
than 1% of driver code. It can and should not be used for any useful
fw_devlink related test coverage.

Thanks,
Guenter
