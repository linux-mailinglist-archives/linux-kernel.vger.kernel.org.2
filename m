Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F37327AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhCAJ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:27:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233896AbhCAJ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:27:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F39164E45;
        Mon,  1 Mar 2021 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614590813;
        bh=VHgTRak+sl2GIrklguql/soqsfocI2iCaJWV3c8IHHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGWMCEHvjKg+rR1m2mrP0pGyK+uM8DfH1ppCkDe+10csVsmBcl7bTgq8USCqzE3JJ
         n/OUqPeNZS3ZPs4O3urTjunt9CXRgwZMZxPDIKhjDrv8OA5UrYY5slDEyT4p5o9/J6
         547SMOJkYMjI4x+w4ZS3ulgWOmZID0JQvMrTD74o=
Date:   Mon, 1 Mar 2021 10:26:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Switch to using the new API kobj_to_dev()
Message-ID: <YDyzW9l0HbYKS79V@kroah.com>
References: <1614590004-69592-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614590004-69592-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 05:13:24PM +0800, Yang Li wrote:
> fixed the following coccicheck:
> ./include/linux/device.h:590:46-47: WARNING opportunity for
> kobj_to_dev()
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  include/linux/device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ba66073..31d7137 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -587,7 +587,7 @@ struct device_link {
>  
>  static inline struct device *kobj_to_dev(struct kobject *kobj)
>  {
> -	return container_of(kobj, struct device, kobj);
> +	return kobj_to_dev(kobj);
>  }

Did you test this change?  Please do so...

{sigh}

greg k-h
