Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C27319496
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhBKUgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhBKUgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:36:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89D7C64D73;
        Thu, 11 Feb 2021 20:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613075731;
        bh=09XWYIqyUCLDxvi5gQzO/ldzLZFs0vKFvLJwHYRvx2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqZTSeWhnVoY7SOKERAfHik04eTojWSyJI9La+60zSsB7NNWbmyB1AoTcvmYNseX9
         f75SCZMW7seTcfe4RvtQzTHv6Si7prB6NF9tUOcCTJ7NegQKmh1Y7b+Kzm9TgZ7GtG
         plby2Tgd/muiO8noNzKyyxDM85HmLjNs6Al4hlYc=
Date:   Thu, 11 Feb 2021 21:35:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     lee.jones@linaro.org, kuba@kernel.org, johannes@sipsolutions.net,
        colin.king@canonical.com, arnd@arndb.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax/i2400m: fix some byte order issues found
 by sparse
Message-ID: <YCWVD34rU5Lu71/S@kroah.com>
References: <20210211202908.4604-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211202908.4604-1-mail@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 01:59:08AM +0530, Anirudh Rayabharam wrote:
> Fix sparse byte-order warnings in the i2400m_bm_cmd_prepare()
> function:
> 
> wimax/i2400m/fw.c:194:36: warning: restricted __le32 degrades to integer
> wimax/i2400m/fw.c:195:34: warning: invalid assignment: +=
> wimax/i2400m/fw.c:195:34:    left side has type unsigned int
> wimax/i2400m/fw.c:195:34:    right side has type restricted __le32
> wimax/i2400m/fw.c:196:32: warning: restricted __le32 degrades to integer
> wimax/i2400m/fw.c:196:47: warning: restricted __le32 degrades to integer
> wimax/i2400m/fw.c:196:66: warning: restricted __le32 degrades to integer
> 
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>  drivers/staging/wimax/i2400m/fw.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wimax/i2400m/fw.c
> index b2fd4bd2c5f9..bce651a6b543 100644
> --- a/drivers/staging/wimax/i2400m/fw.c
> +++ b/drivers/staging/wimax/i2400m/fw.c
> @@ -189,12 +189,16 @@ void i2400m_bm_cmd_prepare(struct i2400m_bootrom_header *cmd)
>  {
>  	if (i2400m_brh_get_use_checksum(cmd)) {
>  		int i;
> -		u32 checksum = 0;
> +		__le32 checksum = 0;

__le32 is only for when the data crosses the kernel/user boundry, just
use le32 in the kernel for stuff like this.

>  		const u32 *checksum_ptr = (void *) cmd->payload;

Add a blank line here, right?

thanks,

greg k-h
