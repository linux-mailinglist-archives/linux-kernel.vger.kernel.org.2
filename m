Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB7370B24
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 12:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhEBKtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 06:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhEBKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 06:49:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B507C06174A;
        Sun,  2 May 2021 03:48:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a11so1314904plh.3;
        Sun, 02 May 2021 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=44Pbc9rBUHoVe5YAupOa4qwfHvmyc/iguPZLYW6hLQQ=;
        b=GvdJ0PzuNdzwIjhvRu5r82xntxXhjrTrpnIkEjV3mHU//BIdgF/GO9SPMQmnWJ2gHt
         aZzOlJVkdrD35+qv4XhxvxYyhTVipXq3vKD7XtYx2QkfNJtofgaLYGxOPpz3ElV5pnHP
         C27IrBwTj7vWM5qeLCnAq4R06O4zVLKIBifC4x7z2p0OM53DQxIBHLxFYF5+vNQDXRXV
         NILnM25brxDoTOMYV0OgUYIrA+6suKef/2WZO+aB8qkqMDSOKVoa/3NDhOEobmabG9kF
         VwSdxIgBMK6Rh8tgM5qxL1LHF4ohcYEopB6xlHDfhYnsZ5GvZjW1MW1lxHqzQhDHaHx3
         ZvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=44Pbc9rBUHoVe5YAupOa4qwfHvmyc/iguPZLYW6hLQQ=;
        b=ckeDz1KdszeU7kll7SdtJrM8uvbNjD4MZWOeUuyVYPzUk6n/OTDRWJrBGpwrAZx5yJ
         fvzdCRAKfeEGnTPPgIdLqXO6yBlMZcA3dQoQ6dOQ/HHOISbtN95+tPYjv9hgAT6HuHro
         Cvwij4wlhr9tInV9P5TWaYsOBo2q2TgrXf0KG8ecs4Y8Ds+Ql5ipCdgDAbZgYiN7Qn3c
         CShB0LcQQdJ3d4R0rJzf1uTZ6s37yXasjq9W8DcPFOxytSGh4000PcKZZU6N2m3V+5kl
         Wq+4xThm3wwSqhVA8Xa2FEUkmkYsL6AnRNhNjCJ9ceFO+UeGoLflt5E8Z2wb6YtT+gYo
         jLpw==
X-Gm-Message-State: AOAM530sMwZmo4ysJ9vjo7ktdDRl1S70spNVze4rqnebgwIA+PpnjkuM
        3iqcvgzvz46icTmr9p6OxzKJ7MtOPBIGi5+WM+U=
X-Google-Smtp-Source: ABdhPJzqOh2dljV5BEmRaB+D95O9Y1KMnYkfzfUT8/Gutsn3Hp/qury/FqduxgFzrOuSWRr7lGggC0LjVYS+ZH9xfUQ=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr14867233plc.0.1619952529427; Sun, 02 May
 2021 03:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_17A7BBC4D15D331C1A25B4075294E5D67706@qq.com> <cb03b75a018e4bec83eac6898eb1d2af@ACNMB2.ACN.ADVANTECH.CORP>
In-Reply-To: <cb03b75a018e4bec83eac6898eb1d2af@ACNMB2.ACN.ADVANTECH.CORP>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 2 May 2021 13:48:33 +0300
Message-ID: <CAHp75Vc_dA_VKMNsUo9jkpuGYX6Mzddy+=P3H+25ZuKiOE5icQ@mail.gmail.com>
Subject: Re: [v2,1/1] adv_mix955x is a scheme that multiplexes PCA9554/PCA9555
 into LED and GPIO
To:     =?UTF-8?B?eXVlY2hhby56aGFvKOi1tei2iui2hSk=?= 
        <yuechao.zhao@advantech.com.cn>
Cc:     "345351830@qq.com" <345351830@qq.com>,
        =?UTF-8?B?UmFpbmJvdy5aaGFuZyjlvLXnjokp?= 
        <Rainbow.Zhang@advantech.com.cn>,
        =?UTF-8?B?eXVueGlhLmxpKOadjuS6kemcnik=?= 
        <yunxia.li@advantech.com.cn>,
        =?UTF-8?B?SmlhLlN1aSjotL7nnaIp?= <Jia.Sui@advantech.com.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:33 AM yuechao.zhao(=E8=B5=B5=E8=B6=8A=E8=B6=85)
<yuechao.zhao@advantech.com.cn> wrote:
>
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
>
> With this driver, we can multiplex PCA9554/PCA9555 into LED and GPIO base=
d on the ACPI data of BIOS.

I really did no get the purpose of this rather enormous pile of code.
Why you can't simply use PCA9555 with correctly described leds-gpio.
What the problem this driver solves that can't be solved by existing
code?

NAK till it will gain a very good justification.

--=20
With Best Regards,
Andy Shevchenko
