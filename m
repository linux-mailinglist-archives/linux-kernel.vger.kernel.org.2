Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3442F5A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhJOOkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhJOOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:40:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EE1C061570;
        Fri, 15 Oct 2021 07:38:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w14so38821919edv.11;
        Fri, 15 Oct 2021 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1HEP6At+Hhj0+UfjA/lr3AwiRgliiJ9IAA2X6QY9jNg=;
        b=gpzcTWsjIEATku5vg2TX7wcqqI6aycAZqoq6BuILpmrWxtRQgMxpjoYCnK2GUBN0P1
         nxqbCjNi5RmP/FTgc8wce5r1UH+BHjLmG30Sb98nSA8O2P2YtYFC+Ee+sQwwPlaEwVvu
         QYUa/hbH9kOfVTF2i13OtvAIVifsi+fV1s3/+Idcjl/BVc9YKUiWk2F9/VqeAerb1pGk
         BHqG8wCdQLmJ1HrIzjqV97W42Dhp+Mv+p1ECvIP/qbGFoAWWyv6eDSAOo48fbN7P0iHU
         sdVRpvvbYRY0G8TkemZ6JuUSaG4b8BNEEbzwCYEMJ5hStyg70LlAudlUUwOZpektY3WU
         NfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1HEP6At+Hhj0+UfjA/lr3AwiRgliiJ9IAA2X6QY9jNg=;
        b=WBck8zg8iovXW9mKC5t91bEYVLX2gX1kL9ZVFSTpwQLFVHR0hCRkJBQeGdnJZp0+eO
         QjwcW67cNzTvfwOECH4jawmsI8dq2meHVhmCfLWTRAuy64xQjpQBqlnIHr1zvk48ZaqA
         KaZIhIUQZuaKTZqPLY7VCJjnGSjrVGw6fMxbFba0grVS2F2dLKUwUE2ilKp6S4RA0SX4
         sXjO0u0WxE8ZL2GQp50u7JzP9yEs6FHdoQmYjMnLVo94DwtxVQFSajCcek0EduWeRGsf
         11Qyu2QvjDNct6wVFxTR5ZZ6tyKw6FD4UO3wWZ6/QKRsFrzGJ8ascF5xqwMzEJTSLUs5
         KeKQ==
X-Gm-Message-State: AOAM5321D2hcb2xFk+29TaxVJ/4XuUDzJ4RLDvUKup8OohlPFFYybxgK
        F7ZzAv9ewCqaO/gDMGCLugMyZZWI9NobpgzQoTwraCIM/yW8ejsDvQA=
X-Google-Smtp-Source: ABdhPJzwVHwjaCBPY1T90IHyGw1GB0Emtn6fo6leBPXStxB2xCcSAJSI4dkJnJvow6Js6zD0nE1BRWqhqqZHOpVPPD4=
X-Received: by 2002:a17:906:a158:: with SMTP id bu24mr6870109ejb.356.1634308639061;
 Fri, 15 Oct 2021 07:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211015055808.327453-1-pauk.denis@gmail.com> <20211015055808.327453-2-pauk.denis@gmail.com>
 <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com> <CAB95QAQMP58-H427+nASKBvHOHZtLQqgRBSPa+MqGU7_D42M2Q@mail.gmail.com>
In-Reply-To: <CAB95QAQMP58-H427+nASKBvHOHZtLQqgRBSPa+MqGU7_D42M2Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Oct 2021 20:36:31 +0300
Message-ID: <CAHp75VfJzaSKzw4E3P=GdtMU1vpi3DvW-VLGNbuaGaykEydhFQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 5:26 PM Eugene Shalygin
<eugene.shalygin@gmail.com> wrote:

...

> > > +#define        ASUSWMI_METHODID_BREC   0x42524543
> >
> > ...above has definitely an ASCII combination in hex format, care to
> > decode it in the comment?
>
> This is a constant from the WMI dispatch function, the number is a
> four-letter ASCII-encoded method name, here BREC, which is already
> noted in the define identifier. Is it needed to repeat that?

Method name and signature might be different, I tend to ask to add a
comment, simple /* BREC */ at the end of line would suffice.

...

> > > +       utf16s_to_utf8s((wchar_t *)data, len * 2,  UTF16_LITTLE_ENDIAN, buffer, len * 2);
> >
> > > +       for (i = 0; i < len; i++, pos += 2)
> > > +               out[i] = (hex_to_bin(pos[0]) << 4) + hex_to_bin(pos[1]);
> >
> > NIH hex2bin().
>
> Does it make sense to call hex2bin() with size = 1?

Definitely. We don't want homegrown copies of library APIs.

...

> > > +       for (i = 0; i < len; i++) {
> > > +               byte = registers[i] >> 8;
> > > +               *pos = hex_asc_hi(byte);
> > > +               pos++;
> > > +               *pos = hex_asc_lo(byte);
> > > +               pos++;
> > > +               byte = registers[i];
> > > +               *pos = hex_asc_hi(byte);
> > > +               pos++;
> > > +               *pos = hex_asc_lo(byte);
> > > +               pos++;
> > > +       }
> >
> > NIH bin2hex()
>
> bin2hex() can't output UTF-16LE characters, can it? It would need an
> intermediate buffer and a call to convert ASCII (UTF-8) to UTF-16.

I didn't get it. If there is a strong endianess expected the parameter
should be __le16 or __be16, moreover it seems it missed the const
qualifier. Any preparatory stuff should be done in the
asus_wmi_ec_make_block_read_query() which prepares the input buffer,
doesn't it?

So, replace homegwon library APIs.

...

> > > +       obj = output.pointer;
> > > +       if (!obj || obj->type != ACPI_TYPE_BUFFER) {
> >
> > > +               acpi_os_free(obj);
> >
> > What's the point of calling acpi_os_free(obj) when you already know it's NULL?
>
> The case when obj->type != ACPI_TYPE_BUFFER

Read my comment again, please.

-- 
With Best Regards,
Andy Shevchenko
