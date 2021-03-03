Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36B32BC84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359269AbhCCOFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842919AbhCCKWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:33 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790CC0698E5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:29:25 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id l8so23770618ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aiFQyvccotyAOCkOFmkIp2oEvU8YKFbNPpPL2ECS/lY=;
        b=vg6Br5lDqRi+2sxN3awq9vrZpYxVUyJjIJhV+UvfLccaJ/bBWcDzxTAgjOryLW0jxp
         ehUGhERTefh4PcNurwRtltDCZzjHo1ifIorAjRHv48e6v+1EowrqWHH+6y6A7nnaOQBQ
         pLILC7teU8PhBRUvGPXm26JJxAF825tmPhtmVd3v707JxE0tBzDu/cAWbVfzkiFNaV7c
         eWvFr6BAQKmCf6/B+4h8jOxX/uG3oMAeNNg6I4u5B2gtmL+S6PX7djefJODSTpgyYT1P
         OSnOUHjb986CZmX0mbxlsXoLkbp+6uHgvIox2xuWOTuQCwrkF4zfPIxvhdN2hCnxY1+y
         AMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aiFQyvccotyAOCkOFmkIp2oEvU8YKFbNPpPL2ECS/lY=;
        b=m81gF6o99nuU+cntkEOJa7BB11mVOx8uGMbEtRUGFNvuUyYe5YR5SVyuGKPzn4eNQa
         fyIXQFNL4w5LSXkHLl3tC2QSDna9PDMISbq3D+edstFBH34rC9IBBlDr04rjmU8syoCm
         0ZGYfgUl9qrQuHYgim4EyMFY9IeskKK9QnHnJfg0ou4pKyXqcOySBNnFc6aCK4c1x1Ls
         VSD/E2RnSxqdAEUtruQeT/ze6tiX+I6qpQoYupLa/PaONaW1P5zLtI4JGMu013egX/QP
         0xCd+t5G08vKkHbfl3Nr3yj6MHvJ3cxC48nl4eWGoAK9MhYU41NlbjfBiQHh9fs4C//f
         C4mg==
X-Gm-Message-State: AOAM532lkd+8kddQ4xC+SBzmoHpf3c/Qt1A1rZ1QD91HlMnmywIHfxtn
        co1teoSCYokRlxUVhKS2XuxJ+XQWhbZzvAFcqEwXgg==
X-Google-Smtp-Source: ABdhPJyVtLnD0blyjYEv+Vvw/Z0kvQGEo9oVRw5D6cmt8TOkMT9NcSWARXScuCfQIdQTGPzsfkNfDLLZ0uXqpN4FvBA=
X-Received: by 2002:a25:dd43:: with SMTP id u64mr2806563ybg.96.1614763764660;
 Wed, 03 Mar 2021 01:29:24 -0800 (PST)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <b2dd44c2720fb96093fc4feeb64f0f4e@walle.cc> <CAGETcx_xCpid3QW0gQJWLL6ZfT-VJJq-SYX4tG09GRQWucw=qg@mail.gmail.com>
 <CAGETcx__oG2XrQ8RwZ57cVgV+Ukfni4qUQCe11kbL8E1U+4a_g@mail.gmail.com> <12f31a46e8dc3f0e53c1a7440a4ce087@walle.cc>
In-Reply-To: <12f31a46e8dc3f0e53c1a7440a4ce087@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Mar 2021 01:28:48 -0800
Message-ID: <CAGETcx8hAX2iv3KakM+pXeBPu_RFsUFLBBZvwDVxG95mAY=woA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 12:59 AM Michael Walle <michael@walle.cc> wrote:
>
> Am 2021-03-02 23:47, schrieb Saravana Kannan:
> > On Tue, Mar 2, 2021 at 2:42 PM Saravana Kannan <saravanak@google.com>
> > wrote:
> >>
> >> On Tue, Mar 2, 2021 at 2:24 PM Michael Walle <michael@walle.cc> wrote:
> >> >
> >> > Am 2021-03-02 22:11, schrieb Saravana Kannan:
> >> > > I think Patch 1 should fix [4] without [5]. Can you test the series
> >> > > please?
> >> >
> >> > Mh, I'm on latest linux-next (next-20210302) and I've applied patch 3/3
> >> > and
> >> > reverted commit 7007b745a508 ("PCI: layerscape: Convert to
> >> > builtin_platform_driver()"). I'd assumed that PCIe shouldn't be working,
> >> > right? But it is. Did I miss something?
> >>
> >> You need to revert [5].
> >
> > My bad. You did revert it. Ah... I wonder if it was due to
> > fw_devlink.strict that I added. To break PCI again, also set
> > fw_devlink.strict=1 in the kernel command line.
>
> Indeed, adding fw_devlink.strict=1 will break PCI again. But if
> I then apply 1/3 and 2/3 again, PCI is still broken. Just to be clear:
> I'm keeping the fw_devlink.strict=1 parameter.

Thanks for your testing! I assume you are also setting fw_devlink=on?

Hmmm... ok. In the working case, does your PCI probe before IOMMU? If
yes, then your results make sense.

If your PCI does probe after IOMMU and uses IOMMU, then I'm not sure
what else could be changing the order of the device probing. In any
case, glad that the default case works and we have a fix merged even
for .strict=1.

-Saravana
