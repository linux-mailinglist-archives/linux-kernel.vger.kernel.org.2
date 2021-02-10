Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59979317223
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhBJVOs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Feb 2021 16:14:48 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:43782 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhBJVMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:12:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C4BB3627AFC8;
        Wed, 10 Feb 2021 22:11:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LRpPA_QJFqh4; Wed, 10 Feb 2021 22:11:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 780276083277;
        Wed, 10 Feb 2021 22:11:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D9Tnmm0EdigE; Wed, 10 Feb 2021 22:11:31 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4EE976089354;
        Wed, 10 Feb 2021 22:11:31 +0100 (CET)
Date:   Wed, 10 Feb 2021 22:11:31 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Message-ID: <605123206.382066.1612991491197.JavaMail.zimbra@nod.at>
In-Reply-To: <20210210215548.40ce9ba5@xps13>
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com> <1507208626.379155.1612906761549.JavaMail.zimbra@nod.at> <CAJfpegugbvppOKhJ8KjSVGgZOGVuj6NSiy4n18mbD7Ui3wme6g@mail.gmail.com> <20210210121429.4fb5ecf3@xps13> <1183985773.380599.1612956233979.JavaMail.zimbra@nod.at> <20210210215548.40ce9ba5@xps13>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: MUSE: Userspace backed MTD v3
Thread-Index: IS11nPAn7mspJgoMPO7FSWtrblrgdQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> By single request we meant FUSE op-codes. The NAND simulator in Userspace
>> will see just one call. My plan is to abstract it in libfuse.
> 
> If libfuse abstracts it, as long as MTD only sees a single request I'm
> fine :)

:-)

I'll prototype that in the next few weeks. Let's see whether my plans are
doable to not.

Thanks,
//richard
