Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5D4282F8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 20:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhJJSrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 14:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhJJSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 14:47:24 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB67C061570;
        Sun, 10 Oct 2021 11:45:25 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e144so17160626iof.3;
        Sun, 10 Oct 2021 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6wla9U4217W0Imp1wy+GILPot5Xepcid4Wq73wnDX9Q=;
        b=AClH7GvtlZR0Hbj47mtaCz2hRoRKOBxmFWzvFkLd16yFQ5zNLkA2SNG5D94UICK2C0
         bgbIEHxpezbNMiF8t6t6zY/JDDk228q6r5+x5/vxJXNFdkM0rcU0loaHEpULwA8la65z
         PF059v/p1BXtbJJIvHuNJti7k5x5IKkIB2B5bm5/cd5I185thvy5wJyc4v2lGJO4Vycz
         qxxawNetf7/qzmGQ/nCNl3zJqG1V40MHQW7BMyOL5k+bEuHTwTgd61NvfPjo8sIX37w0
         8XXiX5WuDWeV1J8/57ZEc6m3Kw8qvrhfRILd48Fw7A5BK8YrM9G13ug9mx2vB/w8TZa+
         cEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6wla9U4217W0Imp1wy+GILPot5Xepcid4Wq73wnDX9Q=;
        b=Go+IyMlbsr+b9r+5VEA+kEDVQz1uGjTsdmV74Rdw6SzzHw7/Drxut+h8/nNRc0B3Vo
         aqgMNNEAmbYg0/qAaIJrSk88Hl3wmBkKdZCSxm0IbRWxYlsJIx8tmE5P9fNTrrqdmjsR
         NFvx49jMIBC7LBR+4+A3hTiNUpVU8wC8z8aM7q6HOHTQKbaZJ3sGUL9bRLAwF2gnqVFG
         5adOHVVCjXRY41Io11jtMfuRiYCilHx6rpks4jS+Vl6h70Io35NY2NKLKHp31nHKHb4M
         4ImttIV4SEsLDH6fxaoJCUs5NcInQsqZObAUDGO3ftjD0vWqw7aMcnOCGJM7d47eh8rk
         Jz5w==
X-Gm-Message-State: AOAM53092lTlQON7zYASC8sedoSX4f1s6u1hIf8VLtysZGZ+e95JCqwX
        QQ+E7cxR/faoIl9H6Z/TGOhvGMWcug8HkGRnNfV2ZZOqhCK9xg==
X-Google-Smtp-Source: ABdhPJxp+Ekgvw+7xecBsFbkVIFr/YVwg8HBZnE5vOmTZU4kqSlKpwQR6HgLJ8fOP4VpGBOWRQX9tnEXlzd/Bs3T0aM=
X-Received: by 2002:a6b:f816:: with SMTP id o22mr16885812ioh.106.1633891524630;
 Sun, 10 Oct 2021 11:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222502.645003-1-pauk.denis@gmail.com> <20211006222502.645003-3-pauk.denis@gmail.com>
 <CAB95QARmjTBVRyru=ZDz9Wc5SX9EPFg7dg6vB+S8=pMtpg8FRw@mail.gmail.com>
 <20211007184644.1d042550@penguin.lxd> <CAB95QASYPRZSFnpE5u=SYJ49Hd+=BAZY==Ky8dzjL8h7YZj-CQ@mail.gmail.com>
 <CAB95QAQ+u4DmF0e9Zvy5hDV0mFQDEULtr-newtz5_6y=Bzp+ww@mail.gmail.com>
 <20211010133921.4277dc79@penguin.lxd> <CAB95QAQs_PUeTU7d9tg83a8hRepjLfLnxVykU2nvBv3Vn49HBQ@mail.gmail.com>
 <8527fb83-4b76-e3c4-85eb-542c1cee249a@roeck-us.net>
In-Reply-To: <8527fb83-4b76-e3c4-85eb-542c1cee249a@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sun, 10 Oct 2021 20:45:13 +0200
Message-ID: <CAB95QATwDkGBWdB0YWJovfN=MdtV9JkAWH2ofDFHMVYymStk5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Denis Pauk <pauk.denis@gmail.com>, andy.shevchenko@gmail.com,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G=C3=BCnter,

On Sun, 10 Oct 2021 at 16:33, Guenter Roeck <linux@roeck-us.net> wrote:
> > Why do you believe they are more reliable? How does it cover more mothe=
rboards?
> >
>
> You said yourself below: "I know the naive reading from the ACPI EC regis=
ters
> leads to problems (fans get stuck, etc.)".

I also know what the WMI functions (BREC, RSIO, WSIO, RHWM, ) do, as I
see their source. They lock the mutex (\AMW0.ASMX) and through
multi-level mapping access EC or Super I/O chip registers. I know all
the hardware access WMI functions begin with acquiring the same mutex,
and those accessing the SIO acquire one more mutex
(\_SB.PCI0.SBRG.SIO1.MUT0). Thus locking the same mutex and accessing
the hardware directly is safe.

By naive I meant reading EC registers without acquiring the ACPI mutex.

> Something in the WMI code is obviously broken and, ultimately, will need
> to get fixed. I don't know if that something is on the ASUS side or on th=
e
> kernel side, or on the interface between the two. A single WMI call takin=
g
> 1 second is way too long and strongly suggests that some timeout is invol=
ved.
> Not using WMI because of that just seems wrong.

On that machine a single reading of the EC register (i.e. a call to
ec_read()) takes approx. 14 ms. The timeout is probably right here.

From that the 990 ms delay of BREC is understandable, because for each
register it performs 4 EC transactions: read current bank,
unconditionally switch current bank, read register, switch to the old
bank. When I ask it to read 14 registers, it needs 42 ec_transaction()
calls which would sum up to 600 ms alone. In the new approach I switch
EC banks only when needed (currently only 2 times including rollback
to the previous bank) and save a lot of ec_transaction() calls. It
would help, however, to extend the EC interface in the acpi/ec.c to
allow for block reads in a single transaction.

I don't know why ec_transaction() takes so long, but in any case the
API of the WMI BREC function dictates it to perform slowly because it
needs to do a bank switch for each item in the input array, while the
direct reading allows us to avoid that bloating.

Regards,
Eugene
