Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2F386CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbhEQWeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbhEQWeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:34:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56603C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:32:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s22so11285813ejv.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcZ2G3QXwytzE9lcG1tPQU5TKUUK+cUpbKoaNocy9es=;
        b=uHlLx7XDiUCf9VDIcwJuPWgGh98/w+VbH4mUtfNZu5tGrV/hdDzPHoyNXLgVRWYSNf
         AEGsxsbFx31kEyRYf6FT4zTH/W6lwC7WsfF5FHnW3OKnqI7UpAftKfiQavn6gRt1mn7S
         3kQuvaXP087Pr4bKGH1Djpv8KE73dViv7GSRKqlAdcVWQU7FRuT6HTr4rwo0UWnPWZ6q
         LVi3whlRNGqkyqCQfyeRE6ooaUh2RoL0uQNet9TIjbV6TDNrAuBhGsP9QEK9C/5IFdFO
         n1hOXH7gsnvmneC9iELFzJDUYN+/tij+PXmEWEgm5FT6P5HueJqSDiML8s6NJKUhaK/9
         pUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcZ2G3QXwytzE9lcG1tPQU5TKUUK+cUpbKoaNocy9es=;
        b=pW6SBbMenxaaEdKnZOBrvU/vLp3knepsnvVVyOhAfbdTU2iLzumiVHYStLPdVQ3bvw
         Pk4OieuJN4n+CRPscwBlZKgZpdBmIlTQGQcm+VO9H3YGN1/USBBhN5e97ISqkI5bnWTw
         ykZGVtvmawmyZF9/adP0w58dVnfhPlEWpeQ73HXMzTOmPMzYdzIW5mR3e14K8mZxyH0e
         Mn6b43xOvP5UsdmV76+mvnSJ7uEL0VpVSffMzAfiIZGkzn0owUxO9mgAyZdtt50aIweb
         47qnI5EGnbFGG4N8lEBrgIIB7Hpxw66E99FdOaHO+ccw2AB6PcGeYHFXT+zAzZ6NOHw2
         FV1g==
X-Gm-Message-State: AOAM533STAUG7KQp2Xyzjrc78Zbt9e/xg8CGzpUdXv8aoR0MplZInjrl
        gTyMbEQo0+nv9SiUxh7nJOAr5RlLwUP+JWveECGCQQ==
X-Google-Smtp-Source: ABdhPJxElLy/DvBzNwvKf+18AUvo1tDHzAXiFXggudyq2mUnp+hE5UGn40TY6khKdEQeLaIlN/MxZp0nHI1iQJ5FWCA=
X-Received: by 2002:a17:907:105e:: with SMTP id oy30mr2297242ejb.258.1621290775930;
 Mon, 17 May 2021 15:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210517222606.3457594-1-linchuyuan@google.com> <ff2e9bf6-f82b-01ce-6206-a9882d9d4a97@roeck-us.net>
In-Reply-To: <ff2e9bf6-f82b-01ce-6206-a9882d9d4a97@roeck-us.net>
From:   Chu Lin <linchuyuan@google.com>
Date:   Mon, 17 May 2021 15:32:44 -0700
Message-ID: <CAKCA56CUMaAw7Zga9sT_uHQ5odW-bSamssug38xvWhcNNw8eng@mail.gmail.com>
Subject: Re: [PATCH] hwmon:q54sj108a2: the PMBUS_MFR_ID is actually 6 chars
 instead of 5
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linchuyuan@gmail.com, Jason Ling <jasonling@google.com>,
        Zhongqi Li <zhongqil@google.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 3:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/17/21 3:26 PM, Chu Lin wrote:
> > The PMBUS_MFR_ID block is actually 6 chars for q54sj108a2.
> > /sys/bus/i2c/drivers/q54sj108a2_test# iotools smbus_read8 $BUS $ADDR 0x99
> > 0x06
> >
>
> What is the 6th character ? Should it be checked as well ?
>
The 6th char is \0. Do you suggest we check that as well?

Thanks,
Chu

> > Tested: Devices are able to bind to the q54sj108a2 driver successfully.
> >
> > Signed-off-by: Chu Lin <linchuyuan@google.com>
> > ---
> >   drivers/hwmon/pmbus/q54sj108a2.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
> > index aec512766c31..0976268b2670 100644
> > --- a/drivers/hwmon/pmbus/q54sj108a2.c
> > +++ b/drivers/hwmon/pmbus/q54sj108a2.c
> > @@ -299,7 +299,7 @@ static int q54sj108a2_probe(struct i2c_client *client)
> >               dev_err(&client->dev, "Failed to read Manufacturer ID\n");
> >               return ret;
> >       }
> > -     if (ret != 5 || strncmp(buf, "DELTA", 5)) {
> > +     if (ret != 6 || strncmp(buf, "DELTA", 5)) {
> >               buf[ret] = '\0';
> >               dev_err(dev, "Unsupported Manufacturer ID '%s'\n", buf);
> >               return -ENODEV;
> >
>
