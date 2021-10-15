Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79142F537
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbhJOO2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbhJOO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:28:15 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5842EC061570;
        Fri, 15 Oct 2021 07:26:09 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id s17so7877956ioa.13;
        Fri, 15 Oct 2021 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoxPsmnc01VS+MXakR3w69x2ei/elIBkKRVWfGQtpeQ=;
        b=Wk4FiEkzfymg8nQOcrLtLcRFiR/itEoqbhDsMUDdjABFxDgI/q+/eOpGiooJrLpbYR
         /7CpmfDl0EcJ/JJxMAJlemV4qTNQ72boy7Aob6T6gMZ2F5s34G2qrCx1owFLyoQofl1j
         6j0DSYAhigtADL3lnkRGVfVt8EViL22wKoLrjKcxxWoNaKdM16jbewLFgMPoGtzyZ7Rx
         +pyFTwxwwy+4L2K0TUvfi3+hzwxxfVonIJoZLPpZwNMFCJbWJ5gLfCopR0oI0yxmFhAN
         Wb5lNUABlWi5+DfO/5toq8ubNTgysiL8mWljPKgxRaFcRN/0DezYDnX6X0Jdbt/XxMX6
         xDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoxPsmnc01VS+MXakR3w69x2ei/elIBkKRVWfGQtpeQ=;
        b=FOK5QhjWGk/fvS+MY0n/QFxDcXb6YXbP/Ftiskqpi5nnvDYVphgxgbPFJbbA9AIRiK
         AQydxHgJTiDOcPHcOBSZjmYKwD0Ey0AfuTz8RBj8KVEHVgjoUi8JXyvOcZ/swUE1ZeZ+
         Qmw2rZPQJH70Weeq1RPGkXCNbXNnbVQtFuqd943RSRJJnctR2UP+1zjpIETUPhiFGTNy
         /WXwYZK7SsdMj1vR3Bot0qGvPam+rcVP0KeLBItFKTkOg6dmpd0If2CRFLF4gz5aCIkN
         E9GVuBSl4NCaXllG8L61p0daUDlRE3GoY2ttAjGB6MJzdpR3oWWdH27Kv2dnbsGYeXJM
         KLrA==
X-Gm-Message-State: AOAM531ZocfGVPFztUpZ3Xxs65vaVjSiT/cjBrbCZFrhUCWgqwErqgtW
        ByOfalo8uCAjUtR1j6HPZNvuv3x04EVkX+h1Rk8=
X-Google-Smtp-Source: ABdhPJwqJKE4HRjNGvtHlHAn5UXmcbJDLTqP+RhK1SBxcQZWOPsrfkUqGDJu/vOqVZZXTrd6bq3S8U8fseoCy4YvBB0=
X-Received: by 2002:a02:2124:: with SMTP id e36mr8485785jaa.35.1634307968705;
 Fri, 15 Oct 2021 07:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211015055808.327453-1-pauk.denis@gmail.com> <20211015055808.327453-2-pauk.denis@gmail.com>
 <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com>
In-Reply-To: <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 15 Oct 2021 16:25:57 +0200
Message-ID: <CAB95QAQMP58-H427+nASKBvHOHZtLQqgRBSPa+MqGU7_D42M2Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

Hi, Andy,


> > +#define        ASUSWMI_METHODID_BREC   0x42524543
>
> ...above has definitely an ASCII combination in hex format, care to
> decode it in the comment?

This is a constant from the WMI dispatch function, the number is a
four-letter ASCII-encoded method name, here BREC, which is already
noted in the define identifier. Is it needed to repeat that?

> > +       utf16s_to_utf8s((wchar_t *)data, len * 2,  UTF16_LITTLE_ENDIAN, buffer, len * 2);
>
> > +       for (i = 0; i < len; i++, pos += 2)
> > +               out[i] = (hex_to_bin(pos[0]) << 4) + hex_to_bin(pos[1]);
>
> NIH hex2bin().

Does it make sense to call hex2bin() with size = 1?

> > +       for (i = 0; i < len; i++) {
> > +               byte = registers[i] >> 8;
> > +               *pos = hex_asc_hi(byte);
> > +               pos++;
> > +               *pos = hex_asc_lo(byte);
> > +               pos++;
> > +               byte = registers[i];
> > +               *pos = hex_asc_hi(byte);
> > +               pos++;
> > +               *pos = hex_asc_lo(byte);
> > +               pos++;
> > +       }
>
> NIH bin2hex()

bin2hex() can't output UTF-16LE characters, can it? It would need an
intermediate buffer and a call to convert ASCII (UTF-8) to UTF-16.


> > +       obj = output.pointer;
> > +       if (!obj || obj->type != ACPI_TYPE_BUFFER) {
>
> > +               acpi_os_free(obj);
>
> What's the point of calling acpi_os_free(obj) when you already know it's NULL?

The case when obj->type != ACPI_TYPE_BUFFER

Regards,
Eugene
