Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7166D420052
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 08:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhJCGmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 02:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJCGmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 02:42:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA9DC0613EC;
        Sat,  2 Oct 2021 23:40:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bd28so51325317edb.9;
        Sat, 02 Oct 2021 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AeP3uMoyOD1tXyvCTemSd5AKSX3A5th0n8YPv2hmEPg=;
        b=VUM2OZ5rarPxvYf5KeJcnTLyL2duuyY1IX3UsLlN7LgZqw/UIAJsUN6TcOw1Jas01H
         1FoY/UEzEvw/ABxRCxh5qcFqgyfamBbKg3BlPS8QnTfyBiQODrCr1VhIAD7JEL0HR4Ig
         wMRGjtDrPmIRLmHwhhAU1pK6CxmiIk34s3rVRt6ga3qyXRSaibu1W0OVlbPrGnJcOO6X
         6rW3Pn6M4cuBC0xglJGpwNIvdmGXG390+P0h/Px8js+Mjp4i57gC4SBRurQGaxZm1PDI
         HoRHRPxNu7uImm34b9Pw7Ct1Ei83P2SVPfV5BPaph0K9Ze0+7KM05avNYQwxUxseObUL
         j7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeP3uMoyOD1tXyvCTemSd5AKSX3A5th0n8YPv2hmEPg=;
        b=54Af69on9/H3xa2fjjyX3IyZwOkXZ9r+te83om7akYP4xchBt5UPO/IMYpdXAUOPbK
         l5y3gnLhqf+cRTQBhBKcIHXwPA1cLmAanYOmPlo4JZ7diqnrIwlcWhL3AfHquvH+dUvc
         AZT19a15e+wPwGvlrWn6EtoGWRD0H7I27uaNzhavY+7SfcX5JCeyL6SPZ3gJlJMNIxD5
         Dc9VIkDTE8SffZ/AM1iwZncWBNOMnDMRbzuf8o2GtSMJ8lMQOR/PhnXowMZgQr3F5LLp
         WXNJSdDymxhXD0mkqVKmdORUHcrfjtKHrKo0H63VoDBOAR/5HVK/AQdhMMwSzI9pM7kp
         EiDA==
X-Gm-Message-State: AOAM532N4PVL/7nZA2VPoL+S/3bOlYDEKjvHU0GTGup0zznH6YxJB94m
        y1VQFTfdsp6ewpdVdjpNznHwTAwOPLvpTYlAfQs=
X-Google-Smtp-Source: ABdhPJxnB4bkOmaVK7ynElzFuEWKJtXBV4fz6YiOo2lh7vlc4Lk9hayFHg8p26c6XicCXIKwCpsc+TNajRCK2J6co5g=
X-Received: by 2002:a50:d987:: with SMTP id w7mr9107500edj.240.1633243220831;
 Sat, 02 Oct 2021 23:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211002210857.709956-1-pauk.denis@gmail.com>
In-Reply-To: <20211002210857.709956-1-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Oct 2021 09:39:44 +0300
Message-ID: <CAHp75VfgGZ1+YfsvfSaUP7+JgKok7oAJJzTni_cPUj0eHXNaBw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Update ASUS WMI supported boards.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 12:10 AM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Add support to nct6775:
> * PRIME B360-PLUS
> * PRIME X570-PRO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX B550-I GAMING
> * ROG STRIX X570-F GAMING
> * ROG STRIX Z390-E GAMING
> * TUF GAMING B550-PRO
> * TUF GAMING Z490-PLUS
> * TUF GAMING Z490-PLUS (WI-FI)
>
> Add sensors driver for ASUS motherboards to read sensors from the embedded
> controller. Based on https://github.com/zeule/asus-wmi-ec-sensors.
>
> Could you please review?

I will look at the last patch later on.

> @Andy Shevchenko, @Guenter Roeck should I split last patch in some way?
> Should I add to MAINTAINERS:
> --
> ASUS WMI HARDWARE MONITOR DRIVER
> M:     Eugene Shalygin <eugene.shalygin@gmail.com>
> M:     Denis Pauk <pauk.denis@gmail.com>
> L:     linux-hwmon@vger.kernel.org
> S:     Maintained
> F:     drivers/hwmon/asus_wmi_sensors.c

I don't see right now if the last patch needs a split, but MAINTAINERS
update is better to have.

...

> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>

This makes a little sense in a cover letter (have you used
--cover-letter parameter?).

> Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

This in a similar way, except the outcome is an appearing above
mentioned name in the Cc.

> Tested-by: matt-testalltheway <sefoci9222@rerunway.com>
> Tested-by: Kamil Dudka <kdudka@redhat.com>
> Tested-by: Robert Swiecki <robert@swiecki.net>
> Tested-by: Kamil Pietrzak <kpietrzak@disroot.org>
> Tested-by: Igor <igor@svelig.com>
> Tested-by: Tor Vic <torvic9@mailbox.org>
> Tested-by: Poezevara <nephartyz@gmail.com>

This is fine (and will be reflected in Cc)

> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

This I already talked about.

-- 
With Best Regards,
Andy Shevchenko
