Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D353E38931F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355019AbhESP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355043AbhESP7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:59:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AF4A611BF;
        Wed, 19 May 2021 15:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621439871;
        bh=CvWgn1TOhKyllL0rp25eLv8GWJAa4SUZ0xSNVCnhHXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQbhPO6fh3q+C+P15r2OQnMBA7xmMTrT+lqIyoBuFEqEf/xDj8CDLj22xKvZY2k6S
         0jQI0+AAyVTWe62kNXqTI6ZxVuLUvIzuS8aqRdjODhXlf63eBa1s0CZyiefwHEGKdH
         ZZFQOsOzEwqe+CSiRPJF4mQGfpywGus3ysXFsQvk=
Date:   Wed, 19 May 2021 17:57:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: greybus: fix open parenthesis issue in gbphy.c
Message-ID: <YKU1fdzyKuwY/IER@kroah.com>
References: <20210519151851.26006-1-asha.16@itfac.mrt.ac.lk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519151851.26006-1-asha.16@itfac.mrt.ac.lk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 08:48:51PM +0530, F.A.Sulaiman wrote:
> This fix "Alignment should match open parenthesis" checkpatch error.
> 
> Signed-off-by: "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
> ---
>  drivers/staging/greybus/gbphy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
> index 9fc5c47be9bd..13d319860da5 100644
> --- a/drivers/staging/greybus/gbphy.c
> +++ b/drivers/staging/greybus/gbphy.c
> @@ -27,7 +27,7 @@ struct gbphy_host {
>  static DEFINE_IDA(gbphy_id);
>  
>  static ssize_t protocol_id_show(struct device *dev,
> -				 struct device_attribute *attr, char *buf)
> +				struct device_attribute *attr, char *buf)
>  {
>  	struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
>  
> @@ -221,7 +221,7 @@ void gb_gbphy_deregister_driver(struct gbphy_driver *driver)
>  EXPORT_SYMBOL_GPL(gb_gbphy_deregister_driver);
>  
>  static struct gbphy_device *gb_gbphy_create_dev(struct gb_bundle *bundle,
> -				struct greybus_descriptor_cport *cport_desc)
> +						struct greybus_descriptor_cport *cport_desc)
>  {
>  	struct gbphy_device *gbphy_dev;
>  	int retval;
> -- 
> 2.17.1
> 
> 

You sent this 3 different times, why?

Please send a new version, a v2, and say what changed from the previous
one.

thanks,

greg k-h
