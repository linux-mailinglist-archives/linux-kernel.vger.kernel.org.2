Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511D1345698
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 05:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCWEPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 00:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCWEPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 00:15:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3762FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 21:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=bKwNbIshUqI8o/JKCn1Ij1dd2vWMlvA0tjzAClAZop8=; b=j6ts8kepkF2rApjXY73Ct9/oY5
        1fTbRTypwOUt55xxUTNxNYizBgY+TduVWuOfrJgHKEIznfN2rc6phBZxpMPlre30P2qLdxwUEFxxq
        Jw6HC6fwkq6bfr+IZtvuAggqSMoyLXUW3kdoMXP3NHHKxDYb7JfpZzVVqfgTbOnYUxjeVUfzlCLou
        1gNaTj0lWalhtdDv2FvuTPeAzGUOPfNB3MiY0IaTaNDSGC6WnPKcsfJGrMQ+o65QKrIwa3x6QUlwI
        JzAg5SenFJiCn4BYb2r5zWKtsaY6BQuhV8kQYqEyZuSIxLzkh15uk1ozcOcy3O60Nf4azUkSVowGr
        UTPkuSZw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOYRL-009VuT-E8; Tue, 23 Mar 2021 04:14:54 +0000
Subject: Re: [PATCH] staging: wimax: Mundane typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gregkh@linuxfoundation.org, colin.king@canonical.com,
        davem@davemloft.net, lee.jones@linaro.org, arnd@arndb.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210323010607.3918516-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <36821877-7a6c-9a15-4e94-cb657ef29dad@infradead.org>
Date:   Mon, 22 Mar 2021 21:14:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323010607.3918516-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 6:06 PM, Bhaskar Chowdhury wrote:
> 
> s/procesing/processing/
> s/comunication/communication/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

drivers/staging/wimax/ is in the process of being deleted.

> ---
>  drivers/staging/wimax/i2400m/driver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/wimax/i2400m/driver.c b/drivers/staging/wimax/i2400m/driver.c
> index f5186458bb3d..162a92682977 100644
> --- a/drivers/staging/wimax/i2400m/driver.c
> +++ b/drivers/staging/wimax/i2400m/driver.c


-- 
~Randy

