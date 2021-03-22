Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3825E344378
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhCVMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhCVMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:42:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:42:11 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u20so20793137lja.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tim9PBVuVi0TH58nfyNz8afp9pqyyITLZZbnoqVhySk=;
        b=Nhnpq40hG2sJsIXz9OX+tqD9B/HrOvlhJYw3U/wDOGoEU50xmcVvfxjq56kNIj8Xhy
         q6l73eSPTST2N/fvHHGu3/zqbtABhEGlplhqVg1JDXAIOgM7Lxu7fR+7tyV/glFtxkx+
         RVQuvW8rLbuBeaxKk1mtElAqQ3qQGojgqvDRm8WACGIVV4o2B7ND/THnJgcvBJCjBVKJ
         nT63a1deWRtNG9iDiFj7XGu11ZsewJ1Ajtg3bdmm5M9K5Jjvile0JEiPMkvyZIiuvl7l
         UoUIqeNCL8hE1XogSa81bnfwwMg7nj/Sq9Yx+/XU8UWgpMPul1uopVziNVgIVKjsjAKi
         PF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tim9PBVuVi0TH58nfyNz8afp9pqyyITLZZbnoqVhySk=;
        b=nzVhJ1xY6hLEQalVG01yVhyAfbc5P1dqOwU8dL1Ze4Fhylxeq5vf2oGl1JlZdyg3RG
         I2B8sLLMN4/qX+w6D5eoxROfRKhl8VB5RigpyNTRnUxAhxnWra/KkRPMN96yTOOnRUMJ
         u+FWjl921b6xHv0q5EPkLmHrJ0ULSqlMByQc5b5LucY8tKr37/TIOjUWjsT94I9RcY7v
         x+4GgrdzrLMxUmi9SlnE9SEel6ghfcQzpI4JhxQKIU59MM5z/4dYRXX3g9zhoUrCzMxM
         B0+VxX+idNuOEXV/TWaFoYXYWvt8zReldp4kANiNlbHS0Ov6mEgEB1+3UaqUXOk4IXLR
         ZmwA==
X-Gm-Message-State: AOAM531vq7OjjS6m1xNeq8lp0n7ThkZNQubXxXdzg2CdxWAKDaSr2BmX
        jsED13G651hY7OpDL3ibOU1ls6ZEE2T5is9SnIw8Nw==
X-Google-Smtp-Source: ABdhPJxiC9YVrWbysWHTKGkL3LjLkBt+soQ7jHlCqIdG5AefbiECeJhDjmS9c69MNLddHsbYsZAjkjktd9OJIorUvIU=
X-Received: by 2002:a05:651c:103a:: with SMTP id w26mr9528236ljm.273.1616416929564;
 Mon, 22 Mar 2021 05:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <1614120685-7452-1-git-send-email-Asmaa@mellanox.com>
 <1614120685-7452-2-git-send-email-Asmaa@mellanox.com> <CH2PR12MB38958655696585998CFDF67BD7919@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB38958655696585998CFDF67BD7919@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Mar 2021 13:41:58 +0100
Message-ID: <CACRpkdYVBCByG-g8jCrzdQMwdQ_7Vm0_adtVyGFzUiJJWAeNPg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Support interrupts in gpio-mlxbf2.c
To:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 9:38 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

> > That's fine, the hardware description model (I guess in your case
> > ACPI) should take care of that.
> >
> We cannot really pass it through the ACPI table because the ACPI
> table is common to all BlueField-2 boards. And each board may have
> a different GPIO pin associated with a particular function. This is
> why we use ACPI properties instead of GpioInt(). So that the
> bootloader can change the GPIO pin value based on the board
> id detected at boot time.
(...)
> Yes. It would belong in the ACPI table if we had a different ACPI
> table for each board. But unfortunately that is not the case.

You have to agree with Andy about all ACPI details.

Andy is the ACPI GPIO maintainer and we cannot merge
a patch with any kind of ACPI support without his ACK,
so hash it out as he wants it. The only people on the
planet that can make me think otherwise is if Rafael
Wysocki and Mika Westerberg say something else,
which is *extremely* unlikely.

If you need to do workarounds because of broken ACPI
tables, you need to convince the ACPI maintainers that
there is no way you can fix these tables so it needs
to be fixed in the kernel. It is not something for the
GPIO maintainers to decide.

To continue that argument please mail these people in
the MAINTAINERS file, Andy and Mika Westerberg and have
a discussion with the kernel ACPI community:

ACPI
M:      "Rafael J. Wysocki" <rjw@rjwysocki.net>
M:      Len Brown <lenb@kernel.org>
L:      linux-acpi@vger.kernel.org

Yours,
Linus Walleij
