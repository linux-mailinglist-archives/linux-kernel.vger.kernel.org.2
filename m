Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B6C3423DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhCSR5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCSR44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:56:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C4BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/2Y1OwGEzXvD6PhFI0NTCqzSzvDFFKVPWIaku64VVVM=; b=j0CTxvkifpqB5TRCg01v+fZzlG
        Zk6yrZrhmn/7H5t7ziv4hhJKXtUULuQrk9Hr/u0X+9/chRR8Bu7Bpqe3/zsq/oyIw/MAecqVlopxI
        RUPjxDTOFQ3L3TkRt1wsJKSj6h49GFkInZ+RPvmO6UizXiilHflW+6+j9rDtf3qRC88cZ6fHRMHDG
        8CtQrhP/TJWdWfed7Fc7Yoz4DErgvoHSUz4FlWXdF3Vjh5FnQN8YUObAH0L/NGQUGVp6lHXV2ldOm
        mUFYQqoj9C8TIKwOj4DVQa6wgnIfvWUdexrpfkST3U6Ys1sRxWp0B7kfhac1/DT5S+IP9T9L6kMs7
        1mz2FHIg==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNJMe-001RDI-Bs; Fri, 19 Mar 2021 17:56:49 +0000
Date:   Fri, 19 Mar 2021 10:56:48 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: ebs: Several typo fixes
In-Reply-To: <20210319011750.23468-1-unixbhaskar@gmail.com>
Message-ID: <d639d14b-39cd-6a11-5536-4b8fcc9f3a7@bombadil.infradead.org>
References: <20210319011750.23468-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_105648_424076_8AC441EE 
X-CRM114-Status: GOOD (  14.41  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote: > > s/retrievd/retrieved/
    > s/misalignement/misalignment/ > s/funtion/function/ > > Signed-off-by:
   Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy Dunlap <rdunlap@infradead.org>
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/retrievd/retrieved/
> s/misalignement/misalignment/
> s/funtion/function/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> drivers/md/dm-ebs-target.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
> index 55bcfb74f51f..71475a2410be 100644
> --- a/drivers/md/dm-ebs-target.c
> +++ b/drivers/md/dm-ebs-target.c
> @@ -28,7 +28,7 @@ struct ebs_c {
> 	spinlock_t lock;		/* Guard bios input list above. */
> 	sector_t start;			/* <start> table line argument, see ebs_ctr below. */
> 	unsigned int e_bs;		/* Emulated block size in sectors exposed to upper layer. */
> -	unsigned int u_bs;		/* Underlying block size in sectors retrievd from/set on lower layer device. */
> +	unsigned int u_bs;		/* Underlying block size in sectors retrieved from/set on lower layer device. */
> 	unsigned char block_shift;	/* bitshift sectors -> blocks used in dm-bufio API. */
> 	bool u_bs_set:1;		/* Flag to indicate underlying block size is set on table line. */
> };
> @@ -43,7 +43,7 @@ static inline sector_t __block_mod(sector_t sector, unsigned int bs)
> 	return sector & (bs - 1);
> }
>
> -/* Return number of blocks for a bio, accounting for misalignement of start and end sectors. */
> +/* Return number of blocks for a bio, accounting for misalignment of start and end sectors. */
> static inline unsigned int __nr_blocks(struct ebs_c *ec, struct bio *bio)
> {
> 	sector_t end_sector = __block_mod(bio->bi_iter.bi_sector, ec->u_bs) + bio_sectors(bio);
> @@ -171,7 +171,7 @@ static void __ebs_forget_bio(struct ebs_c *ec, struct bio *bio)
> 	dm_bufio_forget_buffers(ec->bufio, __sector_to_block(ec, sector), blocks);
> }
>
> -/* Worker funtion to process incoming bios. */
> +/* Worker function to process incoming bios. */
> static void __ebs_process_bios(struct work_struct *ws)
> {
> 	int r;
> --
> 2.26.2
>
>
