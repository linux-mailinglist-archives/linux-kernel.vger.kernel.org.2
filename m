Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7917381470
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 02:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhEOAEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 20:04:34 -0400
Received: from gateway23.websitewelcome.com ([192.185.47.80]:40966 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234465AbhEOAEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 20:04:30 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 54B4929F5
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 19:03:16 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hhm0lyDcJ8ElShhm0lTTKr; Fri, 14 May 2021 19:03:16 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pk6PtlPuiMH4r2ZGSvo7HvjoXb9nyKtTfLHMjVbKyiA=; b=BRPzuh+yiH9mKDyBKk68+dEfbx
        LZGJ/LRnixG6qCWOmspXWpb7lUem66nqvsdKbH9Juo0I08XxtCKRn8eORvzvKeSiPj2EpAWT+I/qX
        5Cf1uJJ6ljAtSSDW+nb65eFHmuL5y5u/6oscwUOGC7mBkkXrjJmAhPLQM5u/ilVjwQ6oZksLmhaog
        ievY82Y2eYgv5sdDTLpo1E2uqA6kbZEDOxqXKtsvaKecr19fgvww9e7qdBkrEM6Wb5pPIXptTwMrI
        LArpdYQc8sMDoHHjh0R/Zdahdv1a1V0bY8sd24b2S4fMdUPfb/7X+ELl5Lkx0l4aVELJWPZ99htoR
        Iyab3IEw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:55108 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lhhlx-0037bL-Uk; Fri, 14 May 2021 19:03:13 -0500
Subject: Re: [PATCH][next] rsxx: Use struct_size() in vmalloc()
To:     Jens Axboe <axboe@kernel.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210513203730.GA212128@embeddedor>
 <fb567b7b-5ea4-fe8b-52cc-f148ff6a61b7@kernel.dk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <86254a3d-b9a2-d0b9-d20c-f9c86666bc1b@embeddedor.com>
Date:   Fri, 14 May 2021 19:03:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fb567b7b-5ea4-fe8b-52cc-f148ff6a61b7@kernel.dk>
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
X-Exim-ID: 1lhhlx-0037bL-Uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:55108
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/21 10:00, Jens Axboe wrote:

> 
> Applied, thanks.
> 

Thanks, Jens.

--
Gustavo
