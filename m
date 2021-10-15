Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC85242F692
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbhJOPI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhJOPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:08:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD08C061570;
        Fri, 15 Oct 2021 08:06:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r18so39428233edv.12;
        Fri, 15 Oct 2021 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UCcs+zJPt+Ayodq9XRJbonbpujk12zwyy17dB04nF8=;
        b=Fex3zBVYz5jbTMCOj0ipCr0TBewe/pHlsfhHXsbPjJwyYlvYouOKfcJVo//A/riKym
         /RhTifcqRYuBV35YDmfhSz8zX+NXNJaBMvL1hnHzF/MHPf6iGb3CzdeGE2tAoOiG0JaY
         3YffLv2EoGeGyKi4sXTyCTRQZ1y/eludexbPeDlA1/yLFXNQlCow6N05PY9kM81ywWgr
         bD1nu4b3AlUEKUpltfe7tZ+TBL3mDYqes5ZJZLr7RZUBaMW/CvPReHvmgCe/qYcGw1ji
         3oW/Cie3A0kO9kLs344De8UlanM9qClL/mixUjujIaCRLGYAqKSAS/On1hbLGOh9qvMt
         ulPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UCcs+zJPt+Ayodq9XRJbonbpujk12zwyy17dB04nF8=;
        b=1ELra0vAXv7Bmyx8dK3v/KxNIKBrvIOLmZTEK5qk+G3FsCx7NW4Je14/eyr5JtcZy9
         KtIB56P9GBSjzvWTlsLbBfZA1trYB5hyg19hxANH51KMvtxSoeV795raKncPQVV5Oxz1
         Bwde/O962Tke3P9RkLg+N4TyJtgTMWOpUZjslbkDL/tCaFHLtfxzI35y1BmG2X2L8mzd
         mPAKcb8XxOc8MgJik4EaMdLKmpALZ7Jpx3uF3pF33zzdavK+Y+/kQ13uO3fIUJV64/c1
         pJ47km2T+yTQLbGa9fRPGwyz24VCs1hXNATx93uyrLX7Mqblj1CQFEPnjovzx0Xna88/
         xSVg==
X-Gm-Message-State: AOAM5300adms4KrE8vQhMKwNkOUA3a5EdxaP2ckdXCS6psxGmdiuT18F
        5WcFoNG3K4IrTXkTwRRmVjtKGZq3tKhOMrsObHM=
X-Google-Smtp-Source: ABdhPJzGK33tcMZRQkeqLDmryhY2H8fcY8nTgwbNC243WE8F0NET+Se2iDsP221JEN/IhQI+8wDK3cGLgcg0h77SDaY=
X-Received: by 2002:a17:906:eb86:: with SMTP id mh6mr7495815ejb.141.1634310325955;
 Fri, 15 Oct 2021 08:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211015055808.327453-1-pauk.denis@gmail.com> <20211015055808.327453-2-pauk.denis@gmail.com>
 <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com>
 <CAB95QAQMP58-H427+nASKBvHOHZtLQqgRBSPa+MqGU7_D42M2Q@mail.gmail.com>
 <CAHp75VfJzaSKzw4E3P=GdtMU1vpi3DvW-VLGNbuaGaykEydhFQ@mail.gmail.com> <CAB95QATQNaPiqJf7DuhWcJiU1Yq3_RXX7r+f3FAdw9aO0hvr0g@mail.gmail.com>
In-Reply-To: <CAB95QATQNaPiqJf7DuhWcJiU1Yq3_RXX7r+f3FAdw9aO0hvr0g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Oct 2021 21:04:38 +0300
Message-ID: <CAHp75Ve6q7fkJdLjZaxGe9jKASv72eExJAGWbT8fFWEUAwgweA@mail.gmail.com>
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

On Fri, Oct 15, 2021 at 5:49 PM Eugene Shalygin
<eugene.shalygin@gmail.com> wrote:
> On Fri, 15 Oct 2021 at 16:37, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > I didn't get it. If there is a strong endianess expected the parameter
> > should be __le16 or __be16, moreover it seems it missed the const
> > qualifier. Any preparatory stuff should be done in the
> > asus_wmi_ec_make_block_read_query() which prepares the input buffer,
> > doesn't it?
>
> We need to produce and parse a, roughly speaking, hex-BSTR to pass it
> to the WMI function (save for its size parameter of 16 bits instead of
> 32 for the BSTR). bin/hex conversion functions accept/output UTF-8
> strings and thus require an intermediate buffer and additional utf-8
> <-> utf-16 conversion. Do you insist that a loop with a stride of 4 is
> a homegrown library already?

The code deserves a very good comment. And even if you want to keep
functionality, replace homegrown library calls.

...

> > > > What's the point of calling acpi_os_free(obj) when you already know it's NULL?
> > >
> > > The case when obj->type != ACPI_TYPE_BUFFER
> >
> > Read my comment again, please.
>
> I did it twice already and still can't understand. The WMI method can
> return a string, for example, which is an error for our code, but the
> buffer needs to be freed.

You cut the context, but I think I meant

if (!obj)
  return -ENOMEM;
if (!obj->...) {
  free();
  return -EIO;
}

-- 
With Best Regards,
Andy Shevchenko
