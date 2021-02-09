Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0740A3151CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhBIOhk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Feb 2021 09:37:40 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:41548 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhBIOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:36:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6B886608A38A;
        Tue,  9 Feb 2021 15:35:58 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8Vwy9HmKlMkY; Tue,  9 Feb 2021 15:35:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0B252605B49C;
        Tue,  9 Feb 2021 15:35:58 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BlL2HfhYicrX; Tue,  9 Feb 2021 15:35:57 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D535B608A38A;
        Tue,  9 Feb 2021 15:35:57 +0100 (CET)
Date:   Tue, 9 Feb 2021 15:35:57 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven@narfation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Message-ID: <563952295.378372.1612881357746.JavaMail.zimbra@nod.at>
In-Reply-To: <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: MUSE: Userspace backed MTD v3
Thread-Index: NVDMpjLzrmLV3u3YwGU4qvbOOzku6A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos,

----- Ursprüngliche Mail -----
>> The core goal of MUSE is having the complexity on the userspace side and
>> only a small MTD driver in kernelspace.
>> While playing with different approaches I realized that FUSE offers everything
>> we need. So MUSE is a little like CUSE except that it does not implement a
>> bare character device but an MTD.
> 
> Looks fine.

I'm glad to hear that!

> I do wonder if MUSE should go to drivers/mtd/ instead.   Long term
> goal would be move CUSE to drivers/char and move the transport part of
> fuse into net/fuse leaving only the actual filesystems (fuse and
> virtiofs) under fs/.
> 
> But for now just moving the minimal interface needed for MUSE into a
> separate header (<net/fuse.h>) would work, I guess.
> 
> Do you think that would make sense?

Yes, I'm all for having MUSE in drivers/mtd/.

I placed MUSE initially in fs/fuse/ because CUSE was already there and muse.c includes
fuse_i.h. So tried to be as little invasive as possible.

>>
>> Notes:
>> ------
>>
>> - OOB support is currently limited. Currently MUSE has no support for processing
>>   in- and out-band in the same MTD operation. It is good enough to make JFFS2
>>   happy. This limitation is because FUSE has no support more than one variable
>>   length buffer in a FUSE request.
>>   At least I didn’t find a good way to pass more than one buffer to a request.
>>   Maybe FUSE folks can correct me. :-)
> 
> If you look at fuse_do_ioctl() it does variable length input and
> output at the same time.  I guess you need something similar to that.

I'll dig into this!

Thanks,
//richard
