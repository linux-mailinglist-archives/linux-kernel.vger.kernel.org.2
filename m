Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AB421167
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhJDOds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhJDOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:33:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FF3C061745;
        Mon,  4 Oct 2021 07:31:57 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id k13so18423884ilo.7;
        Mon, 04 Oct 2021 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQndokDNYK2MVP5/OGRbBEhs0vecHIWi+j/FS2tyHcg=;
        b=MaxOgEqrk0MYewW+FyXBjhp1ghHhe3mKyun7OB4hww3wrTcCYGV3zQgvYdFQInr43E
         xY63N3mBUG5FT1XQxkcRCYp/mZJtf3PvPWE0v66uo1fk9oeF4lfTZiE5EdWT/gvpSIPO
         +oho6P2zERzL1cb4D9Mz33ug668A06BBfpHydIiMNwmH2zV3jHDDwAbS26Rv6VOKJvcw
         k2hyr7RJ1V1Pp0g4YlBBYw9z24x+QRpUtDdSpkd14x5yoGlNndVSyHmCb4J2PVgCwlCb
         45kH2AOBXGWEp4q3pPnqbvKK/f4yMK1T8Pknaro+Y01F/VU7RDx1wL5LBzHlU8oh/ak0
         e7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQndokDNYK2MVP5/OGRbBEhs0vecHIWi+j/FS2tyHcg=;
        b=6LJCi5J3lb4uZrU6XvMlJkayQ1fEED33cg1jdfcIDgQrR3ykhKPkpLUwgyx0F/L7u7
         PY1FaxsNHOo0Eu5zQZt9DtibFDr1rlyvkMJDUoZejOaA70HDbT5jRoKPw3oyVMGdtjUm
         HQhz39jxU1RVV3l6be6kHk7yZxlszTwpRN6tqBaFsEL8WycQ5KcKWCsb6FElxVlcq3C4
         4b9fA6cwM0W6l1G8RIpaLCaQQEWF3yEsFdhF2ESwyVTutjNbVOKbmenxPNLd2blMIpaI
         R//Oaj40c0XXBRouLtpMhwv0cpIHmmBR34Tczal1LTZUlcGgBKHtvFZl0ojKohWCjBe8
         pUMA==
X-Gm-Message-State: AOAM530x0oTgTNlNY2Pt7SppR5imqL23Q/P8miG9cZIUfd0APPcP45SM
        /WzKc8QW9yySaY/gb+zrwJdQTXcOuFwZ84c44rk=
X-Google-Smtp-Source: ABdhPJw/zO/2iUCWwdlrUJpseHZzbDhKv0N/qLiPEGtIawiGY3F+E9Y4GlxlBfwKshJlnEbGHV/XbEoaphCr2bbp7K4=
X-Received: by 2002:a05:6e02:921:: with SMTP id o1mr9702774ilt.289.1633357916341;
 Mon, 04 Oct 2021 07:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211002210857.709956-1-pauk.denis@gmail.com> <20211002210857.709956-4-pauk.denis@gmail.com>
 <CAB95QASk7JGqP2_qLtkb-PXUmKPDMcOvLr_8FLrKpv3S2602mw@mail.gmail.com> <20211003234852.213bcd87@penguin.lxd>
In-Reply-To: <20211003234852.213bcd87@penguin.lxd>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Mon, 4 Oct 2021 16:31:45 +0200
Message-ID: <CAB95QAScBpn_GioELY8QNxxOAu6rvKkk+Fb=U6_pgN_7SrMHbA@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (asus_wmi_sensors) Support access via Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I first wrote the EC sensor driver, I thought there were only a
few sensor configurations, but it turned out the assumption was wrong
and even with currently supported 6 boards the sensor to board mapping
is already hardly readable. Thus I redone that part in a declarative
way so that the sensor list for each board is condensed and is easy to
digest [1]. Please consider updating the submitted patches.

Best regards,
Eugene

[1] https://github.com/zeule/asus-wmi-ec-sensors/pull/4

On Sun, 3 Oct 2021 at 22:49, Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Hi Eugene,
>
> On Sat, 2 Oct 2021 23:56:20 +0200
> Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>
> > Hi, Denis!
> >
> > Thank you for submitting this driver to the mainline! I have a few
> > comments/suggestions, please find them below.
> >
> > > +#define HWMON_MAX      9
> >
> > There is a hwmon_max enum member, whose current value is 10.
> Thank you, I will check.
>
> >
> > > +#define ASUS_WMI_BLOCK_READ_REGISTERS_MAX 0x10 /* from the ASUS
> > > DSDT source */ +/* from the ASUS_WMI_BLOCK_READ_REGISTERS_MAX value
> > > */ +#define ASUS_WMI_MAX_BUF_LEN 0x80
> > Suggestion:
> > #define ASUS_WMI_MAX_BUF_LEN 0x80 /* from the
> > ASUS_WMI_BLOCK_READ_REGISTERS_MAX value */
> >
> > > +#define ASUSWMI_SENSORS_MAX 11
> > This one is for the EC only, maybe rename it accordingly?
> >
> Thank you, I will check.
>
> > > +struct asus_wmi_data {
> > > +       int ec_board;
> > > +};
> >
> > Duplicates the value in the asus_wmi_sensors struct. Refactoring
> > artifact?
> >
> I have used different structures for data in platform and device.
>
> >              asus_wmi_ec_set_sensor_info(si++, "Water", hwmon_fan,
> > > +
> > > asus_wmi_ec_make_sensor_address(2, 0x00, 0xBC),
> > > +                                           &ec->nr_registers);
> > This one is named "W_FLOW" in the BIOS and ASUS software. Maybe append
> > "_flow" to the label?
> >
> Thank you, I will check.
>
> > > + * The next four functions converts to/from BRxx string argument
> > > format
> > convert (remove "s")
> >
> > > +       // assert(len <= 30)
> > Makes little sense in the kernel.
> >
> Thank you, I will check.
>
> > > +static void asus_wmi_ec_make_block_read_query(struct
> > > asus_wmi_ec_info *ec) +{
> > > +       u16 registers[ASUS_EC_KNOWN_EC_REGISTERS];
> > > +       u8 i, j, register_idx = 0;
> > > +
> > > +       /* if we can get values for all the registers in a single
> > > query,
> > > +        * the query will not change from call to call
> > > +        */
> > > +       if (ec->nr_registers <= ASUS_WMI_BLOCK_READ_REGISTERS_MAX &&
> > > +           ec->read_arg[0] > 0) {
> > > +               /* no need to update */
> > > +               return;
> > > +       }
> > > +
> > I would add a test for ec->nr_registers >
> > ASUS_WMI_BLOCK_READ_REGISTERS_MAX and a warning log message here.
> >
> Thank you, I will check.
>
> > > +static int asus_wmi_probe(struct platform_device *pdev)
> >
> > Can we add a module alias or to load the module automatically by other
> > means? For module aliases we know DMI parameters for the supported
> > boards.
> >
> I will look, I prefer to reuse same module code for boards with/without
> EC endpoints same as in
> https://bugzilla.kernel.org/show_bug.cgi?id=204807#c128.
>
> > Best regards,
> > Eugene
>
> Best regards,
>             Denis.
