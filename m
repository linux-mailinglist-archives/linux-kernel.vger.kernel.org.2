Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD37F441455
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 08:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhKAHth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 03:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhKAHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 03:49:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9109DC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 00:47:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1AEFA1F4369A;
        Mon,  1 Nov 2021 07:47:00 +0000 (GMT)
Date:   Mon, 1 Nov 2021 08:46:52 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] mtd: core: protect access to mtd devices while
 in suspend
Message-ID: <20211101084652.0fe6272f@collabora.com>
In-Reply-To: <20211026055551.3053598-1-sean@geanix.com>
References: <20211026055551.3053598-1-sean@geanix.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 07:55:47 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Follow-up on discussion in:
> https://lkml.org/lkml/2021/10/4/41
> https://lkml.org/lkml/2021/10/11/435
> 
> Changes since v3:
>  - edited commit msg and author for mtdconcat patch
> 
> Changes since v2:
>  - added signoff's to patch from Boris
>  - removed accidential line break
>  - kept tests consistent: master->master.suspended == 0 -> !master->master.suspended
>  - added comments to mtdconcat patch
>  - moved mtdconcat before ('mtd: core: protect access to MTD devices while in suspend')
> 
> Changes since v1:
>  - removed __mtd_suspend/__mtd_resume functions as they are not used by
>    mtdconcat anymore.
>  - only master mtd_info is used for mtd_{start,end}_access(). Warn if we
>    got mtd's.
>  - added Boris patch for using uninitialized _suspend/_resume hooks when
>    bbt scanning
>  - mtdconcat uses device _suspend/_resume hooks
>  - I don't really like the macro proposal from Boris
>    mtd_no_suspend_void_call()/mtd_no_suspend_ret_call() I think they
>    make the code complex to read and the macro's doesn't fit every
>    where anyway...
> 
> Changes since from rfc v1/v2:
>  - added access protection for all device access hooks in mtd_info.
>  - added Suggested-by to [1/3] patch.
>  - removed refereces to commit ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
>    from commit msg as commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") is 
>    to be blamed.
>  - tested on a kernel with LOCKDEP enabled.
> 
> Boris Brezillon (2):
>   mtd: rawnand: nand_bbt: hide suspend/resume hooks while scanning bbt
>   mtd: mtdconcat: don't use mtd_{suspend,resume}()
> 
> Sean Nyekjaer (2):
>   mtd: core: protect access to MTD devices while in suspend
>   mtd: rawnand: remove suspended check

Looks good overall (after fixing the minor things I pointed out, of
course), but I'd recommend applying this series to mtd-next just after
-rc1 is out so you get a chance to detect regressions before it's
merged in Linus' tree. I fear this unconditional blocking on suspended
device will lead to unexpected deadlocks (see my comment on panic
writes)...

> 
>  drivers/mtd/mtdconcat.c          |  15 +++-
>  drivers/mtd/mtdcore.c            | 124 +++++++++++++++++++++++++++----
>  drivers/mtd/nand/raw/nand_base.c |  52 ++++---------
>  drivers/mtd/nand/raw/nand_bbt.c  |  28 ++++++-
>  include/linux/mtd/mtd.h          |  81 ++++++++++++++++----
>  include/linux/mtd/rawnand.h      |   5 +-
>  6 files changed, 230 insertions(+), 75 deletions(-)
> 

