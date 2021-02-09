Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA275315A74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhBJABn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Feb 2021 19:01:43 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:47632 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbhBIUfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:35:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 815D46083270;
        Tue,  9 Feb 2021 21:06:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bkPIndMJRUBv; Tue,  9 Feb 2021 21:06:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 38A33608A38F;
        Tue,  9 Feb 2021 21:06:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 83PBCidjxaEH; Tue,  9 Feb 2021 21:06:14 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 17CAB60A358A;
        Tue,  9 Feb 2021 21:06:14 +0100 (CET)
Date:   Tue, 9 Feb 2021 21:06:14 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Message-ID: <1923896038.379134.1612901174023.JavaMail.zimbra@nod.at>
In-Reply-To: <563952295.378372.1612881357746.JavaMail.zimbra@nod.at>
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com> <563952295.378372.1612881357746.JavaMail.zimbra@nod.at>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: MUSE: Userspace backed MTD v3
Thread-Index: NVDMpjLzrmLV3u3YwGU4qvbOOzku6DaSHdFp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos,

----- Ursprüngliche Mail -----
>> I do wonder if MUSE should go to drivers/mtd/ instead.   Long term
>> goal would be move CUSE to drivers/char and move the transport part of
>> fuse into net/fuse leaving only the actual filesystems (fuse and
>> virtiofs) under fs/.
>> 
>> But for now just moving the minimal interface needed for MUSE into a
>> separate header (<net/fuse.h>) would work, I guess.
>> 
>> Do you think that would make sense?
> 
> Yes, I'm all for having MUSE in drivers/mtd/.
> 
> I placed MUSE initially in fs/fuse/ because CUSE was already there and muse.c
> includes
> fuse_i.h. So tried to be as little invasive as possible.

I did a quick patch series which moves CUSE into drivers/char/

https://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git/log/?h=fs_fuse_split

Does this more or less what you had in mind?
If so, I'd submit these patches, rebase MUSE on them and do a v4 soon.

Thanks,
//richard
