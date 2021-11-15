Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97F244FEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 07:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhKOGnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 01:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhKOGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 01:43:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79492C061766;
        Sun, 14 Nov 2021 22:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=MYduknSzCz2rCZxs6GbMLdGFkdcMbYHoRgSEau67hNY=; b=ek+9c7zClyORXLVjTPcGcKHAuR
        NZIHsfaExs7e9D7VkYYj3b+itIsDuWw5FCwnh98bsqanmC+kgxfY/pJNZZKpdAZmkogHITaGMeZbi
        ZgBalGw1CE7pOWjlsYwJGPpzuXJv2LlDTvOCQZiRfGmyNOuRauXGlNMGLcoEwbKnvXvjO48KUzeQk
        QaVPh9BLY3KBiR9AkF8NH6TMXNZgG6KF2FnliwhUI8Wwoaj+ILOa3pjVbnuQfAo+pbDPeII2euNK2
        DCbZbQRCHLE+AdN+B11bbqK9vs6EfeZIC1l9MjM+hu5N9NAd0xWt0By1NNJKJ3p4BV+Z1pBBilKDi
        lusBaGNw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmVfK-00EShs-28; Mon, 15 Nov 2021 06:40:30 +0000
Subject: Re: [PATCH] of: make MAX_RESERVED_REGIONS configurable
To:     Calvin Zhang <calvinzhang.cool@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211115063521.3457302-1-calvinzhang.cool@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <18eb2d82-d3b3-79ec-9c20-c5c5cf5cab52@infradead.org>
Date:   Sun, 14 Nov 2021 22:40:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115063521.3457302-1-calvinzhang.cool@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/21 10:35 PM, Calvin Zhang wrote:
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 80b5fd44ab1c..591b2c4d9dd0 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -73,6 +73,16 @@ config OF_IRQ
>   config OF_RESERVED_MEM
>   	def_bool OF_EARLY_FLATTREE
>   
> +config OF_MAX_RESERVED_REGIONS
> +    int "Maximum count of reserved regions"
> +    depends on OF_RESERVED_MEM
> +    default 64
> +    help
> +        Reserved regions in /reserved-memory node includes static
> +        reservations with fixed location and dynamic ones for device
> +        cma regions. This parameter sets the maximum number of reserved

	  CMA

(as is used in mm/Kconfig)

> +        regions in the system.

Also, all 4 lines of the help text should be indented with
one tab + 2 spaces, not all spaces.


thanks.
-- 
~Randy
