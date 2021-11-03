Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3F443E66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKCIbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231721AbhKCIbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:31:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 801E161183;
        Wed,  3 Nov 2021 08:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635928107;
        bh=BPBXnGOqr3AM/VAnZ7RQiT94cY9nN4bCJuE3Xhs7PwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQWcYCyuKgJ4VC0zPznNYhlc8p3VfJ+DwuCzn9y5ksWtj/3VblIFbFYEJrXQu37rh
         JRcQFCU6H3RSWT0nxmMEu+K8/2ZmS5+laTZKTZ8v+p4a5S2zI2ARt4f75WWXGqiEXH
         QYAAA1yiAWl14SPp6Y5rw7JUFexaCG1aio55UybQ=
Date:   Wed, 3 Nov 2021 09:28:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     johan@kernel.org, linux-kernel@vger.kernel.org,
        Jing Yao <yao.jing2@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers: most: replace snprintf in show functions with
 sysfs_emit
Message-ID: <YYJIJqRLI2fjXlzl@kroah.com>
References: <20211103082313.27570-1-yao.jing2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103082313.27570-1-yao.jing2@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 08:23:13AM +0000, cgel.zte@gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> funcitons:
> WARNING use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
> sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

This "robot" is not coccicheck.


> Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
> ---
>  drivers/most/most_usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
> index acabb7715b42..dccbec16000c 100644
> --- a/drivers/most/most_usb.c
> +++ b/drivers/most/most_usb.c
> @@ -831,7 +831,7 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
>  	int err;
>  
>  	if (sysfs_streq(name, "arb_address"))
> -		return snprintf(buf, PAGE_SIZE, "%04x\n", dci_obj->reg_addr);
> +		return sysfs_emit(buf, "%04x\n", dci_obj->reg_addr);
>  
>  	if (sysfs_streq(name, "arb_value"))
>  		reg_addr = dci_obj->reg_addr;
> -- 
> 2.25.1

Why did you only change one of the instances of this in this function
and not both?

Are you going to send a follow-on patch to change the other use of
snprintf() here?

Please do it all in one patch, and fix your "robot" to correctly notify
you of mistakes like this.

thanks,

greg k-h
