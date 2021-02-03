Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E250030DFD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhBCQf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhBCQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:35:11 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80AFC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 08:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=GmYMNHTsJklH1Fxq78vOuT9014qZSaw9UoGazr/WP5Y=; b=0BU5fJYLPGQOuGhl97HJuDHwaY
        uvyhzetaHTNTn/HkffpTnslMIk1ZfxWWwR5veIvvXJ0a2g40S/j5gGww6cLB8Em1/bGAf82jIDXL6
        iq87+x6WHCm9R5b6SDD3d4er3wsjwZdBxadYTF5h2t6xqkX177i9wLpylvGKVu+MhbL3RIuox96yW
        PMDDdG3ulRNySvuY4shB4GTMFUa4evIUlmu/6l2feRFcYCCsVPmtjVFUgue6peRVucBCtWnDN1FFf
        WS8MYeIVJxxTufRF8bhk8NWM8wcQxYeFl9Tek9oEv0mjBoTVuIAL9iyuMUk9E2xLxEqRm+EulSgB9
        1nBi1nhg==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7L6q-0002E0-MU; Wed, 03 Feb 2021 16:34:29 +0000
Subject: Re: [PATCH] nvmem: Kconfig: Correct typo in NVMEM_RMEM
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210203102932.7277-1-nsaenzjulienne@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <79c10761-5383-0c9c-0181-ab37d93b2f79@infradead.org>
Date:   Wed, 3 Feb 2021 08:34:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203102932.7277-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 2:29 AM, Nicolas Saenz Julienne wrote:
> s/drivers/driver/ as the configuration selects a single driver.
> 
> Fixes: 2bf4fd065384 ("nvmem: Add driver to expose reserved memory as nvmem")
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/nvmem/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index fecc19b884bf..75d2594c16e1 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -273,7 +273,7 @@ config SPRD_EFUSE
>  config NVMEM_RMEM
>  	tristate "Reserved Memory Based Driver Support"
>  	help
> -	  This drivers maps reserved memory into an nvmem device. It might be
> +	  This driver maps reserved memory into an nvmem device. It might be
>  	  useful to expose information left by firmware in memory.
>  
>  	  This driver can also be built as a module. If so, the module
> 


-- 
~Randy
