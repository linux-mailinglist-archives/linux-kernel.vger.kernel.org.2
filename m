Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5031648C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhBJLDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhBJLBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:01:03 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E64FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:00:20 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id o21so1180740qtr.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04D7WiqCI7NQHqfoZHV7XOGofyTBt4zdFBB44Awvjnk=;
        b=IG0QkIZkXZBjKkv0lndbbKwa6qb49vZlpLlQYYEC6rcrm+bbZJ0eLAJ6fykd4gZR/S
         wxZ/m+KKUdUGCpBJmyhC2/jkax6yDV5lVYoJHw+Rk1oFUog9OFGY4JebESWsHgKWdQvT
         inWZcRJJhvyjr5v0feqPls+KpXtM62j2nGxavZpuL+OSnjW+0ZtvAIeBavx2Y80Hskdu
         wIJKl0EYjhto4vMpy5y7P7vLryfuVBOoLRNwjrCwg6O1t9T4VcnkOZ9t85stlS6b0mYj
         QBCUZ5NHMujcZB8AFEb3H+nFoGqstihuyfYR05SLUsphsbEKIIkFiV4C7Kk/8uqydq3n
         N58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04D7WiqCI7NQHqfoZHV7XOGofyTBt4zdFBB44Awvjnk=;
        b=WQxBIFNwOMs9aofaBWuVdCvRsuMg1vCEstGWyWeroDM1pcYZdwlhtNx/KAUjcbC1jU
         4n3vLQPJZyPrjNbt6Rb9UTN9m3LL5fP0N2iwF8v7EgWGwD2Pl/3C0mvtpwbocDcgD23o
         Yfk+dWs1BdU1EXSPAWzDyXfhIoQNoLLMiH4Edp3y8P7K18A35tW3yKpaUaLsidPZ7gT2
         1wgz9U5iCG903t70vCJdlozd/fj161kWoUq8hONC9AXAPbqMoCKwDKLkCZ29tqXMGfcs
         dCiYhbmLHPiGTyt/ClyVbLzYFRX95DEuPRsFeTkfqMmNW58wo8VB6kwczx3eD3dHzkN5
         S23g==
X-Gm-Message-State: AOAM530eijInS3aNbf/4RjJE+pVtV11C0EDNLsuzRxiklEJb61z1PGG5
        Sdc8kLHSeaIxA/LPtXcudnhyINrY+YL+f7tffv0=
X-Google-Smtp-Source: ABdhPJwRr7mUzNOAOmedbVFQ/Xg83qXUrqSrgg5dnbPM+Tw0UB426Rh12Fp9qp+LKpm6JkkJmK1UY7CzoSPfMBIy5dI=
X-Received: by 2002:ac8:7210:: with SMTP id a16mr118272qtp.82.1612954819564;
 Wed, 10 Feb 2021 03:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
 <1507208626.379155.1612906761549.JavaMail.zimbra@nod.at> <CAJfpegugbvppOKhJ8KjSVGgZOGVuj6NSiy4n18mbD7Ui3wme6g@mail.gmail.com>
In-Reply-To: <CAJfpegugbvppOKhJ8KjSVGgZOGVuj6NSiy4n18mbD7Ui3wme6g@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 10 Feb 2021 12:00:08 +0100
Message-ID: <CAFLxGvwhdHeUDR8Mk8kyMvMCcRc4S4pcjs29ttPTHL2XWW93fg@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 11:22 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > In MUSE one use case would be attaching two distinct (variable length) buffers to a
> > single FUSE request, in both directions.
> > If I read fuse_do_ioctl() correctly, it attaches always a single buffer per request
> > but does multiple requests.
>
> Right.
>
> > In MUSE we cold go the same path and issue up to two requests.
> > One for in-band and optionally a second one for the out-of-band data.
> > Hmmm?
>
> Does in-band and OOB data need to be handled together?  If so, then
> two requests is not a good option.

They can be handled separately. All I need to figure who to abstract this nicely
in libfuse.

-- 
Thanks,
//richard
