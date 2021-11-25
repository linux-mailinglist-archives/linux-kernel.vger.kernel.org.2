Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F7A45DAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355479AbhKYNYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354936AbhKYNVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:21:53 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C48C061746;
        Thu, 25 Nov 2021 05:15:03 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id x10so7430719ioj.9;
        Thu, 25 Nov 2021 05:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xyiR2PHr0v2FdVXjJjFf7ZxYNF40ygtvSdsuXP9OBUU=;
        b=CFjS/aB0PL+wx4n7baOgGRPz+kIb/AduQyoggUi/nhC0McEP46hqMPqSJQ6eJImfmI
         A3OU2mIDKUBAOvaW6uGtidB1Ke6BA7u2UIfd9+hsDZdn1TWnorBTiKeF8VqxaiGjT41X
         OaWjQKNJZp3IyABuYv6jTYf6o2qiFmame9HG/Z4fv9djaevzOXHdhYC+kblVU5MXqZPv
         C1yZFZuSjl5niqBA+5QX7DGF4uOdV9ac8Fnj1lmokk28iLIXkvxPLHsIn5AYb439uw1u
         Mw1v4GB6o2mVsOqPXxcZKpLKbHm84lzLZqEic98K/ggXQw3Ve9AdBspZZZBDP15vmRKi
         pWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xyiR2PHr0v2FdVXjJjFf7ZxYNF40ygtvSdsuXP9OBUU=;
        b=3siSslGhHIfMSe8nBf4LT3tIEjNz8L8ufZRm6HlgZ6jgKY2aoPM19xBrGJSKL0+o5H
         AeweBSanF8fU9Qm5cwollrxcS0/ZHtLGlXXJZ2aUGSynMPJOMEKVhzTVhWBQXI+pNnaw
         siJuHjai1LAR3h0KrtV2M6ghNSuPadRmIafKi1z2z34264v9NqQHizsQ4uZxnf95WpFg
         cNLN99qhZE4W/syp10B3JIAG9p0/MbzYlmjlG/Iemm6LU/uDTDAJQGtvkrNOdB7PQAvh
         jKQ+94uAtFxDC3ilUOK2v9CrD1XJi6YzH0jBfKUaXSEx8f1mJ673QeOokgqRmmjcRLPV
         VbuA==
X-Gm-Message-State: AOAM530eLSJ47RjBXzzRXrEbYpQIyWvZ17rVMVlnxyID4kbgxPTELb+n
        lZLV+G63oH31DXIN5BhSmMDLHXT07jJJF8loDzT11hb1d+w=
X-Google-Smtp-Source: ABdhPJwLO9+JzZHlalI5wwCGgGwjJZbiv+i3e5xE3mtuGjvPKcJFTeStiU71quPa6yP1OJzWdSVoGwOLw73mW1Y1a5g=
X-Received: by 2002:a05:6638:3014:: with SMTP id r20mr6311602jak.146.1637846102774;
 Thu, 25 Nov 2021 05:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
In-Reply-To: <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 25 Nov 2021 14:14:51 +0100
Message-ID: <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andy, Denis, and G=C3=BCnter,

Denis worked on my code with the first attempt to read EC sensors from
ASUS motherboards and submitted it as a driver named
"asus_wmi_ec_sensors", which is not in hwmon-next. Now he adds the
ACPI lock feature to support other motherboards, and I have another
iteration of the EC sensor driver under development (needs some
polishment) that utilizes the same concept (ACPI lock instead of WMI
methods), which is smaller, cleaner and faster than the WMI-based one.
I'm going to submit it to the mainline too. I think it should replace
the WMI one. In anticipation of that, can we change the name of the
accepted driver (asus_wmi_ec_sensors -> asus_ec_sensors) now, in order
to not confuse users in the next version and to remove implementation
detail from the module name? The drivers provide indistinguishable
data to HWMON.

Regards,
Eugene

On Wed, 24 Nov 2021 at 17:11, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> > +       if (ACPI_FAILURE(acpi_acquire_mutex(data->acpi_wmi_mutex, NULL,=
 ASUSWMI_DELAY_MSEC_LOCK)))
>
>
> On Mon, Nov 22, 2021 at 11:29 PM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> No period in the Subject.
>
> > Use ACPI lock when board has separate lock for monitoring IO.
>
> the board
> a separate
>
> ...
>
> > +#define ASUSWMI_DELAY_MSEC_LOCK                500     /* Wait 0.5 s m=
ax. to get the lock */
>
> Units are the last in the names, hence (also check the comment's
> location and English)
>
> /* Wait for up to 0.5 s to acquire the lock */
> #define ASUSWMI_LOCK_TIMEOUT_MS                500
>
> ...
>
> > -       struct mutex update_lock;
> > +       struct mutex update_lock;       /* non ACPI lock */
> > +       acpi_handle acpi_wmi_mutex;     /* ACPI lock */
>
> Couldn't it be an anonymous union?
>
> ...
>
> > +static int nct6775_wmi_lock(struct nct6775_data *data)
> > +{
> > +       if (ACPI_FAILURE(acpi_acquire_mutex(data->acpi_wmi_mutex, NULL,=
 ASUSWMI_DELAY_MSEC_LOCK)))
>
> Please, use a temporary variable here and in the similar cases.
>
>   acpi_status status;
>
>   status =3D acpi_acquire_mutex(data->acpi_wmi_mutex, NULL,
> ASUSWMI_LOCK_TIMEOUT_MS));
>   if (ACPI_FAILURE(status))
>
> > +               return -EIO;
> > +
> > +       return 0;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
