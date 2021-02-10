Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C429316540
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhBJLbp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Feb 2021 06:31:45 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:59474 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhBJLYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:24:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9C6FF6083270;
        Wed, 10 Feb 2021 12:23:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KtIL8SOfiiUt; Wed, 10 Feb 2021 12:23:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 42FF06083272;
        Wed, 10 Feb 2021 12:23:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CXmfs8niWTKH; Wed, 10 Feb 2021 12:23:54 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1BDFA6083270;
        Wed, 10 Feb 2021 12:23:54 +0100 (CET)
Date:   Wed, 10 Feb 2021 12:23:53 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Message-ID: <1183985773.380599.1612956233979.JavaMail.zimbra@nod.at>
In-Reply-To: <20210210121429.4fb5ecf3@xps13>
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com> <1507208626.379155.1612906761549.JavaMail.zimbra@nod.at> <CAJfpegugbvppOKhJ8KjSVGgZOGVuj6NSiy4n18mbD7Ui3wme6g@mail.gmail.com> <20210210121429.4fb5ecf3@xps13>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: MUSE: Userspace backed MTD v3
Thread-Index: +AWqGsxtpMS2g3tZtveYZHMCEixznQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel,

----- Ursprüngliche Mail -----
>> Does in-band and OOB data need to be handled together?
> 
> Short answer: yes.
> 
>> If so, then two requests is not a good option.
> 
> More detailed answer:
> 
> There is a type of MTD device (NAND devices) which are composed, for
> each page, of X in-band bytes plus Y out-of-band metadata bytes.
> 
> Accessing either the in-band data, or the out-of-band data, or both at
> the same time are all valid use cases.
> 
> * Read operation details:
>  From a hardware point of view, the out-of-band data is (almost)
>  always retrieved when the in-band data is read because it contains
>  meta-data used to correct eventual bitflips. In this case, if both
>  areas are requested, it is highly non-efficient to do two requests,
>  that's why the MTD core allows to do both at the same time.
> * Write operation details:
>  Even worse, in the write case, you *must* write both at the same
>  time. It is physically impossible to do one after the other (still
>  with actual hardware, of course).
> 
> That is why it is preferable that MUSE will be able to access both in
> a single request.

By single request we meant FUSE op-codes. The NAND simulator in Userspace
will see just one call. My plan is to abstract it in libfuse.

Thanks,
//richard
