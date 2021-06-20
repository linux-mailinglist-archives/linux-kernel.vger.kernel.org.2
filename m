Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ADC3ADFC7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 20:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhFTSa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 14:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhFTSaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 14:30:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806CAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 11:28:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h4so782483pgp.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6zvSQULmBV2QlEmA9WqGHtSW57kHdL85SlLu7727jk=;
        b=oCsSmEUORZxZaDLDX7wlttYZa8i3yc4McBsp+JedK/d+hs718R3TQnnyGlM007mtBy
         +rnjmE/Q7C4NSQYoPOjMCqIALMhVmZMpLc7pfksqdj2Xw0aUlBfp47hHCaBxZ1GmweiI
         dcKIQsaBe6aEYQdTGpuqFly0xvX+GvH/PZT8uJJjbvJSIpciIA+W2gIYI/syKtHVqXV4
         Xjum/KIUgj+DbON9ZQC26AWxzjoqMOCcKIOW1jqlh3U7cSIvqUCvsMbkj747JIQHfvU4
         rpo7eTIKGbAv5Qb9rxvtIum5Bhw/5oYUcwK8/zU6Bx4wcr56Ar8w/HKwY+M+L0YtQU8I
         p+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6zvSQULmBV2QlEmA9WqGHtSW57kHdL85SlLu7727jk=;
        b=QNBtog0VnpQO2R2QJ7Mu5h722qkVdLWUCi4i/uJX37CnvuWTI+udqw3t7Ez2bH7q3v
         YZZLZLYMMwBlvdPGBgiO4CCTDzKhdlfqlsFmMkV/y1dlJea5n6csFElxqtm0m8q73k/F
         KIQg9BaYV56hjcGnH2HjrQIWSNXiPYOY7JBEQU7y4NNVrbKA8drrsRaTAUGf9d8GqBdC
         QyAxk9eZ8Qv/m7p3UgvajPtlWo7sDDBxRtZLuR7MhC2EHrjC/TfpbuS++Nl7xJLXQ7/y
         xM3CZLUKm2cQrszUnNFbsgBikc5c6l0wdlzeP5y9cMSMs2gagTwr2oUcg2j+6+N4Lzoy
         bjVQ==
X-Gm-Message-State: AOAM532QFMUzGIq8pczd526Llm2xe+yo4CvjgVbyb/eXT2dp7KJRBOL4
        L/cB668ygN8mK1/Hn4epYLT+KJrwMYT25TUAdFGd9AHpTcGr4A==
X-Google-Smtp-Source: ABdhPJz8pZ2wbhybqk5UJtOOKjaWkb0GrBJznAnA4thnxDhVkeOTz874iyoKNl3ScF17SIEE73tZcL6vbnZZBrl2nUQ=
X-Received: by 2002:a63:b00d:: with SMTP id h13mr20239358pgf.74.1624213690990;
 Sun, 20 Jun 2021 11:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net> <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
 <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net> <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
In-Reply-To: <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 20 Jun 2021 21:27:34 +0300
Message-ID: <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 7:36 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Jun 20, 2021 at 2:50 PM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > Am Sun, Jun 20, 2021 at 02:19:44PM +0300 schrieb Andy Shevchenko:
> > > On Sun, Jun 20, 2021 at 11:36 AM Dominik Brodowski
> > > <linux@dominikbrodowski.net> wrote:
> > > >
> > > > Over a month ago, Andy Shevchenko reported and fixed a NULL pointer
> > > > dereference issue introduced by commit
> > > >         42e59982917a ("mfd: core: Add support for software nodes")
> > > > in v5.13-rc1:
> > > >         https://lore.kernel.org/lkml/20210510141552.57045-1-andriy.shevchenko@linux.intel.com/
> > > >
> > > > A bisect shows that it is indeed commit 42e59982917a which causes boot to
> > > > fail due to a NULL pointer dereference on my work laptop,
> > >
> > > Can you, please, be more specific? E.g. where may I find the ACPI dump
> > > of your laptop, along with other information?
> > > What you may prepare is (all run under root user)
> > > 1. `acpidump -o laptop-$MODEL.dat` (the *.dat file)
> > > 2. `grep -H 15 /sys/bus/acpi/devices/*/status`
> > > 3. `dmesg`
> > > 4. `cat /proc/iomem /proc/ioport`
> > > 5. `lspci -nk -vv`
> > >
> > > (#2 and #3 are interesting to have in working and non-working cases)
> > >
> > > Perhaps a bug on the kernel bugzilla would be a good container for all these.
> > >
> > > Also it's not clear what exactly an Oops you have (I don't believe
> > > it's the same).
> >
> > Thanks for taking a look at this issue. As it's actually a panic during
> > boot which triggers before initramfs is ready, I can only provide the data
> > for the "working case", i.e. with the patch causing the regression already
> > reverted:
> >
> >         https://bugzilla.kernel.org/show_bug.cgi?id=213511
> >
> > With commit 42e59982917a reverted, the system works just fine.
>
> Is it possible to have any traces of the panic to be logged / photoed / etc?

I'm just wondering (based on the idea behind my fix) if the commenting
out INT3446 ID entry in the intel-lpss-acpi.c will help boot this? If
so, you may try to bind it later to the driver and see the Oops.


-- 
With Best Regards,
Andy Shevchenko
