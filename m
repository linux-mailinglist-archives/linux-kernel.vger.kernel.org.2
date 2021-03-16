Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DCA33CD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhCPFTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbhCPFTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:19:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=dC5E7TsdjgnOgJtug7U2FDwkw6esv99+L3ttmrLCG7I=; b=16C6SNoVtFw/Bu2bYxEhMnHbDc
        dHPAX//TQ1iY8TQ6Z7LEsZ8z42PTwghSxWmiua/yiAesm75WlHXHPxehWNNrNM19y7N1ygXDVu8s3
        bi2mCX7ksTdXjU0C6y1wANt22hIe9bhts0X1kZ2muaCW4pv1dkXQbVfqnMmqmsAfo3I56G3ZgorAg
        jzgGgwS1wZSEZsITlxCEFKcUADc6WSzXDQod/YGr5OBVLr7M5pCWONgZTQDHxANU+TywSGfI2CrqX
        MkmVfeGf1h7Y1jJhVoy6cflGxZssv+hgjWbK1aid8ubiNGr0KfB/Y+1lYJoD9AV90AjhmFyFqdub2
        Y6RuD77Q==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM26y-001PRJ-1A; Tue, 16 Mar 2021 05:19:20 +0000
Subject: Re: [PATCH] x86: events: intel: A letter change in a word to make it
 sound right,in the file bts.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210316041913.2234069-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ecbefd37-1504-a167-760a-96026b9f67b0@infradead.org>
Date:   Mon, 15 Mar 2021 22:19:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316041913.2234069-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 9:19 PM, Bhaskar Chowdhury wrote:
> 
> s/kernal/kernel/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/x86/events/intel/bts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 731dd8d0dbb1..6320d2cfd9d3 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -594,7 +594,7 @@ static __init int bts_init(void)
>  		 * we cannot use the user mapping since it will not be available
>  		 * if we're not running the owning process.
>  		 *
> -		 * With PTI we can't use the kernal map either, because its not
> +		 * With PTI we can't use the kernel map either, because its not

		                                                        it's

>  		 * there when we run userspace.
>  		 *
>  		 * For now, disable this driver when using PTI.
> --


-- 
~Randy

