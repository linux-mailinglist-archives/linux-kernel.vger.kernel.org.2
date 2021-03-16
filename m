Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3722C33CDA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhCPFtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhCPFtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:49:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B53C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=vfGZwIFnI5xpNBTfsu0YQgelzvrmLaCqnrmimGucXYA=; b=qTxkAR2Uw2if9V5lp6nFtHzZri
        qHg6kl6ugUMc5YHHmaiLmriOYGRPLdJBdhymMxmVj1FbhJLWiDCwwXyU5Vnr2WhXfAwU1mDiVP68H
        RX0xUPIuQ67GbBzueUiK14gBB4sITN6QUD9TpT5IeToDRUuDu3dlv7+6sLSi9ORnHrP5+0yphd02C
        es4gKyJaL/USEbJJSe4YvXqfJm9qPoK8mzA0kgFxV7IfV2jO/6JWTXc20KUkTC1VSBAIJFSK0Okqh
        f7KKuJ7PSS7GgLo/9qQxx6jijfJrXVZaiK/5HODAHz+fihQPYxTppf83GGJk2dQnPed/CGed2uS5L
        8TalhLCQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM2Zr-001PdE-8V; Tue, 16 Mar 2021 05:49:11 +0000
Subject: Re: [PATCH V2] x86: events: intel: A letter change in a word to make
 it sound right,in the file bts.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210316054227.962533-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ea936c7-0fd1-df2c-6b65-920baf64ba04@infradead.org>
Date:   Mon, 15 Mar 2021 22:49:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316054227.962533-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 10:42 PM, Bhaskar Chowdhury wrote:
> 
> s/kernal/kernel/
> 
>  A punctuation added too.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Changes from V1:
>  Punctuation missed, added as per Randy's finding
> 
>  arch/x86/events/intel/bts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 731dd8d0dbb1..1ba93c40fc54 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -594,7 +594,7 @@ static __init int bts_init(void)
>  		 * we cannot use the user mapping since it will not be available
>  		 * if we're not running the owning process.
>  		 *
> -		 * With PTI we can't use the kernal map either, because its not
> +		 * With PTI we can't use the kernel map either, because it's not
>  		 * there when we run userspace.
>  		 *
>  		 * For now, disable this driver when using PTI.
> --


-- 
~Randy

