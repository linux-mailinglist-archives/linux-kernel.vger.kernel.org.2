Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03236F748
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhD3IqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:46:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51493 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhD3IqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:46:05 -0400
Received: from 223-138-45-215.emome-ip.hinet.net ([223.138.45.215] helo=[192.168.43.35])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <ike.pan@canonical.com>)
        id 1lcOlq-0001ON-Eg; Fri, 30 Apr 2021 08:45:13 +0000
Subject: Re: [PATCH] platform/x86: ideapad-laptop: fix a NULL pointer
 dereference
To:     Qiu Wenbo <qiuwenbo@kylinos.com.cn>, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210428050636.8003-1-qiuwenbo@kylinos.com.cn>
From:   Ike Panhc <ike.pan@canonical.com>
Message-ID: <a95f27a5-bc5a-a195-09e4-db56d024629e@canonical.com>
Date:   Fri, 30 Apr 2021 16:45:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210428050636.8003-1-qiuwenbo@kylinos.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/21 1:06 PM, Qiu Wenbo wrote:
> The third parameter of dytc_cql_command should not be NULL since it will
> be dereferenced immediately.
> 
> Signed-off-by: Qiu Wenbo <qiuwenbo@kylinos.com.cn>

Fixes: ff36b0d953dc4 ("platform/x86: ideapad-laptop: rework and create new ACPI helpers")
Acked-by: Ike Panhc <ike.pan@canonical.com>

> ---
>  drivers/platform/x86/ideapad-laptop.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 6cb5ad4be231..8f871151f0cc 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -809,6 +809,7 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>  {
>  	struct ideapad_dytc_priv *dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
>  	struct ideapad_private *priv = dytc->priv;
> +	unsigned long output;
>  	int err;
>  
>  	err = mutex_lock_interruptible(&dytc->mutex);
> @@ -829,7 +830,7 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>  
>  		/* Determine if we are in CQL mode. This alters the commands we do */
>  		err = dytc_cql_command(priv, DYTC_SET_COMMAND(DYTC_FUNCTION_MMC, perfmode, 1),
> -				       NULL);
> +				       &output);
>  		if (err)
>  			goto unlock;
>  	}
> 

