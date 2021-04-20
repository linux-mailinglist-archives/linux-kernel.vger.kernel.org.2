Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B43A365B42
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhDTOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:34:46 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33137 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232526AbhDTOem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:34:42 -0400
Received: (qmail 172296 invoked by uid 1000); 20 Apr 2021 10:34:06 -0400
Date:   Tue, 20 Apr 2021 10:34:06 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: datafab: remove redundant assignment of
 variable result
Message-ID: <20210420143406.GA170810@rowland.harvard.edu>
References: <20210420113818.378478-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420113818.378478-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 12:38:18PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable result is being assigned with a value that is
> never read, the assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/datafab.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/datafab.c b/drivers/usb/storage/datafab.c
> index 588818483f4b..bcc4a2fad863 100644
> --- a/drivers/usb/storage/datafab.c
> +++ b/drivers/usb/storage/datafab.c
> @@ -294,7 +294,6 @@ static int datafab_write_data(struct us_data *us,
>  		if (reply[0] != 0x50 && reply[1] != 0) {
>  			usb_stor_dbg(us, "Gah! write return code: %02x %02x\n",
>  				     reply[0], reply[1]);
> -			result = USB_STOR_TRANSPORT_ERROR;
>  			goto leave;
>  		}
>  
> -- 
> 2.30.2
> 
