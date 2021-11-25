Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09A45D9C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347016AbhKYMNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbhKYMLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:11:33 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902E6C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 04:08:21 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u3so15804254lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 04:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JkdfzLF/ZT0meZ9K3RxhDerHR55SIfBpOC9iC8N3REw=;
        b=nYhMa9VvgqD/5tVDNKrf4lpGM7pqt5eSQ2pd6ceCRaViy3NCDW7y1CWyM2o6vJ7jUf
         zyfAk/XjuFrwoLax7Pmr27ORHWHQeBw6FthLStjqxAx7Zo5ywVjlrW/9m4+LjYAWCsjl
         NW1cSb6VGZJa6SrPF5alELHs+laa9gVrrlR7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JkdfzLF/ZT0meZ9K3RxhDerHR55SIfBpOC9iC8N3REw=;
        b=ciI7yLzwHPFoVRNoNAKZ0ecH96vY562wwLvdZ6YnEUvMNL6WVewFH/VjC5z1gabnWY
         2y4bLBO/+gVpwIy3oeHVEvA89qgSo8ctyhPdURJGcbqhQrD5v4HcaHIfHz6KrJi9vk/z
         SRtyp8IGSmbkYArGhE8aRzu6+UCa4V43ODkO1enW+Vsf0n9g9w/YHlhEofZ0I4qn2LAU
         DTyzlSdgv/wWPjuE3N4S39ceP6ezxVWY8qL7XOCkEO2S+GQ+996Mp32DJsHeioC/l2p0
         fuFR9Zq7VrVwhoM4/pc6Z5tk2A1x/ZbM83aN6XlzhDM56uJ/fECGSZtaxLdmq56tRqjN
         QGBA==
X-Gm-Message-State: AOAM530Uq6rr9m0nhL2KKwesVqMnm+PYKtRdbZK2d5m+YS6Xj4mBhi40
        UMd9OaHmqvrcpW08z6KoalnLlg==
X-Google-Smtp-Source: ABdhPJzgBgorf4UQPr3rAtMPS9jzAmnikYL22lGssV3hmusbtzqqdthpC9nMfVtuEr70Vcu1VTUphg==
X-Received: by 2002:a05:6512:1296:: with SMTP id u22mr23122317lfs.296.1637842099803;
        Thu, 25 Nov 2021 04:08:19 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id t7sm287475lfl.260.2021.11.25.04.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 04:08:19 -0800 (PST)
Date:   Thu, 25 Nov 2021 13:08:16 +0100
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdchar: prevent unbounded allocation in MEMWRITE ioctl
Message-ID: <YZ98sDJZIqdhP0NF@larwa.hq.kempniu.pl>
References: <20211025082104.8017-1-kernel@kempniu.pl>
 <20211122103122.424326a1@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211122103122.424326a1@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

TL;DR: thanks, your comment made me look closer and I found what seems
to be a feasible workaround that I will apply in v2 (along other fixes).

> > Despite my efforts, the patch does _not_ retain absolute backward
> > compatibility and I do not know whether this is acceptable.
> > Specifically, multi-eraseblock-sized writes (requiring multiple loop
> > iterations to be processed) which succeeded with the original code _may_
> > now return errors and/or write different contents to the device than the
> > original code, depending on the MTD mode of operation requested and on
> > whether the start offset is page-aligned.  The documentation for struct
> > mtd_oob_ops warns about even multi-page write requests, but...
> > 
> > Example:
> > 
> >     MTD device parameters:
> > 
> >       - mtd->writesize = 2048
> >       - mtd->erasesize = 131072
> >       - 64 bytes of raw OOB space per page
> > 
> >     struct mtd_write_req req = {
> >         .start = 2048,
> >         .len = 262144,
> >         .ooblen = 64,
> >         .usr_data = ...,
> >         .usr_oob = ...,
> >         .mode = MTD_OPS_RAW,
> >     };
> > 
> >     (This is a 128-page write with OOB data supplied for just one page.)
> > 
> >     Current mtdchar_write_ioctl() returns 0 for this request and writes
> >     128 pages of data and 1 page's worth of OOB data (64 bytes) to the
> >     MTD device.
> > 
> >     Patched mtdchar_write_ioctl() may return an error because the
> >     original request gets split into two chunks (<data_len, oob_len>):
> > 
> >         <131072, 64>
> >         <131072, 0>
> > 
> >     and the second chunk with zero OOB data length may make the MTD
> >     driver unhappy in raw mode (resulting in only the first 64 pages of
> >     data and 1 page's worth of OOB data getting written to the MTD
> >     device).
> 
> Isn't this a driver issue instead? I mean, writing an eraseblock
> without providing any OOB data is completely fine, if the driver
> accepts 2 blocks + 1 page OOB but refuses 1 block + 1 page OOB and then
> 1 block, it's broken, no? Have you experienced such a situation in your
> testing?

