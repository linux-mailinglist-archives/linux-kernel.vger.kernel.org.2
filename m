Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771BF447D13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhKHJxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhKHJxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:53:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E55761177;
        Mon,  8 Nov 2021 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636365024;
        bh=plS38UIbyzd2wEXopOk5WiMyFMFGACeQb5PcOmdcqo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrenQ7I84ZtCQIhEybLUGFj/5b0KlKcN4QJt/4Ds4dVRPUgLITY4nLyaLUEG+kWOO
         tDNkfYlac1634JbjJkXExEeEdNgj9eeNBwaR4h5AOyLcwBgoPWt0YqcVH5fl4qIHem
         /0lxNZ7RdT2XNZcLOdRUQr7fNWLjMjjcUqMGSa8+EoKuAGzbCM3QNgl/nbDOQCMHrK
         k7OLw5Mhwkgy9ZOmGS4pFjub69Aj/PmOq4VI2bhh3uhP1WArOQQVHY9uiNu269haQS
         aGY2BPpNzWYjyq+tJq94yFa+dkRxzYWfGjXgVELlFqEHE4Zsh4CKmOtkmXSmvEGWCr
         ktMzHDsY+QY2Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mk1ID-0003Xc-Lx; Mon, 08 Nov 2021 10:50:21 +0100
Date:   Mon, 8 Nov 2021 10:50:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        yao.jing2@zte.com.cn, zealci@zte.com.cn
Subject: Re: [PATCH v2] most: replace snprintf in show functions with
 sysfs_emit
Message-ID: <YYjy3QRXk/VL2Lze@hovoldconsulting.com>
References: <YYJH/lYLQJdM2H1p@hovoldconsulting.com>
 <20211104114540.30622-1-yao.jing2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104114540.30622-1-yao.jing2@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 11:45:40AM +0000, cgel.zte@gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
> sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
> ---
> 
> Changes since v1:
>  - Actually, the robot which is composed of lots of tools includes
>    coccienlle.
>  - Change the ignored snprintf().
>  - Change the wrong Subject.

Ok, this is much better, but note that there are a lot more instances
like this in the "most" subsystem which this patch is not addressing so
the patch prefix should really have been:

	"most: usb: ..."

since you're only handling the most usb driver.

>  drivers/most/most_usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
> index acabb7715b42..73258b24fea7 100644
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
> @@ -843,7 +843,7 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
>  	if (err < 0)
>  		return err;
>  
> -	return snprintf(buf, PAGE_SIZE, "%04x\n", val);
> +	return sysfs_emit(buf, "%04x\n", val);
>  }
>  
>  static ssize_t value_store(struct device *dev, struct device_attribute *attr,

Other than that, looks good:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
