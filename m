Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F093335590D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhDFQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhDFQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:20:33 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B33CC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:20:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i143so8772104yba.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BfGN9I6trd5BkeqeFDlqe8gVjdVzdmFU44UO56dxZA=;
        b=FyHsXimFgxNgg4LXZcpB/jQYPZPdVvLWdFqr+x2Q1emEnpcHxOqcf8bFw9699Zti9L
         N0sR2lSJLjyEw4ljxx5/DWU50f+8C3ZdwTpNEYiUM1semfFwCcE57T8AUpewIC3VSKLq
         T3+zQZyE4nHlrmMdBS5Tf4nt7abPowfjltZLkf7M6y72eoexwI0N0UwPkFXu6PzvPU5b
         5oWLBDyRr4Pu+Pd8YMj3dOm05KYmG4UKG1sgu8gNUDT79MxpI4IwKAzI2CcbGM4ORSQQ
         YbrjdY/Tsk6xH9EUipBKayUHOU5t4x0huMldy08I/QWBIyWaQKjuT212cWGQMQ1SP5wH
         aaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BfGN9I6trd5BkeqeFDlqe8gVjdVzdmFU44UO56dxZA=;
        b=VoDgQqTHxoIQJP0URxBs5me554bN4O9YKyg2cnKNw/n3HcFbGXLFNmnkqSukwJpcrw
         eCUcENH9QuT94j2RqtHLJnY4Ch46sJ/rc96npZsVD8mV1Ut0NXI4QI2ueOzKxFVrLDHv
         lTPthL1L6+32flpIvKuUx0iZGMTbRaV0VYwdSDDPdWvW6PqUiyXsURRMpsN9xf3WSnmv
         quQqXY27mMVsAtJNulG4a7FZx8rnrbrJTRkveMMggfziCabbYVirx6S5DOi08UayRLOw
         C0ZscKSVJjtgORXVfjxx13o/YVdaR7p3C6lLrRMU/zxxWYmNW7c2eNMK9lgGC6IhShsB
         2lLA==
X-Gm-Message-State: AOAM530ets9B+EBIBM9VuAWNsoMXBUPB3TeQqPrsX7wWMP4tAMbyGQsO
        D3T4Syyuq51gOhjzeV2bEO4owW/Ny4IPr/5EXMhHIA==
X-Google-Smtp-Source: ABdhPJymluBRZe0ZRl/0Ybrf9Y3OpI0vaW7hM8e2UvJc8sGk7d30GCtnl4Qw+A7Twj0wuUyAl7G2mgKWdOfasYjUHj8=
X-Received: by 2002:a25:58d5:: with SMTP id m204mr43146231ybb.32.1617726023335;
 Tue, 06 Apr 2021 09:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210406181945.2ae6fed1@canb.auug.org.au> <YGwly0cRvxGpt26D@kroah.com>
In-Reply-To: <YGwly0cRvxGpt26D@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 6 Apr 2021 09:19:47 -0700
Message-ID: <CAGETcx_JT+1_ZorCeF3CW2T1vGDM2p7uNm3drHeAMFLZTz0JCg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 devicetree tree
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robherring2@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 2:11 AM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Apr 06, 2021 at 06:19:45PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the driver-core tree got a conflict in:
> >
> >   drivers/of/property.c
> >
> > between commit:
> >
> >   3915fed92365 ("of: property: Provide missing member description and remove excess param")
> >
> > from the devicetree tree and commit:
> >
> >   f7514a663016 ("of: property: fw_devlink: Add support for remote-endpoint")
> >
> > from the driver-core tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
>
> Change looks good to me, thanks!

LGTM too.

-Saravana
