Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9A6349FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhCZC3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhCZC3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:29:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A985CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 19:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=9ioHdOmky52MXJvonHV5wE14/tYK+Ev3m0hmPa4lVDI=; b=WXWpwkE0DoPUXPliNi6YcU92lV
        WONjgnUZGz0cEvYDPTNt3s45i9xXlwYWF4JoppbpI5IaqN/GbUbrynqA020zEMXCxqKNd0Ga+hqRo
        URDtOugP7N8m0UjnV6G1laqFKupHl/G3iM2R0iSDR4qykA5q3b2YpaS6OoLaKvQgng0ileETn5uqL
        ui59HlER7q9LchDbBYa+AaZUWkuy/uxDURfvDt/DROXVURJT+rrJEGSHim/GDHcVYdKNhT+Le/Tzc
        XONbrxZ5EZurY6jOPqBMpamUFji8D9gAozYLVL6blrQIN3xgvs0CfDuv4+67h440SUfGCLP17yZkS
        omTYdB3g==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPcDr-002cDV-Sn; Fri, 26 Mar 2021 02:29:16 +0000
Subject: Re: [PATCH V2] ipc/sem.c: Mundane typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        akpm@linux-foundation.org, gustavoars@kernel.org,
        adobriyan@gmail.com, linux-kernel@vger.kernel.org
References: <20210326022240.26375-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <11d38287-9b0a-6354-6908-2b9354288f6f@infradead.org>
Date:   Thu, 25 Mar 2021 19:29:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210326022240.26375-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 7:22 PM, Bhaskar Chowdhury wrote:
> 
> s/runtine/runtime/
> s/AQUIRE/ACQUIRE/
> s/seperately/separately/
> s/wont/won\'t/
> s/succesfull/successful/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Changes from V1:
>   Wrongly spelt filename in the subject line, corrected.
> 
>  ipc/sem.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/ipc/sem.c b/ipc/sem.c
> index f6c30a85dadf..0897dac27f43 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -36,7 +36,7 @@
>   * - two Linux specific semctl() commands: SEM_STAT, SEM_INFO.
>   * - undo adjustments at process exit are limited to 0..SEMVMX.
>   * - namespace are supported.
> - * - SEMMSL, SEMMNS, SEMOPM and SEMMNI can be configured at runtine by writing
> + * - SEMMSL, SEMMNS, SEMOPM and SEMMNI can be configured at runtime by writing
>   *   to /proc/sys/kernel/sem.
>   * - statistics about the usage are reported in /proc/sysvipc/sem.
>   *
> @@ -224,7 +224,7 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
>   * Setting it to a result code is a RELEASE, this is ensured by both a
>   * smp_store_release() (for case a) and while holding sem_lock()
>   * (for case b).
> - * The AQUIRE when reading the result code without holding sem_lock() is
> + * The ACQUIRE when reading the result code without holding sem_lock() is
>   * achieved by using READ_ONCE() + smp_acquire__after_ctrl_dep().
>   * (case a above).
>   * Reading the result code while holding sem_lock() needs no further barriers,
> @@ -821,7 +821,7 @@ static inline int check_restart(struct sem_array *sma, struct sem_queue *q)
> 
>  	/* It is impossible that someone waits for the new value:
>  	 * - complex operations always restart.
> -	 * - wait-for-zero are handled seperately.
> +	 * - wait-for-zero are handled separately.
>  	 * - q is a previously sleeping simple operation that
>  	 *   altered the array. It must be a decrement, because
>  	 *   simple increments never sleep.
> @@ -1046,7 +1046,7 @@ static void do_smart_update(struct sem_array *sma, struct sembuf *sops, int nsop
>  			 * - No complex ops, thus all sleeping ops are
>  			 *   decrease.
>  			 * - if we decreased the value, then any sleeping
> -			 *   semaphore ops wont be able to run: If the
> +			 *   semaphore ops won't be able to run: If the
>  			 *   previous value was too small, then the new
>  			 *   value will be too small, too.
>  			 */
> @@ -2108,7 +2108,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
>  	queue.dupsop = dupsop;
> 
>  	error = perform_atomic_semop(sma, &queue);
> -	if (error == 0) { /* non-blocking succesfull path */
> +	if (error == 0) { /* non-blocking successful path */
>  		DEFINE_WAKE_Q(wake_q);
> 
>  		/*
> --


-- 
~Randy

