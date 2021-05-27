Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE63393057
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhE0OAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbhE0OA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:00:28 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1A2C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:58:54 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j30so327331ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metormote-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBwGgIAtq0k7T16dBifpnEDrgqw47u2uJ/1GL3X87l0=;
        b=h0peyp+YFFTdosSc74g3OhYTbaHr90CcVNytuV9wzripuWeY4BwGgajhvl8HchtZUR
         1mRc+bpBwD/j4UkBzkUMOZq1bCTQvybjhgAunAzA0qXYpuAYLb3JpGLA7sxY1wGs1QNy
         bKOj+nukId/c+USkNcBmwzldJjN3NRn3OI/LivKmnwCrxavSeyo0wM0amHsXbLTknAQk
         fl6xcGD5Q3hAafuZ7D+gwz/orZDXJyXcQuIkRTO3yIfDQKuRS2VGJvAgXZgl6M74yOzs
         zvhwwPb1HEIe0tKj1Q47OJdEd9vkbXC6vV708STm1d43QCceyI3yU0iSbwaQVIqGfRxO
         6QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBwGgIAtq0k7T16dBifpnEDrgqw47u2uJ/1GL3X87l0=;
        b=nIWfHFEopyZcDCNi1+tLMeaxyVdw9hOwOUJN7kTH67J1GpGkoI3wHJ+ynAm0qevox9
         ibDNg+6mjDhiXvG+WiLGlEvkcxLPubE5ghlVqSjDVS4kJIaBRUm02A3MlUeNwg/I2ypg
         I9DMZAEPeYtQvjNEyhVM3hTnC2TX5L+NRytHAgT+RLn9UyZphHajttpLlGzUX7vKFe8N
         MaO6OOBnRD9N+ULcP0aAOx+3rekxThNklSlTfoa5EN+Wi5SriymAjqcNrsYfaW+pcnU0
         4XBRvr/fvdnKi3IfvlZ6aNP1+JWYpzfihzj/VECPwQnApNU4ckV1ky+WSqn2Ac5RyjPd
         Ytvw==
X-Gm-Message-State: AOAM533K+C+HEr+r5uTN6+7/YqjQmb9HYv3ekNtmSvLgg+qRoQ8EXOmx
        hr6H1lBXcJsPXS0HK+9mRPA0jKh4pTOT7TBXRxpFdwNxHQ9bYjPoQGg=
X-Google-Smtp-Source: ABdhPJxGwYGJc3mS7bPueDKyIBU/WCO5SaJOB+Dyw93qgCViv6F0Imrsk7FlcO9q+kbJjnCQVG/91rd3tqwH1dPcRwY=
X-Received: by 2002:a05:6e02:216b:: with SMTP id s11mr3109882ilv.267.1622123933569;
 Thu, 27 May 2021 06:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210524150246.90546-1-erik.rosen@metormote.com>
 <20210524150246.90546-7-erik.rosen@metormote.com> <949e42c8-01f7-d5e5-deaa-7ba3e3a6934a@roeck-us.net>
In-Reply-To: <949e42c8-01f7-d5e5-deaa-7ba3e3a6934a@roeck-us.net>
From:   Erik Rosen <erik.rosen@metormote.com>
Date:   Thu, 27 May 2021 15:58:42 +0200
Message-ID: <CA+ui0HkatLcr0UnavOk1RkMycT4P6up5dC6rTDg9QoGGBCydMw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] hwmon: (pmbus/pim4328) Add documentation for the
 pim4328 PMBus driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, he's aware of his nomination. The rationale being that it's advantageous
to have a maintainer that has long term access to the actual hardware and
testing infrastructure. I'll ask him to send an Ack for the next version.