I may not have expressed myself clearly here, sorry - the example was
already getting a bit lengthy at that point... :)

I tested the patch with nandsim, but I do not think it is that specific
driver that is broken.  The catch is that when mtd_write_oob() is
called, nand_do_write_ops() splits multi-page requests into single-page
requests and what it passes to nand_write_page() depends on whether the
struct mtd_oob_ops it was invoked with has the oobbuf field set to NULL
or not.  This is okay in itself, but when another request-splitting
"layer" is introduced by my patch, the ioctl may start returning
different result codes than it used to.

Here is what happens with the unpatched code for the example above:

 1. mtdchar_write_ioctl() gets called with the following request:

    struct mtd_write_req req = {
        .start = 2048,
        .len = 262144,
        .ooblen = 64,
        .usr_data = 0x10000000,
        .usr_oob = 0x20000000,
        .mode = MTD_OPS_RAW,
    };

 2. The above request is passed through to mtd_write_oob() verbatim:

    struct mtd_oob_ops ops = {
        .mode = MTD_OPS_RAW,
	.len = 262144,
	.ooblen = 64,
        .datbuf = 0x10000000,
        .oobbuf = 0x20000000,
    };

 3. nand_do_write_ops() splits this request up into page-sized requests.

     a) For the first page, the initial 2048 bytes of data + 64 bytes of
        OOB data are passed to nand_write_page().

     b) For each subsequent page, a 2048-byte chunk of data + 64 bytes
        of 0xff bytes are passed to nand_write_page().

    Since the oobbuf field in the struct mtd_oob_ops passed is not NULL,
    oob_required is set to 1 for all nand_write_page() calls.

 4. The above causes the driver to receive 2112 bytes of data for each
    page write, which results in the ioctl being successful.

Here is what happens with the patched code:

 1. mtdchar_write_ioctl() gets called with the same request as above.

 2. The original request gets split into two eraseblock-sized
    mtd_write_oob() calls:

     a) struct mtd_oob_ops ops = {
            .mode = MTD_OPS_RAW,
            .len = 131072,
            .ooblen = 64,
            .datbuf = 0x10000000,
            .oobbuf = 0x20000000,
        };

     b) struct mtd_oob_ops ops = {
            .mode = MTD_OPS_RAW,
            .len = 131072,
            .ooblen = 0,
            .datbuf = 0x10020000,
            .oobbuf = NULL,
        };

    (My code sets oobbuf to NULL if ooblen is 0.)

 3. nand_do_write_ops() splits the first request up into page-sized
    requests the same way as for the original code.  It returns
    successfully, so mtdchar_write_ioctl() proceeds with the next
    eraseblock-sized request.

 4. nand_do_write_ops() splits the second request up into page-sized
    requests.  The first page write contains 2048 bytes of data and no
    OOB data; since the oobbuf field in the struct mtd_oob_ops passed is
    NULL, oob_required is set to 0.

 5. The above causes the driver to receive 2048 bytes of data for a page
    write in raw mode, which results in an error that propagates all the
    way up to mtdchar_write_ioctl().

The nandsim driver returns the same error if you pass the following
request to the MEMWRITE ioctl:

    struct mtd_write_req req = {
        .start = 2048,
        .len = 2048,
        .ooblen = 0,
        .usr_data = 0x10000000,
        .usr_oob = NULL,
        .mode = MTD_OPS_RAW,
    };

so it is not the driver that is broken or insane, it is the splitting
process that may cause the MEMWRITE ioctl to return different error
codes than before.

I played with the code a bit more and I found a fix which addresses this
issue without breaking other scenarios: setting oobbuf to the same
pointer for every loop iteration (if ooblen is 0, no OOB data will be
written anyway).

I also tackled the problem of mishandling large non-page-aligned writes
in v1 and I managed to fix it by trimming the first mtd_write_oob() call
so that it ends on an eraseblock boundary.  This implicitly makes
subsequent writes page-aligned and seems to fix the problem.

Finally, I reworked the OOB length adjustment code to address other
cases of mishandling non-page-aligned writes.

I could not find any other cases in which the revised code behaves
differently than the original one.  I will send v2 soon.

-- 
Best regards,
Michał Kępień
