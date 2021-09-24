Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41564417DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 00:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhIXWiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 18:38:08 -0400
Received: from gateway20.websitewelcome.com ([192.185.65.13]:30351 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhIXWiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:38:07 -0400
X-Greylist: delayed 1479 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 18:38:07 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id A3AD5400D5CF0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 16:52:50 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TtQ9mgrJTejmuTtQ9mbiof; Fri, 24 Sep 2021 17:11:53 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9Q0qgDyxKZKWKpblvkt7lUWUuHDvyt31RrTbtQxth/U=; b=M5VL8eWynBx5pkhxY/i+owuCjx
        vSSt/EbFVRcpof2ibmfnaWs7edrNZZVcr3W9AUV2JB6Gg4sCNVUwDDNyNoH55fDy2kzLPNnZXG6YQ
        zy4B78HL/gfzb77mCmcX9dv/C6ZcpXh5yxGZtgvfgEUj+dFWcZQCnYLGHsMAMW9toL281dUqru/kL
        qoXSspKJP2ClrThZU76P9Pyh6ERaj8vRT3VsOi52EIdOSFpLQ6mkjJ5pSz+W0zsTyYRV8eO7WW517
        tZuA0c0Somyrsv089Qm2Vu885ugMj9PXY7YPDmxTsnZeSN9a0AaFNI0cKOohQMYYZXUd3/McRaw82
        A9WxH3+A==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:45326 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mTtQ8-001M7Y-KW; Fri, 24 Sep 2021 17:11:52 -0500
Subject: Re: [PATCH v2 3/3] staging: vt6655: replace camel case port_offset
 instead of PortOffset.
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        =?UTF-8?B?QWxkYXMgVGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210924210008.106355-1-tomm.merciai@gmail.com>
 <20210924210008.106355-4-tomm.merciai@gmail.com>
 <58c61a30-c368-8e4f-d9c9-1f39cadda869@embeddedor.com>
 <20210924220142.GA4788@tom-desktop>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <cb4c2cfe-a2ad-a72d-16c2-02dcf4d32ab8@embeddedor.com>
Date:   Fri, 24 Sep 2021 17:15:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924220142.GA4788@tom-desktop>
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
X-Exim-ID: 1mTtQ8-001M7Y-KW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:45326
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/21 17:01, Tommaso Merciai wrote:
> On Fri, Sep 24, 2021 at 04:56:16PM -0500, Gustavo A. R. Silva wrote:
>>
>>
>> On 9/24/21 16:00, Tommaso Merciai wrote:
>>
>> Where is the changelog text? :/
>>
>> Sorry but I insist: take a look at this:
>>
>> https://kernelnewbies.org/Outreachyfirstpatch
>   
>   Hi Gustavo,
>   You mean the changelog in the cover letter?

That's not how it works. :)

What's the hurry?
Check section "Versioning one patch revision" and then read the
whole thing, so you can learn how to smoothly land as many patches
as you want:

https://kernelnewbies.org/Outreachyfirstpatch

--
Gustavo

> 
>   Thanks.
>   Tommaso
>>
>> Thanks
>> --
>> Gustavo
>>
>>> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
