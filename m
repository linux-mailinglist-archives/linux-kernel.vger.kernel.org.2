Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E6F345AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhCWJe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCWJeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:34:05 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8895C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:34:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h7so14410510qtx.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6F6NXGeRgosTfbHvdsjCF0kdLc4P28DODH78gYIvxqw=;
        b=fV2KtRlBe3pRC9JBnAglQgxeGSx0SOHh5MWpO6JuKtiJZLRckX7LnmLb53KNDNv9RM
         HPDkxwKKP2o1egsy8SLrXaRPGJDIpsuIDLHW3bOIXLOnVzF5oDhavnE+q1UQj3aR7Q2B
         8VJACUxTUlp86gI985gqvFExbpI/Rr/qVJILE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6F6NXGeRgosTfbHvdsjCF0kdLc4P28DODH78gYIvxqw=;
        b=sOJks0m5Y8jqDGX+PSkLMDCt7Hk5CsO44jIJo9EnaNqLYiHGCNjzIWWHe9DvCaBLw/
         8JYqX6JkC9BbsV9+Imyw45CHlXbUO2AThgdMffDnzrxTc6mqUs97414gcj7gBZRmq2Nb
         8HitPc3Tn/xzeX/7Tm+qWFh1ZA1zldsmkjCjJQGtNnSdU/1p+S9gwcbjG7CbJJtPnmGK
         EhB2SvRrDsrkUUkrWWJ2+jIXdGxrN9tJPNC3V191CyjynZZfI4pxJTjNHbMy5j6aOZP2
         YgKxqk8GvAB+okDXbisxSyNWFPodDhoBR7e2TBeFF8Ayhx6rSi+4zN7ZBLqFLyGuXZMH
         vREg==
X-Gm-Message-State: AOAM531cBIfQywbuyRoi0ACztyVM/y2Stm6QKt1F83chqdIdm8B7qaZ+
        WL/Q3RpLRAL43p5zZRFzTqC9JXkNw1uJ6JTCP+xYKCMPs3w=
X-Google-Smtp-Source: ABdhPJyaQ6eVd9B6SzxtJ9qIpIV127NwgBWnq05rA8QfHUnr0gUAolRXXUQKXqsEl2qp/wlkQGgU8wZxJnm63FRO2t0=
X-Received: by 2002:ac8:5313:: with SMTP id t19mr3518326qtn.148.1616492044872;
 Tue, 23 Mar 2021 02:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210213095724.3411058-1-daniel@0x0f.com> <20210215112409.1a755bf0@xps13>
 <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
 <20210215121653.4edd86c4@xps13> <CAFr9PXmVehtcm6FjBqi_hmEAj1rgtxMvarisjPmWhgjruVj++Q@mail.gmail.com>
 <20210322193213.18520b9a@xps13>
In-Reply-To: <20210322193213.18520b9a@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 23 Mar 2021 18:33:54 +0900
Message-ID: <CAFr9PX=mL9UWcr-yWbYa5NXS-R=yHeGgM+hd_MKOa2XiBUAJOQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Tue, 23 Mar 2021 at 03:32, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > I think this shows that the datasheet is right in that the complete 64
> > bytes of "spare area" is usable.
> > I have no idea where it puts the ECC though. :)
>
> Argh, I don't like when hardware tries to be smart.

I'm sort of worried that there just isn't any ECC :D

> Ok then let's declare no ECC bytes in the OOB layout, I guess it's the
> best thing to do...

Ok. I think I might add a comment in the code that this is a best guess.

> I don't recall the state of the patch which triggered this discussion,
> so I guess it's a good time to respin.

I'll resend it. I've added support for the 2Gb version in the meantime
so I need to resend it either way.

Thanks,

Daniel
