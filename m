Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8213F447DE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhKHK0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhKHK0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:26:50 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3F8C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FXPBoj/ZN1gsxRPPoqUbYPnrlaqbLV0OQZqAiF+kw8w=;
        t=1636367046; x=1637576646; b=ZKuOoFni55WI7nbQzGWvOtU6pH9/xZ1HS5RcoiRRx4pFuEO
        8J9oNj4jE5MgUJ8q2U5CqwfBmAxgxw7BXW7NRkGqhH5xuMZfO6ypF165K1pSd78BoiLBwMlKPA2Iy
        ijy0szqj0Z/k2XA7z43wQdGNtqj5uxFEx11HmEtGtlNFWPYTEZrUYaFk8+7qcnxEXL1IhcPrJxfVb
        nebRklMK32CmvnKoxIRFdDVozvPl2IWaREDc4bci+D8cf83zGLk9oqeamDAyoQfwf46p87UtG7ke5
        3kiOzv1QyK2biwpZaJprM9ZVlkW/T3nAXN/i5xJZUqQp7gSwoHVJNMmm+v4ynZIg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mk1om-00CVSY-1x;
        Mon, 08 Nov 2021 11:24:00 +0100
Message-ID: <129beb0a860102ba7970ab7497a5a83fe2041e68.camel@sipsolutions.net>
Subject: Re: [PATCH v0 25/42] arch/um: Check notifier registration return
 value
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     linux-um@lists.infradead.org
Date:   Mon, 08 Nov 2021 11:23:59 +0100
In-Reply-To: <20211108101157.15189-26-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
         <20211108101157.15189-26-bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-08 at 11:11 +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Avoid homegrown notifier registration checks.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: linux-um@lists.infradead.org
> ---
>  arch/um/drivers/mconsole_kern.c | 6 ++++--
>  arch/um/kernel/um_arch.c        | 5 +++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
> index 6ead1e240457..ceea940c0aa0 100644
> --- a/arch/um/drivers/mconsole_kern.c
> +++ b/arch/um/drivers/mconsole_kern.c
> @@ -856,8 +856,10 @@ static struct notifier_block panic_exit_notifier = {
>  
> 
>  static int add_notifier(void)
>  {
> -	atomic_notifier_chain_register(&panic_notifier_list,
> -			&panic_exit_notifier);
> +	if (atomic_notifier_chain_register(&panic_notifier_list,
> +					   &panic_exit_notifier))
> +		pr_warn("UM console panic notifier already registered\n");
> +
>  	return 0;

Maybe it should just return it? I don't see how this is ever possible,
since it's an initcall.

johannes

