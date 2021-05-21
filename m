Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5713E38C699
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhEUMfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhEUMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:35:14 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92099C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:33:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h11so18040566ili.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpO6BIafvD2hOCNXTJTJbtzAGKrAMZzzslSK25ZL87w=;
        b=O0c08Mfv2KTImi7bgzIVhWaZMR7FSlJWcaqlFhMKrnjMPnoCz7h+I/1brPipWvfsDj
         IWZqHVGAg+LfkeBYcm3sbhYZqjSiBoQ7k01GVTuKsrLB+pZCXtQM7HwCsCfI6+9bzoS7
         TUVoyenbOVEedRMxaPySsKW2YXfG4wzAWVsLULlUkL1w7hghJGu+EP3pvJdrPJmDhZu1
         ed06B+6r3NK6eMphIIu3gX+B5BlVfTc3wgelFxwAsdHrt5TUSWvwX+B3G0RU0H3tVdY2
         WwDLrv1IYiNm6FrQLkJ//hxJxvsPS9xSDGpF7DRu3OB1+XH+YIZs5aKcan2tQfwnRF51
         YgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpO6BIafvD2hOCNXTJTJbtzAGKrAMZzzslSK25ZL87w=;
        b=ixokgwkZ+ISjVYIyN++3NEeojBRjdfa0oT5n/jDMn67JkVQvikGcMnnbl/VYDmDWsk
         1KW9eHmeWdTuO7X+UdXsJqkeDaUYM37WmsvkdX2gGyj6eQcBjbN1XJThOY1Ow5cvuQCe
         Ie9IAcDyDhbe7Zi5coxTzWzn4hL47o6t3kg3E+KVXm1/gzTtXHUfoQxryCQCvWW4ODsT
         RjSnjr+BqvYUklOFQIRysUitwBWtUDrNfIbZ3yreY6j0YpLrZnEKM49ywGtwcH/2mnso
         yycisc/DXN9D+WTJIGoQIyoixY1LxWgtlnq1AKmRowtwv/yil+hzKuTT7Fgx1xYYSywD
         I5ZA==
X-Gm-Message-State: AOAM532AsiPrpZI5ysreoMfnSCzp3A2izJLhnTMZuQBxbzN8FA9C7poL
        poYmDVeZq/rGFwRx6FkYM9nh2X7x6cQDyX7un77JVA==
X-Google-Smtp-Source: ABdhPJxnXV24GGdA/oMAE68kFxV347dqFM2SrBXQKlXkrt3n9gC2hqcXRd9ei71zrCSIRiuv9RB/zXFx3G6D5ZkAPUA=
X-Received: by 2002:a05:6e02:1e05:: with SMTP id g5mr12352076ila.134.1621600430826;
 Fri, 21 May 2021 05:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210430132735.127342-1-robert.marko@sartura.hr>
 <20210430134810.GA2714262@roeck-us.net> <CA+HBbNH+gQOmu_Ho0ivFuGHdu0zBtOrr1474z+7FA1zmNb4bug@mail.gmail.com>
 <2b990feb-dc26-debb-4f81-430bbc89b51c@roeck-us.net> <CA+HBbNHQHqD-wgryaBLZ5M2Lxafb0OwNcbiQJmRQPcZfprmUEg@mail.gmail.com>
 <cfbe487f-8d01-e9b7-0aae-f93a27aff023@roeck-us.net>
In-Reply-To: <cfbe487f-8d01-e9b7-0aae-f93a27aff023@roeck-us.net>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 21 May 2021 14:33:39 +0200
Message-ID: <CA+HBbNHQrZRcz-3qBn1RkqLxOn_+sNH8VKJVihkaaiFoAy=d7g@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 1:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/21/21 1:36 AM, Robert Marko wrote:
> [ ... ]
> >> In this context, I have a hard time finding a reference for
> >> this power supply. Do you have a datasheet or some other documents
> >> you can share ?
> >
> > Unfortunately, I don't have a datasheet as that would have made this way easier.
> > It was all based on the vendor "driver" from DENT:
> > https://github.com/dentproject/dentOS/blob/main/packages/platforms/delta/arm64/tn48m/tn48m-poe/modules/builds/src/arm64-delta-tn48m-poe-psu.c
> >
>
> Ah, so this is not a driver for a power supply from DeltaPSU,
> but a power supply from Delta Networks Technology Corporation,
> as used in that company's TN48M-POE switch. That is a world
> of difference, even though the parent company seems to be the
> same. I am not sure if, based on this information, the driver
> should claim to be for "Delta DPS-920AB PSU" in the first place.

It's actually a PSU from Delta Electronics INC, Delta Networks are just using
it inside of the Delta Networks TN48M-DN-P switch.
I checked the label on the PSU-s.
>
> Can you run a block read on MFR_MODEL and MFG_SERIAL ?
> That might give us an idea about the actual manufacturer
> and model of this power supply.

MFG_SERIAL is just a bunch of 0xf-s, but MFR_MODEL has something.
However, the Armada 7040 I2C adapter cannot do block reads although
it returns 11 bytes but it's just zeros.
>
> Also, isn't that the same power supply for which you were
> trying to add another hwmon driver to display some of its
> status information, obtained from some CPLD ?

This and one more as the non-PoE version of the TN48M-DN switch
has a single 150W PSU that does not support PMBus, but the CPLD
always provides presence information and Power Good status.
>
> Thanks,
> Guenter



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
