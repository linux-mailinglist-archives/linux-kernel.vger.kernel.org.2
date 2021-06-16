Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA83A94E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhFPIZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:25:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8E7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:23:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ltQpd-0005HI-Ti; Wed, 16 Jun 2021 10:23:29 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ltQpb-0003rt-Rs; Wed, 16 Jun 2021 10:23:27 +0200
Date:   Wed, 16 Jun 2021 10:23:27 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     richard@nod.at, yangds.fnst@cn.fujitsu.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yukuai3@huawei.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ubifs: Fix races between xattr_{set|get} and
 listxattr operations
Message-ID: <20210616082327.GP9782@pengutronix.de>
References: <20210531125210.1173922-1-chengzhihao1@huawei.com>
 <20210531125210.1173922-2-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531125210.1173922-2-chengzhihao1@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:19:16 up 118 days, 11:43, 116 users,  load average: 0.04, 0.11,
 0.15
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 31, 2021 at 08:52:09PM +0800, Zhihao Cheng wrote:
> UBIFS may occur some problems with concurrent xattr_{set|get} and
> listxattr operations, such as assertion failure, memory corruption,
> stale xattr value[1].
> 
> Fix it by importing a new rw-lock in @ubifs_inode to serilize write
> operations on xattr, concurrent read operations are still effective,
> just like ext4.
> 
> [1] https://lore.kernel.org/linux-mtd/20200630130438.141649-1-houtao1@huawei.com

I had a closer look at it and reviewed that you carefully release the
lock where you claimed it. I can't tell if adding this lock is the right
approach, but for what it's worth you can add my

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -356,6 +356,7 @@ struct ubifs_gced_idx_leb {
>   * @ui_mutex: serializes inode write-back with the rest of VFS operations,
>   *            serializes "clean <-> dirty" state changes, serializes bulk-read,
>   *            protects @dirty, @bulk_read, @ui_size, and @xattr_size
> + * @xattr_sem: serilizes write operations (remove|set|create) on xattr

s/serilizes/serializes/

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
