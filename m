Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2985C402F83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346474AbhIGURa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345793AbhIGUR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:17:29 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD2C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:16:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m4so494920ljq.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBVcB3gRmZKLrv7PpY2nYU2VNEBB5GvLFn0wO6q1ZJs=;
        b=ggo61pACO5GBYx7im/OQaKvU+weL5b60LiGjFknBmwit+YjKmtAKdJxGjrNe74l6xZ
         aK4Uzq1GvrzT/2D4NnOq1hvDbVsoleOMjGOX0IObGey/+iRXnJkePTgrC+5Gv0hsYBMt
         q7Vb+ihtM5ctw+2r1rH9q6xOYoudE3X/lfyzxDlwbG/AVNQOMGppgc59vIDtZExJhvHI
         xEigsibhU0Ay5Zwwp4gnSz5h+mjBw2kFm+UoxvAI/6I74134d2+M0Zqym3Uv/W4/pIpd
         aKa+FR1ZTspVMKHfN2qAVhZpljzfziGzVM7CcBvea14OFlk9XRVIel5E7Lp5AT887P7g
         4zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBVcB3gRmZKLrv7PpY2nYU2VNEBB5GvLFn0wO6q1ZJs=;
        b=DO/wpHiCEEF/jNbjXTtKkkPo1CDF+UWMtaGRI0nLy22S9/atIu5sjiieEuiHmX/e9n
         btx31WMerFSvVcIGHblFK/Cyg2GmTVXNDAgJfG1dJ7Csrh5l+qpUHrJs00ljDWugZ6OM
         b7V0SrFVyP77Gw174+whyILivZW0NcmW8a2VAi+r6liHmmZbvCXX1Ln/9b2r+FKx2f9z
         QYmpQQaG6dlMpbQRR0QELx2KAmgaqHKbL9IN8nDTeNX7HYD4fxX3vH+BjmrYDVGCdYuH
         gk/pcWINn3+ddD6qJpBDJdweQ5RfHsqdNFEioFJiXa2qNNCVrBHZUG6/o4s7v+laqi+R
         ymkg==
X-Gm-Message-State: AOAM532F4uiRqEwPF7ZON0tNZIrKVJ7zqR+RvfxODelwoUJZB7sTDxRF
        06LXK/y0H32NEE7r3v8zgAkPsPTzwkBqa1k1nC8gPA==
X-Google-Smtp-Source: ABdhPJxseSKURdHcnn+fgBOBFJDfN6A4190MF+lZkTi4mDmPk2g0JcxbePPVJAaKLuhlpcRFOgz1FwR2khBwzC48lLI=
X-Received: by 2002:a05:651c:1121:: with SMTP id e1mr30522ljo.468.1631045780336;
 Tue, 07 Sep 2021 13:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
 <20210513132051.31465-1-ggherdovich@suse.cz> <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
 <067ee60e47a0350d01f0c3f216c1032818044b36.camel@suse.cz> <CAAYoRsX0xJf1mm1a_YUCzDy86r8q4QE98iVtS1AMLaUx+KTgQQ@mail.gmail.com>
 <CAAYoRsXK79PspEUh9pqgj2OGQnxQONkEeK-7af3=5frBzAqULQ@mail.gmail.com> <2a1b000cd101737400f6320ef18c0143d3a5145b.camel@linux.intel.com>
In-Reply-To: <2a1b000cd101737400f6320ef18c0143d3a5145b.camel@linux.intel.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Tue, 7 Sep 2021 13:16:10 -0700
Message-ID: <CAAYoRsVeMCivVBp-q_9N23BDOVvkc8ZLS3mubnz+4TREZ9Cz_A@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support in
 no-HWP mode
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas, Thank you for your reply.

On Tue, Sep 7, 2021 at 9:01 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Tue, 2021-09-07 at 08:45 -0700, Doug Smythies wrote:
>>
> > Recent ASUS BIOS updates have changed the default system
> > response for this old thread, rendering "intel_pstate=no_hwp"
> > useless.
> >
> > It also raises a question: If BIOS has forced HWP, then how do we
> > prevent the acpi-cpufreq driver from being used? Read on.
>
> Does BIOS has option to enable Intel speed shift with no legacy
> support?
> Then this option will not populate ACPI _PSS table.

The option is there no matter what.
I have tried every variation of legacy or no legacy that
I can find. Currently:
Current boot mode:   UEFI Firmware mode
SecureBoot:          disabled

>
> >
> > On Fri, May 14, 2021 at 3:12 PM Doug Smythies <dsmythies@telus.net>
> > wrote:
> > >
> > > On Fri, May 14, 2021 at 1:33 PM Giovanni Gherdovich <
> > > ggherdovich@suse.cz> wrote:
> > > > On Fri, 2021-05-14 at 08:31 -0700, Doug Smythies wrote:
> > ...
> > > >
...
> > Previous correspondence was with BIOS version 1003. There have been 3
> > BIOS
> > releases since then (at least that I know of), 2103, 2201, 2301, and
> > all of them
> > have changed the behaviour of the "Auto" setting for Intel Speed
> > Shift
> > Technology BIOS setting, forcing it on upon transfer of control to
> > the OS.
> >
> > Where with "intel_pstate=no_hwp" one used to get 0 for MSR_PM_ENABLE
> > (0x770) they now get 1.
>
> So they are forcing Out of band OOB mode.
> Does bit 8 or 18 in MSR 0x1aa is set?

No.

Here is the output from my msr reader/decoder program.
Kernel 5.14 (unpatched).
intel_pstate=disable
BIOS setting "Auto" for Intel Speed Shift,
Driver: acpi-cpufreq

doug@s19:~$ sudo c/msr-decoder
How many CPUs?: 12
8.) 0x198: IA32_PERF_STATUS     : CPU 0-11 :  45 :  45 :  45 :  45 :
45 :  45 :  45 :  45 :  45 :  45 :  45 :  45 :
B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
1.) 0x19C: IA32_THERM_STATUS: 88450000
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled
OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88410000
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO disable
5.) 0x771: IA32_HWP_CAPABILITIES (performance): 10B2930 : high 48 :
guaranteed 41 : efficient 11 : lowest 1
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-11 :
    raw: 80003001 : 80003001 : 80003001 : 80003001 : 80003001 :
80003001 : 80003001 : 80003001 : 80003001 : 80003001 : 80003001 :
80003001 :
    min:        1 :        1 :        1 :        1 :        1 :
1 :        1 :        1 :        1 :        1 :        1 :        1 :
    max:       48 :       48 :       48 :       48 :       48 :
48 :       48 :       48 :       48 :       48 :       48 :       48 :
    des:        0 :        0 :        0 :        0 :        0 :
0 :        0 :        0 :        0 :        0 :        0 :        0 :
    epp:      128 :      128 :      128 :      128 :      128 :
128 :      128 :      128 :      128 :      128 :      128 :      128
:
    act:        0 :        0 :        0 :        0 :        0 :
0 :        0 :        0 :        0 :        0 :        0 :        0 :
7.) 0x777: IA32_HWP_STATUS: 0 : high 0 : guaranteed 0 : efficient 0 : lowest 0

...

... Doug
