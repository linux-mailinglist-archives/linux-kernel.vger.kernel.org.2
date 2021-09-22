Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335DA4153EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbhIVXey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:34:54 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.12]:24722 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238477AbhIVXeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:34:50 -0400
X-Greylist: delayed 1450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Sep 2021 19:34:50 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 3F6A43FA60
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:09:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TBMPmHGNDjSwzTBMPmkT85; Wed, 22 Sep 2021 18:09:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AbCQpuiP0FFS2JbpLU0DivFOkabMY3zTZtov5oB6aVE=; b=vsJK6s1sXjGgkOPIoPKkCmn7md
        cM8amv9OdZfUe+WNLoc0sEimnA80MPQmdMAyJfMGWklrvLEB9OdQKoqNIzbE+bXg22gXYgIHwxpoq
        O0zCD1/ZyR+h6tcTY1YJ3n5g1peyn3JeZK/V4Cx9Fm31wLuk/pe3EDEcIsP1wOr+vef2yT4O5+sje
        K9OG6cZoVCK2cz8b1ZHl166pR2R57gHt/s6F6h8o7xghBV/6V0i+1YbLC2FZQx43ajYwYiDwpzqhT
        jNH/BekCyF43CYGqs3ID4tSAKY0H3HgCSxeMWLTc7wUjacTG+cJKda9a3Sylsv/Qgi7LXbFqsQI5j
        FX2w1Uxg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:38206 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mTBMO-000C97-Px; Wed, 22 Sep 2021 18:09:04 -0500
Subject: Re: [PATCH] staging: vt6655: Replace camel case variable name
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        =?UTF-8?B?QWxkYXMgVGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210922225138.668520-1-tomm.merciai@gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <6695e45f-4530-ab39-923d-8347649762bb@embeddedor.com>
Date:   Wed, 22 Sep 2021 18:12:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922225138.668520-1-tomm.merciai@gmail.com>
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
X-Exim-ID: 1mTBMO-000C97-Px
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:38206
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/21 17:51, Tommaso Merciai wrote:
> Work in progress: replace camel case variables
> 
> PortOffset -> port_offset
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---

When someone gives you feedback and you have to respin your
patch, you should version the patches that you resend, and
mention what changed, here:

Changes in v2:
 - Variable should be port_offset instead of port_off_set.

I encourage you to take a look at this:

https://kernelnewbies.org/Outreachyfirstpatch

It will be of great help if you are trying to land
your first patches. :)

--
Gustavo
