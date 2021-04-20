Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23E36611E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhDTUse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:48:34 -0400
Received: from gateway20.websitewelcome.com ([192.185.65.13]:33002 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234009AbhDTUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:48:31 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 3DAC54012B099
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:13:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwvElhmIOb8LyYwvEljdh4; Tue, 20 Apr 2021 15:24:36 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9bKajUIjAM4oNSjyzCLVKB1/vBoVI77Dq0uSCOEdFGg=; b=mGuZWbP94+G+uV/xsgmMBIZPxr
        4nEy+NFfdH5ECY0QjkenRsKAr61Ef6YfahW1dOTqjd3PJbj4smESLPx4Ae5jFwkD9YdNryq8cqBL+
        LY324z8a7U5VSVWZdySydtc2vZLqaw6SCr0Io6Otld8pz18Xf0PDfMCrciu/eMfcfzDj6UMwrWYmz
        3WVftV2e19Yr77ITkncFlL8qMitmKvDi6QOb3ugAvhe6MKeGRx7HTOhHUCdVCApP0XjZy75DOJ3pn
        kMNE/aNjAR4F1P6hMra3LRCJ2e/a7L3LTLEUwCocyVEVc/kkXYvAaKMgEJ7mWPAqAc0ZLc8dCyOrU
        PhdJ5lNA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49040 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwvD-0032In-KC; Tue, 20 Apr 2021 15:24:35 -0500
Subject: Re: [PATCH 038/141] isofs: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <5b7caa73958588065fabc59032c340179b409ef5.1605896059.git.gustavoars@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <db9d74de-ef12-1d55-4007-944c2a4e2904@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:24:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <5b7caa73958588065fabc59032c340179b409ef5.1605896059.git.gustavoars@kernel.org>
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
X-Exim-ID: 1lYwvD-0032In-KC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49040
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 169
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

On 11/20/20 12:30, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of just letting the code
> fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/isofs/rock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
> index 94ef92fe806c..4880146babaf 100644
> --- a/fs/isofs/rock.c
> +++ b/fs/isofs/rock.c
> @@ -767,6 +767,7 @@ static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
>  			rs.cont_extent = isonum_733(rr->u.CE.extent);
>  			rs.cont_offset = isonum_733(rr->u.CE.offset);
>  			rs.cont_size = isonum_733(rr->u.CE.size);
> +			break;
>  		default:
>  			break;
>  		}
> 
