Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB33813D9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhENWmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 18:42:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52592 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhENWma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 18:42:30 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 14EMf6PJ096996;
        Sat, 15 May 2021 07:41:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Sat, 15 May 2021 07:41:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 14EMf67u096993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 May 2021 07:41:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: PATCH: Re: LOCKDEP customizable numbers upper limit
To:     hooanon05g@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
References: <30795.1620913191@jrobl>
 <f323397b-dbe7-b655-4624-d243c2f68d81@i-love.sakura.ne.jp>
 <19935.1621016564@jrobl>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <11faf952-c0f8-6e1d-3560-12d77847a8ac@i-love.sakura.ne.jp>
Date:   Sat, 15 May 2021 07:41:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <19935.1621016564@jrobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/05/15 3:22, hooanon05g@gmail.com wrote:
> Tetsuo Handa:
>> Please submit a patch that avoids only BUILD_BUG_ON().
> 
> Here it is.

Thank you. In practice, nobody will increase by more than 5 bits.

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

> 
> J. R. Okajima
> 
> ----------------------------------------
> commit 43e103e1a5975c61334811d16e207e6d0ac57b77
> Author: J. R. Okajima <hooanon05g@gmail.com>
> Date:   Sat May 15 03:17:10 2021 +0900
> 
>     LOCKDEP: upper limit LOCKDEP_CHAINS_BITS
>     
>     CONFIG_LOCKDEP_CHAINS_BITS value decides the size of chain_hlocks[] in
>     kernel/locking/lockdep.c, and it is checked by add_chain_cache() with
>             BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
>     This patch is just to silence BUILD_BUG_ON().
>     
>     See-also: https://marc.info/?l=linux-kernel&m=162091320503900&w=2
>     Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Signed-off-by: J. R. Okajima <hooanon05g@gmail.com>
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 678c13967580e..999ed5aa6bcee 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1390,7 +1390,7 @@ config LOCKDEP_BITS
>  config LOCKDEP_CHAINS_BITS
>  	int "Bitsize for MAX_LOCKDEP_CHAINS"
>  	depends on LOCKDEP && !LOCKDEP_SMALL
> -	range 10 30
> +	range 10 21
>  	default 16
>  	help
>  	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
> 

