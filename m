Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A12A343653
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCVBhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVBhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:37:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D4DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 18:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=PeFKywclNnynK3PkK2KbFgcceqz0rhw+gZ/xqsuy7V4=; b=CoLFIbj8NE5TVurjY88m32BZtj
        T+K2i/96ZLIcdICZQ/Fv/vtYa1ohxn9bkoWFW1Og+eSeO3YbSVEz8Z4w8oAcoR5VXuNT3qs7o8aso
        GM840PVa32U7oMoYB00NAnb84ub0WniKLZ6o/u8DM0p7AO2yxkmGbLUsMb1L25tknkScWhEoIuAJr
        ASbT1xrFlR4YNbaaXCYtxN5Mq/Ha4pruGeMQOQ6YZtJ1inmieZsuNQReH6AGoxYKFBHZ938QXMjBe
        HTg6NCRkMWOn0nbaGu8X3hreOV1AH+1l7oVX9zET3FX1LLo1Gnz47jMRhNsiJk8YblUIUlr2kMSFn
        pa5Xso9Q==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lO9V4-00AfX1-Lw; Mon, 22 Mar 2021 01:36:59 +0000
Subject: Re: [PATCH] ipc/shm.c: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        akpm@linux-foundation.org, liao.pingfang@zte.com.cn,
        daniel.m.jordan@oracle.com, vbabka@suse.cz, gustavoars@kernel.org,
        yanaijie@huawei.com, walken@google.com, 0x7f454c46@gmail.com,
        adobriyan@gmail.com, linux-kernel@vger.kernel.org
References: <20210322013223.1930159-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <88e3a572-1326-c4d9-b873-01b38bb72c28@infradead.org>
Date:   Sun, 21 Mar 2021 18:36:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322013223.1930159-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/21 6:32 PM, Bhaskar Chowdhury wrote:
> 
> s/exit\'ed/exited/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  ipc/shm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ipc/shm.c b/ipc/shm.c
> index febd88daba8c..07fb04c20d8c 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -357,7 +357,7 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
> 
>  	/*
>  	 * We want to destroy segments without users and with already
> -	 * exit'ed originating process.
> +	 * exited originating process.
>  	 *
>  	 * As shp->* are changed under rwsem, it's safe to skip shp locking.
>  	 */
> --

I think this one could go either way.
It's referring to the exit() library call or syscall,
so it's not so bad is it currently is.

I.e., I'll leave it up to someone else if they want to merge it.

-- 
~Randy

