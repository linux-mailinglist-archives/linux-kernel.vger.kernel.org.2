Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C232315BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhBJBAQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Feb 2021 20:00:16 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49232 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbhBIWPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:15:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 25CCA6083270;
        Tue,  9 Feb 2021 22:39:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zcuKv_gcvvzX; Tue,  9 Feb 2021 22:39:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C6A76608A38F;
        Tue,  9 Feb 2021 22:39:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o475j9w_Tchu; Tue,  9 Feb 2021 22:39:21 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A34F76083270;
        Tue,  9 Feb 2021 22:39:21 +0100 (CET)
Date:   Tue, 9 Feb 2021 22:39:21 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Message-ID: <1507208626.379155.1612906761549.JavaMail.zimbra@nod.at>
In-Reply-To: <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: MUSE: Userspace backed MTD v3
Thread-Index: ouVDBBxzMEdyj7XGvi0Ky/PygYF9uw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos,

----- Ursprüngliche Mail -----
> If you look at fuse_do_ioctl() it does variable length input and
> output at the same time.  I guess you need something similar to that.

I'm not sure whether I understand correctly.

In MUSE one use case would be attaching two distinct (variable length) buffers to a
single FUSE request, in both directions.
If I read fuse_do_ioctl() correctly, it attaches always a single buffer per request
but does multiple requests.

In MUSE we cold go the same path and issue up to two requests.
One for in-band and optionally a second one for the out-of-band data.
Hmmm?

Thanks,
//richard
