Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D305336BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhCKGPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhCKGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:15:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ffmBsnrqNlpNo19oLmCnhE0jEbSDEvogYJu0N5K/NHM=; b=PQnSE9xXYLQ7R4+hhQurUBt5MC
        xrrgN+4epogg9LvTSZlMmBdz7O9dnYUiY9AYNSXyQwQ2LyHaRMEkInV5hwueXxHkistSk9Rz02XuY
        YDNWgqGKMTcaUUAUj82Oe17paUm3rOGeb85V0Poc4Omnq7X0J4mKdditNAZEGIZvcMmWu0LW9jHbf
        mD0ZoMDt7YG704cFFGSg5M2HfiMymRXhfLo1qgwe9MqOPSHZKPzRUyqSDeNcjL7uXxu+MLKraIZyZ
        1ulCkJP4PEckvSKmQQ9y+oEw4bfm3kkS0EoSWz5Enj9KR6LH+2JUW+9kSszevQHVYg0oaeg8eUKK/
        rld99T5A==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKEbc-000tWY-Nl; Thu, 11 Mar 2021 06:15:33 +0000
Subject: Re: [PATCH] ia64: kernel: Few typos fixed in the file fsys.S
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210311061058.29492-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e26a1461-0d05-d79c-7688-de45d285e068@infradead.org>
Date:   Wed, 10 Mar 2021 22:15:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210311061058.29492-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 10:10 PM, Bhaskar Chowdhury wrote:
> 
> Mundane spelling fixes.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

but no maintainer Cc:ed to pick it up...

> ---
>  arch/ia64/kernel/fsys.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
> index 0750a716adc7..2094f3249019 100644
> --- a/arch/ia64/kernel/fsys.S
> +++ b/arch/ia64/kernel/fsys.S
> @@ -172,7 +172,7 @@ ENTRY(fsys_gettimeofday)
>  	// r25 = itc_lastcycle value
>  	// r26 = address clocksource cycle_last
>  	// r27 = (not used)
> -	// r28 = sequence number at the beginning of critcal section
> +	// r28 = sequence number at the beginning of critical section
>  	// r29 = address of itc_jitter
>  	// r30 = time processing flags / memory address
>  	// r31 = pointer to result
> @@ -432,7 +432,7 @@ GLOBAL_ENTRY(fsys_bubble_down)
>  	 *	- r29: psr
>  	 *
>  	 * We used to clear some PSR bits here but that requires slow
> -	 * serialization.  Fortuntely, that isn't really necessary.
> +	 * serialization.  Fortunately, that isn't really necessary.
>  	 * The rationale is as follows: we used to clear bits
>  	 * ~PSR_PRESERVED_BITS in PSR.L.  Since
>  	 * PSR_PRESERVED_BITS==PSR.{UP,MFL,MFH,PK,DT,PP,SP,RT,IC}, we
> --


-- 
~Randy

