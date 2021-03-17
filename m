Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B98B33F6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCQR0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCQRZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:25:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F83C06174A;
        Wed, 17 Mar 2021 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=OC5ns7Q2lAq5rjOh5Mg0dRoImkJNwBQe+BgcvqUEvmA=; b=ahwdZsuDAcl6wq9mDEDkas2iCd
        xRP06FZFnziIc49o5aHDSdOgb4A6mcIKovW32MpMM5LQPdX9XBK/mkI5qAI1GUHQTDqskwfmna7ZZ
        +KeNlOri8SrhljsPWkPPFig7xRLW11MvFklyQdM5pcBmX8ZMO9iV/+KjPXztmyCsmakERZkOzCkPW
        gxXNoPm5GPU0KnHC+KcPM9/tzYupKjE11A8GY2ENW4yzbY+MQz7D3snkbV2G26CQtH5yP24GSOw9e
        hdv5GRD5W/afstuUyTsNUL0F0KAKZaumRvvRJPbaF2TBvmdRq7i3hskahWRRk/GIueozsi6Nbd6cC
        NWNtBhtg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZvY-001fPf-5e; Wed, 17 Mar 2021 17:25:48 +0000
Subject: Re: [PATCH] platform: x86: Typo fix in the file classmate-laptop.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, cascardo@holoscopio.com,
        don@syst.com.br, hdegoede@redhat.com, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317084343.3788084-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb527fe8-3039-f02b-a206-054386e1b647@infradead.org>
Date:   Wed, 17 Mar 2021 10:25:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317084343.3788084-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 1:43 AM, Bhaskar Chowdhury wrote:
> 
> s/derefence/dereference/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/platform/x86/classmate-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
> index 3e03e8d3a07f..9309ab5792cb 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -956,7 +956,7 @@ static int cmpc_ipml_add(struct acpi_device *acpi)
>  	/*
>  	 * If RFKILL is disabled, rfkill_alloc will return ERR_PTR(-ENODEV).
>  	 * This is OK, however, since all other uses of the device will not
> -	 * derefence it.
> +	 * dereference it.
>  	 */
>  	if (ipml->rf) {
>  		retval = rfkill_register(ipml->rf);
> --


-- 
~Randy

