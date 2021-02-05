Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E680310E73
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhBEPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhBEPcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:32:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF652C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ybzs5M9VwDbwUj6k5lPBL4Ca11AeEu/EwDa9UlZ0t70=; b=doC3i5RpbQycKNC0QJYSnIayOu
        +skUEQCnmisvs3jSuHeMQtPHzNbtq5v6IyTl3nPs/LqF+5jxXUpWwNF2T3XMeRpaqp/86NmmxywmS
        EF7zB/nxQaIh4Sc88qaVwGh680lVT1HAGDhobbpdwNFubItSdpfGI7Ftf9xJPNfT4sVN1avz4dO2h
        GTrhKksrIj9l4Oht0TFIoyW0cxAdcdjcX4ubXF7BHdlP1slCABzgRPiT9K5pnowaJXcnNjGk0qFb0
        eCpgrYSlQyw88sfyy1HqgfYbhIdUqiu5p1soLMMW9QRbmhbnXtsek8CNYoAZoTJHu5d+7ASzczf0V
        ItO8B0Lg==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l84gQ-000383-Cg; Fri, 05 Feb 2021 17:14:14 +0000
Subject: Re: [PATCH] drivers: mfd: Spelling fixes in the file max77620.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
References: <20210205085456.369049-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eaf48b69-3caf-dfc3-e54b-ff1f159e2efd@infradead.org>
Date:   Fri, 5 Feb 2021 09:14:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210205085456.369049-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 12:54 AM, Bhaskar Chowdhury wrote:
> 
> 
> s/Teminology/Terminology/
> s/confguration/configuration/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  drivers/mfd/max77620.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> index fec2096474ad..429f7fbe92bc 100644
> --- a/drivers/mfd/max77620.c
> +++ b/drivers/mfd/max77620.c
> @@ -10,7 +10,7 @@
>   *	Mallikarjun Kasoju <mkasoju@nvidia.com>
>   */
> 
> -/****************** Teminology used in driver ********************
> +/****************** Terminology used in driver ********************
>   * Here are some terminology used from datasheet for quick reference:
>   * Flexible Power Sequence (FPS):
>   * The Flexible Power Sequencer (FPS) allows each regulator to power up under
> @@ -20,7 +20,7 @@
>   * be programmed to be part of a sequence allowing external regulators to be
>   * sequenced along with internal regulators. 32KHz clock can be programmed to
>   * be part of a sequence.
> - * There is 3 FPS confguration registers and all resources are configured to
> + * There is 3 FPS configuration registers and all resources are configured to
>   * any of these FPS or no FPS.
>   */
> 
> --
> 2.30.0
> 


-- 
~Randy

