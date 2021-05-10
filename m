Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B1A379968
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhEJVti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:49:38 -0400
Received: from gateway30.websitewelcome.com ([192.185.146.7]:28280 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhEJVtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:49:31 -0400
X-Greylist: delayed 1207 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 17:49:31 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 8175D12B62
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 16:28:13 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id gDRll4Z0xDedfgDRllLK3l; Mon, 10 May 2021 16:28:13 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KgfgvAJslFXT/V//YjtBHOgr5mG9TcHB2XOA5MwkyEc=; b=jBEbMKAMemcnb4u3CBVuzDGDg/
        9TAQOBwBZc8a0bYT0mZXv0Az0trVtcXMbJaj5NTPgpRHn6s8y6j9uwqjqS9TO2hXOeHcP6Y0zMlct
        z9W1UgaHqhQSY7T8JBksNrS9m5YBhU4iOQS+pLgMqGY0Qgm+IUudasrrN/xO1kvLqNi0Ycg4g2706
        dA9uU9e9MrQr8v0rFuJjnU9fULOrz1TNk3rGPp6zZrd2J5Bj08W8MDxSWiTwC9QXFnZM2fu/GSFkw
        EehqKoYJrDqeSoZ/os8loLvV5zVg8oT0KrbTAIYcP7tF3lqOfk1Rb0OFLoj8R/w5YMlENzZ0NyLsY
        1A/4VDyA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:42170 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lgDRg-00137t-Uf; Mon, 10 May 2021 16:28:08 -0500
Subject: Re: [PATCH] drm/radeon/ni_dpm: Fix booting bug
To:     Alex Deucher <alexdeucher@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-hardening@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210509224926.GA31035@embeddedor>
 <CADnq5_OWk+rXK5xrwu0YOMVC45WyQgFQBTUNkcF8oO3ucp+=XQ@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ba5f2a73-58e8-6b3e-4048-bb19f238be51@embeddedor.com>
Date:   Mon, 10 May 2021 16:28:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_OWk+rXK5xrwu0YOMVC45WyQgFQBTUNkcF8oO3ucp+=XQ@mail.gmail.com>
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
X-Exim-ID: 1lgDRg-00137t-Uf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:42170
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 5/10/21 16:17, Alex Deucher wrote:
> On Sun, May 9, 2021 at 6:48 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
[..]

>>
>> Bug: https://lore.kernel.org/dri-devel/3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de/
>> Fixes: 434fb1e7444a ("drm/radeon/nislands_smc.h: Replace one-element array with flexible-array member in struct NISLANDS_SMC_SWSTATE")
>> Cc: stable@vger.kernel.org
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Link: https://lore.kernel.org/dri-devel/9bb5fcbd-daf5-1669-b3e7-b8624b3c36f9@xenosoft.de/
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> This seems like a lot of churn just to use flexible arrays.  That
> said, if static checkers are going to keep complaining about single
> element arrays, I don't mind applying these patches since this code is
> not likely to change.  Applied.  Thanks.

This is not only about the one-element arrays. These fixes (together with commits
434fb1e7444a and 96e27e8d919e) allow us to fix more than a dozen of these out-of-bounds
warnings:

drivers/gpu/drm/radeon/ni_dpm.c:2521:20: warning: array subscript 1 is above array bounds of ‘NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’ {aka ‘struct
NISLANDS_SMC_HW_PERFORMANCE_LEVEL[1]’} [-Warray-bounds]
 2521 |   smc_state->levels[i].dpm2.MaxPS =
      |   ~~~~~~~~~~~~~~~~~^~~

which should be fixed in order to globally enable -Warray-bounds. :)

Thanks!
--
Gustavo

