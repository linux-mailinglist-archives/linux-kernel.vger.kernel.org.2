Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4913F9290
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 05:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbhH0DBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 23:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhH0DBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 23:01:11 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC71C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 20:00:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6A50C41F5D;
        Fri, 27 Aug 2021 03:00:18 +0000 (UTC)
Subject: Re: [PATCH] maintainers: Add Alyssa Rosenzweig as M1 reviewer
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>
References: <20210823151738.6273-1-alyssa@rosenzweig.io>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <3112bc2c-7c6a-3190-26cd-a873b4029429@marcan.st>
Date:   Fri, 27 Aug 2021 12:00:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210823151738.6273-1-alyssa@rosenzweig.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2021 00.17, Alyssa Rosenzweig wrote:
> Add myself as a reviewer for Asahi Linux (Apple M1) patches.
> 
> I would like to be CC'ed on Asahi Linux patches for review and testing.
> I am also collecting Asahi Linux patches downstream, rebasing on
> linux-next periodically, and would like to be notified of what to
> cherry-pick from lists.
> 
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Sven Peter <sven@svenpeter.dev>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b63403793c81..399e536bf629 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1264,6 +1264,7 @@ F:	drivers/input/mouse/bcm5974.c
>   
>   APPLE DART IOMMU DRIVER
>   M:	Sven Peter <sven@svenpeter.dev>
> +R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
>   L:	iommu@lists.linux-foundation.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
> @@ -1693,6 +1694,7 @@ F:	drivers/*/*alpine*
>   
>   ARM/APPLE MACHINE SUPPORT
>   M:	Hector Martin <marcan@marcan.st>
> +R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   W:	https://asahilinux.org
> 

Acked-by: Hector Martin <marcan@marcan.st>

P.S. fix your mail server, I had to pull this from the list and I doubt 
I'm the only one ;)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
