Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E133ADD4C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 08:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhFTGDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 02:03:25 -0400
Received: from mx-lax3-3.ucr.edu ([169.235.156.38]:9285 "EHLO
        mx-lax3-3.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhFTGDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 02:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1624168872; x=1655704872;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=ca2COAjHKL7+OCkgt+dQm/iTK6CkVF0mlcxAWJfZ2rg=;
  b=AF/qJVPSCFLJX5+AkNKjAbOO2Mnc402aHib33c/BAbJgg4QnsyjNLmK6
   Vv9k8U8mTsbZT8Og2uG9aEiZ+1IhVb8BxASjLmgrxG6bX2OcveSalKQsK
   gLAkX0ki05MfoIZI6hWdsJMRVPwS+G4e0PGabW8Q1fPc9SjNo+lIy+EFq
   QbSzrgb5AeDnO/IZDGG3HeGB9B3Lj7u+OzhlFjfIlZckESY1uNUnKgcwN
   pobAqdBlYQ0xFr63DWHLPyyfDvVIKdu6ZBCz3JNz4wcBVwZECZgttv2vt
   OZTBaYT/pdMxE6Z2Mw1kxqzQxVw54dHa7g7zKeZKu6ihvl3eUYdxAWYTs
   A==;
IronPort-SDR: m2RkeRndped622VIzKJ0guDzs9xUo9uwNfhZNgpD/k5T4v2hSpOLjih6GH4P64LxnVpAnMJ217
 jh5qtEs1VYRL+uzHs3MuC7ho2KrbA/B88eVLgdSwdqFO6IKj5uF16XIHZYpQjokWjArMnsna8m
 Vnmm0/ZgQQGSxD/M7h5DzQ8ACMh556tjuelBYp2j95imq49rfDDIDWAcHu/0ggUmGMAV+tI6z5
 eW8a42XFICl4D6CKn/BKpSN8nXM1JzD4Caq8VhazKwL5N46+d+26M3GJAWaBiUsr4Uk4hLPrYI
 QFE=
X-IPAS-Result: =?us-ascii?q?A2EmAwA+2c5ghsjXVdFagQmFT2yESJFxikuLQYc7AgkBA?=
 =?us-ascii?q?QEPQQQBAYRQAoJuAiU4EwIEAQEBAQMCAwEBAQEFAQEGAQEBAQEBBQQBAQIQA?=
 =?us-ascii?q?QEBAWyFL0aCOCkBg20BAQEDEhFWEAsLDQICJgICIQESAQUBHAYTIoJPglYDL?=
 =?us-ascii?q?5lCgQQ9izKBMoEBh1UNTAEJDYFiEn4qhwmGYSeCKYFLgjc2PoIghTuCZASEG?=
 =?us-ascii?q?G5pgjIBAQGeRJwMWgEGAoMFHJIXhgyFWyuDXosnhW+Qfi2GNZ49kVGDQxAjg?=
 =?us-ascii?q?UiBfjMaJX8GZ4FLUBkOjjiOVSQvOAIGCgEBAwmNNAEB?=
IronPort-PHdr: A9a23:M800dxa/N8frER5DTfC9UWz/LTEz0IqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1Q6PBt6FoKsd1qL/iOPJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHOZwhEnjSwbL1zI
 Rm5sAndq8kbipZ+J6gszRfEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3Q
 qBWAzogM2Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VSik4
 qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ3dKUMRMWCxbGo6zY
 IUPAOgBM+hWrIfzukUAogelCAmwGO/i0CNEimPq0aA41ekqDAHI3BYnH9ILqHnbrtT1NaYSU
 eCoy6nD0DbMb/NM1jf89YPFdRAgoPCMXb1qcMrd1VUjGg3eg1WNtYPlJSmZ2foQvGiG9udtU
 /+khGE7pQ9ruDev2tsshZfThoIT0l3J+iF0zYI1KNO2VkJ2btqpHpRTuiyVOYZ7Qs0vTn1pt
 Ssmy7ALt522cDUXxZg6xBPSdfKKfoeL7x/+WuicPCt1iXR4c7y8nxa/6VasxvH4W8Wu01tHr
 jBJnsfRun0NzRDf9NSLRud780y8wziAzRrT5ftBIU0skKrbLIMuzaAom5oItETDAjf2mELrj
 K+Kbkkk+van6+DgYrj+o5+TLY50igXnPqQ2lcyzHP00MgYQU2SH5eiwzrLj/Ur+QLVFiv05j
 LPVv4zdJcQevqK5AglV3Zg/6xunETuqzNAVkWMEIV9FYh6LkZXlNlHULPzmEfuzn0ygkDJxy
 PDHOr3hDI/NLn/GkLr5fbd86k5cxxAyzdxD+55ZBKoMIO/vVU/rrtDXEAI2MxGsz+b9FNp9z
 p8eWX6IAqKBNKPSsFmI5v8gIuWVZ48apiz9K/476P7qlnI5h1Adcrez3ZcNa3C3AO5mI0OHb
 nromNsBFn0KvgVtBNDt3XGHUCJJdj6OWLg75TE8FsryAYLCWpq8xqCGxiC4HppITm9DA1GIV
 3zvctPXde0LbXejI91hjztMZ7ioSsd1xAOuvQ6ik+FPM+HOvCAUqMSwh5BO++TPmERqpnRPB
 MOH3jTIFjks9l4=
IronPort-HdrOrdr: A9a23:1x45VayZH6rlYxdxYQr3KrPwF71zdoMgy1knxilNoNJuA7Wlfq
 GV7YwmPHDP+VMssR0b6LK90ey7MBDhHP1OgLX5X43SODUO0VHAROpfBMnZowEIcBeOkdK1u5
 0QFZSWy+ecMbG5t6zHCcWDfOrICePqnpyVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,286,1616482800"; 
   d="scan'208";a="52623606"
Received: from mail-pg1-f200.google.com ([209.85.215.200])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2021 23:01:11 -0700
Received: by mail-pg1-f200.google.com with SMTP id r5-20020a635d050000b0290220f78694c8so9213778pgb.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 23:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbFMlSU8VOH+3s30vncOXVUKJU1McKhQjkr8IIeWaNk=;
        b=uWwhbHPvcSRUKVMmcHowfHSqpSUx5WXpGCTyB84rjFcpUNwrq+boDSBVLkzaiixU+X
         DIjYB+nZrUX9n8ZBnqkXPd1yMAjMtVhuc2oLIH59wjJNi80jIryw1hmIo9+0L1Bd+qMc
         385IxQBZvORQ9Y0bLt319WOG0ZAcoVNbIJ7QFCcfhdlRBps7IGARqwlzCzP705E9M/kr
         YJ3B4uT61sKcK2RP5jq9TKb97By3Cds4IOo8Zdyj4ndFOZAVQ89NIr77guW2nzth8jmr
         Psrz7tOkVp/D+YYOgfOUXJcWkRsjczeuXb8jb0QTW+5O5EYuztK6WoL6LBczbG8K6iMq
         3GaQ==
X-Gm-Message-State: AOAM532/ZRrfb0mlTZWoSiM2za0p00ZqekxAYT7aSYzdjlV41YlUGBny
        5uWpKM4KNDsV4ZiLKJeDA7mqzGOyX4jGyzrPEbh2prlNU/Ocg4m62SK5yQpJCSGAdvkIpJRlYi/
        vptRTnqUPwzIUXSnPJbb0CBKZBkG411XEF8JondYXOg==
X-Received: by 2002:a63:805:: with SMTP id 5mr17808119pgi.353.1624168870254;
        Sat, 19 Jun 2021 23:01:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzD9PEuA2dT9jWZUEPhmwSRvJzCmrsGK5wEPE61ZuokJ1CUZk9YPzk0ucz0jUcMkSU2fTyYcxnEWHxpVFbtSI0=
X-Received: by 2002:a63:805:: with SMTP id 5mr17808101pgi.353.1624168869944;
 Sat, 19 Jun 2021 23:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <CABvMjLRxy1yqXUOWqTTeq=UOsLtuPAyOSCi4SPgcbAqjMuWCCg@mail.gmail.com>
 <YM7NzYgEl8NhU36H@google.com> <YM7RkI8fvpkfwAGA@google.com> <YM7ToLeaDajmBiwi@google.com>
In-Reply-To: <YM7ToLeaDajmBiwi@google.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Sat, 19 Jun 2021 23:00:59 -0700
Message-ID: <CABvMjLTP+Vh0cTDLU72Q-64f4DWQAp8-7DZ9GTBtoiqnKsaChA@mail.gmail.com>
Subject: Re: [PATCH] Input: hideep - fix the uninitialized use in hideep_nvm_unlock()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Anthony Kim <anthony.kim@hideep.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitry:

Sorry for the inconvenience, I would build the changes next time.
Thanks for your help : )

On Sat, Jun 19, 2021 at 10:35 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sat, Jun 19, 2021 at 10:26:40PM -0700, Dmitry Torokhov wrote:
> > On Sat, Jun 19, 2021 at 10:10:37PM -0700, Dmitry Torokhov wrote:
> > > On Wed, Jun 16, 2021 at 03:48:51PM -0700, Yizhuo Zhai wrote:
> > > > Inside function hideep_nvm_unlock(), variable "unmask_code" could
> > > > be uninitialized if hideep_pgm_r_reg() returns error, however, it
> > > > is used in the later if statement after an "and" operation, which
> > > > is potentially unsafe.
> > >
> > > I think this is pretty sensible, but let's see if the original author
> > > has some comments...
> >
> > I guess not. Oh well...
> >
> > Applied, thank you.
>
> Note that I had to make some changes to make it compile. Please next
> time try building your changes before posting them,
>
> Thanks.
>
> --
> Dmitry



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
