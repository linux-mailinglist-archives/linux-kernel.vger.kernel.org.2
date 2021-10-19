Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACBB434128
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 00:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhJSWFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 18:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSWFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 18:05:41 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432E9C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:03:28 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d125so22191732iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cte4Yz9UFBWmtaszK1pKMNyLvlLh7oIZGqKpmP55a3I=;
        b=csVvT0wfMqWYCBhKdl6GyQrkezOZCrIVdUbcC5K1aknXxIFfCqX44qyP+Xk35PU6ey
         Fhy88PO2FkN0632kEENPegDw4nDguAq2P8M880cMLSvDsTPs6tvBKiHG0R2jhnCj0VXd
         J84U3O/AhcbQgndBfMhpw3PTYaJLg8WduUlrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cte4Yz9UFBWmtaszK1pKMNyLvlLh7oIZGqKpmP55a3I=;
        b=itBpnGcpsZs59OgGYPd/xsFOfv+dpoIwXV4/es0QzkVh0sYLw4daRbxf8RKN6LVLam
         2Yx/QrEs1u3TfemasVrl8rx9R90FiijZEiNBUoVDqw10SYa/oCvK42+lusL8lxJxqTpf
         V+5jFgGUBKf7YeUJjLcaM7GARTZiMSR29Mt7BRhUMCpgbZ8hp/2hJSFteomE3lxMQeL4
         HHKEwBs2IC4yGOfrHXTE+IaJWIuWcrSawaHBlK9jkIXRr4YbK0Hgo8Z97DJYR0utlau8
         8dp3qJReGLfPGS8up8nS1ZdVUAGOjGB3bNXyXItHuWVx6rXbZ7wZM280JUlSrkcXdIGZ
         46Ug==
X-Gm-Message-State: AOAM533/80dRGUuEA/u+Dqy8YhgNlNP2BRzRZBYH+gbxPELcbmUGDAGd
        faDt+1ePagWVmpIq+7zRqZMI3PuxKstKXA==
X-Google-Smtp-Source: ABdhPJwKO90oFY1hYTsR3fsig/+B0a96QbadaHaTqlyyF/sx4AtlOk2xfMgg4MAr/jXL+ZEH27kVug==
X-Received: by 2002:a02:cdc2:: with SMTP id m2mr6152277jap.52.1634681007269;
        Tue, 19 Oct 2021 15:03:27 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id s7sm158481iow.31.2021.10.19.15.03.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 15:03:26 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id g2so20005714ild.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:03:26 -0700 (PDT)
X-Received: by 2002:a05:6e02:15cb:: with SMTP id q11mr20328357ilu.180.1634681005902;
 Tue, 19 Oct 2021 15:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <1632399378-12229-1-git-send-email-rajpat@codeaurora.org>
 <1632399378-12229-9-git-send-email-rajpat@codeaurora.org> <CAK8P3a3KuTEAXbSTU+n3D_fryquo8B-eXSF2+HrikiNVn6kSSg@mail.gmail.com>
 <YW8xl0fLnQE5o3AQ@ripper> <CAD=FV=XsiMp5jSpX5ong27KYW=G-XYhCfjo48E5cC6Cm+oU-mA@mail.gmail.com>
 <CAK8P3a2FroDEppfEkPge7Mm4gGF8ZNHvCwL3r-8Cg7f575YhPw@mail.gmail.com>
In-Reply-To: <CAK8P3a2FroDEppfEkPge7Mm4gGF8ZNHvCwL3r-8Cg7f575YhPw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Oct 2021 15:03:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wi9xTnWTPbakSnf9rKkiT+4AT=3db-uwhww1bdLKjv9g@mail.gmail.com>
Message-ID: <CAD=FV=Wi9xTnWTPbakSnf9rKkiT+4AT=3db-uwhww1bdLKjv9g@mail.gmail.com>
Subject: Re: [PATCH V10 8/8] arm64: dts: sc7280: Add aliases for I2C and SPI
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        msavaliy@qti.qualcomm.com, satya priya <skakit@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 19, 2021 at 2:27 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Oct 19, 2021 at 11:11 PM Doug Anderson <dianders@chromium.org> wrote:
> > On Tue, Oct 19, 2021 at 1:57 PM Bjorn Andersson
> >
> > Hrm. I know this gets into slightly controversial topics, but I'm a
> > little curious what the downside of having these in the dtsi is. In
> > the case where these i2c/spi/mmc devices _don't_ have "well defined"
> > numbers in the hardware manual of the SoC then I can agree that it
> > doesn't make sense to list these in the dtsi file. However, in the
> > case of sc7280 these numbers are well defined at the SoC level for i2c
> > and SPI.
> >
> > Said another way: if you have a board that's got peripherals connected
> > on the pins labelled "i2c2" and "i2c6" on the SoC then it's a really
> > nice thing if these show up on /dev/i2c-2 and /dev/i2c-6.
> >
> > ...so I'm not sure what board exactly would be overriding and
> > re-numbering? Unless a board really has a strong use case where they
> > need the device connected to the pins for "i2c2" to show up on
> > "/dev/i2c-0"?
>
> There are multiple things going on here:
>
> - The aliases are traditionally managed by the bootloader, same way
>    as the /chosen nodes including the kernel command line, so the
>    numbers are local policy, and the per-board defaults are just
>    for convenience.

