Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193813D150C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhGUQnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhGUQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:43:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511CC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 10:24:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h9so3958363ljm.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/geap+n06qADP8bUUkTvJg1+GbqYMe8lt6RpcUMxI18=;
        b=Hdt2KFh5xvg+QlcJKKcwzWITxdiB3zzWrNsSCi3yAmz5xkPmKzqnF9Vf88sIJjyPDe
         Ja3BG8LkZkNqMVYCmyfVmPjbmoWDHNC6HgfHZY9miAffsE8USRj45txPlXOHFqcKntP3
         JjG7JeL0LVCQRQFaqy6JOIaGkcz2XECZ3STKTmPSSK0EKewRHEkllDmMhuIPT0uEdT52
         UwELbIZsRCf9PI/reTR9o+ZG02ZzwTKnr65Pk5ZvQwTvMOL5yV5Q6QklhTuJftyhkSuM
         MNeB8hArE2/Uhg1XW/oqWLr9/271h+/O24cYDoBKJOPLkn+OgMrJxb73TsB4kCB0PkhA
         PB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/geap+n06qADP8bUUkTvJg1+GbqYMe8lt6RpcUMxI18=;
        b=nkWxsP90J/pEV0w1W8lOrX3QSuP6J0O6yoKN9IBfNR+r1et/7SiOqcqtb4aVsygp59
         Z0fhu4bkU5yDENKf1iDxeiMnLtvaTtHHYzvhm5IcsAUJYR/RRSMIG4HnCXEGK2zIkIW+
         edRsnel8jDdaa/dX9PE8ohbMc9Jes/40PaAm9vmeBcS0NwEl0zPYv9R7lVtAzDyyYNLX
         dg5VYcYikAgyU7QcUD9Rai65O0LvB9XKFQ0j4LpgFup+uGnno6mwoLs4YNwxfoNgaLtF
         rFlUCIqTLGNqOG337aGjK8dhopwe0NeptbeTth3pq+J9uj8nFAR4FJ9W2JIGOTcy/sp0
         b/yg==
X-Gm-Message-State: AOAM533Dazgl8UwhuQI2LAlYPvzmZmEtVRvgMEimQOOKB2R1lfq7JxrE
        8eWLAIs4Dw7V6pTE/2JNsbKNXEk29IbxFvncexbJBg==
X-Google-Smtp-Source: ABdhPJws9ZMve7X1DBmsQqOrLOBnsRl56RypIYvLQcQu3Pn14yEsYIeMebFKy7cEHM6l5RgopE5mNsBgOpWsXYjmmQY=
X-Received: by 2002:a2e:a54b:: with SMTP id e11mr24488402ljn.503.1626888252628;
 Wed, 21 Jul 2021 10:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210707045320.529186-1-john.stultz@linaro.org> <YPgK50dmV7Z69WsL@kroah.com>
In-Reply-To: <YPgK50dmV7Z69WsL@kroah.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 21 Jul 2021 10:24:01 -0700
Message-ID: <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 4:54 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> > Allow the qcom_scm driver to be loadable as a permenent module.
>
> This feels like a regression, it should be allowed to be a module.

I'm sorry, I'm not sure I'm following you, Greg.  This patch is trying
to enable the driver to be able to be loaded as a module.

> > This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> > ensure that drivers that call into the qcom_scm driver are
> > also built as modules. While not ideal in some cases its the
> > only safe way I can find to avoid build errors without having
> > those drivers select QCOM_SCM and have to force it on (as
> > QCOM_SCM=n can be valid for those drivers).
> >
> > Reviving this now that Saravana's fw_devlink defaults to on,
> > which should avoid loading troubles seen before.
>
> fw_devlink was supposed to resolve these issues and _allow_ code to be
> built as modules and not forced to be built into the kernel.

Right. I'm re-submitting this patch to enable a driver to work as a
module, because earlier attempts to submit it ran into boot trouble
because fw_devlink wasn't yet enabled.

I worry something in my description made it seem otherwise, so let me
know how you read it and I'll try to avoid such confusion in the
future.

thanks
-john
