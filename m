Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8441359EF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhDIMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhDIMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:41:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B9C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:41:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m3so6398798edv.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cr3MWabTM6V/ksBGwd1Fv/a5RR46Fk3oRrRz+yH2SMQ=;
        b=Cd/f22QQeG5V/FE31NylqMaOxmaMe6m6j8l2PNSbNeXvmC8LGV5fpui1/zTzqpqWKb
         OlMBrFiyh/N3pMoW3wuMG011svsJzoNzGfuR5avxBEzSL84Y5ihzhug9irmOJxoUQ0uq
         F7lZqFAyeXSFCvPL9iK+lnaXFiYmhWilzAQWDKPHkE2uKmqnF9vqETWnjO6CxBFBsFhf
         YZKHNha8xZrAHim3akBMZKnW4X4INl0Ams2Ie5Mh7qIWPu6uIlrWyx74Do1hU5Ue6b1e
         cCJ2Og0Uo/N9cHUR1dpzZM2NEHN1GOT3KoxQxXNfEa9DCGtefM3mz4Ge7nqd/bEyRRZq
         NQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cr3MWabTM6V/ksBGwd1Fv/a5RR46Fk3oRrRz+yH2SMQ=;
        b=a5O1rSr3x9Bl6ZC/g4rlxfUypdf9Pz+58jO5On23i7gq8LPKbG1dKoRpLQlfaPXqqq
         0mBfPmF8kbs0cm/y26PcnxmuUElJ2RRy6hXfndFvqYHFs/LkTJ7MBwRcEAErofUZgO5p
         73VDl3MdPBm9LozFJTgGnxXpkt03q53wUg5QI95h+BqIPek0F7ePKEwSjfJpf7I1TV4D
         ZsZhquJSrjItNXNahPeOf1l8Cbo+NnWMe78T7PcZDd/vU8Qp/0/HzPMV6JxAxgQkmFpF
         A1Ao39o1oY6PextjApiQ1ef2/Hpe8DO1FKsgv4wEl5pI5PfnxOAErkhvr7XZZs+1GV2k
         UQdw==
X-Gm-Message-State: AOAM531UzzoxlSzcWtT4HIm+wAdpe0QgQj+PMrXOwu90gbx3K0otzRCL
        +vbiIiYu4csrysA4bnbDDQO+tRmGcCWu6eogxIIWTw==
X-Google-Smtp-Source: ABdhPJzl79i7iMaiAodbMaScK8s3swtu232FR+p+Bi/JsO87cIpvlPk6WnxxJMCos0YG9754L3CdcY+XFTjvLyluqpM=
X-Received: by 2002:a05:6402:42d3:: with SMTP id i19mr17274011edc.220.1617972100093;
 Fri, 09 Apr 2021 05:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210408130605.541796-1-gi-oh.kim@ionos.com> <20210408220502.8126bc2f278b5199707ec122@linux-foundation.org>
 <CAHp75VcjNWycV-SLUzzfgtMp8BzXUiUAoz_BYr4+nCazAzsrqw@mail.gmail.com>
In-Reply-To: <CAHp75VcjNWycV-SLUzzfgtMp8BzXUiUAoz_BYr4+nCazAzsrqw@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Fri, 9 Apr 2021 14:41:04 +0200
Message-ID: <CAJX1YtZtXoLmbwvAk40CHZ0_LtE__+SvvyWYYvcJaHAeDH4Chg@mail.gmail.com>
Subject: Re: [PATCH v4] lib/string: Introduce sysfs_streqcase
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "laniel_francis@privacyrequired.com" 
        <laniel_francis@privacyrequired.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dja@axtens.net" <dja@axtens.net>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 9:11 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Friday, April 9, 2021, Andrew Morton <akpm@linux-foundation.org> wrote=
:
>>
>> On Thu,  8 Apr 2021 15:06:05 +0200 Gioh Kim <gi-oh.kim@ionos.com> wrote:
>>
>> > As the name shows, it checks if strings are equal in case insensitive
>> > manner.
>>
>> Peh.  Who would die if we simply made sysfs_streq() case-insensitive?
>
>
> I think it will be a disaster. Like we have with case-insensitive file sy=
stems. Famous Mac case that most of the soft stop working when they actuall=
y moved to the right direction, I.e. case-sensitive. Personally I=E2=80=99m=
 against such change.

Hi Andy,

I am sorry but I am a little bit confused because I don't have any
experience with case-insensitive file systems.
I think the case-insensitive file system does not care if sysfs_streq
is changed to case-insensitive.

For example, if the case-insensitive file system would accept the "OFF" com=
mand,
the user can pass either of "off" and "OFF" and both will work with
case-insensitive strfs_streq.

On the contrary, I think the case-sensitive file system would not like
it if sysfs_streq is made case-insensitive.

Could you please inform me what I am missing?

>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
