Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416D3458B95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhKVJed convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Nov 2021 04:34:33 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47643 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbhKVJec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:34:32 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0D4C360014;
        Mon, 22 Nov 2021 09:31:22 +0000 (UTC)
Date:   Mon, 22 Nov 2021 10:31:22 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdchar: prevent unbounded allocation in MEMWRITE ioctl
Message-ID: <20211122103122.424326a1@xps13>
In-Reply-To: <20211025082104.8017-1-kernel@kempniu.pl>
References: <20211025082104.8017-1-kernel@kempniu.pl>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michał,

kernel@kempniu.pl wrote on Mon, 25 Oct 2021 10:21:04 +0200:

> In the mtdchar_write_ioctl() function, memdup_user() is called with its
> 'len' parameter set to verbatim values provided by user space via a
> struct mtd_write_req.  Both the 'len' and 'ooblen' fields of that
> structure are 64-bit unsigned integers, which means the MEMWRITE ioctl
> can trigger unbounded kernel memory allocation requests.
> 
> Fix by iterating over the buffers provided by user space in a loop,
> processing at most mtd->erasesize bytes in each iteration.  Adopt some
> checks from mtd_check_oob_ops() to retain backward user space
> compatibility.
> 

Thank you very much for this proposal!

> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>
> ---
> Fixing this problem was suggested last month, during a discussion about
> a new MEMREAD ioctl. [1] [2]
> 
> My primary objective was to not break user space, i.e. to not change
> externally visible behavior compared to the current code.  The main
> problem I faced was that splitting the input data into chunks makes the
> MEMWRITE ioctl a _wrapper_ for mtd_write_oob() rather than a direct
> _interface_ to it and yet from the user space perspective it still needs
> to behave as if nothing changed.
> 
> Despite my efforts, the patch does _not_ retain absolute backward
> compatibility and I do not know whether this is acceptable.
> Specifically, multi-eraseblock-sized writes (requiring multiple loop
> iterations to be processed) which succeeded with the original code _may_
> now return errors and/or write different contents to the device than the
> original code, depending on the MTD mode of operation requested and on
> whether the start offset is page-aligned.  The documentation for struct
> mtd_oob_ops warns about even multi-page write requests, but...
> 
> Example:
> 
>     MTD device parameters:
> 
>       - mtd->writesize = 2048
>       - mtd->erasesize = 131072
>       - 64 bytes of raw OOB space per page
> 
>     struct mtd_write_req req = {
>         .start = 2048,
>         .len = 262144,
>         .ooblen = 64,
>         .usr_data = ...,
>         .usr_oob = ...,
>         .mode = MTD_OPS_RAW,
>     };
> 
>     (This is a 128-page write with OOB data supplied for just one page.)
> 
>     Current mtdchar_write_ioctl() returns 0 for this request and writes
>     128 pages of data and 1 page's worth of OOB data (64 bytes) to the
>     MTD device.
> 
>     Patched mtdchar_write_ioctl() may return an error because the
>     original request gets split into two chunks (<data_len, oob_len>):
> 
>         <131072, 64>
>         <131072, 0>
> 
>     and the second chunk with zero OOB data length may make the MTD
>     driver unhappy in raw mode (resulting in only the first 64 pages of
>     data and 1 page's worth of OOB data getting written to the MTD
>     device).

Isn't this a driver issue instead? I mean, writing an eraseblock
without providing any OOB data is completely fine, if the driver
accepts 2 blocks + 1 page OOB but refuses 1 block + 1 page OOB and then
1 block, it's broken, no? Have you experienced such a situation in your
testing?

> 
>     Is an ioctl like this considered a "degenerate" one and therefore
>     acceptable to break or not?

I don't think so :)

