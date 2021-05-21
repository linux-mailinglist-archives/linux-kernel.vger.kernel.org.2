Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1262738C7B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhEUNXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhEUNWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:22:45 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C18C06138A
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:21:18 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k4so14496931ili.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbVslEDCXZqr9GQsPgesZninZAO5fJ8cP+O7eR+D2ow=;
        b=WXHL18usQi6/X1DY0P70c46qL5S/W0CO4eAaoTcpGTnbT5adPqyBw9vIAENH2Q090m
         2sWijX15tu2g5GCoRwDDMioK+ZndWOGpyIhffX+SG9wieUqydJufYiPiq0UQr7/UXQVd
         VN6q6iHizBjg56hrlAqExOTzUdMbT1T8+T5O+1G9dapo9RzYr6fPCTUeIEx1iLiitNt0
         Xjzc4bmq/BbEiwDym1y+pvyt0FsoqE1hCYAu/MRnE/H5tHxyrXUVwGskWJ+uD1gZ+gv/
         2L8Xb2tO0Fsvep+3LTZBYZnuqz5JRL33oHvlZiNNhVP8Zg4cHALC4U9zTMN01mdcLV9L
         wHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbVslEDCXZqr9GQsPgesZninZAO5fJ8cP+O7eR+D2ow=;
        b=JIHG8/s2Czmdv87wBWPpeUTQ1sUZOvh/hBmUCvgBrE08bcsAWTjjGsaLL7TwqUK/fm
         1VV0QvoNW1fQNKUDIQcbusOd27MutihuzR247Sc1sdPglMd12SqYyv8DwfNOkC5xgrAA
         94WfyvH64gunQFqossf/Rzx2RSzxpGuIGv6JScOLrW9hOAox19pUOugpMG+mZnyznmgZ
         x+MXdtKAcH/I952slSY4Mr0dZ3lrK1LCNSA2l23v3Wj4A0iZK8zhfEctTrET1Y2ccuAe
         u+6GF2gD+u6nAPxCXQLknJOSI8D0I/I4cuK3iuiKFFOr/u11DmKv3oi7C5SzbhAADYgU
         R4pg==
X-Gm-Message-State: AOAM533uONelS8FhFf7Ph2kLY5ufVZLbhiTQG5D90/GS6925oC/QNlks
        EzD01ft8jXXcnz3DZaysi9Wx6fpXJGHFMQsYWGYEFQ==
X-Google-Smtp-Source: ABdhPJyYDXBEABM+ZMXi1dpuXIBZ6wsLpvjkTRRh4YyhYrRftimgUINWny+L2YfAziSbR/6/cYnnkFB4d9ujQ/51so4=
X-Received: by 2002:a05:6e02:671:: with SMTP id l17mr11894813ilt.267.1621603276872;
 Fri, 21 May 2021 06:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210430123511.116057-1-robert.marko@sartura.hr>
 <20210430123511.116057-3-robert.marko@sartura.hr> <10b67a4dce693f013eccfd6f46ecb4c4@walle.cc>
In-Reply-To: <10b67a4dce693f013eccfd6f46ecb4c4@walle.cc>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 21 May 2021 15:21:06 +0200
Message-ID: <CA+HBbNHikM_8sCrc9FM-z7nUXVLwjpZ=Lg7fKWGbgWGBrfciOg@mail.gmail.com>
Subject: Re: [PATCH 3/6] gpio: Add Delta TN48M CPLD GPIO driver
To:     Michael Walle <michael@walle.cc>
Cc:     Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, jdelvare@suse.com,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        jmp@epiphyte.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 6:38 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2021-04-30 14:35, schrieb Robert Marko:
> > Delta TN48M CPLD is used as a GPIO expander for the SFP GPIOs.
> >
> > It is a mix of input only and output only pins.
> >
> > Since there is no logical GPIO numbering arbitrary one is used
> > along dt-bindings to make it humanly readable.
>
> Can gpio/gpio-regmap.c be used here? See gpio/gpio-sl28cpld.c
> for an example.

I suppose it can be used, I need to look into it more to see how could
translation to register and mask be done with it.

I have adapted the driver to work with simple I2C MFD so far.

It still leaves me with a finding the logical way to number the GPIO-s.

Robert
>
> -michael



--
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
