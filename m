Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B78D40F46E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbhIQIxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbhIQIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:53:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F32EC061574;
        Fri, 17 Sep 2021 01:52:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m3so28222155lfu.2;
        Fri, 17 Sep 2021 01:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvpEIBoByg42XkOM/TNyoYT6HJF27BGOhJ85ClCpsEY=;
        b=QbFfYFO80788sb60dOMh7/d+qKia30CW+uSSxaXSFw2PZamB+PJlEwH2S7pM/p4Y1g
         gKEdEiynO3nwbRxZ8kj2Q6Eb32bMrSHCmKrRskQ+kyIjg4skyJER0BR9BDYMY6OZdcwn
         Yf8Tma/Igfkgj0XsLcjnnqEGtUDWeqdNRh5XB+QY49zp8F6KaSeKgDii2sacaxNG0cLk
         6JX4vsnYJLt6hLcsRDrwzS4UAEceqKLHQ07HxzvscaMuFCfvQoqk6b6NvLmX3SBdEIhj
         jLU1NchNKpN6ww230QmMKSk2BMYgdW7jS/JW28pZF1qcpUJMlD/hhqRCYNMj0c22Y6S7
         d3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvpEIBoByg42XkOM/TNyoYT6HJF27BGOhJ85ClCpsEY=;
        b=A6vp0c11AANbcEJS96W79S+W8RHtoLaz+88kUJ43bqns1+OaA4iz3u04ndSYLKkTOz
         92xmjgqu7b5hWHdxFr4+9tePrLBE8oiaq+YHH7R7R3IiDfiDBAfMvazOj3grK3YYeAyo
         2N8OJOcDd0N23HR7JJIuWRhcY3LNEv7Qe3rEjev/nH/UCJoNoWJ0AUpSfVFiy5m+ny69
         bbLYXZH00DgepxKGQoCMI7tlQmGSVFXoLQSImf9XEaTg8b3M5mggYT5Qznj54126NOYs
         2J5Ly9qiEW6pHKqmuIJMQodPoE3BeV/oo+ep+ILX+kbo2lmahcRUA1IeniE49uyVn5v5
         jCyQ==
X-Gm-Message-State: AOAM530FNVpmv2iQnq+iUABoMGHciCTpovbUEzXrZ5QSQ5ODGwU6S5T7
        MDw1FnzWmgPyDmEYhDyE12KxQykZToN2LSSRYtM=
X-Google-Smtp-Source: ABdhPJyGLH723MyowALyoIZWfMm/f/MFSOi+oazfMJPxfw2fPSZRaRXq7YBHvsBrRWq6ok+xNSwPI79c68bHb9irV4M=
X-Received: by 2002:a05:651c:a12:: with SMTP id k18mr8561807ljq.90.1631868720641;
 Fri, 17 Sep 2021 01:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210915120325.20248-1-heiko.thiery@gmail.com>
 <7e7ee4244ababc0a46e0875222c7e37d@walle.cc> <898fd5e0-2073-3689-89b6-2c5071773786@kontron.de>
 <CAEyMn7ZbJr0_2Phc2rW7sDYQu4AABWPZ1F7xDgaS5U7ha7iqzA@mail.gmail.com> <3EDFF987-82C2-4B0A-9488-037D1BD4CA48@walle.cc>
In-Reply-To: <3EDFF987-82C2-4B0A-9488-037D1BD4CA48@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Fri, 17 Sep 2021 10:51:49 +0200
Message-ID: <CAEyMn7Z9wRZWpWD3krx=3Zgc-9H0Y6eWjDpOhbO-v2yXuRcGXg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-kontron-n801x-som: do not allow to
 switch off buck2
To:     Michael Walle <michael@walle.cc>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Michael,

Am Fr., 17. Sept. 2021 um 10:21 Uhr schrieb Michael Walle <michael@walle.cc>:
>
> Am 17. September 2021 09:28:51 MESZ schrieb Heiko Thiery <heiko.thiery@gmail.com>:
> >Hi Frieder,
> >
> >Am Mi., 15. Sept. 2021 um 14:09 Uhr schrieb Frieder Schrempf
> ><frieder.schrempf@kontron.de>:
> >>
> >> On 15.09.21 14:05, Michael Walle wrote:
> >> > Am 2021-09-15 14:03, schrieb Heiko Thiery:
> >> >> The buck2 output of the PMIC is the VDD core voltage of the cpu.
> >> >> Switching off this will poweroff the CPU. Add the 'regulator-always-on'
> >> >> property to avoid this.
> >> >
> >> > Mh, have this ever worked? Is there a commit which introduced a regression?
> >>
> >> Yes, this did work before, even without 'regulator-always-on'. I
> >> currently don't understand why this is needed. The regulator is
> >> referenced in the CPU nodes as 'cpu-supply'. This should be enough to
> >> not disable it as long as the CPU is up.
> >
> >I rechecked that with 5.11, 5.10 and 5.9 and I see on all of them the
> >same issue:
> >
> >[ 31.716031] vdd-5v: disabling
> >[ 31.719032] rst-usb-eth2: disabling
> >[ 31.722553] buck2: disabling
> >
> >While on that I tried to compare with other boards and see that they
> >also have the cpu-voltage marked as "regulator-always-on". The only
> >exception in dts/freescale is in imx8mq-librem5-devkit.dts [1] that
> >has not set this property.
> >
> >I agree with you and don't understand why this is happening. Has
> >anyone else an explanation?
>
> Do you have the CPU frequency scaling driver enabled?

That was a good hint. What I now see is in my case the driver is not
loaded (I boot via network). In the default kernel config the module
is marked as 'm'. When switching to 'y' as expected it will be probed
and the the buck2 (cpu-supply) will not be deactivated after 30
seconds.

-- 
Heiko