> 
> At any rate, the revised code feels brittle to me and I would not be
> particularly surprised if I missed more cases in which it produces
> different results than the original code.
> 
> I keep on wondering whether the benefits of this change are worth the
> extra code complexity, but fortunately it is not my call to make :)
> Perhaps I am missing something and my proposal can be simplified?  Or
> maybe the way I approached this is completely wrong?  Any thoughts on
> this are welcome.
> 
> As the outcome of the discussion around this patch will have a
> significant influence on the shape of the v2 of the MEMREAD ioctl, I
> decided to submit this one first as a standalone patch.
> 
> [1] https://lists.infradead.org/pipermail/linux-mtd/2021-September/088485.html
> [2] https://lists.infradead.org/pipermail/linux-mtd/2021-September/088544.html
> 
>  drivers/mtd/mtdchar.c | 93 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 70 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 155e991d9d75..a3afc390e254 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -578,9 +578,10 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
>  {
>  	struct mtd_info *master = mtd_get_master(mtd);
>  	struct mtd_write_req req;
> -	struct mtd_oob_ops ops = {};
>  	const void __user *usr_data, *usr_oob;
> -	int ret;
> +	uint8_t *datbuf = NULL, *oobbuf = NULL;
> +	size_t datbuf_len, oobbuf_len;
> +	int ret = 0;
>  
>  	if (copy_from_user(&req, argp, sizeof(req)))
>  		return -EFAULT;
> @@ -590,33 +591,79 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
>  
>  	if (!master->_write_oob)
>  		return -EOPNOTSUPP;
> -	ops.mode = req.mode;
> -	ops.len = (size_t)req.len;
> -	ops.ooblen = (size_t)req.ooblen;
> -	ops.ooboffs = 0;
> -
> -	if (usr_data) {
> -		ops.datbuf = memdup_user(usr_data, ops.len);
> -		if (IS_ERR(ops.datbuf))
> -			return PTR_ERR(ops.datbuf);
> -	} else {
> -		ops.datbuf = NULL;
> +
> +	if (!usr_data)
> +		req.len = 0;
> +
> +	if (!usr_oob)
> +		req.ooblen = 0;
> +
> +	if (req.start + req.len > mtd->size)
> +		return -EINVAL;
> +
> +	datbuf_len = min_t(size_t, req.len, mtd->erasesize);
> +	if (datbuf_len > 0) {
> +		datbuf = kmalloc(datbuf_len, GFP_KERNEL);
> +		if (!datbuf)
> +			return -ENOMEM;
>  	}
>  
> -	if (usr_oob) {
> -		ops.oobbuf = memdup_user(usr_oob, ops.ooblen);
> -		if (IS_ERR(ops.oobbuf)) {
> -			kfree(ops.datbuf);
> -			return PTR_ERR(ops.oobbuf);
> +	oobbuf_len = min_t(size_t, req.ooblen, mtd->erasesize);
> +	if (oobbuf_len > 0) {
> +		oobbuf = kmalloc(oobbuf_len, GFP_KERNEL);
> +		if (!oobbuf) {
> +			kfree(datbuf);
> +			return -ENOMEM;
>  		}
> -	} else {
> -		ops.oobbuf = NULL;
>  	}
>  
> -	ret = mtd_write_oob(mtd, (loff_t)req.start, &ops);
> +	while (req.len > 0 || (!usr_data && req.ooblen > 0)) {
> +		struct mtd_oob_ops ops = {
> +			.mode = req.mode,
> +			.len = min_t(size_t, req.len, datbuf_len),
> +			.ooblen = min_t(size_t, req.ooblen, oobbuf_len),
> +			.datbuf = req.len ? datbuf : NULL,
> +			.oobbuf = req.ooblen ? oobbuf : NULL,
> +		};
>  
> -	kfree(ops.datbuf);
> -	kfree(ops.oobbuf);
> +		/*
> +		 * For writes which are not OOB-only, adjust the amount of OOB
> +		 * data written according to the number of data pages written.
> +		 * This is necessary to prevent OOB data from being skipped
> +		 * over in data+OOB writes requiring multiple mtd_write_oob()
> +		 * calls to be completed.
> +		 */
> +		if (ops.len > 0 && ops.ooblen > 0) {
> +			u32 oob_per_page = mtd_oobavail(mtd, &ops);
> +			uint32_t pages_to_write = mtd_div_by_ws(ops.len, mtd);
> +
> +			if (mtd_mod_by_ws(req.start + ops.len, mtd))
> +				pages_to_write++;
> +
> +			ops.ooblen = min_t(size_t, ops.ooblen,
> +					   pages_to_write * oob_per_page);
> +		}
> +
> +		if (copy_from_user(datbuf, usr_data, ops.len) ||
> +		    copy_from_user(oobbuf, usr_oob, ops.ooblen)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		ret = mtd_write_oob(mtd, req.start, &ops);
> +		if (ret)
> +			break;
> +
> +		req.start += ops.retlen;
> +		req.len -= ops.retlen;
> +		usr_data += ops.retlen;
> +
> +		req.ooblen -= ops.oobretlen;
> +		usr_oob += ops.oobretlen;
> +	}
> +
> +	kfree(datbuf);
> +	kfree(oobbuf);
>  
>  	return ret;
>  }


Thanks,
Miquèl
