Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109CB3F5400
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 02:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhHXAL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 20:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhHXALZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 20:11:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F29C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 17:10:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id x11so40665414ejv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 17:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFa/vNXbOTkZVECzFyo1BP3x0iFIJhbAlOvPMoA4Yo4=;
        b=bm2bQu1aHZ9J8cmciQhZPFBuntv/uZy6KS3dfLJAqaaUHSfjLev+ubv/Aj6xbD7Dwu
         gWVQ6t8c+vG9qgCm1a33LkhOUWg52KmQzIAqoQJOaySbfFhfmLZdbpv9N9KM5vIMG+8z
         X9/Ed3J2WS4CiJUpNzl0blpe4lxwyj4W+H+dE7L08KBJlYFRAEk4mCpentH/GwBzAv0X
         iJ3karqOibXrgSMNNO8DLbIhPYJT+xcDX/Z5fjA8d+1zWN2OMXxG8MJvcBl0hPXMJpwZ
         0xL7XxZOOnlawvbXiJ3N4vaTaG4E9MnHaBOHoSq5kc70G3uUBQkVRr+5KXIJhZ9IJg4P
         vTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFa/vNXbOTkZVECzFyo1BP3x0iFIJhbAlOvPMoA4Yo4=;
        b=QiicZmPZCmBXxyx3v/IOKcZtDOQE7Pke9Dx2Xpr9XvBu1g90Oq3fE94DtI1KUjJaLp
         F+dLtbu9KPafJUqV4MYnSvP9KGJ8fTDZZf5VlHYhMSMEJV8gHZuyRyJIwKtVZkf68uRZ
         KI2w+fTfK0jJMa/j1sIx6xgEyfgRdmkm9Uf0VDVzSI8iJkHDV1oOSiAkMlrtXK6Bhf2n
         Ekd00Un29LwrwuKU8Hj0z4H7/yhGCHGF19FVfW8f29sj4/c9I09KO+gOIhSH7OS+3tt5
         bD3RTlKdOacXEJXoW4U95TNRs/DigkuCpz9ahw+B0k0Gtn8cixDByYw7lCmhvw9a5I1n
         RDYA==
X-Gm-Message-State: AOAM531eVDMyt1T+P3PfjZqSajQnZO2lam12m3UQ9TZx7t4NB7jRiICR
        8wEr0HvsTftTbJM5b5ldjJo=
X-Google-Smtp-Source: ABdhPJzPbz9pHA31WemzzpNGNV/666FPgTsPXhwuhMdh35F/9FiJdWh1JuiiV/rsJSc24hpsXRGBQg==
X-Received: by 2002:a17:906:5497:: with SMTP id r23mr1262301ejo.302.1629763840571;
        Mon, 23 Aug 2021 17:10:40 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id m19sm10042670edd.38.2021.08.23.17.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 17:10:40 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of rtw_read32
Date:   Tue, 24 Aug 2021 02:10:37 +0200
Message-ID: <2424268.2DCLMNk6Lg@localhost.localdomain>
In-Reply-To: <CAA=Fs0=gX66TW3qoHYWcoSsvai6YZn=U81a34V45oij7NrMJrQ@mail.gmail.com>
References: <cover.1629642658.git.paskripkin@gmail.com> <9004eb2972780455db4cba9694244a2c572abba8.1629642658.git.paskripkin@gmail.com> <CAA=Fs0=gX66TW3qoHYWcoSsvai6YZn=U81a34V45oij7NrMJrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 1:33:46 AM CEST Phillip Potter wrote:
> On Sun, 22 Aug 2021 at 15:36, Pavel Skripkin <paskripkin@gmail.com> wrote:
> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
> >  {
> >         u8 requesttype;
> >         u16 wvalue;
> >         u16 len;
> > -       __le32 data;
> > +       int res;
> > +       __le32 tmp;
> > +
> > +       if (WARN_ON(unlikely(!data)))
> > +               return -EINVAL;
> >
> >         requesttype = 0x01;/* read_in */
> >
> >         wvalue = (u16)(addr & 0x0000ffff);
> >         len = 4;
> >
> > -       usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> > +       res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> > +       if (res < 0) {
> > +               dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
> > +       } else {
> > +               /* Noone cares about positive return value */
> > +               *data = le32_to_cpu(tmp);
> > +               res = 0;
> > +       }
> >
> > -       return le32_to_cpu(data);
> > +       return res;
> >  }
> 
> Dear Pavel,
> 
> OK, found the issue with decoded stack trace after reviewing this
> usb_read32 function. Your line:
> res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> 
> should read:
> res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);

Dear Philip,

No, it should read:

res = usbctrl_vendorreq(pintfhdl, wvalue, data, len, requesttype);

I suspect that Pavel didn't notice he was reusing a line of the old code 
wth no due changes.

> With this change, the driver runs fine with no crashes/oopses. I will
> explain the issue but you can probably see already, so I hope I'm not
> coming across as patronising, just trying to be helpful :-)
> 
> Essentially, you are taking the address of the data function parameter
> on this line with &data, a pointer to u32, which is giving you a
> pointer to a pointer to u32 (u32 **) for this function parameter
> variable. When passed to usbctrl_vendorreq, it is being passed to
> memcpy inside this function as a void *, meaning that memcpy
> subsequently overwrites the value of the memory address inside data to
> point to a different location, which is problem when it is later
> deferenced at:
> *data = le32_to_cpu(tmp);
> causing the OOPS
> 
> Also, as written, you can probably see that tmp is uninitialised. This
> looks like a typo, so guessing this wasn't your intention. Anyhow,
> with that small change, usbctrl_vendorreq reads into tmp, which is
> then passed to le32_to_cpu whose return value is stored via the
> deferenced data ptr (which now has its original address within and not
> inadvertently modified). Hope this helps, and I'd be happy to Ack the
> series if you want to resend this patch. Many thanks.

I think that another typo is having 'tmp', because that variable is unnecessary
and "*data = le32_to_cpu(tmp);" is wrong too.

Now I also see that also usb_read16() is wrong, while usb_read8() (the one that 
I had read yesterday) is the only correct function of the three usb_read*().

Regards,

Fabio
> 
> Regards,
> Phil
> 




