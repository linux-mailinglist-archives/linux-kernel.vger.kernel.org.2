Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C3C344F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhCVTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbhCVTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:00:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8F5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=2EJyJcrq06gm3q/Jdx7dDHzPtIm0aUhTMkX60JDg6g0=; b=ay+4yFF+i6CBiMEA4/WsQ0vM90
        oonwhXHrSUzuXF4uBOLEU6ZkKgy4VhB5tLF2OET8X6a6qs6VBiL/xIrbINRIZeEJpjaIbLps+glMz
        gAPJGv5KL8HurcKgN41c0p56GSYyt0vJGIysm5Vc7RakHhKkjCZ+yO9WtY+LBVoR1joVqk1ogF1jq
        FZJIenYCTLHrGppch151kJTaebwVBXGuPCmtfUES+EHas7cadKh+SCfN6HdGS1PrPfbUE7MKCvgmG
        WF9wICxTEVpwQKJMVu7VwtB2TAvdou9IGWA2yxF3lOVOQdif32dOea8Pe7LW2FOHoLysHh01B2IB2
        R15XDjGg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPlI-008wiR-Ca; Mon, 22 Mar 2021 18:59:01 +0000
Subject: Re: [PATCH] arch: arc: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, vgupta@synopsys.com,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210322122819.2704169-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ff40ae9d-60e7-5c41-0271-6edc5906b219@infradead.org>
Date:   Mon, 22 Mar 2021 11:58:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322122819.2704169-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:28 AM, Bhaskar Chowdhury wrote:
> 
> s/defintion/definition/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/arc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arc/Makefile b/arch/arc/Makefile
> index 4392c9c189c4..e47adc97a89b 100644
> --- a/arch/arc/Makefile
> +++ b/arch/arc/Makefile
> @@ -31,7 +31,7 @@ endif
> 
> 
>  ifdef CONFIG_ARC_CURR_IN_REG
> -# For a global register defintion, make sure it gets passed to every file
> +# For a global register definition, make sure it gets passed to every file
>  # We had a customer reported bug where some code built in kernel was NOT using
>  # any kernel headers, and missing the r25 global register
>  # Can't do unconditionally because of recursive include issues
> --


-- 
~Randy

