Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEED93209ED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 12:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBUL1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 06:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhBUL1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 06:27:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5397164EE6;
        Sun, 21 Feb 2021 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613906781;
        bh=kkFnXUKm0Rf2iX3RQtP2a5rmUIvBNUgXozmpS/vKma8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQjYtThi8Z6ofSATMneeTrITirVNKfdpTg78V0XP4ydEoy+MtQJ2NqkQeUVpneT8M
         zVNZRAr5CPLFQdXTbcfBEyyp/XhN/UTEwfsLc11OJHwKGS34uOh94Hsn+jfXmYU5yS
         p6pwjzM8lCvkOx9NLXE9NYs/dtKmFVo1LbAKBOcQ=
Date:   Sun, 21 Feb 2021 12:26:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthik alapati <mail@karthek.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax/i2400m: fix byte-order type issue
Message-ID: <YDJDW97X7k+mb/gE@kroah.com>
References: <YDEGD7pFyTi+CTXy@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDEGD7pFyTi+CTXy@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 06:22:31PM +0530, karthik alapati wrote:
> fix sparse type warning by converting le32 types to
> host byte-order types before comparison
> 
> Signed-off-by: karthik alapati <mail@karthek.com>
> ---
>  drivers/staging/wimax/i2400m/fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wimax/i2400m/fw.c
> index 92ea5c101..f09de1810 100644
> --- a/drivers/staging/wimax/i2400m/fw.c
> +++ b/drivers/staging/wimax/i2400m/fw.c
> @@ -511,7 +511,7 @@ ssize_t __i2400m_bm_ack_verify(struct i2400m *i2400m, int opcode,
>  			opcode, i2400m_brh_get_response(ack));
>  		goto error_ack_failed;
>  	}
> -	if (ack_size < ack->data_size + sizeof(*ack)) {
> +	if (ack_size < le32_to_cpu(ack->data_size) + sizeof(*ack)) {
>  		dev_err(dev, "boot-mode cmd %d: SW BUG "
>  			"driver provided only %zu bytes for %zu bytes "
>  			"of data\n", opcode, ack_size,

You sent 3 patches that seem to do the same thing, yet are a bit
different?

Please make your patches a patch series and provide proper subject lines
to make them unique.  I have now dropped all of your submitted patches
from my review queue.

thanks,

greg k-h
