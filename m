Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D81314523
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhBIAz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBIAzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:55:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B98C061786;
        Mon,  8 Feb 2021 16:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=rQlRhFP48P9Jvt2v4RBO5FEygmEjqLgAyW4pvHX5MCs=; b=kD0zC9xvX5l+0HsV3mYjhKkq9F
        OyZF30I04gI8pJF5Ervbjj9oWpnu7LYMXB/VCBDkdgOervMtdaguTAxoMUYLKiFVKSgMSQMhGZ/eN
        kExeaPenySYakk3eHVMsjT6rOeDK010gpALZa0f+9PA2EztCk9979KbvNJ3hCSXT9yvchxJqgET1q
        KOkbcew6AtAhxRRvtpJ2CEoIZ22w3TRtkbxGv7wcV0dTL29GfDWDakefvzfHFvUriU2Iy6dvJmwnZ
        TA0jae4cQoknN5TIcR+acBLFvEUrMhHARTCUa70z2k4St+I3NHhgWIIGxfTjDX8nE2PBJkBxi/D6v
        latpslZA==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9HJ8-0002W2-6q; Tue, 09 Feb 2021 00:55:10 +0000
Subject: Re: [PATCH] Documentation/admin-guide: kernel-parameters: Update
 nohlt section
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20210209003047.2231924-1-f.fainelli@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <62dc4371-d971-9164-1c1d-8923877b5e31@infradead.org>
Date:   Mon, 8 Feb 2021 16:55:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209003047.2231924-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 4:30 PM, Florian Fainelli wrote:
> Update the documentation regarding "nohlt" and indicate that it is not
> only for bugs, but can be useful to disable the architecture specific
> sleep instructions. ARM, ARM64, SuperH and Microblaze all use
> CONFIG_GENERIC_IDLE_POLL_SETUP which takes care of honoring the
> "hlt"/"nohlt" parameters.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a10b545c2070..83c37e23e1e2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3266,9 +3266,14 @@
>  			parameter, xsave area per process might occupy more
>  			memory on xsaves enabled systems.
>  
> -	nohlt		[BUGS=ARM,SH] Tells the kernel that the sleep(SH) or
> -			wfi(ARM) instruction doesn't work correctly and not to
> -			use it. This is also useful when using JTAG debugger.
> +	nohlt		[ARM,ARM64,MICROBLAZE,SH] Forces the kernel to busy wait
> +			in do_idle() and not use the arch_cpu_idle()
> +			implementation, requires CONFIG_GENERIC_IDLE_POLL_SETUP

Sounds good... but above, I would prefer s/,/;/

> +			to be effective. This is useful on platforms where the
> +			sleep(SH) or wfi(ARM,ARM64) instructions do not work
> +			correctly or when doing power measurements to evalute
> +			the impact of the sleep instructions. This is also
> +			useful when using JTAG debugger.
>  
>  	no_file_caps	Tells the kernel not to honor file capabilities.  The
>  			only way then for a file to be executed with privilege
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

-- 
~Randy

