Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D72339BDE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 06:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhCME75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 23:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCME7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:59:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C78C061574;
        Fri, 12 Mar 2021 20:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=vYdsOoPiENgm1KSFxe3mEMrAb7vGMVrT+CqhsCQ6zM8=; b=SAVR/XDs4hBX7L2s2Dg8zmauRX
        0O6n4vCA/zf4x+h2oAkS3cWmj8osYOWtHDk+ZgOvpLv1Kqx29AIgnSUieCtdCQqBK54Q8StYC/xb1
        kTQ2G0daWcwtajg9d/uqrxY8ohUPg8RRT8nC99mR+Cl/Xr8bdwdbZ/O4/HAg2/HDLfD9WfZ0m35gd
        GPyhlCVtLJOuvt7v8K7I2vkjkQTg5HHNhzpfNmYnfeR4/jyLw/oltGbu8LXzUCg4WMEjbE9KXKZQ0
        vGbnjuKsxijolyj5GwX8LfSi9pxEZn038Xl/oO8MoihayRkljOv6ag2tkQYQleHa55m6SSUJSbe4L
        9kkJRM7A==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKwNI-0017U6-AF; Sat, 13 Mar 2021 04:59:40 +0000
Subject: Re: [PATCH] ia64: include: asm: Minor typo fixes in the file
 pgtable.h
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rppt@kernel.org,
        akpm@linux-foundation.org, deller@gmx.de, shorne@gmail.com,
        anshuman.khandual@arm.com, jrtc27@jrtc27.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210313045519.9310-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8804bf7a-6fb9-6eff-2461-f1a31e444ac7@infradead.org>
Date:   Fri, 12 Mar 2021 20:59:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210313045519.9310-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 8:55 PM, Bhaskar Chowdhury wrote:
> 
> s/migraton/migration/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  arch/ia64/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
> index 9b4efe89e62d..00a76ed7e018 100644
> --- a/arch/ia64/include/asm/pgtable.h
> +++ b/arch/ia64/include/asm/pgtable.h
> @@ -328,7 +328,7 @@ extern void __ia64_sync_icache_dcache(pte_t pteval);
>  static inline void set_pte(pte_t *ptep, pte_t pteval)
>  {
>  	/* page is present && page is user  && page is executable
> -	 * && (page swapin or new page or page migraton
> +	 * && (page swapin or new page or page migration
>  	 *	|| copy_on_write with page copying.)
>  	 */
>  	if (pte_present_exec_user(pteval) &&
> --


-- 
~Randy

