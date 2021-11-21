Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F86A45841D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 15:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbhKUOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 09:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbhKUOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 09:38:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49965C061574;
        Sun, 21 Nov 2021 06:35:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y12so65057341eda.12;
        Sun, 21 Nov 2021 06:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVWJrGUhmNY+5JO5COkw5yTLxe0P/eEhJzzrs9rKS80=;
        b=pPQtvw1oWzKCCaSlHXkMN2HGFkW1mYIh6uaHutvd/Rc3mRbYodwWovDjLUfXKhi0/g
         8sDaVot9XAxSgCXlZkldX8sgWFzlwSXKsFV6uqvI+wY59F9Z3KDxXNnYXNwEPsXeazBO
         +60VVXz5WVfbOxF6CUP/KQ5ABWPi6XggL0FRf2mU0iCMwN8FJbNlIVJepeTW2JC3WPdN
         J9adJ51b3EaHlLJyvQZFI2s/TNpyMAYa4KrScx/D+8xaoZe4V4jm6haMGOJSD9YqGv0J
         fm+Y1IeWhkYLzNtl9g4MenpUgj/nqprnmtkXIrhsP5qdfq5iHPNJtV38i9JAFom4bG3o
         7Lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVWJrGUhmNY+5JO5COkw5yTLxe0P/eEhJzzrs9rKS80=;
        b=S6FmrD1eca6ZEMsfnVtIhM7bOkSsIbRIUAaNR0Pz+T4YSJP2NjS5JUZZGN5PxhEiop
         oPeZ43utGruwEewTBC6D44UhOhPdqQInzVu062xjAyJ6p8XSv+wZnN7lxrDpfJP4oYim
         G28Eg8tZOegycinohX4RJlstFCQB9HbET6jRNTkwEYp1MMp1Gc0Lt/QGn38R1TDt64+L
         kXpJGzsypUHamAObYbaBuPR5APHWJXk20oHbTLSVZHaB/DW760jqBsvlt5FfFYEHQUsa
         lVb7PvxunTK6k+OPs4ZNF7STY/hH0/DbPcdU3PVLuOvdI0OBxGCJ8/51QKCelEXiIJf3
         RzQw==
X-Gm-Message-State: AOAM532wsUuXdkXiPC21rYd8wUpOp8+avxOm4oHhizuz4NzRhq9+xk/9
        TR0N/1fWZMKS09Wjn03ip7E/y6sBXFMyMmlVPC8=
X-Google-Smtp-Source: ABdhPJwq3Ba4opXjf0mtBzSWbRxwHpLA6KQV4nWd8uJXSGR4AB362UA1kpnuwf2ADgdZqExGejZpUDPWQPUVD/Lx8P4=
X-Received: by 2002:a17:906:3c46:: with SMTP id i6mr29158150ejg.371.1637505308545;
 Sun, 21 Nov 2021 06:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20211104161804.587250-1-aford173@gmail.com> <CAJ+vNU2jcWyCm3UyiOnvknS0t+mSdpaB+CgGWYO3jxXTa3LhRA@mail.gmail.com>
 <CAHCN7xJrnZMQgXVMJg7MZdFMWyesf6Ph7HnfMH7-9bm1qODHFw@mail.gmail.com>
 <CAJ+vNU32GXtbKWGQXoE7pkXU8FcKh+HQJJduwRbRJ0tC-d6GoA@mail.gmail.com>
 <CAHCN7xLAm21zUJQ8s4s--+ygmeVY0qyo0WSLp7ZM9bT9R3sjxw@mail.gmail.com>
 <CAOMZO5Am4P17mOXWrPs0ns9AwOXM_ZpBdzbYTYJfv_48Ea=BHg@mail.gmail.com>
 <CAHCN7xLzR5LqqydC7uydsXQPFVn=nyqKD8ZEH3EjcPuwQky5WA@mail.gmail.com> <CAOMZO5AnXDV3jdR6hP_+uqyss4KftzjahcrGq1XA37nGsfQedw@mail.gmail.com>
In-Reply-To: <CAOMZO5AnXDV3jdR6hP_+uqyss4KftzjahcrGq1XA37nGsfQedw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 21 Nov 2021 08:34:57 -0600
Message-ID: <CAHCN7xKJBHY1o94VDkBaXXFjMUm=5WoshddT4DVWD04aiPV8MA@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 8:21 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Sun, Nov 21, 2021 at 11:17 AM Adam Ford <aford173@gmail.com> wrote:
>
> > I am using https://source.codeaurora.org/external/imx/imx-atf/log/?h=lf_v2.4
> >
> > Since the driver sending SMCC commands to ATF isn't doing that, I
> > assume it's safe to use the linux power-domain drivers with the ATF
> > from NXP's kernel.
> >
> > If you can point me to the repo you think I should be using, I'll give it a try.
>
> Do you know if the mainline TF-A repo v2.5 works too?
> https://github.com/ARM-software/arm-trusted-firmware/tree/v2.5

That's good to know.

I just built it into U-Boot:

NOTICE:  BL31: v2.5(release):v2.5
NOTICE:  BL31: Built : 08:24:13, Nov 21 2021

The Etnaviv driver is still loading without hanging

root@beacon-imx8mn-kit:~# dmesg |grep -i etna
[   12.393936] etnaviv etnaviv: bound 38000000.gpu (ops gpu_ops [etnaviv])
[   12.400676] etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
[   12.641297] [drm] Initialized etnaviv 1.3.0 20151214 for etnaviv on minor 0



>
> Thanks
