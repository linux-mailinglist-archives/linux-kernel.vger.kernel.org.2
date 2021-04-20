Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711803660D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhDTUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:25:55 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.142]:49636 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233874AbhDTUZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:25:49 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 3FE128C13F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:25:12 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ywvolhmwtb8LyYwvoljeJ4; Tue, 20 Apr 2021 15:25:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R4YY3/mgC/gUIYKZSrqzsX4je8UYskhl2Zgm7MunrkQ=; b=euHCn4QVUJQQZ1doxgUQ2ckS8b
        UjtXZrWzfYxR5ByiNploqNmpDR4wVrdakpRcYYhFZ6/4KDegr48WUz4YXIRzN4bTOMeLxG0Ou4OCo
        +Dn0kyYNvK24OXgr0GPNoJcWAnH91WtQ6LxPQ2bbVSD2iKI/fPYj2qKHBYznxPEWdAYO+R/C1Xn5y
        PMRkVlLZifKO6e+UI0yfPO+blBcA9/aTE1cpKVami6I2DHvjfY1EUzAI9vqsVMJBZ7gHUbhPlUOzn
        VmzF6wSLnP5MEicZqNSNCSEAbXHskeqmbyJNpVCiMrbsQYna0EN7cr1qAnaYdUPgPGT6cMUoNVThK
        wSGzBxXw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49044 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwvl-0033at-P2; Tue, 20 Apr 2021 15:25:09 -0500
Subject: Re: [PATCH 032/141] floppy: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <ede7ffddba64f621150f8f5c5f2b8f080b560903.1605896059.git.gustavoars@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <2599e39d-faec-01fc-e835-16a5c96082d6@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:25:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ede7ffddba64f621150f8f5c5f2b8f080b560903.1605896059.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lYwvl-0033at-P2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49044
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 176
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 11/20/20 12:28, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a fallthrough pseudo-keyword in places where the
> code is intended to fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/block/floppy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 7df79ae6b0a1..21a2a7becba0 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -2124,6 +2124,7 @@ static void format_interrupt(void)
>  	switch (interpret_errors()) {
>  	case 1:
>  		cont->error();
> +		fallthrough;
>  	case 2:
>  		break;
>  	case 0:
> 
