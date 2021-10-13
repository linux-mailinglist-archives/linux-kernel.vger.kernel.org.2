Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16542BFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhJMM3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbhJMM3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:29:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08632C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:27:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r10so7690393wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9awpcXt/Fdpp4EJHkJMGWZwyEPn4Abz4go+4w/OnuM8=;
        b=ZfWNceE3G/TTRQBOuhiGQdi4K0oUr0UsdhkU2cLqStFePRwF9n7hZK6c9ovz6xTUiL
         fIPyr8dH0U8uEpMQZ8W3fZoktL1OO5CjH/QBlursUbALa9t0Hkhsd04xKxNKk1f3B3q+
         PLzYHeUQ78cWs2HuDNXyc6RhQjVr+qraq1z1gA/k6fKHmcdYXC9FOmSywiUMw4OF1O/T
         kmQJ3xnOcQ0/aPUK08LDlpHF4aCY6icO6urjHWrDwFuk9Zgdy9CJMm/tTcQBXUg+seoQ
         OAJqlZ6yTaRiwWpBh/v9HLvIxSl4cJ2wWVtUFUkGEMA8VDaexmLPcCH19I2aDm2migMl
         3VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9awpcXt/Fdpp4EJHkJMGWZwyEPn4Abz4go+4w/OnuM8=;
        b=saAYZe5heW9ElVLe1UzqPwsHolIZYuBVjJwg7RkiIIEkhekM9OUVmwkJWAZuceE1x1
         jfwGLx5lDgxVKS5DMs6CBvA6IoFNelnFlfkgVnpmWDCWGEOwws9szsyWd5KD4vJK4rRC
         hPKPsQ8/kRbvf+Vzavl/6MPESM4PG2csflDwFTnLnudVYHFmZuOwo9qjDTkkfd340PPy
         KBzgrx1Zp7iS2iMSPqvQiMSfCAebQkEmbbwd6itfrx/5asF4wuvhDYOyJAurSQzVULpe
         ma6Cz12WeTsf+e0uEdOUqwqQsUbcbgoIH64rw+vQnFC8h0xbEtncKZaoKzTWluKy2NMw
         9M4Q==
X-Gm-Message-State: AOAM531W3CU6KMNh2RLWRc2xaQ9lFUouw9GLfq9x56N0Y9jXZg5YglPy
        cVj/SiRT4M00W+wcoXF0nozsSLC/IcOUhaF87Q2lVw==
X-Google-Smtp-Source: ABdhPJx3DoA2nVDxuZtgL5KQn742hz/AF3AE8knSm7WsPWONEB9itvODbFeaF63zXup9GS2noIWIvuVZ7ovgy/sUbnA=
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr3806329wrs.96.1634128052539;
 Wed, 13 Oct 2021 05:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211012073116.4156054-1-sumit.garg@linaro.org>
 <20211012180348.zalanzdw3ykqg4db@bogus> <CAFA6WYNqzmEe23RQ2Wrq2oeaxAxxwg+e3sW0=7PmgZni5Sd2eQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNqzmEe23RQ2Wrq2oeaxAxxwg+e3sW0=7PmgZni5Sd2eQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 13 Oct 2021 14:27:21 +0200
Message-ID: <CAHUa44HFGWeF5x6rUqWY2vE2ia8MFZtxHXKGJc5JqBRScPOuYw@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix missing devices unregister during optee_remove
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Jerome Forissier <jerome@forissier.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 8:00 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 12 Oct 2021 at 23:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 01:01:16PM +0530, Sumit Garg wrote:
> > > When OP-TEE driver is built as a module, OP-TEE client devices
> > > registered on TEE bus during probe should be unregistered during
> > > optee_remove. So implement optee_unregister_devices() accordingly.
> > >
> > > Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> > > Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  drivers/tee/optee/core.c          |  3 +++
> > >  drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
> > >  drivers/tee/optee/optee_private.h |  1 +
> > >  3 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index ccad3c7c8f6d..3915dc574503 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pdev)
> > >  {
> > >       struct optee *optee = platform_get_drvdata(pdev);
> > >
> > > +     /* Unregister OP-TEE specific client devices on TEE bus */
> > > +     optee_unregister_devices();
> > > +
> >
> > This is not based on FF-A support series by Jens I assume.
>
> Yeah as it fixes an existing problem and for stable backport reasons I
> would suggest rebasing FF-A support series on top of it.
>
> > I added
> > optee_unregister_devices to optee_remove_common and that fixes the issue
> > I reported. I haven't followed the comments by Jens on the approach yet.
> >
>
> Thanks for testing this fix.


I'll rebase the next version of the FF-A patchset on this patch.

Cheers,
Jens
