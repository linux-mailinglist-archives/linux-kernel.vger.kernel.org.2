Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3872433CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhJSQvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhJSQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:51:29 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3FDC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:49:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0715B41ECC;
        Tue, 19 Oct 2021 16:49:12 +0000 (UTC)
Subject: Re: [PATCH] iommu/dart: Initialize DART_STREAMS_ENABLE
To:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>
Cc:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik@protonmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20211019162253.45919-1-sven@svenpeter.dev>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <e73c6976-7dac-3ee1-7f96-1e9c1829463f@marcan.st>
Date:   Wed, 20 Oct 2021 01:49:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019162253.45919-1-sven@svenpeter.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2021 01.22, Sven Peter wrote:
> DART has an additional global register to control which streams are
> isolated. This register is a bit redundant since DART_TCR can already
> be used to control isolation and is usually initialized to DART_STREAM_ALL
> by the time we get control. Some DARTs (namely the one used for the audio
> controller) however have some streams disabled initially. Make sure those
> work by initializing DART_STREAMS_ENABLE during reset.
> 
> Reported-by: Martin Povišer <povik@protonmail.com>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> 
> While this could technically count as a fix I don't think it needs to go to
> 5.15 since no driver that requires this is in there. The first driver
> that needs this will likely only be ready for the 5.17 merge window.
> 
>   drivers/iommu/apple-dart.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index ce92195db638..6f8c240d8d40 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -70,6 +70,8 @@
>   #define DART_ERROR_ADDR_HI 0x54
>   #define DART_ERROR_ADDR_LO 0x50
>   
> +#define DART_STREAMS_ENABLE 0xfc
> +
>   #define DART_TCR(sid) (0x100 + 4 * (sid))
>   #define DART_TCR_TRANSLATE_ENABLE BIT(7)
>   #define DART_TCR_BYPASS0_ENABLE BIT(8)
> @@ -299,6 +301,9 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
>   	apple_dart_hw_disable_dma(&stream_map);
>   	apple_dart_hw_clear_all_ttbrs(&stream_map);
>   
> +	/* enable all streams globally since TCR is used to control isolation */
> +	writel(DART_STREAM_ALL, dart->regs + DART_STREAMS_ENABLE);
> +
>   	/* clear any pending errors before the interrupt is unmasked */
>   	writel(readl(dart->regs + DART_ERROR), dart->regs + DART_ERROR);
>   
> 

Reviewed-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
