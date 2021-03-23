Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C302346B95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhCWWBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhCWWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:01:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CF9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ssQLO61WHzovjKdnPCoQmV/RGBUr6XLqwV8AQTum3tk=; b=Kcj1d5rLpAV7WflXzEaGjSTP+G
        d2J5YGat7mhoq73KQEBTp3/FSD2FSZ2q0ObEXdF07h1i4JWGCxRHOsQCJi9/+X+vurzmx2EI1xBgb
        /eqxBFXYjohMRhrTcBPwPwvHKM1T7/z3IDcB5a+bf8uYbtyCUh0FmR04W/9XARi7VNZxGQZIpdHGJ
        pe4GN3IlhX28Ci9qbKM3ZWDqPn3jKEt23XOXaHWiZP/Dzu0/MHe/SpiqXHOlfJ/awELtSVV13Z9N+
        J7QHMdw4qTc6/KMKn092+atTxpkf86H33+gpNQdd4JQxVFnewZYbTQTmOX6k4Bx5JuHFOqY7v2WsD
        DyZN7dQA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOp5Q-00FohT-6E; Tue, 23 Mar 2021 22:01:17 +0000
Subject: Re: [PATCH] macintosh: A typo fix
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210323204652.23059-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d01060e9-8986-c23b-71d3-ada645500186@infradead.org>
Date:   Tue, 23 Mar 2021 15:01:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323204652.23059-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 1:46 PM, Bhaskar Chowdhury wrote:
> 
> s/coment/comment/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/macintosh/windfarm_smu_controls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
> index 79cb1ad09bfd..75966052819a 100644
> --- a/drivers/macintosh/windfarm_smu_controls.c
> +++ b/drivers/macintosh/windfarm_smu_controls.c
> @@ -94,7 +94,7 @@ static int smu_set_fan(int pwm, u8 id, u16 value)
>  		return rc;
>  	wait_for_completion(&comp);
> 
> -	/* Handle fallback (see coment above) */
> +	/* Handle fallback (see comment above) */
>  	if (cmd.status != 0 && smu_supports_new_fans_ops) {
>  		printk(KERN_WARNING "windfarm: SMU failed new fan command "
>  		       "falling back to old method\n");
> --


-- 
~Randy

