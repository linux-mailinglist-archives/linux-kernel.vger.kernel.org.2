Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4E425614
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbhJGPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:08:22 -0400
Received: from marcansoft.com ([212.63.210.85]:41906 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242244AbhJGPIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:08:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 40A363FA60;
        Thu,  7 Oct 2021 15:06:25 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: add myself to ARM/APPLE MACHINE
To:     Sven Peter <sven@svenpeter.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211007053430.51319-1-sven@svenpeter.dev>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <6fa58793-427c-6b16-0910-38801cfba377@marcan.st>
Date:   Fri, 8 Oct 2021 00:06:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007053430.51319-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2021 14.34, Sven Peter wrote:
> Hector suggested I should add myself to help him maintain the
> platform.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 329d3a0a9fdb..448e82566d63 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1727,6 +1727,7 @@ F:	drivers/*/*alpine*
>   
>   ARM/APPLE MACHINE SUPPORT
>   M:	Hector Martin <marcan@marcan.st>
> +M:	Sven Peter <sven@svenpeter.dev>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   W:	https://asahilinux.org

Acked-by: Hector Martin <marcan@marcan.st>

Thanks for signing up! :-)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
