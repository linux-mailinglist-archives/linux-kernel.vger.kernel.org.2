Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E645DBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355545AbhKYOB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350991AbhKYN74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:59:56 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3386AC0613B6;
        Thu, 25 Nov 2021 05:52:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so25850533edd.13;
        Thu, 25 Nov 2021 05:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w7QOqlg7NXp+XdD6x2IVHW38xoWHxMWCKBKmK9OXTFI=;
        b=d5NvN0WUd7yKpTq4Nc9aefuuCetqmxEWCWO3TA/E+xJa9uPRGbji+sq4HdO4nzXJ8r
         orKZ6NV8ofRrvcjSbpaYwTlwNLG3PONhfrYBykUner7H2YtEW5hbBB/Nu/WCgfrHPvAn
         clh8YWePEhpFaDJmOkLSXbt6L/Aqp7M/8V00nAQGZZwYZv8nweyl7fa5NTvPGHDNfMDa
         YOjo1z/SOUL9uy5pT6GJz/YaueOFsTB6pqrdyiaJj7dImND7zKM3OyGB7FQCHdXwPcS1
         L066FjYSANUm/JvfSthNBQqUlOYQlG32XRYVaBAOhRuqPYzXqsRlRxzqqXzgTv5+t84f
         2qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w7QOqlg7NXp+XdD6x2IVHW38xoWHxMWCKBKmK9OXTFI=;
        b=rwTpOQwC6mshEJv+Z4cXGAIxXKb4mpYvSK3nZfKmnhdpycF6fY9uprwWR5ZyFUJZ6Y
         z1cA4z0FN7MMTe/94h8RpRRYhxKGoH17yHJ9Uml4kyaPCtvrTivP7OjFLmd0H1naMg9c
         gTZk2htaGWgQQeAhG8TwshuP6TAuKa5ZMbGwtSpvvWJ42dikcaC2b1iyqC5ARLDh5NXW
         YHYWgVWIwYYbbfYyGsd8aCfWCnwhH6eTNpIlcrOpNjWh7T/PTOuQ7t5bqEXyuLq92oQk
         uihORIxoGlsAlnzMzqK1IJ4QS7pvgvUklNLtZreAtTOqu6WJYNi/vgkmMNyNRXvenxQZ
         /Pkg==
X-Gm-Message-State: AOAM531CemoO8aHz+z5zw1HjGg0qob8iCUQ1TUMa18AsZashox7ptLaT
        coV6ZozsPPgDf+sw4HRGfsq3Pj6mEZl3C64svUmFUryJOX0=
X-Google-Smtp-Source: ABdhPJx+OYIAa1Pd1vqUueC7F/YmpUU08xG9UUcifQ5Zl0yw0xgp6iXNig/6FGNn4cctN2raskJbJZZW2IUa9MgnMPU=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr32812491ejc.141.1637848334761;
 Thu, 25 Nov 2021 05:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com> <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
In-Reply-To: <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Nov 2021 15:51:38 +0200
Message-ID: <CAHp75VeO2mz7wJpuKdrErnYcw-dUOBs9W4FzA6MkgCQLr0eQUg@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
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

On Thu, Nov 25, 2021 at 3:15 PM Eugene Shalygin
<eugene.shalygin@gmail.com> wrote:
>
> Dear Andy, Denis, and G=C3=BCnter,

Please, do not top post in the mailing lists!

> Denis worked on my code with the first attempt to read EC sensors from
> ASUS motherboards and submitted it as a driver named
> "asus_wmi_ec_sensors", which is not in hwmon-next. Now he adds the
> ACPI lock feature to support other motherboards, and I have another
> iteration of the EC sensor driver under development (needs some
> polishment) that utilizes the same concept (ACPI lock instead of WMI
> methods), which is smaller, cleaner and faster than the WMI-based one.
> I'm going to submit it to the mainline too. I think it should replace
> the WMI one. In anticipation of that, can we change the name of the
> accepted driver (asus_wmi_ec_sensors -> asus_ec_sensors) now, in order
> to not confuse users in the next version and to remove implementation
> detail from the module name? The drivers provide indistinguishable
> data to HWMON.

I'm not sure I have got the above correctly, do you mean that the just
submitted asus_wmi_sensors HWMON driver will be replaced by your
changes? If so, you guys, need a lot to improve communication between
each other before submitting anything upstream.

--=20
With Best Regards,
Andy Shevchenko
