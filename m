Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4828E41E574
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350830AbhJAASW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348319AbhJAASU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:18:20 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CBDC06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 17:16:36 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id 37so5487702uaq.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 17:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=reoSaQ9AhImvnMfD926etvYbnKQHn3wv1fqTb5190TQ=;
        b=uDiOshgTJ26FnFnhsDdDxgo0wiCApgOTuGkrvWZz8ozm6Lx/YpHN2K6Fa70Luh9BcI
         FgCNVD80AJuwQA9PS2+tgjMNoWQRsGbAXU0d/iNj/sPlu+H/HgLRAtoUKT4+JJGyk79W
         NX9Au7Pt3OWeqygX9Hvw15Q9m8cn6e5n+MYT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=reoSaQ9AhImvnMfD926etvYbnKQHn3wv1fqTb5190TQ=;
        b=p4topgHF4OgyFz4rgGij8NtXCSHCToAoRNayuRai3T68VZDA5+6IHkRvUqJDTIYkJJ
         a5EKncOkw14O7UZTlpadJ1TqFWH1St1H7Ni0jBWKqRXN628DR11EYrf9Xr0C7punn0/J
         SwOqv7uqN13GnZbR5ZlbW4lOubv0OMF1m8QKauKiklUIncKdXHy2WR09HiJUm83caaYS
         YtU3zwzhvHl1w0RfjCDxwoaDjd/c/C6b/kK2urUye02IVYNgleaINOTVt42dALq0mBWj
         AuSdnOBtzyvjdvDm2/yzuAH/KgXU18UNRiHyeiNwJIX73gaI4X/ThVCEzr08whqyKFvt
         5wRA==
X-Gm-Message-State: AOAM530BBR0UTqIOHbGOH7f21/lWUkQDSYvgJ8iTG540/ZK9ajmz4AK8
        URi0SoTYCdFDwKL/chZmttswDawjQmUsNgmG2heHDQ==
X-Google-Smtp-Source: ABdhPJwdxWlbRP12X6ZE/i37ZeQyQ7WbNoa0R8WFeUB9ZN6+OnmJwCC7HZBzoLWkDPzpBUDP9EqpT+z+lgHbzOl1ras=
X-Received: by 2002:ab0:7587:: with SMTP id q7mr5660146uap.92.1633047395886;
 Thu, 30 Sep 2021 17:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210930124950.3069638-1-daniel@0x0f.com> <YVXWiQWGkzmp6O1A@smile.fi.intel.com>
 <CAFr9PXkgDaXPb+h3TFmS4VVzzmPqjJJj0Y4cd_ZTUgqMbNZUSA@mail.gmail.com> <YVYmTL8WsgYnxPwc@smile.fi.intel.com>
In-Reply-To: <YVYmTL8WsgYnxPwc@smile.fi.intel.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 1 Oct 2021 09:16:24 +0900
Message-ID: <CAFr9PXmVQFDdMiMUgg4v7DAcFkdaUtFeaXOyW4_NrVd5oYKSSA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Mark acpi match table as maybe unused
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, 1 Oct 2021 at 06:04, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> > Doesn't this mean the ACPI table ends up in kernels that will never use ACPI?
>
> Yes. Is it a problem (*)? If so, you need to use ifdeffery, since __maybe_unused is
> not for the ID tables.

Ok, is there a reason it's not for the ID tables? Does it break something?

> *) while justifying this you also need to show why it's a problem specific
> to the ACPI IDs and not a problem for OF ones, which we have tons of in the
> Linux kernel without any guards (ifdeffery).

To be honest I don't care about this too much. I just wanted to cut
down some of the noise when I build my patch backlog so that warnings
in the stuff I'm trying to mainline are more visible.

For what it's worth I think the OF ids are a bit wasteful. For some
drivers where there are tons of broken variations they add a few K of
unneeded data. But since everyone now has gigabytes of memory I doubt
they care...
I'm working with 64MB. :)

Cheers,

Daniel
