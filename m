Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29682426FBE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbhJHRw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:52:28 -0400
Received: from first.geanix.com ([116.203.34.67]:37356 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhJHRw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:52:26 -0400
Received: from skn-laptop (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id AA81DC3B66;
        Fri,  8 Oct 2021 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633715429; bh=EawVE9wODTtRpHeuB7Eov1BPNVWZvN+3ycWO3+Qq5Ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BTDhV3GPGw27VB/2hapBnyYk1chXXjVdCVirjFEFDGtRf0W8pO1UD36H32kmq+Bj4
         haVBHrq57ONgAl0nr/4wpe4geGBg3TohmcMJodCHTvFID594CEORDtPbORAdmDfjUp
         GvdZNgFTC41UhOMQpqsSGUcPmnbvqg2GkTVk4JBZ+uNtCvUymMi2BHrV2FQnRIMEWG
         hddjjO5EqzQHjZaYTHktlRnKp53Y6VpPz4+pnRE91ZszIUNJG6aNgBo0FAaaoEgYax
         QytNexE71RwdkhjewxvuzPkgdjFVrD8PL+gNT01h/68M15z53OHYzBiORvkA/SZ9W5
         u/S2BnFVFsOSg==
Date:   Fri, 8 Oct 2021 19:50:27 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mtd: core: protect access to mtd devices while
 in suspend
Message-ID: <20211008175027.4eg4qsrcu7nxwplv@skn-laptop>
References: <20211008141524.20ca8219@collabora.com>
 <20211008143825.3717116-1-sean@geanix.com>
 <20211008173526.19745a10@xps13>
 <20211008180811.36c371f5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008180811.36c371f5@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 06:08:11PM +0200, Boris Brezillon wrote:
> On Fri, 8 Oct 2021 17:35:26 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > > into suspend. But it's actually "mtd: rawnand: Simplify the locking" that
> > > allows it to return errors rather than locking, before that commit it would
> > > have waited for the rawnand device to resume.  
> > 
> > I don't think so, I believe it was broken in the same way but was just
> > not returning errors.
> 
> Actually I was wrong, 013e6292aaf5 ("mtd: rawnand: Simplify the
> locking") removed the blocking wait (returning -EBUSY when the device
> is suspended instead of putting the thread on a waitqueue). At that
> time, I assumed all threads would be paused when the device is
> suspended, which appeared to be incorrect. So I guess the Fixes tag
> should remain, and we might want to consider backporting a less
> invasive patch to stable releases (one touching only the raw NAND
> layer).

Thanks Miquel add Reviewed-By you on the second patch.

I'll remove the mentioning of commit ef347c0cfd61
("mtd: rawnand: gpmi: Implement exec_op") in this commit msg.

Is it possible to backport another(less invasive) patch to stable
releases? I thought only upstream commits could be backported.

/Sean
