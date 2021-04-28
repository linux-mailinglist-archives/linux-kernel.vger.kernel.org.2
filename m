Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7580136DC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbhD1P7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbhD1P7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:59:30 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB318C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:58:43 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id g9-20020a4ad3090000b02901ec6daba49aso7156335oos.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPInnfOFiDjbUtus8UESi4go/lSMf8a+ZIcwDEWf+8g=;
        b=erKh+epsO63scyXMwNrUCjVdg/KQNgN3/PTHy6uqKZ3wbcqM0VUrGjnRNq+l7DYi0Y
         E2O+zrnAZTSNsco+1E7M2Cp5PmhNpFyWwJY3WtK9tmbUCQ75/b6b/Zuk6qLXYBH0Flte
         srY6xHKDoXmmK99E2QiNxPCf72uFfhw1xCHx+XQTd9FKDuizkzGvCYWhARywzQ44EhMf
         zQ57DjH2RHlSfdCkr1baAiXGaWSV8xv+NJqZVIljCLMTwoPHkXMYvGBROrGK4CPh0Oq9
         HhADVMBQR7Y6k9HwI/ojdt8l0En48Hv4ZxHcyoIzIaOYia+NMzLno/uK4V86IJjmb+hh
         hICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPInnfOFiDjbUtus8UESi4go/lSMf8a+ZIcwDEWf+8g=;
        b=HN/ObYRSwZzMfQAiv0C6L1mjJ+hy0D+EH7BHqK+s+aIDO9t8Zj6OLHnKgfWGQNYhu6
         kdsEQMLpbzvmmJzDCwrY9TuJ1MZamjwXDXKoS0uXEo8f+Gj0UHZQn3j/QuJL10GZBetQ
         jfdGcE+jrrQaLLqaZn1mJVYPgL5izoOmrk863INgWhplQLmtxREdRhMw3oWwNZ2bpP1V
         +08+kx/ALCkC0ka5q4sJYTXWRWIUzXq3uItSAPqtA3BnXkQcTYRrl+Jrwr9DDckZ4G7L
         ZaSwzs44nwZKWIqSQuERBxWuE8U2JFeKcSEqZdBVDraAdIwipEwRx7xKOH++mcIH/9nu
         zK2Q==
X-Gm-Message-State: AOAM533xLno7MIrELFX54lfbjQgPP7/pzyfRv97thePZMmlcc4/e6I8n
        TzmXVyrONnHtMleX/dtW5RlUCejn11lls0RyHa/kyQ==
X-Google-Smtp-Source: ABdhPJzY2bBmiTk7UScRg+Ew+/mwUg7rioHvkVTYx5RrU19N+q7hRblmsHXhiSDyJt7D/QuDmKwCvetLwCWaeZ+xVgE=
X-Received: by 2002:a4a:db7d:: with SMTP id o29mr23054498ood.45.1619625523100;
 Wed, 28 Apr 2021 08:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210428052725.530939-1-awill@google.com> <dd33cf8d3a78d60eebbb6f1be90cb7d3@walle.cc>
 <CACqsJN-Vernbp5kJc+qZ6nUW50xPWz_9DznLDjtTu=btSra09Q@mail.gmail.com> <5e23722b1c7d6716c404667a3c5bfbff@walle.cc>
In-Reply-To: <5e23722b1c7d6716c404667a3c5bfbff@walle.cc>
From:   Alexander Williams <awill@google.com>
Date:   Wed, 28 Apr 2021 08:58:32 -0700
Message-ID: <CACqsJN_OmEGO+Dgd-xYtX0RXaPcaj4zBL3PqB8=w9TAO_a04Hg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mtd: spi-nor: Export SFDP access to sysfs
To:     Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 8:51 AM Michael Walle <michael@walle.cc> wrote:
>
> Am 2021-04-28 17:37, schrieb Alexander Williams:
> > On Wed, Apr 28, 2021 at 12:58 AM Michael Walle <michael@walle.cc>
> > wrote:
> >>
> >> Hi Alexander,
> >>
> >> Am 2021-04-28 07:27, schrieb Alexander Williams:
> >> > Add the ability to specify a technology-specific attribute_group, and
> >> > expose the SFDP through spi-nor's private group. This enables user
> >> > space
> >> > to have full access to the contents of the SFDP, so all information is
> >> > available without regard for whether the kernel supports parsing it.
> >>
> >> Please see:
> >> https://lore.kernel.org/linux-mtd/20210318092406.5340-1-michael@walle.cc/
> >
> > Thanks for the pointer! Sorry I didn't see that patch series already:
> > My search
> > skills need some work... In any case, there's no good reason for me to
> > duplicate
> > work.
> >
> > I should probably comment on that series directly, but I'll note that
> > one thing
> > I tried to do with the sysfs attributes here was avoid racing with user
> > space.
> > The uevent is suppressed until all the related files are created in
> > sysfs. See
> > http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
> > for
> > Greg's explanation of a scenario.
>
> Sure, reviews and remarks are always welcome. Btw. what is patch 2/3 and
> 3/3?
> I couldn't find it on the LKML.

There are none. I goofed and forgot to fix up the subject line. The two commits
that followed merely added quick-and-dirty SFDP support to intel-spi.c to enable
testing on one of the platforms I had lying around.

--Alex
