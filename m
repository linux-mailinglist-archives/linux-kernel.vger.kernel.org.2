Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E04144FFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhKOI2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhKOI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:28:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D780CC061746
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:25:06 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1mmXIH-0006uC-Lr; Mon, 15 Nov 2021 09:24:49 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1mmXIE-00060h-RX; Mon, 15 Nov 2021 09:24:46 +0100
Date:   Mon, 15 Nov 2021 09:24:46 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        mcoquelin.stm32@gmail.com, kirill.shutemov@linux.intel.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/12] ubifs: Add missing iput if do_tmpfile() failed
 in rename whiteout
Message-ID: <20211115082446.GC25697@pengutronix.de>
References: <20211112121758.2208727-1-chengzhihao1@huawei.com>
 <20211112121758.2208727-5-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112121758.2208727-5-chengzhihao1@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:21:42 up 270 days, 11:45, 131 users,  load average: 0.32, 0.22,
 0.27
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 08:17:50PM +0800, Zhihao Cheng wrote:
> whiteout inode should be put when do_tmpfile() failed if inode has been
> initialized. Otherwise we will get following warning during umount:
>   UBIFS error (ubi0:0 pid 1494): ubifs_assert_failed [ubifs]: UBIFS
>   assert failed: c->bi.dd_growth == 0, in fs/ubifs/super.c:1930
>   VFS: Busy inodes after unmount of ubifs. Self-destruct in 5 seconds.
> 
> Fixes: 9e0a1fff8db56ea ("ubifs: Implement RENAME_WHITEOUT")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  fs/ubifs/dir.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index 2735ad1affed..6503e6857f6e 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -1334,6 +1334,8 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>  
>  		err = do_tmpfile(old_dir, old_dentry, S_IFCHR | WHITEOUT_MODE, &whiteout);
>  		if (err) {
> +			if (whiteout)
> +				iput(whiteout);

Should this rather be done in do_tmpfile() directly?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
