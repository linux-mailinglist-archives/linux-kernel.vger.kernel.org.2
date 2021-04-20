Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E193660D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhDTUZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:25:04 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.28]:13638 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233891AbhDTUY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:24:57 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id F34E7493BF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:20:42 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YwrSlH03LL7DmYwrSlP4jp; Tue, 20 Apr 2021 15:20:42 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YJ684Kpvtuy+Txg6HPlLNrGi4yuyp01ExRu2aDYFwec=; b=KcZiilEOn60I/bZtIYwKsP9pew
        jJd0ZoY9izCQJfT7R87oZf8I24a5JH06be0qTXNhcmoJsqV8cIUzBZ8FQ5uVRlzyRZB6ZP1cpDrTS
        cwXz9/MKXWl9l2D83bqaHVtKLQMsaE2RcHxvE7os1iKGemg5F1JwmmRXYKzGl+08kNjeUVhznGT92
        ISXrZAu35kiEmxPlyvjTt62c6aYDvxU8+1Fw9WkQwaU/JynxcqoEgEqxyBOcYk4U6ySL2Vki8LCxq
        B7tdobHjc4TMdmFKinAyHFcEwU+Dc1EJddeFxk6G19icsxkTfeGHyMNMGn1uuMqGPUeUyrRXsriBs
        S8pDF+IQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49008 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYwrQ-002wCT-HH; Tue, 20 Apr 2021 15:20:40 -0500
Subject: Re: [PATCH 061/141] tee: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <c505109fe0c02f648e16caa83d8a9773afd696b1.1605896059.git.gustavoars@kernel.org>
 <CAHUa44G1B8_CSahTJ1uOUMLcDfpVKHUaoN+u87BywkVwyhjnRw@mail.gmail.com>
 <20201123225507.GR21644@embeddedor>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <e44a9011-f2ed-f1d2-cc1a-7dcba2f41956@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:20:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20201123225507.GR21644@embeddedor>
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
X-Exim-ID: 1lYwrQ-002wCT-HH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49008
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 129
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

On 11/23/20 16:55, Gustavo A. R. Silva wrote:
> On Sun, Nov 22, 2020 at 10:26:09AM +0100, Jens Wiklander wrote:
>> On Fri, Nov 20, 2020 at 7:33 PM Gustavo A. R. Silva
>> <gustavoars@kernel.org> wrote:
>>>
>>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>>> by explicitly adding a break statement instead of letting the code fall
>>> through to the next case.
>>>
>>> Link: https://github.com/KSPP/linux/issues/115
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>  drivers/tee/tee_core.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
> 
> Thanks, Jens.
> --
> Gustavo
> 
