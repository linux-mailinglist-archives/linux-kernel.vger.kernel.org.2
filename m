Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8BC3673BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245536AbhDUTtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhDUTtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:49:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D459C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:49:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m11so29884948pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O19OVUmKX+OatpTnEx2U4M6GnjJTDDCO8nNhpR1gr+U=;
        b=HVJpPUulS/cE7FTJFQx951RCIw/OmH6YXIQbR5foiMyGtLNI0cVGjM7U8320d3cV9L
         JxKLlWe/bDSY/GgFeePkdVPrCV+NZibAEAwS4zsS3KYGfXPgeBTvEVMRJ3RK419Hn/MN
         sE41F434eXaMq8yFrV8mjgqFlKstFjRqHVFQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O19OVUmKX+OatpTnEx2U4M6GnjJTDDCO8nNhpR1gr+U=;
        b=hxSZVJhOMDiyi6TbirLdNvHCjigVRZdb8f5DPQwO6tkF2j9UL2C2N/OxV/ClRvdpyo
         mseLgzzNLfzQ5v31eM6dELZdBKzMEw5/eJcB+PoGfHZsd2NWMmVEyDV/CN5t4fr/h/cb
         fyybgWHrYcEkTXqXxmVtrKmXW3T2hCIlvTvt+BlgeiL9aq7Q9hl1lYlaAfdbBqAIqs3n
         ujL7gms6Yt9bYhVEKTJpBABX3QQFGPXNIRmDAB3vl0n/rAhmu52jmB/bI8Tyehr4euA+
         T5UMqSZwIZURqdPDaDYoa/RpIuqr4jX0jToAtJaH83JfAEqpI1U+/H9J4W4UCvZo78c6
         oSBw==
X-Gm-Message-State: AOAM532E9+VGbEpxQdDmY/5EQ/KHo3Jj0p9tUQQePC/ou2ZWgcIcjzgd
        SkeA9vqSLmH8tZHyT6HXhZI34A==
X-Google-Smtp-Source: ABdhPJz9xRiT9tNpBXV6BTuNLW1W3j8W0pT2+ejHISCsnJyOhHDvmUe9/eBvJ8kEdeTc+v9S1nwD0w==
X-Received: by 2002:a63:1157:: with SMTP id 23mr12968428pgr.25.1619034556055;
        Wed, 21 Apr 2021 12:49:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k19sm200050pgl.1.2021.04.21.12.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:49:15 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:49:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>, kjlu@umn.edu,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>,
        Nicolai Stange <nstange@suse.de>,
        Roland Dreier <roland@purestorage.com>
Subject: Re: [PATCH 113/190] Revert "x86/hpet: Prevent potential NULL pointer
 dereference"
Message-ID: <202104211245.F5FEC8D15D@keescook>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-114-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-114-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:48PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 2e84f116afca3719c9d0a1a78b47b48f75fd5724.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kjlu@umn.edu
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Nicolai Stange <nstange@suse.de>
> Cc: Roland Dreier <roland@purestorage.com>
> Cc: https
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/kernel/hpet.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index 08651a4e6aa0..0515a97bf6f5 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -930,8 +930,6 @@ int __init hpet_enable(void)
>  		return 0;
>  
>  	hpet_set_mapping();
> -	if (!hpet_virt_address)
> -		return 0;
>  
>  	/* Validate that the config register is working */
>  	if (!hpet_cfg_working())

FWIW, this patch looks harmless. It is checking for a failure in
hpet_set_mapping(), and avoids the following code from performing
0-offset reads. hpet_set_mapping() is likely to never fail in real-world
situations. *shrug*

I think it would make more sense for the check to live in
hpet_cfg_working(), though.

-- 
Kees Cook
