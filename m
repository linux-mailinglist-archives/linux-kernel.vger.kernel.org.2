Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5545E155
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356795AbhKYULj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhKYUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:09:37 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED78C06175B;
        Thu, 25 Nov 2021 12:05:24 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p23so8858313iod.7;
        Thu, 25 Nov 2021 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tk+wDJ0OIJSyvhiVPqoj4E54xUK6n2Q3zpVGN+CGegs=;
        b=BKd/b6HTWV41bKS7ciC/+NwIZ1/4K4nhUOFF05GvfEleMDUKUp0HJvC0fsXMj4eY4z
         kdB0L6rLa2EMarlJcU9K8hC9ODloAx/r+6mN/f0//qS4fUKED23rj6PwTT7rm8vpIR29
         x0RYemJOjXgGOU5s29uSzQKPa0WIJ/6dVU+tPeqf2rj4NtgnChdJXjOJSIlp6bhxE/tu
         1UQZyHlixcwrhuOGfCby12FU1ycsHodJr38CGbN9MXeXDU57WrJMQj6Ya0Nv6g6p78lL
         qNP9kb9uvjl+hkVK4AxXg7jUeD7EpEUV4v0NvceQu2voTy46on4YfpSS1BAaDdGZ/1ia
         9+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tk+wDJ0OIJSyvhiVPqoj4E54xUK6n2Q3zpVGN+CGegs=;
        b=bYawYtidrj08zJu0QM0tj/72eC+D1rIcpM+ckphM4w+oBhVQMtxObVD/orPBxvOxLc
         Bn2H+CBy4TE1OkQThJaOoUEdVp96D4AiUxH3g8Wr/SosoIFnI77Id6hahSHGrezxgGYi
         Sb6Qd1sAz7RdC5MxkNWym719sWX2tw5IaTvkbhzoLZrd74x8blkTRXAMExxZT2vtDp13
         cWd2yYQnXdcCuJsCs4ifEvCeqF5mBDuuQYstMrS+2VdOPOciF5RaGuTMerjPGMoEwE17
         8vgiQFlmb0mu4k2k58O1trQWqouk5mksQttKe6wOxGpJxj4SmFWGmMs6HxMK+zdNqGDE
         eUKQ==
X-Gm-Message-State: AOAM532dbur06bPT+Z0Lvbmx8k5b1/g2et/eDtHZmexqjCVli8xXG8+P
        tSTHrDhcRjzAPHnnae3aPnaKTtx0zkzR4/z7zq8=
X-Google-Smtp-Source: ABdhPJyyvN2jld5oPPLGEqT0uIXzet5/CMmfRu2rP0BA1sAFw4EAgn07nDoNish5O5T941XUkXMy3i7nlN3bWbJwu+Y=
X-Received: by 2002:a05:6638:3014:: with SMTP id r20mr10004991jak.146.1637870724006;
 Thu, 25 Nov 2021 12:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
 <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
 <CAHp75VeO2mz7wJpuKdrErnYcw-dUOBs9W4FzA6MkgCQLr0eQUg@mail.gmail.com>
 <CAB95QAT_b8Wef+4wN-H8dKZXxgnznqOk5J0fMuL2XJLhob7d9Q@mail.gmail.com> <b7616187-87d8-c87f-8f66-d5936a33395f@roeck-us.net>
In-Reply-To: <b7616187-87d8-c87f-8f66-d5936a33395f@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 25 Nov 2021 21:05:12 +0100
Message-ID: <CAB95QAQ2vpXFxZC0G6ogbpk+rDzGMN7N8-RaUX9w_U5bQ1WGMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 at 20:54, Guenter Roeck <linux@roeck-us.net> wrote:
> We won't be heving two drivers with the same functionality. Give me one
> reason why I should not drop the wmi driver (or both of them; I am not
> sure which one we are talking about here).
>
> On top of all that, this submission isn't about any of the wmi drivers,
> but for the nct6775 driver, which just adds to the confusion.

Let me try to explain once again, please. I began to dig into the ASUS
sensors and how to read their values and at first found the WMI
function to do that, wrote a driver and Denis submitted it as
asus_wmi_ec_sensors. Now, I know a better and simpler way to read
those sensors, which uses ACPI mutex directly. I suggested Denis to
use the mutex way for the nct6775 driver for motherboards without WMI
functions to read from the nct chip. With that change entering the nct
driver, I want to submit my updated driver for EC sensors, replacing
the asus_wmi_ec_sensors code (which is essentially my old driver).

So, now I ask to rename asus_wmi_sensors to asus_ec_sensors (source
file and KBuild options) already before 5.16 is released, because the
updated code, which I will submit later, and which will replace that
in asus_wmi_ec_sensors.c, does not use WMI.

Hope this clarifies my request and intention.

Best regards,
Eugene