The bootloader creates aliases? I've never seen this for I2C or SPI or
MMC, but I will admit I've been off in Chrome OS land for a really
long time and coreboot/depthcharge don't do this. I guess I could
believe that u-boot or some other bootloader does? Do you happen to
have a pointer to code that does this?


> - IMHO there should not be any aliases for status="disabled"
>   nodes, and the status is usually set in the board files.

...but there is no harm in having an alias for status="disabled",
right? Below I have a use case where it's helpful to have aliases even
for status="disabled", and if it doesn't hurt...


> - The labels on the board don't always match what the SoC calls
>   them, or there might not be any labels at all.

Are you saying that someone would draw up schematics and write on the
schematics "i2c0" and then connect it up to the pins on the SoC
labeled "i2c2"? I mean, I guess they could. I would really not like
working with the EE who did that, but people can do all sorts of crazy
things.

...or maybe you're saying that someone would take these I2C and SPI
pins and expose them to the end user with a little label over them
that said "i2c-0", "i2c-1", and "i2c-2"? ...and that end user would be
confused because the "/dev/i2c" and "/dev/spi" numbers wouldn't match?
I guess I could see that being a problem, though it feels unlikely to
come up in many cases except maybe in dev boards? This is also a new
SoC not designed onto any existing boards, so I'm not convinced that
someone would actually go and do this...


>   This is more
>   important for things like serial ports that are often bare
>   connectors rather than already wired up. The aliases should
>   normally match how the board numbers the connectors, not
>   how they are attached internally.

So for UARTs I agree with you and that's one reason why this patch
doesn't include serial aliases. There seems to be a lot of history
around UART and requirements built into userspace / other places that
require UARTs be numbered starting at 0. Also UARTs _are_ historically
exposed to end users and they want sane numbers. Luckily this doesn't
cause _too_ much confusion since usually there is only one or two
UARTs in use and mostly they just hook up to console and bluetooth.

I think of UARTs as really the exception here, not the norm.


> - For i2c, it's not uncommon to have i2c devices attached behind
>   expanders on i2c/spi/gpio/usb/pci devices

If there are extra i2c devices, that's OK. The i2c subsystem handles
will pick a number that's above the highest defined alias.

...and, in my mind, that actually gives a really good reason for
including all the aliases, even for status="disabled" nodes. Here's an
example output of `i2cdetect -l` on a sc7180-based device which has
aliases for all i2c adapters:

# i2cdetect -l
i2c-13  i2c             dpu_dp_aux                              I2C adapter
i2c-4   i2c             Geni-I2C                                I2C adapter
i2c-2   i2c             Geni-I2C                                I2C adapter
i2c-9   i2c             Geni-I2C                                I2C adapter
i2c-7   i2c             Geni-I2C                                I2C adapter
i2c-14  i2c             ti-sn65dsi86-aux                        I2C adapter
i2c-12  i2c             cros-ec-i2c-tunnel                      I2C adapter

You can see that we've got peripherals hooked up to i2c ports 2, 4, 7, and 9.

On the sc7180 SoC, there are 12 i2c ports built-in to the SoC with
well-defined numbers. These are i2c-0 through i2c-11. On this system,
there are 3 additional extra i2c adapters. You can see that the i2c
subsystem starts numbering the extra adapters at 12. This is
specifically because i2c-10 and i2c-11 aliases were defined. This is
_good_ IMO.

If I saw a log message about "i2c-10" in the logs or in /dev/, I would
first look in the sc7180 devicetree file and assume that the
peripherals must be connected to the i2c10 pins on the SoC. If I see
"i2c-12" in the logs I would quickly realize that it couldn't be one
of the SoC i2c ports and I'd go look at the dynamically numbered ones.

Yes, yes. I'm smart enough to look things up and deal with any random
/ arbitrary numbers. You could also come up with an arbitrary Chinese
character for each i2c bus and I'm smart enough to look it up and map
it to find the right port. ...but there is no reason to make people go
through this work. This is the primary SoC on the system and it has
well-defined numbers. It just makes everyone's lives a little easier
if the numbers match the reference manual.


-Doug
