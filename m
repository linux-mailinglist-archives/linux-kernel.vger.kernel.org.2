Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B16A386E61
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbhERAjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:39:36 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.9]:34542 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235470AbhERAjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:39:35 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 1A048E59AF0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:38:18 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id inkYlxZqsMGeEinkYl00jn; Mon, 17 May 2021 19:38:18 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4RWxH2aMjPw2HSLpv4Ox8ZbpnFLLqLifGHgZKKmBLB8=; b=Zyx6BH8SuObchvVV+OQuUswGSy
        +Xf6OFxssDkxxY0ZmmULPoazWY8n6c03pHquDa6AgAG+f1+WzpEnSmNXtzoyHa+VCoyVo9hNC9xaR
        c6nErunCqKZ+K8BZ1iAN856s4glkosIR6SeuH970mh2KDs5bweVYSi4WtX60uAAQx1ndT1XMN6DHN
        Je2JAqDWHi78UfTDWSlFlsOlBAGWRxmFOLSc+ydPZKvWINldb3bWL3ENklLvquzORl46VMzc2yhiJ
        ze0Zu6xQr2o41t2OWPSfsMc+lXVdglmD0NBV4JtID8D3fKdzyq47JDhTHZZu6KG67RNIS62GPHqbo
        pZXSflRw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53490 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1linkW-002fSu-Np; Mon, 17 May 2021 19:38:16 -0500
Subject: Re: [PATCH 071/141] braille_console: Fix fall-through warnings for
 Clang
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <a0be16871b77956d75ea2f877da2fa5fba3e64ac.1605896059.git.gustavoars@kernel.org>
 <f7e58552-309f-ef96-7ac8-3cb692c979d1@embeddedor.com>
Message-ID: <0e8e9cee-57c3-47ea-703c-b9ed3fa8b7f7@embeddedor.com>
Date:   Mon, 17 May 2021 19:39:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f7e58552-309f-ef96-7ac8-3cb692c979d1@embeddedor.com>
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
X-Exim-ID: 1linkW-002fSu-Np
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:53490
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 56
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm taking this in my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

On 4/20/21 15:16, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 11/20/20 12:34, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a break statement instead of letting the code fall
>> through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/accessibility/braille/braille_console.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
>> index 9861302cc7db..359bead4b280 100644
>> --- a/drivers/accessibility/braille/braille_console.c
>> +++ b/drivers/accessibility/braille/braille_console.c
>> @@ -246,6 +246,7 @@ static int keyboard_notifier_call(struct notifier_block *blk,
>>  				beep(440);
>>  		}
>>  	}
>> +		break;
>>  	case KBD_UNBOUND_KEYCODE:
>>  	case KBD_UNICODE:
>>  	case KBD_KEYSYM:
>>
