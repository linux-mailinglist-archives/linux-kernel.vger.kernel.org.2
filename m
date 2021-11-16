Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028A1453670
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbhKPP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbhKPP4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:56:22 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7309C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:53:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso2750685wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MZ1A18a8DhKkvYpaBs4OFeNvkKqocA6m1zrEyzC/omA=;
        b=CBzLNRBH30tST8SbteyK580Jlgc33s8JyRSV/Ol3bcvyubL/joCvwjYXBGkBaWUp/T
         ePTKqSk6VYpKSnAZa61/lg4/XxJzZB99jb82UGgE7SYmtGEm8PUUynoXQ6lEiWDNTuiZ
         kfxKA3MQQM1n5OPJDJHNb6XcT4CBwGuz/BXCvRSkVfDlPfeZtE1TFdQrdPE6uuiUnxC7
         ikyPO2ylqIGrV4uSHkCBeVHm4uOdkUikyEaL0yoUG0WOnUI2LsRVgPUFbEJbIXcB3zs6
         d3g+9d5wA3dAJUcIaXY411p2xgUw/aLaaf009vJ2LsT/xTTavXrCogR4ns4f03Zpz5L9
         46gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MZ1A18a8DhKkvYpaBs4OFeNvkKqocA6m1zrEyzC/omA=;
        b=DfMK886y7zYQR8IFyb7TEbO4dJOBuXbcZWhj3kJq8p3JQwHZCYBJUIbuP3I0aMy5zc
         c9RXp0wQyvbezMRR16Nht+WOmWG4V1PP/u+65pMdDYUT54uqjBbVX5ng+H+oQcHVjgO6
         HbyCQgYeneOJ0Mz+bUrMCsv2wSwymVMSfitDT6cW/jlwZzHhoEqZxDPX/a+mdrVzkeTY
         DtcNibcXvDE9BncW3cfuGkMWk/ySLFR/Q8ScpPKGZVqbhGRyDNnqXBIyFsSYfRhbS/go
         5dbHgG8NGMO+LbgbU2wrUMysBpw/ag14zZZ2TVDmMXcOse0UIAqVvzVKviG74Cunyd7D
         okfg==
X-Gm-Message-State: AOAM531vd7ivaxfCTDW+ANi72cSP23p5KilFROY5yiVFSrqH/Wpv7R/W
        amGp2T4DFQzo67+4j0iR8hdsVA==
X-Google-Smtp-Source: ABdhPJw9fKI70Duu+o9WHnfgiS2JPLAs18TSodH4cZJOBxBSbM8MhOGIF2tRod+JdFzCtqp4VdkhgQ==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr9211242wmi.61.1637078003347;
        Tue, 16 Nov 2021 07:53:23 -0800 (PST)
Received: from google.com ([95.148.6.231])
        by smtp.gmail.com with ESMTPSA id f15sm3704383wmg.30.2021.11.16.07.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:53:22 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:53:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH v2 1/1] mfd: intel-lpss: Fix too early PM enablement in
 the ACPI ->probe()
Message-ID: <YZPT8YfVXlNlBpY9@google.com>
References: <20211101190008.86473-1-andriy.shevchenko@linux.intel.com>
 <54F23B0A-9DB9-439A-B3BA-E1141703E91D@live.com>
 <YZI4FnCvAws2FLDA@smile.fi.intel.com>
 <PN2PR01MB44118FFB624CD71D6C3F0FF5B8989@PN2PR01MB4411.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN2PR01MB44118FFB624CD71D6C3F0FF5B8989@PN2PR01MB4411.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021, Aditya Garg wrote:

> 
> ________________________________
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Monday, November 15, 2021 4:06 PM
> To: Aditya Garg
> Cc: Lee Jones; linux-kernel@vger.kernel.org; Orlando Chamberlain
> Subject: Re: [PATCH v2 1/1] mfd: intel-lpss: Fix too early PM enablement in the ACPI ->probe()
> 
> On Tue, Nov 02, 2021 at 05:42:35AM +0000, Aditya Garg wrote:
> > > On 02-Nov-2021, at 12:30 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > > The runtime PM callback may be called as soon as the runtime PM facility
> > > is enabled and activated. It means that ->suspend() may be called before
> > > we finish probing the device in the ACPI case. Hence, NULL pointer
> > > dereference:
> > >
> > >  intel-lpss INT34BA:00: IRQ index 0 not found
> > >  BUG: kernel NULL pointer dereference, address: 0000000000000030
> > >  ...
> > >  Workqueue: pm pm_runtime_work
> > >  RIP: 0010:intel_lpss_suspend+0xb/0x40 [intel_lpss]
> > >
> > > To fix this, first try to register the device and only after that enable
> > > runtime PM facility.
> > >
> > > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> > > Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
> > > Reported-by: Aditya Garg <gargaditya08@live.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Tested-by: Aditya Garg <gargaditya08@live.com>
> > > ---
> > > v2: added tag (Aditya), returned 0 explicitly at the end of ->probe()
> 
> > It works
> 
> Thanks for testing again!
> 
> Lee, can we have this as a fix material for v5.16-rcX?

Generally not, no.

We usually only push patches for the -rcs if they fix something that
was broken during the merge window.  Not 6+ years ago. :)

However, if other valid fixes appear, I'll shove it into the PR too.

> I would like to have it backported to stable 5.15 too.

Yes, once it's merged into mainline, it will be back-ported as far
back as it applies cleanly.

If you have a specific kernel in mind, you should indicate it on the
end of the Fixes line.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
