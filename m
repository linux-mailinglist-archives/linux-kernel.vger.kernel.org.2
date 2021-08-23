Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B143F53AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 01:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhHWXeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 19:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhHWXel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:34:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED421C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:33:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id c17so18087320pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUD3URlQQ4xgxg25mMWImAQvOjSa5iTY45I32xJuvNM=;
        b=JcBiXlmqhj3LPM6JqRufWO+Vsm8GT83ezqt7zzR0ISlNoJT4DworPjGgVfm1t+4i0/
         5B5aeOKwnYAp1tvZcXrJaRUoMfkfcqKAeqrzRkwkDL+5wb6ExRcGCQyiQ3sYaQS3z0Nn
         CICdkqDIC84EGcGGgVSaYzc0Fdn+Fqo0ruCifLry18SYaAm1K+6H/2j8/jj53i7ghvYM
         p5NukNFZdAbOhQXeQxLjTvdcCjnt8T9uHDLIniGMr0K5/9LB96xVpviaX0iUYdvw72jz
         FTOCVnnp83SuRXES+s7h3nZ1OXHSCCTQoSkNKUSvJBG0QdbLuU0bhZ7GgPC8LO/aabBt
         F/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUD3URlQQ4xgxg25mMWImAQvOjSa5iTY45I32xJuvNM=;
        b=SYm5gQ0udJSbJK6pLO1pUalI0QAT1WRD7T977G4wMS9N2kOc2KWJDazTA+/Suh9cKM
         EbdhkndJLK/8H+2CqsTFxPWvzHGkkPds9vvw01eSZXdbMHE8a+h3ZA3I681W8leNh54J
         V2KGuwEyimL1KkC3RXZH6VcakAErMZoEbxnZ8X6GSwbqA84FYa8oeytqUBUOROiAxZIe
         qr2Gd54c1R912G1Y/mh77HI9M47zx/qswrq0XTVQ+DWoRujZ0NdHiq9/eDQngoyPO/AF
         is8G3vDHBmR0kNz2hh4cTGh5EXX36U3ZSaNqhUjtcdWIXS0HaP4wLgc/KIOEO2xyIYuF
         966Q==
X-Gm-Message-State: AOAM532rlVinC3I0mNJMjR6bf3txwXcs4xGFteHTZgnR6Uu9VLgshy1k
        FDxS/xkdzhT4/Dsj87VBdsfnFeFGjhwv7bXQX8roHQ5qQ6BRI01c
X-Google-Smtp-Source: ABdhPJx/7mwpvlh4TrY49LIoOv9osixhVrk+2zmmOflygabPw1FsjiknYx/WsT7h7IzFz7ssY0Pfr+/K2hx7NAmMjXg=
X-Received: by 2002:a63:d910:: with SMTP id r16mr33990805pgg.318.1629761637490;
 Mon, 23 Aug 2021 16:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629642658.git.paskripkin@gmail.com> <9004eb2972780455db4cba9694244a2c572abba8.1629642658.git.paskripkin@gmail.com>
In-Reply-To: <9004eb2972780455db4cba9694244a2c572abba8.1629642658.git.paskripkin@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Tue, 24 Aug 2021 00:33:46 +0100
Message-ID: <CAA=Fs0=gX66TW3qoHYWcoSsvai6YZn=U81a34V45oij7NrMJrQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of rtw_read32
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021 at 15:36, Pavel Skripkin <paskripkin@gmail.com> wrote:
> -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
> +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
>  {
>         u8 requesttype;
>         u16 wvalue;
>         u16 len;
> -       __le32 data;
> +       int res;
> +       __le32 tmp;
> +
> +       if (WARN_ON(unlikely(!data)))
> +               return -EINVAL;
>
>         requesttype = 0x01;/* read_in */
>
>         wvalue = (u16)(addr & 0x0000ffff);
>         len = 4;
>
> -       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +       res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> +       if (res < 0) {
> +               dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
> +       } else {
> +               /* Noone cares about positive return value */
> +               *data = le32_to_cpu(tmp);
> +               res = 0;
> +       }
>
> -       return le32_to_cpu(data);
> +       return res;
>  }

Dear Pavel,

OK, found the issue with decoded stack trace after reviewing this
usb_read32 function. Your line:
res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);

should read:
res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);

With this change, the driver runs fine with no crashes/oopses. I will
explain the issue but you can probably see already, so I hope I'm not
coming across as patronising, just trying to be helpful :-)

Essentially, you are taking the address of the data function parameter
on this line with &data, a pointer to u32, which is giving you a
pointer to a pointer to u32 (u32 **) for this function parameter
variable. When passed to usbctrl_vendorreq, it is being passed to
memcpy inside this function as a void *, meaning that memcpy
subsequently overwrites the value of the memory address inside data to
point to a different location, which is problem when it is later
deferenced at:
*data = le32_to_cpu(tmp);
causing the OOPS

Also, as written, you can probably see that tmp is uninitialised. This
looks like a typo, so guessing this wasn't your intention. Anyhow,
with that small change, usbctrl_vendorreq reads into tmp, which is
then passed to le32_to_cpu whose return value is stored via the
deferenced data ptr (which now has its original address within and not
inadvertently modified). Hope this helps, and I'd be happy to Ack the
series if you want to resend this patch. Many thanks.

Regards,
Phil
