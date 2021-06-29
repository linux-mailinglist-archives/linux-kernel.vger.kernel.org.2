Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2CF3B6D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 05:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhF2DrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 23:47:12 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.80]:15961 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231598AbhF2DrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:47:10 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 350281495E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 22:44:42 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id y4fylYtRKMGeEy4fylADpV; Mon, 28 Jun 2021 22:44:42 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8bHhcBI3oukYyTdqV5uxgQTbLz8FHxPHJwAaOKccwVc=; b=dpvTwbiDdJ0iaW24Xsy3Ex2wnY
        P2ny48w+CJ3MHj7SBBsrSKPJ70PMlgULfNJ0/my147+6y+/Mk/2bQaorb/rje8p/+sCaJuY5tD7D/
        rDWkk2Xptu44BQNPMUJwsWjjckm1EJifYvuuphzlfRLGO1nIPw5/YOB46/hXpOPVO1NvliP9Dtdlz
        1j54LSWQrpf6N3e3DToSv4SUT8pAyPmSnMs8RKFR1LFjYELnMUoNWKqbzlQAW6KrvSeywKr6IyFHI
        63CG0NuD90r8Rqp0OQITU0522NgCrKQs2quhe9PpOeTUxSW99EGeQYPTVnevexpfDUBBLN7M8YLno
        iHjASjVQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:37824 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ly4fw-001ii7-RZ; Mon, 28 Jun 2021 22:44:40 -0500
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210628205947.GA10869@embeddedor>
 <CAHk-=wik-iqVYJyDxfPsOk_8vt1BrsKF-H-nunAYHw3HHuvZqA@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <4a2ef94c-c5cb-c6d4-d36a-e6f5c23c076b@embeddedor.com>
Date:   Mon, 28 Jun 2021 22:46:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wik-iqVYJyDxfPsOk_8vt1BrsKF-H-nunAYHw3HHuvZqA@mail.gmail.com>
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
X-Exim-ID: 1ly4fw-001ii7-RZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:37824
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/21 22:12, Linus Torvalds wrote:
> On Mon, Jun 28, 2021 at 1:58 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
>>
>> Please, pull the following patches that fix many fall-through warnings
>> when building with Clang 12.0.0 and this[1] change reverted. Notice
>> that in order to enable -Wimplicit-fallthrough for Clang, such change[1]
>> is meant to be reverted at some point. So, these patches help to move
>> in that direction.
> 
> I've pulled this, but I really don't like how random it is.
> 
> Just as an example - and there are many others - look at the patch to
> net/netrom/nr_route.c.
> 
> It does
> 
>                 case 0:
>                         nr_node->routes[0] = nr_node->routes[1];
>                         fallthrough;
>                 case 1:
>                         nr_node->routes[1] = nr_node->routes[2];
> +                       fallthrough;
>                 case 2:
>                         break;
> 
> and then about a hundred lines later it does
>                 case 0:
>                         s->routes[0] = s->routes[1];
>                         fallthrough;
>                 case 1:
>                         s->routes[1] = s->routes[2];
> +                       break;
>                 case 2:
>                         break;
> 
> Notice? One does a 'fallthrough' to the next case that does the
> 'break', and the other - very much equivalent case - does a 'break'.
> 
> So the whole "add 'fallthrough' or 'break'" decision doesn't seem to
> have any pattern or rule at all.

I see, you're right.

I still have another PR with more of these fixes (the last ones before finally
being able to enable -Wimplicit-fallthrough for Clang :) ) pending to be sent
later this week. I'll double check and fix any similar issues before sending it.

Thanks for the feedback.
--
Gustavo
