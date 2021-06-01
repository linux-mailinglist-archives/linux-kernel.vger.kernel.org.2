Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA1C3971D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhFAKxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhFAKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:53:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ABDC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 03:51:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w33so21059567lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kkk96RFhOUVeXcdtYw7VNYf9WSYu11sjtdPL/xxbKe8=;
        b=o1ehZKIudj8IUbNQJja9Bw9E9H+E7miiapinkr/taDqFF3USQSngLdAs8ijRzdZ5V4
         R8DlQVmJxyWLsrLsjSnekMwy/de6jXpATv4L6WrPeY0hpYbHi8PSRH6GATZbgs9j3QlQ
         5TK1ycoaH/cgAu6KgAma2Q3jm3i0rbxMBH1ca232N7C8suTpy2V/Obr1ogILk8FMvgdz
         9DPGRRwyNUcb8mXrXKub2kPGQ2RxKx1zZL6wQDX4+c8gLKNy4DfiNZP7IgsUtPFQxGjy
         ppyiI9c1hoOI9oSO/zm31ropq2E1gVVhXMwoeppqq2s3IlwYf0fEv7QhfUNyXfLJ++9H
         tfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kkk96RFhOUVeXcdtYw7VNYf9WSYu11sjtdPL/xxbKe8=;
        b=Yz4orueJtRDEJR+IzGSs2mdr33ZhZTqkvtIWwOIkwJA1twKGa+obSFTkegRCXfA06g
         F/0+wqeS+NmWd5JA/W2jHbVVzsO0usBEOZ0OvFoEgw5oKlygb7+gcDv7KpyzzOJEnHw6
         fApOE083qnNG/4Xmb0GCihenmz05OR5Qc3jSdbQTxfdn43kC4pnCdr+aAeyGpNam1OdK
         5RBBsNxx5fMj+5sCbvBWV3BWFL2Sox+WaWfWHizoWmfqOSdn1I0qSCiC37VGDkcH0j7C
         xaat0F1REwjBl9UnZuWFTq4Bvy2vt2+lCobIW0p5UWvy85cJrsDF7rH8NLaEmGtESAjB
         K7cw==
X-Gm-Message-State: AOAM531kQJrE65N0jkRVgDftFt7R/42R/RlepqbHQNgptkm4efNCCBux
        aDb051zfwcUUIVv8AIbfE3Rkbhl34ix4g/NDA53m8A==
X-Google-Smtp-Source: ABdhPJyA7vr/U/2Lycbd2FWBZBtLqVEAm94uzNvJ8gdrDqZfAvOsT2ddncI3yJcK4skM3pg4UBmX6/vZkNHtfc3zogI=
X-Received: by 2002:a05:6512:3e03:: with SMTP id i3mr14354819lfv.529.1622544715508;
 Tue, 01 Jun 2021 03:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620735871.git.sander@svanheule.net> <cover.1621809029.git.sander@svanheule.net>
 <YKr9G3EfrM34gCsL@lunn.ch> <CAHp75VewCw8ES_9S48qmeCtSXMkGWt0s4iub0Fu4ZuwWANHpaQ@mail.gmail.com>
 <02bbf73ea8a14119247f07a677993aad2f45b088.camel@svanheule.net>
 <f03d5cdc958110fc7d95cfc4258dac4e@walle.cc> <84352c93f27d7c8b7afea54f3932020e9cd97d02.camel@svanheule.net>
 <a644b8fa-c90a-eab6-9cca-08344abec532@redhat.com> <CAHp75VcFmU4rJ6jL204xGFM=s2LV=KQmsV8E75BpuSAZMXBn0w@mail.gmail.com>
 <CACRpkda+m5mOzMJ8KcPmojFGWkUpCrbmY0ySPTVx72RtWwf89A@mail.gmail.com> <e10c8ef7f758b4f7fa0fcbc992c84125@walle.cc>
In-Reply-To: <e10c8ef7f758b4f7fa0fcbc992c84125@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Jun 2021 12:51:43 +0200
Message-ID: <CACRpkdb4j6krXwdZGtth9b2W2bAdy9_StGbse_YbBY86-AWdLg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] RTL8231 GPIO expander support
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Andrew Lunn <andrew@lunn.ch>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 12:18 PM Michael Walle <michael@walle.cc> wrote:
> Am 2021-06-01 11:59, schrieb Linus Walleij:

> > Just regarding all registers/memory cells in a register page
> > as default volatile (which is what we do a lot of the time)
> > has its upsides: bugs like this doesn't happen.
>
> I don't think this is the bug here. If it is really a write-only
> register
> the problem is the read in RMW. Because reading the register will return
> the input value instead of the (previously written) output value.

True that. Write and read semantics differ on the register.

Volatile is used for this and some other things,
like for example interrupts being cleared when a register
is read so it is strictly read-once.

So the regmap config is really important to get right.

IIUC one of the ambitions around Rust is to encode this
in how memory is specified in the language. (I am still
thinking about whether that is really a good idea or not.)

Yours,
Linus Walleij
