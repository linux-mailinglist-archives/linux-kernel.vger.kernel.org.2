Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5D344F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhCVTHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhCVTGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:06:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFE2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=7cfe1JlfISFX8pOM6sDgLHDUaW5DqJpnJyz+DMnS2oc=; b=vwIzuJxLpV2id+3LLa0TgwM4mG
        HLBTRpNOjzhXsv5Ck3D5NOqb0/jTyghHqAsgeWlSZ9F3tbesS8AF6EGeNPF9kZgu9C8xp5IG6uRIW
        rzWXtcOmxvrO2KN60yqt4aRaEpW28QAJs1PpdoLdGH8cDUaNuaPfDJFpT/MifEOe2wyGxO05rL/nE
        ED61B7UERG3eD19GYf9ZBdsV0GmqlHDGdZx5VQHk8x42iFY6wU7UX2tCUg+ROxMPeCjkggFIlXyDw
        5dO8XBQAtZC67EmcW2pof32cPLlSwPBfXSYJCvVAO0fLuVcOLX+ZrcKbcQ0y3Xf9GtBOevmPD6zsv
        0nBfc4/g==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOPsC-008xAA-J3; Mon, 22 Mar 2021 19:06:16 +0000
Subject: Re: [PATCH] irqdomain: Couple of typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, maz@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20210322120017.2084799-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a21dd076-5ea7-0148-fa92-8151f94b3a88@infradead.org>
Date:   Mon, 22 Mar 2021 12:05:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322120017.2084799-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:00 AM, Bhaskar Chowdhury wrote:
> s/nececssary/necessary/ ....two different places
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  kernel/irq/irqdomain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index d10ab1d689d5..349adef40c9d 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +\// SPDX-License-Identifier: GPL-2.0

What is the above change supposed to be?

> 
>  #define pr_fmt(fmt)  "irq: " fmt
> 
> @@ -665,7 +665,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
> 
>  	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
> 
> -	/* Look for default domain if nececssary */
> +	/* Look for default domain if necessary */
>  	if (domain == NULL)
>  		domain = irq_default_domain;
>  	if (domain == NULL) {
> @@ -906,7 +906,7 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
>  {
>  	struct irq_data *data;
> 
> -	/* Look for default domain if nececssary */
> +	/* Look for default domain if necessary */
>  	if (domain == NULL)
>  		domain = irq_default_domain;
>  	if (domain == NULL)
> --


-- 
~Randy

