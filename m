Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A976642031B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhJCRcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 13:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhJCRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:32:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0725CC0613EC;
        Sun,  3 Oct 2021 10:30:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p13so27360899edw.0;
        Sun, 03 Oct 2021 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nx23uFP7YBzW7KynLSJkC6d2qQ5HngXNFDwkHBWR0lk=;
        b=fhGEHTsEhv/Zwc517ylamR/z4Limsn4EaraS/9cstKmq8+b9o6edTUumHJBwq7JjNV
         o2b0q8va80XXfVT/aTcj4BOlBbrGRikJwGIyyoWYdolLjayE4xO1QKUvhS7J83eXkenK
         GU6Cvha1sGRlyV0nQdb5TwblgGwhaGQ63yHVHS3DHX8xxNbk6NwyVTNHPUCZrbIJ7vqP
         JCamDjZl0/q1z/tzqFDqqNAAvpMaeCJsohx+M+ukfvepRd+gM9fBaoVs6WUgJqjqhoKG
         Alz60T4cOLwHZ3SLu6GWQa1Gw+rOcjHpvg4/cGRl/BOEWe3fyBoSkyl8gpQ/k4VQEdvT
         qIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nx23uFP7YBzW7KynLSJkC6d2qQ5HngXNFDwkHBWR0lk=;
        b=TtgmOsUtc6DtgNFC9w3RqGgiuiZ1G7Y8sVyjbj1tiewUHpYlL9811hkwL/E9gRwT8g
         M/naxHYXs8LUIG/R/iMNxqWSOdhYKQe57uvUCn1/EaRpTw7XgIps1JlErlDq4i4ZNMPA
         bkeOHB998X9rcquAVOuihfiVHK6ZJSTd/G0C/woGvtsnZBTYMfO5d0fZDopOVjg0O5ST
         Rp07ojw5jMuOVfL4z983xfHk+3DFMrHIhXj5WmDMcutk0BykiduYmKlNDox1+4aFpov6
         DfTo21AjlAOdGpsW3kXpK3NxsTLZtFb8irL4Ohnj6EhwWnvaqmNUYZUii7m6xDT8bwfd
         u6ow==
X-Gm-Message-State: AOAM533OTJZJHfmRo34XrNehj7jeKw0jBRMhf9kO0Jyupprov+1r+g9c
        jxyRux3YK4IXBwL/9TfwwiEGguJbt0vWl5yXRRA=
X-Google-Smtp-Source: ABdhPJyJ816L0NPRO045GzLme97N9JS8dpWNmsA5szO6yFhlz2Rifjh5TX3TIOq62HO3pVWnfp2bCDh88ftrfmGIQ8E=
X-Received: by 2002:a05:6402:1696:: with SMTP id a22mr12270212edv.283.1633282249403;
 Sun, 03 Oct 2021 10:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211003133344.9036-1-oleksandr@natalenko.name>
In-Reply-To: <20211003133344.9036-1-oleksandr@natalenko.name>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Oct 2021 20:30:13 +0300
Message-ID: <CAHp75VeYm1NEOMjmdpw7+azrcLs_kOgEQqEVC4DqgRq=rZUkmg@mail.gmail.com>
Subject: Re: [PATCH 0/3] hwmon: add ASUS Pro WS X570-ACE support
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 4:41 PM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> Based on hwmon-next + [1].
>
> ASUS Pro WS X570-ACE board carries an nct6775 chip, which needs proper
> support without kernel command line quirk. Also, the sensors of this
> board can be monitored via BREC WMI method.
>
> This submission addresses both issues.
>
> Please review.

All three looks good to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Thanks.
>
> [1] https://lore.kernel.org/lkml/20211002210857.709956-1-pauk.denis@gmail.com/
>
> Oleksandr Natalenko (3):
>   hwmon: (nct6775) add Pro WS X570-ACE
>   hwmon: (asus_wmi_sensors) split out T_Sensor
>   hwmon: (asus_wmi_sensors) add Pro WS X570-ACE
>
>  drivers/hwmon/asus_wmi_sensors.c | 19 ++++++++++++++++---
>  drivers/hwmon/nct6775.c          |  1 +
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> --
> 2.33.0
>


-- 
With Best Regards,
Andy Shevchenko
