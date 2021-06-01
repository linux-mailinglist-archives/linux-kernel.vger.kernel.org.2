Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C56397C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhFAWOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:14:30 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.191]:12834 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234740AbhFAWO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:14:27 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id E9B92400D497F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 17:12:41 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id oCcrlatSrDedfoCcrlg1CA; Tue, 01 Jun 2021 17:12:41 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gQRWjLhpoAcL1f0UUsLAbLVdyvmjcaGwSmImCIMpK8g=; b=bMNcVIOdSbAXlFOIuKZBAlQgHb
        rizHEbtPx/wzzA8zqcRapvlU8ysBb7UK1JtNxmi9ml0UM3aWv2vx56T2J6VDzc9qm9xnsicW6cPub
        wCWYuhcSS0L4MR/0nu+MH1rJ8KNNWRDQZba/bygsG2AVLOwhqdh0oJFFpMd9o5XRSrSqFMPMEoBHs
        9Eycf2roWWXoQh436c20ZAonzOD6Dff1+OIQK/bdOQYuXJmaM3D8Dj2tQXEwxBZxBKCJLdeJal2Kx
        DBPDf7EnoxQyV365tcr0fc7lC7Q6+OAvSioS5JvoAErfDv+s5bNk5+LxyYo50rrDXoNxXtDKzCtmI
        JKx47Xbg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:52568 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1loCco-000BPJ-Fv; Tue, 01 Jun 2021 17:12:38 -0500
Subject: Re: [PATCH][next] kgdb: Fix fall-through warning for Clang
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210528200222.GA39201@embeddedor>
 <202106011220.AA0C1482@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <0d53a68c-b445-1df6-43a9-eff1a54f8fce@embeddedor.com>
Date:   Tue, 1 Jun 2021 17:13:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202106011220.AA0C1482@keescook>
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
X-Exim-ID: 1loCco-000BPJ-Fv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:52568
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/21 14:20, Kees Cook wrote:
> On Fri, May 28, 2021 at 03:02:22PM -0500, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
>> fall-through warning by explicitly adding a goto statement instead
>> of letting the code fall through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> JFYI: We had thousands of these sorts of warnings and now we are down
>>       to just 25 in linux-next. This is one of those last remaining
>>       warnings.
> 
> So close! :)

Almost there!

> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks

--
Gustavo

> 
> -Kees
> 
>>
>>  kernel/debug/debug_core.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
>> index 4708aec492df..431749dd9ab6 100644
>> --- a/kernel/debug/debug_core.c
>> +++ b/kernel/debug/debug_core.c
>> @@ -1038,6 +1038,7 @@ dbg_notify_reboot(struct notifier_block *this, unsigned long code, void *x)
>>  	switch (kgdbreboot) {
>>  	case 1:
>>  		kgdb_breakpoint();
>> +		goto done;
>>  	case -1:
>>  		goto done;
>>  	}
>> -- 
>> 2.27.0
>>
> 
