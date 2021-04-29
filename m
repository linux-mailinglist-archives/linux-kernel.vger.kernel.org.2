Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25F36E7FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhD2J3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231883AbhD2J3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:29:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DDB36143F;
        Thu, 29 Apr 2021 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619688517;
        bh=AusVHjuIXgZgsTu2ipmvELfDJSLbFgoa7bi3g0WaxBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpPTYNIL+XTJSXbeyrXHP9wPpYYfS4jWfYX4UIwcPITvmohZFZCky1Qe+Lj8V3I0r
         zmk1luw3qXS6Dh6zmR9rLpz1EiMg6Yq0hh2NiGCGyEa1XVoJNQEOgS880ueJhceJPW
         fCiyu3QkrY/5jFYb0eF0jS7VOsqPnGZHBQJ+Se4MPin7oVv+JQhSep2DZnXmlOqERA
         mmNyL4oZFkWlubiBHMucVXJw4W1r+4DDo1eZHrVE85A79khp1MkzJjpYY1F/aqeQpC
         5zMWBAFv84A2rxWcKndwY1h13fm7tjSOlRbUWlzAyvSmyhuV1pL/OVU4k5Jwtp6+3y
         VwhdNl5ZOiozg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lc2yY-00084i-Mr; Thu, 29 Apr 2021 11:28:51 +0200
Date:   Thu, 29 Apr 2021 11:28:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
Cc:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix indentation of block comments
Message-ID: <YIp8UnL4big41DdL@hovoldconsulting.com>
References: <20210429085532.djej2ko2dttertt5@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429085532.djej2ko2dttertt5@sanjana-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:25:32PM +0530, Sanjana Srinidhi wrote:
> Trailing */ of block comments is moved to a new line to maintain code uniformity.
> 
> Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
> ---
>  drivers/pcmcia/soc_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
> index 98b6d96a4435..7a88bd9bd4ed 100644
> --- a/drivers/pcmcia/soc_common.c
> +++ b/drivers/pcmcia/soc_common.c
> @@ -28,7 +28,8 @@
>      the provisions above, a recipient may use your version of this
>      file under either the MPL or the GPL.
>  
> -======================================================================*/
> +======================================================================
> +*/

These kind of "cleanups" are mostly pointless and amount to nothing more
than noise.

Please consider working in drivers/staging/ which currently works as
some sort of learning-ground for new contributors instead if you really
want to send these kind of patches.

Johan
