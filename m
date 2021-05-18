Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18A3878ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbhERMhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:37:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48118 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349241AbhERMhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:37:18 -0400
Received: from mail-lj1-f197.google.com ([209.85.208.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1liyx5-0002c9-GW
        for linux-kernel@vger.kernel.org; Tue, 18 May 2021 12:35:59 +0000
Received: by mail-lj1-f197.google.com with SMTP id b13-20020a05651c032db02900cf5cc3941eso4493605ljp.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tx9LU5o9jAhb+IFA4JJT+cH3DFIRGJA++2PvkEKicgc=;
        b=YQNBgicUZtIqSjUDqllpKuHewYGtm7XgtEHLi5cvM5L3s2Hp8RHIwCYdPl+kUdTD6d
         LvV+JwOe6EcVosh4NztQQ0fF6zTi8rsw89wxB2aKZO29AKor9u3EayT1Z2ocqR4BWpzR
         lJaBugVwC+dK56WxJso87EUBKn3xsq3MqvAFF25dqLNK6cNGRlGguKEeqwvEwKnJ1xe1
         rT0BzXGSH3uCz0LA/YWL7zcDLuvrOOvs0fEzoAIItX3sMc0fBCENcn6MGq1AUYdKr9pq
         FcDSoKKtRUKx1fH9MqUmE9QT8vvakSHicQGKt36ZwEqUCYH7kfzYmlggq/tsqblC4pD4
         rr6w==
X-Gm-Message-State: AOAM530Le80FwHW13jcbolMHDRgnLSXq9X7TBW3QgUvUu9GAng+BGQg3
        hRSZS9aGUzWb0v5vVePvt7rQOp9A8cqbVMzUFB5HowgboqF7vJ646eJEigrYAITFMgySiYSM4Aa
        iSVVzF71Q4uWyEjYLIEFx4P2DcgihiTxF0t0dYKsE7H+Uoz4tEOdZRE8Lew==
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr3932590ljc.116.1621341358976;
        Tue, 18 May 2021 05:35:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybFNsPf0Do0WDz9v8JDWpUkpj6ScfvlBCFO6JixzRfpYuTdjiLENvOk6Er/8rzNY+u/3WjWPm0zCTgII+Ml2E=
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr3932572ljc.116.1621341358636;
 Tue, 18 May 2021 05:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210518111640.243559-1-kai.heng.feng@canonical.com> <f5d2e440-e777-7ef1-db4b-0f50a8a5f6e1@linux.intel.com>
In-Reply-To: <f5d2e440-e777-7ef1-db4b-0f50a8a5f6e1@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 18 May 2021 20:35:45 +0800
Message-ID: <CAAd53p6MS=nZ=rK3kEe4TpBO99cvBkbntcTJpNs2cxw1CjThtg@mail.gmail.com>
Subject: Re: [PATCH] xhci: State explicitly when the controller is inaccessible
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 8:19 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 18.5.2021 14.16, Kai-Heng Feng wrote:
> > Sometimes the dmesg says "Controller not ready at resume" because CNR is
> > flagged. But what actually happens is that the whole USBSTS becomes
> > inaccessible, and the reason could be disabled PCI I/O space or faulty
> > firmware/hardware.
> >
> > So state the reason explicitly to make the message more clear.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/usb/host/xhci.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index ca9385d22f68..0e6fbe1f4fcc 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -1117,8 +1117,9 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
> >               retval = xhci_handshake(&xhci->op_regs->status,
> >                                       STS_CNR, 0, 10 * 1000 * 1000);
> >               if (retval) {
> > -                     xhci_warn(xhci, "Controller not ready at resume %d\n",
> > -                               retval);
> > +                     xhci_warn(xhci, "Controller is %s at resume %d\n",
> > +                               retval == -ENODEV ? "inaccessible" :
> > +                               "not ready", retval);
>
> Old way did print out retval, and was greppable.
> Not sure this is an improvement

That's true. Maybe it's just me, but I can't directly mapped the value
to -ENODEV at first glance.
But in essence this is just a cosmetic change.

Kai-Heng

>
> -Mathias
