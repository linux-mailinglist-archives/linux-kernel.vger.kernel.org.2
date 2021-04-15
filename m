Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB2361331
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 21:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhDOT4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 15:56:40 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.191]:19970 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234815AbhDOT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 15:56:34 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 6872140159B18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 14:54:24 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id X84Gl39nsPkftX84GlLYCK; Thu, 15 Apr 2021 14:54:24 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0kHnTRwN0hxqCsvTD3VbFwdfLw6YEEfoemtA7hgFdeY=; b=Uz5ISGpvbu8Eh1ur5FcrX5PwqN
        L/Jl1ogfKgW2x9xQaRMfWaV1L0HpT+UGvP/6RH7IxwPKtVJ7miG6I21IxzHg8JqlNP4TUcsqdhOgO
        zpz2soKPSa0UKVS6Guo6BokfVR2PiAu03lBnbn7f3fUMCLggwBfV1AqtTT0zBt4ExnDFtosuM4u+O
        fsoOSRFxwzYtVpQhnP6PFVbfYrc50eGqZf4QmH7dQTohqgNSgsuXcBxMNi/MgFS0hIUlq0RCUTXbR
        mB224o3I1uvTbZOjXX2a0eO4phhoo/7CSQUvThlgi7T0DaHJ9CYLF52iIcwbEPurF+wqrPkDzV4XS
        eW/PIiHQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:47186 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lX84D-001iz4-TV; Thu, 15 Apr 2021 14:54:21 -0500
Subject: Re: [PATCH][next] hpfs: Replace one-element array with flexible-array
 member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210326173510.GA81212@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <d204fcb3-d8d0-34ad-1f22-79104ac32ac7@embeddedor.com>
Date:   Thu, 15 Apr 2021 14:54:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326173510.GA81212@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lX84D-001iz4-TV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:47186
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
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

On 3/26/21 12:35, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use “flexible array members”[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
> 
> Also, this helps with the ongoing efforts to enable -Warray-bounds by
> fixing the following warning:
> 
>   CC [M]  fs/hpfs/dir.o
> fs/hpfs/dir.c: In function ‘hpfs_readdir’:
> fs/hpfs/dir.c:163:41: warning: array subscript 1 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
>   163 |         || de ->name[0] != 1 || de->name[1] != 1))
>       |                                 ~~~~~~~~^~~
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/hpfs/hpfs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/hpfs/hpfs.h b/fs/hpfs/hpfs.h
> index 302f45101a96..d92c4af3e1b4 100644
> --- a/fs/hpfs/hpfs.h
> +++ b/fs/hpfs/hpfs.h
> @@ -356,7 +356,8 @@ struct hpfs_dirent {
>    u8 no_of_acls;			/* number of ACL's (low 3 bits) */
>    u8 ix;				/* code page index (of filename), see
>  					   struct code_page_data */
> -  u8 namelen, name[1];			/* file name */
> +  u8 namelen;				/* file name length */
> +  u8 name[];				/* file name */
>    /* dnode_secno down;	  btree down pointer, if present,
>       			  follows name on next word boundary, or maybe it
>  			  precedes next dirent, which is on a word boundary. */
> 
