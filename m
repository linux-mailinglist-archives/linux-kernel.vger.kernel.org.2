Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB142B644
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 08:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhJMGCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 02:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhJMGCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:02:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB61CC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 23:00:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so6648058lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 23:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEWRKo0fhQ7LaA5ubEPV4PTCzW8bHaOQIjdgFkAs2J0=;
        b=MCCKvjTsqHrXf2nJrTdQUwft5thpfnFD3ag6RR9xVjUaLR11jt4OkCrdsL6/BGA9I0
         PhBYxGmeNkFsS8N3ctPy4WAuiQbDBwGQjo1pO5QUf5PLHjk/u0k83BLBj2ws3AWytC2n
         ocKk+/3D99ZKm47+WvOeOziGQ7usEKFIJXtEr5vBiALWfyySllQlvTpFVh92fLwgqP+z
         TJaXKn0ZaLs5JfuU2x1z2Pb+sRk7y9nw79Yq0fepf+yfvgVQDu5Q8uVYF9x8zCojcV8p
         B6MWJ+QWMgw3BmPsEycirH96xi3iDFywXOYHTAN2MQU0pEU4yuZGMdLVKRyW8JxgkZJW
         h0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEWRKo0fhQ7LaA5ubEPV4PTCzW8bHaOQIjdgFkAs2J0=;
        b=Ix1PNUOK3JY/8OC+q6vQL8V7VDADMPJ6pzcEJCnXi/nZ2vS7lJ0mq/UhxDMgpvkg64
         CR8d/58Iv1Q/As+sJGhd2M64VorIilaj32ONtX4MqYArPNUOr1WelxZbJxvHNN2hGuuU
         GRwJ36UaX99246qgyQvaS7G0eP9uGRoGDQHT3D+Ir20/mGxYFBQ2mLCx+KqKNde+sFUl
         jtg70m/Ek1bE0lHwbZakSXeWUR7z8X/f9cNg3xgtLzbbzZ/GXnUJ1q7IxZkfUXUabaaq
         ybO9bW8wdqYHpIBrKgfJKrCENsE3UmFbaJ6ewd+EZa5NV4wGw2DkoNqi2BfPaFe0weHL
         NS1w==
X-Gm-Message-State: AOAM531ItIbAcbl4+x9AtR3/U7KIpocncHPAJJISAUpHBiKejsK8LC3R
        PV85GdYTEAfnTVZAv8AZA+FOHGz0VPEOXJIiT/iGk3E9pdKw+w==
X-Google-Smtp-Source: ABdhPJwdUroKerRP156Qz3NtV+bU8DBdkfS+K+EFkrjloNW/BMTSH7n2UNx5Pm6ZSemjooLT1HEQ/tMpmhNhrKOAjJQ=
X-Received: by 2002:a05:651c:1304:: with SMTP id u4mr33243525lja.136.1634104817130;
 Tue, 12 Oct 2021 23:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211012073116.4156054-1-sumit.garg@linaro.org> <20211012180348.zalanzdw3ykqg4db@bogus>
In-Reply-To: <20211012180348.zalanzdw3ykqg4db@bogus>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 13 Oct 2021 11:30:04 +0530
Message-ID: <CAFA6WYNqzmEe23RQ2Wrq2oeaxAxxwg+e3sW0=7PmgZni5Sd2eQ@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix missing devices unregister during optee_remove
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jerome Forissier <jerome@forissier.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 at 23:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Oct 12, 2021 at 01:01:16PM +0530, Sumit Garg wrote:
> > When OP-TEE driver is built as a module, OP-TEE client devices
> > registered on TEE bus during probe should be unregistered during
> > optee_remove. So implement optee_unregister_devices() accordingly.
> >
> > Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> > Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/optee/core.c          |  3 +++
> >  drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
> >  drivers/tee/optee/optee_private.h |  1 +
> >  3 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index ccad3c7c8f6d..3915dc574503 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pdev)
> >  {
> >       struct optee *optee = platform_get_drvdata(pdev);
> >
> > +     /* Unregister OP-TEE specific client devices on TEE bus */
> > +     optee_unregister_devices();
> > +
>
> This is not based on FF-A support series by Jens I assume.

Yeah as it fixes an existing problem and for stable backport reasons I
would suggest rebasing FF-A support series on top of it.

> I added
> optee_unregister_devices to optee_remove_common and that fixes the issue
> I reported. I haven't followed the comments by Jens on the approach yet.
>

Thanks for testing this fix.

-Sumit

> --
> Regards,
> Sudeep