On Wed, May 26, 2021 at 6:33 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/24/21 8:02 AM, Erik Rosen wrote:
> > Add documentation and index link for pim4328 PMBus driver.
> >
> > Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> > ---
> >   Documentation/hwmon/index.rst   |   1 +
> >   Documentation/hwmon/pim4328.rst | 105 ++++++++++++++++++++++++++++++++
> >   MAINTAINERS                     |   7 +++
> >   3 files changed, 113 insertions(+)
> >   create mode 100644 Documentation/hwmon/pim4328.rst
> >
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 9ed60fa84cbe..719625f8f755 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -150,6 +150,7 @@ Hardware Monitoring Kernel Drivers
> >      pc87360
> >      pc87427
> >      pcf8591
> > +   pim4328
> >      pm6764tr
> >      pmbus
> >      powr1220
> > diff --git a/Documentation/hwmon/pim4328.rst b/Documentation/hwmon/pim4328.rst
> > new file mode 100644
> > index 000000000000..70c9e7a6882c
> > --- /dev/null
> > +++ b/Documentation/hwmon/pim4328.rst
> > @@ -0,0 +1,105 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel driver pim4328
> > +=====================
> > +
> > +Supported chips:
> > +
> > +  * Flex PIM4328
> > +
> > +    Prefix: 'pim4328', 'bmr455'
> > +
> > +    Addresses scanned: -
> > +
> > +    Datasheet:
> > +
> > +https://flexpowermodules.com/resources/fpm-techspec-pim4328
> > +
> > +  * Flex PIM4820
> > +
> > +    Prefixes: 'pim4820'
> > +
> > +    Addresses scanned: -
> > +
> > +    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-pim4820
> > +
> > +  * Flex PIM4006, PIM4106, PIM4206, PIM4306, PIM4406
> > +
> > +    Prefixes: 'pim4006', 'pim4106', 'pim4206', 'pim4306', 'pim4406'
> > +
> > +    Addresses scanned: -
> > +
> > +    Datasheet: https://flexpowermodules.com/resources/fpm-techspec-pim4006
> > +
> > +Author: Erik Rosen <erik.rosen@metormote.com>
> > +
> > +
> > +Description
> > +-----------
> > +
> > +This driver supports hardware monitoring for Flex PIM4328 and
> > +compatible digital power interface modules.
> > +
> > +The driver is a client driver to the core PMBus driver. Please see
> > +Documentation/hwmon/pmbus.rst and Documentation.hwmon/pmbus-core for details
> > +on PMBus client drivers.
> > +
> > +
> > +Usage Notes
> > +-----------
> > +
> > +This driver does not auto-detect devices. You will have to instantiate the
> > +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> > +details.
> > +
> > +
> > +Platform data support
> > +---------------------
> > +
> > +The driver supports standard PMBus driver platform data.
> > +
> > +
> > +Sysfs entries
> > +-------------
> > +
> > +The following attributes are supported. All attributes are read-only.
> > +
> > +======================= ========================================================
> > +in1_label            "vin"
> > +in1_input            Measured input voltage.
> > +in1_alarm            Input voltage alarm.
> > +
> > +in2_label            "vin.0"
> > +in2_input            Measured input voltage on input A.
> > +
> > +                     PIM4328 and PIM4X06
> > +
> > +in3_label            "vin.1"
> > +in3_input            Measured input voltage on input B.
> > +
> > +                     PIM4328 and PIM4X06
> > +
> > +in4_label            "vcap"
> > +in4_input            Measured voltage on holdup capacitor.
> > +
> > +                     PIM4328
> > +
> > +curr1_label          "iin.0"
> > +curr1_input          Measured input current on input A.
> > +
> > +                     PIM4X06
> > +
> > +curr2_label          "iin.1"
> > +curr2_input          Measured input current on input B.
> > +
> > +                     PIM4X06
> > +
> > +currX_label          "iout1"
> > +currX_input          Measured output current.
> > +currX_alarm          Output current alarm.
> > +
> > +                     X is 1 for PIM4820, 3 otherwise.
> > +
> > +temp1_input          Measured temperature.
> > +temp1_alarm          High temperature alarm.
> > +======================= ========================================================
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index bd7aff0c120f..378a121d80f6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14416,6 +14416,13 @@ K:   (?i)pidfd
> >   K:  (?i)clone3
> >   K:  \b(clone_args|kernel_clone_args)\b
> >
> > +PIM4328 DRIVER
> > +M:   Daniel Nilsson <daniel.nilsson@flex.com>
>
> This will require an Ack from Daniel; you can not just nominate someone
> else as maintainer.
>
> > +L:   linux-hwmon@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/hwmon/pim4328.rst
> > +F:   drivers/hwmon/pmbus/pim4328.c
> > +
> >   PIN CONTROL SUBSYSTEM
> >   M:  Linus Walleij <linus.walleij@linaro.org>
> >   L:  linux-gpio@vger.kernel.org
> >
>
