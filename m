Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324F0460666
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357494AbhK1NWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345293AbhK1NUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:20:44 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E440AC061746
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:17:27 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id n6so28385048uak.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7whuhitVqPnZipfah97TIBIyag3vXAwUvYkJpquBSrU=;
        b=Qut2xFPsrGNP7QzIatUjPh112CGOyBKAFtaiKWt7oknS3e3elMukv8TEerX8+sKXPf
         mJYzduV+T784qBHP2lLUgIaYzdJSsnKE6BiBPYRknHzOw+qlCKEMpnZrrqde/g6V3ZrI
         D/NsTx2ampFgtvcjWZLgyhsdxucTEn3IFIGH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7whuhitVqPnZipfah97TIBIyag3vXAwUvYkJpquBSrU=;
        b=W9JvmHcFvhrb09C5oyUEB2ckx9bXwcu+s7j2mfyfa2QvI8VeEYbIcsDPc9zQYGEzdJ
         eCh6YxKGSFh3zfoa8lRiKQ6hsKou4267/b689cJQehuOKwta9nraCsSGNR8tMTYV0JU6
         RUfZ++YewwtD/7tUdXlb9Voa4ZJSYPgCA/LwX1XMfqoM/md9F8136GnChDE1OVhZsRck
         3y0XMqRlYzr23uRR1X/CHg9e8yiUVp5C+8TofrPzxvm5C1D/QWTdqmT8hGIrB6owHH+8
         kHLqfjlDy11QADpP94YwhauSyMdwZL+kz3PA8XvGAlkEXnJ7yr3VI9n6vM6nHnFCxg3W
         V1Xw==
X-Gm-Message-State: AOAM533raBEwhsM2WKySXUIqEzEAO7iT+2sk2Y+Gs/UxrD9q/35HRHqR
        mh60EKR42I1CHDRqQ1Irb9weSMVWZUgR0Q9K5DzgKUaQY/8=
X-Google-Smtp-Source: ABdhPJyZxe5YIKk6QpWHAe4AORoq3DVeSfu4IYXAhafnMShxVmuFujEF374iQEYwpRHvwBOmiIsTOa1Yeask/tphui0=
X-Received: by 2002:ab0:6ecf:: with SMTP id c15mr45724445uav.113.1638105446637;
 Sun, 28 Nov 2021 05:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20211126202144.72936-1-romain.perier@gmail.com> <20211126202144.72936-7-romain.perier@gmail.com>
In-Reply-To: <20211126202144.72936-7-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 28 Nov 2021 22:17:16 +0900
Message-ID: <CAFr9PXmpKrcPXL=EdL-uGu0X3nZBrAVcBSDqSbaDEvRhE6Abiw@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: mstar: Switch to compatible
 "mstar,ssd20xd-timer" on ssd20xd
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Sat, 27 Nov 2021 at 05:22, Romain Perier <romain.perier@gmail.com> wrote:
>
> This defines the real oscillators as input of timer1 and timer2 and
> switch to "mstar,ssd20xd-timer".
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi

I just noticed this during testing. I think we should put this in
mstar-infinity2m.dts. All of the infinity2m chips use the same die
from what I can tell so if the ssd201/ssd202d needs this then anything
else that includes mstar-infinity2m.dtsi will too.

Cheers,

Daniel
