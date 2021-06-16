Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAD53A90CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFPE4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhFPE4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:56:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAAEC061574;
        Tue, 15 Jun 2021 21:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Xvl3Q2BcDnn3sLPuJT0gF3XCMgyvBysAyx7WRFcD6k=; b=hoy+nfIWENzx8GAUiPRCr2RsfB
        zNT0KOgXy30afI0OD19/gwlKp+TPc+6ca1QNb0ddVkGQT/EqZDP/twuipJwBJ/lXfUUtIsqTFc6Jy
        5I3ZoCCVVBO3qOHC731JeUKWn7LdArOx+BuUqMT0xZ4hbA494l1u/uX0hrPd5j6jXlOk86bbuMdsC
        34SqtVR0QDr+T71XGVaWknHNeas7VKxTKSmzIagsrOaf/nk2Ch6a8RaGanlYW8Bex86zTKUe8qA0P
        iO4ye84sy7/5K2orTww85wALeFmyZF1HoL/B81bwqxKPDFmMKjjjEIFLiPAI8CadPavTmaSUaXB+Z
        gDB2ccvg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltNYM-007bdJ-Sv; Wed, 16 Jun 2021 04:53:39 +0000
Date:   Wed, 16 Jun 2021 05:53:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     edwardh <edwardh@synology.com>
Cc:     axboe@kernel.dk, neilb@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, s3t@synology.com,
        bingjingc@synology.com, cccheng@synology.com,
        Wade Liang <wadel@synology.com>
Subject: Re: [PATCH v3] block: fix trace completion for chained bio
Message-ID: <YMmDxl9abff+wulm@infradead.org>
References: <20210616030810.4901-1-edwardh@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616030810.4901-1-edwardh@synology.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:08:10AM +0800, edwardh wrote:
> @@ -1400,18 +1404,13 @@ void bio_endio(struct bio *bio)
>  	if (bio->bi_end_io == bio_chain_endio) {
>  		bio = __bio_chain_endio(bio);
>  		goto again;
> +	} else {
> +		blk_throtl_bio_endio(bio);
> +		/* release cgroup info */
> +		bio_uninit(bio);
> +		if (bio->bi_end_io)
> +			bio->bi_end_io(bio);

No need for an else after a goto.
