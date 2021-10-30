Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE2E440889
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 13:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhJ3LZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 07:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJ3LZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 07:25:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBADC061570;
        Sat, 30 Oct 2021 04:22:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 5so46483571edw.7;
        Sat, 30 Oct 2021 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWexc/LK6FIYBp06KI+cdl/UAdPUztyrgVADysvBRp4=;
        b=dwWzKdWF8h5SLSpkIe+VNo+53IWktafwG0rmntBROOczBXkp5tZgCaaTDe2cTNusR2
         1+438Kp9E3oUpSDBZA3U20a/z8AC/TwoNfJXKoehe/Ihwrc/qmV1HQmFBhwTpmNWPLry
         /xGGI1A6oa2t09ZjeUVGJ1ynIkhvlkcF/ynTIlJ6QJUXTWX/rAaTsNu7DgsVGiLJI8IH
         jqRxPEsWP+Cnl+Pl1RX46u54QOANMaWQ69CDrgLRCHNRFRymZ1nwpXL85EVhaZzLOL0/
         gGNZfTBg7RASOPPvx4278ajfzIdx1cinXLsxuJiJxWq9uaDawCXrxT6oPXl6fUiI3M5J
         WJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWexc/LK6FIYBp06KI+cdl/UAdPUztyrgVADysvBRp4=;
        b=ASmveCICRr0Kw9uvUq3pS9rDJwefQPFkJyqZgqinCqJ6eO9kDmw89OSCr32cvvyITj
         /w0doiBvouZh5v45zv9E/+Blf/wrVb5KOD9NjTRjX+rb1qJmeUCR9h9ZkDkYkZyhkFZp
         40epMnVSlau2WF4KdG47xOCKyCHAbwZb0oaKbHLgMWLB6gdunhEbPsR+pNaRnJ+ZHr5v
         n9QsJOxJySIzCvW1WTHBUG56Du/G9DpqEkud7+wYaai0bBF33UqI3SoZKFTQlpREDm2P
         L2aYO49DRzt8LWq2zNSX3isVco09jk22m/0l4FaKPZRSFK6M/hApilHDx6z007gNDsUw
         Ffhw==
X-Gm-Message-State: AOAM532j3IA+ZdukseW1lo9e9cDqqfNEl3yhAuliBJT9WSx6EF7URzun
        DJZDWmSXsRXWdTSAZN1+feYFHITfEuTJ90gLnpk=
X-Google-Smtp-Source: ABdhPJyWM6mUu9nd+6aSReRhyZXfjsf2nEINvwXybTGMVOc5SygZgwRXFmachl+VY9XuCAax/oSKK0p/pzvd/dD+w14=
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr20119313ejc.128.1635592971384;
 Sat, 30 Oct 2021 04:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211030091706.25470-1-pauk.denis@gmail.com>
In-Reply-To: <20211030091706.25470-1-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Oct 2021 14:22:15 +0300
Message-ID: <CAHp75Ve_dvc-33y5U3fgN-ZTGibcyO3dO7WxC_ZaPkNSh8kd0w@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Update ASUS WMI supported boards
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 12:17 PM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Add support by WMI interface provided by Asus for B550/X570 boards:
> * PRIME X570-PRO,
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-E GAMING
>
> Add support by WMI interface provided by Asus for X370/X470/
> B450/X399 boards:
> * ROG CROSSHAIR VI HERO,
> * PRIME X399-A,
> * PRIME X470-PRO,
> * ROG CROSSHAIR VI EXTREME,
> * ROG CROSSHAIR VI HERO (WI-FI AC),
> * ROG CROSSHAIR VII HERO,
> * ROG CROSSHAIR VII HERO (WI-FI),
> * ROG STRIX B450-E GAMING,
> * ROG STRIX B450-F GAMING,
> * ROG STRIX B450-I GAMING,
> * ROG STRIX X399-E GAMING,
> * ROG STRIX X470-F GAMING,
> * ROG STRIX X470-I GAMING,
> * ROG ZENITH EXTREME,
> * ROG ZENITH EXTREME ALPHA.
>
> @Andy Shevchenko: I have added your changes to asus_wmi_ec_sensors. Have I
>     correctly applied changes? Thank you.

Thanks!
Since I have no hardware, you may answer better than me, i.e. if it
works, then you did a great job!

> @Guenter Roeck: I have adeed comments about units in the
>     asus_wmi_scale_sensor_value.
>
> I have added ACPI_FREE for results to all case of
> usage wmi_evaluate_method. Is it correct?
>
> Could you please review?

I'll look at it later.

-- 
With Best Regards,
Andy Shevchenko
