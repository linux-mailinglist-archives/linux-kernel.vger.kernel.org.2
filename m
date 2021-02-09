Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8157315188
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhBIO1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhBIO1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:27:17 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8503C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:26:36 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id y35so519652uad.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mc9ajK/ExIHzpPYfk2i4tM1eLLMKQGhgH9O5R8zyOqU=;
        b=ouVVqh2U1belsgV04Y2GTHvzxh79luVJ3l8YALSNgGm61/eOOU2lsLpx068nDGY+H2
         5vLtmWhUNeK3M5Zd1ICUI+4vVz3lc+1iI4Dbh0jwR7BUTHChQcb5bWLTDAtiHNReOgG3
         XnDn+d0opgj17dtKIW0wVlbRBnVcsM5kpZZUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mc9ajK/ExIHzpPYfk2i4tM1eLLMKQGhgH9O5R8zyOqU=;
        b=gQcn1HFuDki1maQJ4oBjhApVvqmaqHGHRf21LFiErU2SaUhqEqBZmssqbwu3l1tRum
         9xrYq/SrJEkn5S6bfzmftK64OnzZRVTBDPLr0FktnNxlrN68kc14lx2uUF+IsWVze/ZN
         4jWoPFMEwdKTaQe8Ra4zTpEfMn4fWHLH948XsfP5kDxaLEobqwawTF13FQnU81a0CJYm
         lLg1kU4X/gkhoCBcgtrSm+HFIcnNe2YkWCVYQI+wiv8Gfck9UZEVRPF88gAa+k6iKBdA
         xQ1hcufShmjpahCUaZDwIuGMW7KTvRXTMNhE3c47AvOokj2oC1JbIfjDvwNRUoD7SzUF
         b/tg==
X-Gm-Message-State: AOAM533mkSPhogoHtiKjcwuYU8cG3fFt3zF5mDlxf58D3t25o3TtRCYp
        6OMwVXfP97cXbApDuSWasEKxviaFjJ4bFCe4FIkj6TM/yaA=
X-Google-Smtp-Source: ABdhPJy4aJHucfQgRXcSfDHbkiZDQs6NDFbWHQh0a37F5qLXYBPdb60JYI8BizBvkqD7MN8sIvwQyZuq60ynD6iUVg4=
X-Received: by 2002:ab0:6f0d:: with SMTP id r13mr13099908uah.8.1612880795818;
 Tue, 09 Feb 2021 06:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at>
In-Reply-To: <20210124232007.21639-1-richard@nod.at>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 9 Feb 2021 15:26:25 +0100
Message-ID: <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven@narfation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:21 AM Richard Weinberger <richard@nod.at> wrote:
>
> I'm happy to announce the first non-RFC version of this patch set.
> Over the xmas holidays I found some time to experiment with various users=
pace
> implementations of MTDs and gave the kernel side more fine-tuning.
>
> Rationale:
> ----------
>
> When working with flash devices a common task is emulating them to run va=
rious
> tests or inspect dumps from real hardware. To achieve that we have plenty=
 of
> emulators in the MTD subsystem: mtdram, block2mtd, nandsim.
>
> Each of them implements an ad-hoc MTD and have various drawbacks.
> Over the last years some developers tried to extend them but these attemp=
ts
> often got rejected because they added just more adhoc feature instead of
> addressing overall problems.
>
> MUSE is a novel approach to address the need of advanced MTD emulators.
> Advanced means in this context supporting different (vendor specific) ima=
ge
> formats, different ways for fault injection (fuzzing) and recoding/replay=
ing
> IOs to emulate power cuts.
>
> The core goal of MUSE is having the complexity on the userspace side and
> only a small MTD driver in kernelspace.
> While playing with different approaches I realized that FUSE offers every=
thing
> we need. So MUSE is a little like CUSE except that it does not implement =
a
> bare character device but an MTD.

Looks fine.

I do wonder if MUSE should go to drivers/mtd/ instead.   Long term
goal would be move CUSE to drivers/char and move the transport part of
fuse into net/fuse leaving only the actual filesystems (fuse and
virtiofs) under fs/.

But for now just moving the minimal interface needed for MUSE into a
separate header (<net/fuse.h>) would work, I guess.

Do you think that would make sense?

>
> Notes:
> ------
>
> - OOB support is currently limited. Currently MUSE has no support for pro=
cessing
>   in- and out-band in the same MTD operation. It is good enough to make J=
FFS2
>   happy. This limitation is because FUSE has no support more than one var=
iable
>   length buffer in a FUSE request.
>   At least I didn=E2=80=99t find a good way to pass more than one buffer =
to a request.
>   Maybe FUSE folks can correct me. :-)

If you look at fuse_do_ioctl() it does variable length input and
output at the same time.  I guess you need something similar to that.

Thanks,
Miklos
