Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53C93812CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhENVYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhENVYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:24:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FA43613BB;
        Fri, 14 May 2021 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621027375;
        bh=0B3vRzqZ6K4f9UvjfOOfzoQhIiCFoDeVGmsMqIbrkJw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NasdIl1l9tT5rUPuIDMyvvfYYcKOQmtML694FQkUFSaJdrwROCeX4kVrVqB3kqQl8
         e0yT5W8xzCBDInwJ8ssRxXTEX/YeuRdoq1VsNFEiFhRNENVDq5wydwdp8yaTWnS0XB
         rB1obsszE0sc052b0QoSwIe3ZaxG9Fr76AR10Kee+CyPISsvO2T2hKx60RMHWfP3AC
         FY4QYEtPhX0ImNwN/sWfQNvJ4i40gL8N/4O+OYYC2IFKNuAqvuW8owkfXT2CqTqC1q
         z2rjO4OA31GY6J8C7J9fO3kobVqN/TQu+67bY+3fNPB8nRh3p3sfpWvlxglaSWnuHs
         gwZvKaeJbhz5g==
Subject: Re: [PATCH] [v2] platform/surface: aggregator: avoid clang
 -Wconstant-conversion warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210514200453.1542978-1-arnd@kernel.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <057b5568-c4b8-820c-3dd7-2200f61a4d58@kernel.org>
Date:   Fri, 14 May 2021 14:22:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514200453.1542978-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2021 1:04 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Clang complains about the assignment of SSAM_ANY_IID to
> ssam_device_uid->instance:
> 
> drivers/platform/surface/surface_aggregator_registry.c:478:25: error: implicit conversion from 'int' to '__u8' (aka 'unsigned char') changes value from 65535 to 255 [-Werror,-Wconstant-conversion]
>          { SSAM_VDEV(HUB, 0x02, SSAM_ANY_IID, 0x00) },
>          ~                      ^~~~~~~~~~~~
> include/linux/surface_aggregator/device.h:71:23: note: expanded from macro 'SSAM_ANY_IID'
>   #define SSAM_ANY_IID            0xffff
>                                  ^~~~~~
> include/linux/surface_aggregator/device.h:126:63: note: expanded from macro 'SSAM_VDEV'
>          SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, tid, iid, fun)
>                                                                       ^~~
> include/linux/surface_aggregator/device.h:102:41: note: expanded from macro 'SSAM_DEVICE'
>          .instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,                        \
>                                                 ^~~
> 
> The assignment doesn't actually happen, but clang checks the type limits
> before checking whether this assignment is reached. Replace the ?:
> operator with a __builtin_choose_expr() invocation that avoids the
> warning for the untaken part.
> 
> Fixes: eb0e90a82098 ("platform/surface: aggregator: Add dedicated bus and device type")
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> v2: use __builtin_choose_expr() instead of a cast to shut up the warning
> ---
>   include/linux/surface_aggregator/device.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
> index 4441ad667c3f..6ff9c58b3e17 100644
> --- a/include/linux/surface_aggregator/device.h
> +++ b/include/linux/surface_aggregator/device.h
> @@ -98,9 +98,9 @@ struct ssam_device_uid {
>   		     | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),	\
>   	.domain   = d,								\
>   	.category = cat,							\
> -	.target   = ((tid) != SSAM_ANY_TID) ? (tid) : 0,			\
> -	.instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,			\
> -	.function = ((fun) != SSAM_ANY_FUN) ? (fun) : 0				\
> +	.target   = __builtin_choose_expr((tid) != SSAM_ANY_TID, (tid), 0),	\
> +	.instance = __builtin_choose_expr((iid) != SSAM_ANY_IID, (iid), 0),	\
> +	.function = __builtin_choose_expr((fun) != SSAM_ANY_FUN, (fun), 0)
>   
>   /**
>    * SSAM_VDEV() - Initialize a &struct ssam_device_id as virtual device with
> 

