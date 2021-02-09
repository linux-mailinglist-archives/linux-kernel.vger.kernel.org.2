Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1D315545
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhBIRjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhBIRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:36:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1041FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 09:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Xo7XyHvMTDXEt/s7IZOh7pRGS7mOTP+ADw1RfpB6oT0=; b=QosAN4Q/U1UNUh0klToH9fA++S
        2zFN0hY1m6qduLhCkbUgOhTD4p16f6mrlZaynaMaCnIz9wW+NKqSVnjMOd9toGdhxXS7f1b67KoHb
        AouSTnnSCYyBcXrddZ7y+OtauCOriMcR5Tlf9KXIb8GB11te50RJOWkvpLZKa8vXI4sTydZJy7Sw7
        s5wbcbeUvXsG0VZS8WD3Qwi3UqF134CKXphxA9ejTmf5Do5XCktBKe2rnskihKBlB3e53DRWe77uF
        OuBy0NKdTD3P5RvN0Rz6spI6e90Qiagwxh5TMSWXCYLfkHCin7IdCDaEQ3lalMrYUkvNDbadBdlK7
        M7shtH+w==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9Wvl-0008DO-HE; Tue, 09 Feb 2021 17:36:05 +0000
Subject: Re: [PATCH v2] mm: cma: Print region name on failure
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     pdaly@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210209142414.12768-1-georgi.djakov@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7caf3642-4283-4288-45c1-fcbd17d8c84b@infradead.org>
Date:   Tue, 9 Feb 2021 09:36:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209142414.12768-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 6:24 AM, Georgi Djakov wrote:
> From: Patrick Daly <pdaly@codeaurora.org>
> 
> Print the name of the CMA region for convenience. This is useful
> information to have when cma_alloc() fails.
> 
> Signed-off-by: Patrick Daly <pdaly@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v2:
>  * Print the "count" variable, as it was originally in the code. (Randy)
>  * Fix spelling s/convienience/convenience/ in the commit text (Randy)
> 
> v1: https://lore.kernel.org/r/20210208115200.20286-1-georgi.djakov@linaro.org/
> 
>  mm/cma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 23d4a97c834a..54eee2119822 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -500,8 +500,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  	}
>  
>  	if (ret && !no_warn) {
> -		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
> -			__func__, count, ret);
> +		pr_err("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
> +		       __func__, cma->name, count, ret);
>  		cma_debug_show_areas(cma);
>  	}
>  
> 


-- 
~Randy

