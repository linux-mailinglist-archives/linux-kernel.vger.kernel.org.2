Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2E33F2A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhHTKvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhHTKve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:51:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C00B60FDA;
        Fri, 20 Aug 2021 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629456656;
        bh=q8gLSnrTAf3x+Wghr7BlfshsmKBhWmCOudXqUTpNQXk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L7lb99ewy3BYP6mgeycwTX79zyznsksvDG7mQHW/mjHQy1MiO9O6wLT9G6A0qJ/tv
         CHKdyHe1KBGGtno1+jq8yN0f0YUd9q9U8Wxs1mYfa6D2xbqRIuxNqh3vmrRC52GdgU
         C/TWLHkTBczm78vSlcx6ogH9OVLpZaJkYI5pkGYW3WBmq9rYmU/8QpCZN5o2hDUA3L
         HwO757h9VJlZjl8Z2on1nEBvMMVhbXlZ8PZFChf+34fSgvp+ypTx0gttNuBB22y5PE
         Hbgs6PDnft4a2ZMo90CW+QuD/zJqu+bfxZEMn2qzS06vTlmH5eIpIyfIOabkYinoGA
         5bDlJdeybYyuQ==
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: introduce periodic iostat io
 latency traces
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210820035229.216975-1-daeho43@gmail.com>
 <20210820035229.216975-2-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <48725f58-1a48-73f3-80cf-a0c5efc3b470@kernel.org>
Date:   Fri, 20 Aug 2021 18:50:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820035229.216975-2-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/20 11:52, Daeho Jeong wrote:
> +void iostat_update_and_unbind_ctx(struct bio *bio, int rw)
> +{
> +	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
> +	int sync_type = bio->bi_opf & REQ_SYNC ? 0 : 1;

int sync_type = bio->bi_opf & REQ_SYNC ? 1 : 0;

Right?

>   int f2fs_init_iostat(struct f2fs_sb_info *sbi)
>   {
>   	/* init iostat info */
>   	spin_lock_init(&sbi->iostat_lock);
> +	spin_lock_init(&sbi->iostat_lat_lock);
>   	sbi->iostat_enable = false;
>   	sbi->iostat_period_ms = DEFAULT_IOSTAT_PERIOD_MS;
> +	sbi->iostat_io_lat = f2fs_kzalloc(sbi, sizeof(struct iostat_lat_info),
> +					GFP_KERNEL);
> +	if (!sbi->iostat_io_lat)
> +		return -ENOMEM;

What do you think of just embedding iostat_io_lat structure into f2fs_sb_info
structure? it's minor thing though.

Thanks,
