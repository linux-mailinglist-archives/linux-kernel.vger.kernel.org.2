Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3504A45E16E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356978AbhKYURz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244722AbhKYUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:15:54 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8B7C061746;
        Thu, 25 Nov 2021 12:10:23 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so29806188edd.13;
        Thu, 25 Nov 2021 12:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdfoBXgufbnatg+3VzfdcRdx3ogmqytd11/m71cWDhY=;
        b=hN4zOMRTOhflRitiZVTOuF6Gugsl69sq1eOfDnmoVev4go492cOzgTfHPEUeM4L/Ea
         ZCM6mvF8H2T8Mh5ji1WUcjpzEvsmmNNgSZBD8PtT9P7ohuU737YOqiS8Vkl8FocbeHMn
         x+mj2IjqvjhNfGq5LZrXM8d/vyijqIcsOtM5q1R8bUYoUNrs9NqUXgq0q0TC09JsEO7q
         RHfMpcOTlwfKMi/1bPH4k11OrZfARLrq537IkHaiRNz1kRIE/WmqmXoQ7uHd8eqAGHJO
         llF51poJBJ8yG56gJu0w7r7/0cFMwpE86JVxy5jcYpu2lU2uugtBLV06puW5rQr2hlp1
         1K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdfoBXgufbnatg+3VzfdcRdx3ogmqytd11/m71cWDhY=;
        b=nYnDkoOMQiffTxalmLrW/OfflyWZ5ug3SS7PQXXnO3a6AYRiw7ZyNwMNDUzxRZCCu9
         VCPuHyYcAYFOoLU7ISUonDypcm+KqFIBqEhgkp4PKH3NQjyuNd/4bRTOq/7sRMqG5Ngi
         XoZAVp+VdCdYdU68XgwOkC1/HrwPlOjvQ8ufyEWr/qvzNJ8TMgC2OOWJp3N2bNDDXqj/
         6lb+uOw7YUf99Fx6s/VgE0rmJ8mjuZxeArMEvPVcJbJ46zVlw557Kx5uHbmPL5d59lYt
         HYkj9pSmEOAFUlCs9qssHir1XgxCqLkahGY0yibPjz4BkrOi0GU4WeY5nAMsFk9jEciP
         StUQ==
X-Gm-Message-State: AOAM532Bn3FJd6AkXduyF7zdbrkHuYl7YiqOp7Os6HYkZYzLIogJmWX2
        NsOeOl3XduqvMS3eTim81viLeuOc5T/rcfcANww=
X-Google-Smtp-Source: ABdhPJxWEPP1p84eSC5Y6t6w7VbC9Fr7G02Sn1RnRSFhVAEGFQaauSSMOo7Ih7GsGwa/j6u928cQEacFVu+LPI+C4rc=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr33930531ejb.377.1637871022515;
 Thu, 25 Nov 2021 12:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
 <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
 <CAHp75VeO2mz7wJpuKdrErnYcw-dUOBs9W4FzA6MkgCQLr0eQUg@mail.gmail.com>
 <CAB95QAT_b8Wef+4wN-H8dKZXxgnznqOk5J0fMuL2XJLhob7d9Q@mail.gmail.com>
 <b7616187-87d8-c87f-8f66-d5936a33395f@roeck-us.net> <CAB95QAQ2vpXFxZC0G6ogbpk+rDzGMN7N8-RaUX9w_U5bQ1WGMg@mail.gmail.com>
In-Reply-To: <CAB95QAQ2vpXFxZC0G6ogbpk+rDzGMN7N8-RaUX9w_U5bQ1WGMg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Nov 2021 22:09:46 +0200
Message-ID: <CAHp75Vdi8ujoC5LTYqNmiWe1dTxrYRQKS+YtZE921d-6CZTs=A@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Denis Pauk <pauk.denis@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:05 PM Eugene Shalygin
<eugene.shalygin@gmail.com> wrote:
>
> On Thu, 25 Nov 2021 at 20:54, Guenter Roeck <linux@roeck-us.net> wrote:
> > We won't be heving two drivers with the same functionality. Give me one
> > reason why I should not drop the wmi driver (or both of them; I am not
> > sure which one we are talking about here).
> >
> > On top of all that, this submission isn't about any of the wmi drivers,
> > but for the nct6775 driver, which just adds to the confusion.
>
> Let me try to explain once again, please. I began to dig into the ASUS
> sensors and how to read their values and at first found the WMI
> function to do that, wrote a driver and Denis submitted it as
> asus_wmi_ec_sensors. Now, I know a better and simpler way to read
> those sensors, which uses ACPI mutex directly. I suggested Denis to
> use the mutex way for the nct6775 driver for motherboards without WMI
> functions to read from the nct chip. With that change entering the nct
> driver, I want to submit my updated driver for EC sensors, replacing
> the asus_wmi_ec_sensors code (which is essentially my old driver).
>
> So, now I ask to rename asus_wmi_sensors to asus_ec_sensors (source
> file and KBuild options) already before 5.16 is released, because the
> updated code, which I will submit later, and which will replace that
> in asus_wmi_ec_sensors.c, does not use WMI.
>
> Hope this clarifies my request and intention.

Since you are talking about something which is not ready yet (as I
read "will" above), I propose a compromise variant, i.e. let's leave
current driver(s) as is for v5.17 and after v5.17-rc1 you submit your
proposal for review. Okay?

-- 
With Best Regards,
Andy Shevchenko
