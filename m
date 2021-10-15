Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F1D42F639
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhJOOwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhJOOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:52:01 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B12C061570;
        Fri, 15 Oct 2021 07:49:55 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h196so8052968iof.2;
        Fri, 15 Oct 2021 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fL8+mgMcadnALrTayBWbaujkXyGx/ICo6dyKKnlu570=;
        b=Vl8/fHUgsoGAEvaEAPPyassn27Us3O1tIYbImm/prxO5yCZC7Icl8aG7VOwmxcDXxk
         pIiXPKAb6VdRPBu8ICOZ054AbNpP8vQVyYWkiWS63mnQ+1zTSFx65j92wBC7EusXKHQR
         KzXMoLIEbh2r7s/5g2MIC4CxPF6/FtVDYu+QvKKTj/jesPsphm7VHalstx/JA18qp97B
         YfLi5P9z5u6+9o++qcj+a3dkZlFeHOmfDimSz01cmn/OzMbdCKaiq/lyj/rZMX9XTgAz
         IOg7hzJzbdCseQ71hCYXn0yZFmzeA9A535kXisUy9WjgMNPHf+7Z9BcQ3b9YU1ORrhol
         6wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fL8+mgMcadnALrTayBWbaujkXyGx/ICo6dyKKnlu570=;
        b=dR+psE8Rcihya6tAU6X+CZHPLoLvUDzF4iO6sejSmPm258yUWKStcKE1f3PgwrFsyw
         APIZFog8YXG/HlvoZEgb2l/VSXWoCx5M+c1AXEHFO/3gBX+EbByEbr7Y1A8cygZqL2+E
         +mLloNsEX/MB6mhNOz81JTZA42ySJccWbJMlD1WDdsSFgyDUfjrEcUwy/qpM+IXVrBqJ
         VA8MIEZhrsFqDInOGVdBBkf8nYSg7tQ+Ktwf8H2xJT8JajpEQNq3kkXllbx0kWWoc/oI
         o3CLbc5HJq1oILk+vq41uWd7upWTA5KkiE4ZFy/GoEw3ypQ8Kr9S1WwTXkAAq1XGiOFh
         24Eg==
X-Gm-Message-State: AOAM532FyuFmjkNEinZlIJbpmQn2TtmqoXUBUa7aAAosA6oNgRj4DZIl
        ePSGsSeQiKFzKdArVg5ZPIUAp6pgOeZtMgctNLs=
X-Google-Smtp-Source: ABdhPJzzB8N6SPYWHddFZ13/1bfKjIU1iQmR5XsMBgpen4Gi9hWheknEqQ3rEy04MABdE0cHk/A9MCQIbva0TNP2/ho=
X-Received: by 2002:a05:6602:1504:: with SMTP id g4mr4004341iow.133.1634309394425;
 Fri, 15 Oct 2021 07:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211015055808.327453-1-pauk.denis@gmail.com> <20211015055808.327453-2-pauk.denis@gmail.com>
 <CAHp75VfUYgYT_RSNXCc+_3rkBbywL8ZDcAFPwr=WbPzcD8MF0w@mail.gmail.com>
 <CAB95QAQMP58-H427+nASKBvHOHZtLQqgRBSPa+MqGU7_D42M2Q@mail.gmail.com> <CAHp75VfJzaSKzw4E3P=GdtMU1vpi3DvW-VLGNbuaGaykEydhFQ@mail.gmail.com>
In-Reply-To: <CAHp75VfJzaSKzw4E3P=GdtMU1vpi3DvW-VLGNbuaGaykEydhFQ@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 15 Oct 2021 16:49:43 +0200
Message-ID: <CAB95QATQNaPiqJf7DuhWcJiU1Yq3_RXX7r+f3FAdw9aO0hvr0g@mail.gmail.com>
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

On Fri, 15 Oct 2021 at 16:37, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> I didn't get it. If there is a strong endianess expected the parameter
> should be __le16 or __be16, moreover it seems it missed the const
> qualifier. Any preparatory stuff should be done in the
> asus_wmi_ec_make_block_read_query() which prepares the input buffer,
> doesn't it?

We need to produce and parse a, roughly speaking, hex-BSTR to pass it
to the WMI function (save for its size parameter of 16 bits instead of
32 for the BSTR). bin/hex conversion functions accept/output UTF-8
strings and thus require an intermediate buffer and additional utf-8
<-> utf-16 conversion. Do you insist that a loop with a stride of 4 is
a homegrown library already?

> > > What's the point of calling acpi_os_free(obj) when you already know it's NULL?
> >
> > The case when obj->type != ACPI_TYPE_BUFFER
>
> Read my comment again, please.

I did it twice already and still can't understand. The WMI method can
return a string, for example, which is an error for our code, but the
buffer needs to be freed.

Regards,
Eugene
