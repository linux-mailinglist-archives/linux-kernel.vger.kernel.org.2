Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BDE42F5CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbhJOOof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbhJOOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:44:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3046C061762;
        Fri, 15 Oct 2021 07:42:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i20so38212900edj.10;
        Fri, 15 Oct 2021 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+zGmTYCSMl9Jk+wZyC8YFyhGK1gcDucxT1GDpDZTuM=;
        b=kj+1T7etiQ1yhpR2wJ7yK2OOWl6GCSSjJmmCnSVASs6glWgSnriT29vLkNJ1ECIdui
         sIR66gqMbuhBQIU3mNidpBfEDfx2O6HGmSE0L0X5K1p1AX0okpXxnYYjSfv2hbE/2qCw
         +nZa723fFPpj4V4gecfZPdrNdpgMMCedc+6UYjizAaEWwoy5zYHx5seAJno2biMs6LHA
         ydj3s6QI3fj7md4F3zclEVJEQm0EO3ZEI/9sOinS0RyrZPGhf0IZkrNQgCPxyo9Esy01
         IxBaLjcuo1+OuCibQm9PZlPCYs1cUtbJRCdcGgbRJJJIEGPZzfXRQZXs45sLmYEFAPLZ
         KrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+zGmTYCSMl9Jk+wZyC8YFyhGK1gcDucxT1GDpDZTuM=;
        b=UGQv6DJCfvugvGEuE+EoNokrrxtHRntruA+oaa2n1wm8AcOcyLxUK2Kmeeox3HQB6R
         W/8HAjYGRncO5Y9OM8r9sL2REaMSJzNqAIESQnP4Y4XE2gk7znONnDKrbNGp63sOSBnU
         PLSX37hc9J6pnwYKuzApKlJ88heMxufj0dHROPe/wF2P4ToX4Sdo+mRUSfWKCMLtm4Sr
         maOkQoXAKnZoXzi0LnPDhbnZgzx811pKXUMejVayRqvmntU6td/eaPZiR6wgKr8FqqZw
         lUCkWt/6NMX4FCqkaR8w3kOVXpb+3cVL817/8DSl2APhIJM6z/Ym2j4yz6Fx7LQXpnew
         ax+Q==
X-Gm-Message-State: AOAM533F2Wp7o2mR5huy9axcce4HNac/njINR7xeiCd24wJrl/qklIeI
        kccLNDFS3qY0AK6AOQNhamvFRNqZ2DDVARBW0t7dG3GA6xNSNe6a
X-Google-Smtp-Source: ABdhPJyaEGgUmNaZ1jQj4eTP5bfnQBSjwm5dDuw1uXLDARKhiRmmQfJCCePav+qKCR42/TjM/nVD0kVpeQMEJEEUQik=
X-Received: by 2002:a17:907:8a27:: with SMTP id sc39mr7125346ejc.567.1634308900544;
 Fri, 15 Oct 2021 07:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211015055808.327453-1-pauk.denis@gmail.com> <20211015055808.327453-2-pauk.denis@gmail.com>
 <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com>
 <CAB95QAQMP58-H427+nASKBvHOHZtLQqgRBSPa+MqGU7_D42M2Q@mail.gmail.com> <CAHp75VfJzaSKzw4E3P=GdtMU1vpi3DvW-VLGNbuaGaykEydhFQ@mail.gmail.com>
In-Reply-To: <CAHp75VfJzaSKzw4E3P=GdtMU1vpi3DvW-VLGNbuaGaykEydhFQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Oct 2021 20:40:52 +0300
Message-ID: <CAHp75VcUk=b32F0Ngo5xtUmDJGmJqxbFaHHs44w6yrmcuisOpg@mail.gmail.com>
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

On Fri, Oct 15, 2021 at 8:36 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Oct 15, 2021 at 5:26 PM Eugene Shalygin
> <eugene.shalygin@gmail.com> wrote:

...

> > bin2hex() can't output UTF-16LE characters, can it? It would need an
> > intermediate buffer and a call to convert ASCII (UTF-8) to UTF-16.
>
> I didn't get it. If there is a strong endianess expected the parameter
> should be __le16 or __be16, moreover it seems it missed the const
> qualifier. Any preparatory stuff should be done in the
> asus_wmi_ec_make_block_read_query() which prepares the input buffer,
> doesn't it?

I'm expecting a confusion here, so let me clarify:
1) in the current code the __le16/__be16 is missed, BUT
2) if you are going to prepare CPU endian buffer in the caller, the
u16 is correct, only const should be added.

-- 
With Best Regards,
Andy Shevchenko
