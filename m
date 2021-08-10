Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AA73E5CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbhHJONi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbhHJONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:13:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8EBC0613C1;
        Tue, 10 Aug 2021 07:13:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so19139309lfu.5;
        Tue, 10 Aug 2021 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tQ9djM8Tzt2DqRTr0Ac9cV4rkPFXLMY1XtXmewIg/CM=;
        b=pm5OtXw3zU2t/eI3uwo88dLJRmQSC5LPfztxKtRQ4lAZn1PTaztvFcIlMDQ399PoUM
         3v76ZG0lY0LgoD3rsEJsRpwKD4nqP17ofL+SZHJJHPYeZ2Z2/xtKRzPU1scoZ+iVxE5j
         nX8XgnP0vT+Dg2Fn5usNbfjL9HCiG7RpUzy3DDpo0SVdwFMgh5si2bwiMrG5nFqotEEE
         uYxvT2TlijQ6qAurDm55aBPiCVcpMgZPkbYvYVuP+Kz/EILRs4Z3BYcYjzL2AZx89eJs
         mR5EQhSP0rLCHaTIeOGcFZ1IkZxa7aT+lDI27nyMynl9MX9XUQn2JKXpQCNd77WrgbCx
         1Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tQ9djM8Tzt2DqRTr0Ac9cV4rkPFXLMY1XtXmewIg/CM=;
        b=erqC52FAP+FgtGmoU1Ld/XkORENodoI4cGvb1gu8elWNeMgukCxYeXOMmSe+qFYq3P
         q2yHZ71CfX9Wy80+6KcZo3cmPFv2o9XLR5ECD3vJwK69l5nBWBXF86J+eoiFWjELnY0T
         1CCItOmAKkK7iZTukq1Rg2xR80PfaAhkKEFYYN4mnntkYqh+R6h7CofHE5FTY0dupIaY
         9OUmqMsMGQvVNoC0C1eUHWCRrijaCw2SJpZ3oJOuus95UIiDV0xj1/T8KjplTIimwjFO
         6CCRnqMn22HJKtFnl7JYVAPGjb4Ab/jpzG6KfcI/Vn2fCUi4NCI66BUDYnjDYQdiD0Oq
         KDOA==
X-Gm-Message-State: AOAM533wD1umB6ViMkOCNblVrH7ABP8bFi6topan9CojZCY2zLg0OiXy
        tYQZsg/BUJTu18F3m7h2ds93sW8Nu0z1o5b9AC0=
X-Google-Smtp-Source: ABdhPJx24iFkm7YOe7nV7SVgDlikcarRRpk+Zs+LpMZRYMJLqAsoiV7nt+GMbA3+axaX+DFRpqeMyPBKfowApoBOw1k=
X-Received: by 2002:a05:6512:3b07:: with SMTP id f7mr23846052lfv.398.1628604793544;
 Tue, 10 Aug 2021 07:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+jKREfXERKj7XB7U3Wh1g4STO2Dt0qnMkcPV5nXB3_bwg@mail.gmail.com>
 <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com>
In-Reply-To: <8923f2b8-0be0-ffbf-70a4-c03c9a02d58a@suse.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 10 Aug 2021 19:43:02 +0530
Message-ID: <CAHhAz+i5YeQdJnBH6BvMJ-B0DtoBu9ER4Z79CPOfX5NuFvO=bA@mail.gmail.com>
Subject: Re: read() via USB bus
To:     Oliver Neukum <oneukum@suse.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 1:45 PM Oliver Neukum <oneukum@suse.com> wrote:
>
>
> On 09.08.21 09:58, Muni Sekhar wrote:
> > Hi all,
> >
> > PCIe memory mapped registers can be read via readb(), readw(), readl()
> > kernel API's. Similarly what are the kernel API to read the device
> > registers via USB bus
> >
>
> Hi,
>
> I am afraid this is based on a fundamental misunderstanding on how
> USB works. It is based on passing messages, not reading and writing
> registers.

I am referring to the code mentioned in
https://patchwork.kernel.org/project/linux-arm-msm/patch/1534464348-8227-3-=
git-send-email-pheragu@codeaurora.org/

As per this driver gets access to the Qcomm=E2=80=99s USB h/w device regist=
ers
via devm_extcon_dev_allocate(), devm_extcon_dev_register(),
platform_get_resource() and devm_ioremap_resource API=E2=80=99s.

What does the USB external connector EXTCON_USB \ EXTCON_USB_HOST
devices means? Are these different from normal USB devices?


>
> USB devices are primarily based on endpoints, not registers. A literal
> answer to your question would point you to the clear/set/get_feature
> standard requests of chapter 9 of the specification, but that really
> will not help you, as you are making assumption that fundamentally
> do not apply.
>
> I hope this list stays friendly to newcomers and we will answer
> specific questions, but at this point I must advise you to first
> read an introductory book.
>
>     HTH
>         Oliver
>
>


--=20
Thanks,
Sekhar
