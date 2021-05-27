Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253323926D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 07:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhE0FYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 01:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232240AbhE0FYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 01:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622092985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kMolLnDEuKlCbbgIOvjZGGBzK5WYRhCAHto1CLY+p8s=;
        b=TGpZIpUJddH24prhTz0/nxwz7qwQWR2QXX1cSDQdiIS31A0qAWM4Pl4q1UopVellJCP6if
        ZkOnL5d3EYGXaGk1uazPTwDygoqvNteSJFCR63uhv+I6CZbsBjJPtA0eP+vFceLm+rAucb
        Q0+8F7xWVXbFQ08UgluHaFvOSo0MBfc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-pZV3FiTBPS-HgJ_wJklk_A-1; Thu, 27 May 2021 01:23:03 -0400
X-MC-Unique: pZV3FiTBPS-HgJ_wJklk_A-1
Received: by mail-wr1-f70.google.com with SMTP id a9-20020adfc4490000b0290112095ca785so1279901wrg.14
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 22:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMolLnDEuKlCbbgIOvjZGGBzK5WYRhCAHto1CLY+p8s=;
        b=i3PF0KtX90zvK+M2GIsUEwp6G8t3gFtanLpwlHxjxfpVVEAIUGXczVa9cXNrqjghWP
         nEKmQcVTUtppAjzZedcCY3Anhsq13mrs3xiYh9iaTf3WIBn8qnv8Cqr1Sw6RW0OS0PJG
         jPKphkfCIkF7f9yBvtFCbnsQq52fXYCcf+fZaWGxeMX2eA8PUvn95VvztCb+BXBk7qbE
         ZJ5L842AZrxF3K9ebos/9mpdy9vdZTP26xLq/tP+fwuqiVRiht8pqobp3QFGfB3MEJJY
         AdO0VQC67dhCZSYAUvtpXwqrwfYLwz9cr92BhDVSoITjrRGB65fxKIzIksDDocLrb2s+
         idIw==
X-Gm-Message-State: AOAM531foftPtZTQSIe4zVJCIu3xlJaXZlywy+NoArD5umoMYUNTkG0q
        DQmA8sPHeqQZCPtrTpVgpoJ30A/04wQwTAjiUGjIaCewGBD0/Eh3wi/j2o8Je0TnjSxHz3RmajE
        0mH7uBUVTdCE8ILFGa5b5RUL/nRB02OsEggu1cmkJ
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr1475250wmj.13.1622092982522;
        Wed, 26 May 2021 22:23:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa0wPCCjw27Z2yCH+wdxntKMt6SKdiBQRynFGJITdQ1ITjKHgkP1NlgNUqPttT4t/L9oT/b35YZi6UHzeV/LA=
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr1475236wmj.13.1622092982195;
 Wed, 26 May 2021 22:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210429102828.31248-1-prasanna.kalever@redhat.com>
 <YKMKdHPFCNhR1SXx@T590> <CANwsLLH0HyZ-VGPMc+VmuLivG1fiZHnSqUyLx3UWb76ZMCgYSg@mail.gmail.com>
 <CAFnufp3ZzrKHiV1Vy9_bAymy0oEr288dL4yWo4EjqUzhJV6J-A@mail.gmail.com> <CAFnufp0V7X_nvN3RGK-C0AXappQ+qjMS_rb7iQhcjT8E0OVpzA@mail.gmail.com>
In-Reply-To: <CAFnufp0V7X_nvN3RGK-C0AXappQ+qjMS_rb7iQhcjT8E0OVpzA@mail.gmail.com>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Thu, 27 May 2021 10:52:50 +0530
Message-ID: <CANwsLLEtOws-+X=3CCGzO88poP9NF8uNN8aW9wHOJ+QA=SFH3A@mail.gmail.com>
Subject: Re: [PATCH] nbd: provide a way for userspace processes to identify
 device backends
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Ilya Dryomov <idryomov@redhat.com>,
        Xiubo Li <xiubli@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 7:44 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Wed, May 19, 2021 at 4:33 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > On Tue, May 18, 2021 at 9:52 AM Prasanna Kalever <pkalever@redhat.com> wrote:
> > > > BTW, loop has similar issue, and patch of 'block: add a sequence number to disks'
> > > > is added for addressing this issue, what do you think of that generic
> > > > approach wrt. this nbd's issue? such as used the exposed sysfs sequence number
> > > > for addressing this issue?
> > > >
> > > > https://lore.kernel.org/linux-block/YH81n34d2G3C4Re+@gardel-login/#r
> > >
> > > If I understand the changes and the background of the fix correctly, I
> > > think with that fix author is trying to monotonically increase the seq
> > > number and add it to the disk on every single device map/attach and
> > > expose it through the sysfs, which will help the userspace processes
> > > further to correlate events for particular and specific devices that
> > > reuse the same loop device.
> > >
> >
> > Yes, but nothing prevents to use diskseq in nbd, and increase it on reconfigure.
> > That would allow to detect if the device has been reconfigured.
> >
> > Regards,
> > --
> > per aspera ad upstream
>
> FYI: I just sent a v2 of the diskseq change
>
> https://lore.kernel.org/linux-block/20210520135622.44625-1-mcroce@linux.microsoft.com/

Thanks, Matteo, I will take a look.

Just to set the expectation here, I don't have any thoughts on
leverage the diskseq number for nbd as part of this patch. This patch
is trying to solve a different problem which is more severe for us
than helping to identify the reconfigured events.

That all said, once diskseq patches are merged, I will surely open a
new patch with the required changes in nbd, to leverage diskseq
number.

Best Regards,
--
Prasanna

>
> --
> per aspera ad upstream
>

