Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0033A99E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCOC05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 22:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhCOC0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 22:26:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C96C061574;
        Sun, 14 Mar 2021 19:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ElaAFY9/UXStLJRalxeZD6FlZJd58vjvmaaC1RSadXE=; b=VbiKtHNHJ7VxkWquU5vdjACOhp
        SnxDYA8jIeHjrxGQOZNKR7ptPRVLPCan0hg2wk+2xLm9CQ1jA3IpdwjAfSKmuB0gdBpqDkqxfb/j8
        9ARyhHDMg0g2FI3pCUq6HdzpQjlKhHmjFsMR1l1A1gMhW/x9HEE0J6OIRCa+pNMeCCUGP4PGL3XBa
        meVpurneS2XEVFblNsDwbwVn9WkvfrJOP6vnBbFVdOpm9LnNtkliOtxPpb7JppmTtU8xJpu6hPjRp
        6LsWA8qCc+uhqmWQoBBP3L47T8/kCx8noeGsGnCmZFR6GOfMyXit2Zl0Ane0WTmJUR7MHsfVuEMTY
        o18njTeQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLcwG-001FOq-A6; Mon, 15 Mar 2021 02:26:39 +0000
Subject: Re: [PATCH] block: Few spelling fixes in the file blk-merge.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210315011849.3964886-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4f8b61d9-dc3a-7ba2-2f49-4a596f19d385@infradead.org>
Date:   Sun, 14 Mar 2021 19:26:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315011849.3964886-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/21 6:18 PM, Bhaskar Chowdhury wrote:
> 
> 
> s/trival/trivial/
> s/attributs/attributes/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  block/blk-merge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 808768f6b174..a39327e38276 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -283,7 +283,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  	/*
>  	 * Bio splitting may cause subtle trouble such as hang when doing sync
>  	 * iopoll in direct IO routine. Given performance gain of iopoll for
> -	 * big IO can be trival, disable iopoll when split needed.
> +	 * big IO can be trivial, disable iopoll when split needed.
>  	 */
>  	bio->bi_opf &= ~REQ_HIPRI;
> 
> @@ -675,7 +675,7 @@ void blk_rq_set_mixed_merge(struct request *rq)
>  	/*
>  	 * @rq will no longer represent mixable attributes for all the
>  	 * contained bios.  It will just track those of the first one.
> -	 * Distributes the attributs to each bio.
> +	 * Distributes the attributes to each bio.
>  	 */
>  	for (bio = rq->bio; bio; bio = bio->bi_next) {
>  		WARN_ON_ONCE((bio->bi_opf & REQ_FAILFAST_MASK) &&
> --


-- 
~Randy

