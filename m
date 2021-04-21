Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4929B366CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbhDUNZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242787AbhDUNYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:24:15 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99BC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:23:11 -0700 (PDT)
Received: from [IPv6:2003:e9:d726:bdfb:8a40:d84b:ef70:faa6] (p200300e9d726bdfb8a40d84bef70faa6.dip0.t-ipconnect.de [IPv6:2003:e9:d726:bdfb:8a40:d84b:ef70:faa6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id C287CC024A;
        Wed, 21 Apr 2021 15:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1619011387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=76xUzmq2IlI3oC/OVcv8QsY4bL71v/ZDnHYxYGU1Qq8=;
        b=tJKyixubNuZsGdZHPFY6Cuk2SKfbwFesepGKDExkDi8hJs6/HXS0Y87o+eV/WGg3ZAk9iv
        2LCL+bASXsRfjBhVgdH8OoE59s/nw0uHwh26TuCDURbcXoiBuyR/++7tQQW2rn2KKsa4q7
        UTSvn+Fi0Dk4twJ4egTk6ioCiIycKYgvoLIcuoAq19zlTqRypE7uXzWcxs/IQOqhOuKCCJ
        oP+faEXZRBhfbq2kCmGQ5jqFRn9eDb46Cjahbjj3aRSjCpgfugMk9K/8USzKJZMk56KPUp
        j/LqRmaey20XPTg9SAZqRl4xuQ1QvsICBrWZpRoOi28+ZXu77hax1NUN0PA2hA==
Subject: Re: [PATCH 084/190] Revert "net: ieee802154: fix missing checks for
 regmap_update_bits"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Mukesh Ojha <mojha@codeaurora.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-85-gregkh@linuxfoundation.org>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <4e9dad99-8a88-a617-33be-0cb17824bc62@datenfreihafen.org>
Date:   Wed, 21 Apr 2021 15:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-85-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 21.04.21 14:59, Greg Kroah-Hartman wrote:
> This reverts commit 22e8860cf8f777fbf6a83f2fb7127f682a8e9de4.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/net/ieee802154/mcr20a.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index 8dc04e2590b1..2ce5b41983f8 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -524,8 +524,6 @@ mcr20a_start(struct ieee802154_hw *hw)
>   	dev_dbg(printdev(lp), "no slotted operation\n");
>   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>   				 DAR_PHY_CTRL1_SLOTTED, 0x0);
> -	if (ret < 0)
> -		return ret;
>   
>   	/* enable irq */
>   	enable_irq(lp->spi->irq);
> @@ -533,15 +531,11 @@ mcr20a_start(struct ieee802154_hw *hw)
>   	/* Unmask SEQ interrupt */
>   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
>   				 DAR_PHY_CTRL2_SEQMSK, 0x0);
> -	if (ret < 0)
> -		return ret;
>   
>   	/* Start the RX sequence */
>   	dev_dbg(printdev(lp), "start the RX sequence\n");
>   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>   				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
> -	if (ret < 0)
> -		return ret;
>   
>   	return 0;
>   }
> 


Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
