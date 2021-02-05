Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50686310E60
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhBEP2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhBEP1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:27:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA12C0617AA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=RGGYFhSCjVKXxXnySIK8TUEokRVKxSe6BrRzQn1bAdA=; b=U/se1uRT/EtcqRjZlrfb49ANZ4
        68AYoGg4/x5MX9l47aMuEKa+mmdD8z/y6DSKHp15Ib+hOOp74luWjYnwoY8dTgHKeXJtDZyHVZz35
        weQo5X577hiRZG9HXCFla1KAQcYFvxC7ukCMQxB0ezTmdk26TTIYyZg/A4a0ZasEdU8jkrcHsT7Lr
        NdxGkuL/sm1SSJbwrTjSExwoMZUczLk+R2VoOuHuHnM+8/Yw+IZ4FngkLdbwZ87TKX8luAzQwxpXB
        5W7HfygK4dpiBaZ6LUtnjFDknI5nmGmknnuExS8B97z+fGieRZkonQxsbtRJN3BvwLvtmvO0HI8IZ
        u77dvp7w==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l84S8-0001NG-4m; Fri, 05 Feb 2021 16:59:28 +0000
Subject: Re: [PATCH] arch: arm: mach-imx: Fix a spelling in the file pm-imx5.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, linux@armlinux.org.uk,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, yukuai3@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210205083831.339095-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9d6844e6-b610-652f-d375-05be7a10c157@infradead.org>
Date:   Fri, 5 Feb 2021 08:59:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210205083831.339095-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 12:38 AM, Bhaskar Chowdhury wrote:
> 
> s/confgiured/configured/
> 
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  arch/arm/mach-imx/pm-imx5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
> index e9962b48e30c..2e3af2bc7758 100644
> --- a/arch/arm/mach-imx/pm-imx5.c
> +++ b/arch/arm/mach-imx/pm-imx5.c
> @@ -45,7 +45,7 @@
>   * This is also the lowest power state possible without affecting
>   * non-cpu parts of the system.  For these reasons, imx5 should default
>   * to always using this state for cpu idling.  The PM_SUSPEND_STANDBY also
> - * uses this state and needs to take no action when registers remain confgiured
> + * uses this state and needs to take no action when registers remain configured
>   * for this state.
>   */
>  #define IMX5_DEFAULT_CPU_IDLE_STATE WAIT_UNCLOCKED_POWER_OFF
> --
> 2.30.0
> 


-- 
~Randy

