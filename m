Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA9A30ADED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhBARcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:32:51 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:48078 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbhBARcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:32:12 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 57C927DC5;
        Mon,  1 Feb 2021 09:31:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 57C927DC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1612200678;
        bh=ii84u06WrT1wiRPFXlO0+eF4/FLJ4dFwcrOss1Lc6eA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QpuYK2w/7lPWXicgXQL/GcriLG2q2s1bXucpzb/a/peLGHJud2LpfTe5ceUb8ON5q
         nSwQhYA6Ui/ZUynwD3N9PKe5Z+RhJF36eM6xdE4PmdeNWc7fBqq6wvdxlyPsykWwOv
         J/ND1doXxrVt5JfTBGnxG1e+ofO5FqiaY985sqp8=
Subject: Re: [PATCH] misc: bcm-vk: unlock on error in bcm_to_h_msg_dequeue()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YBfyb+jU5lDUe+5g@mwanda>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <cf899c97-2c26-afc4-f0ea-4976a074a05e@broadcom.com>
Date:   Mon, 1 Feb 2021 09:31:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBfyb+jU5lDUe+5g@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-02-01 4:22 a.m., Dan Carpenter wrote:
> Unlock before returning on this error path.
>
> Fixes: 111d746bb476 ("misc: bcm-vk: add VK messaging support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/bcm-vk/bcm_vk_msg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
> index eec90494777d..fc972e43258a 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_msg.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
> @@ -849,7 +849,8 @@ s32 bcm_to_h_msg_dequeue(struct bcm_vk *vk)
>  				 * that is fatal.
>  				 */
>  				dev_crit(dev, "Kernel mem allocation failure.\n");
> -				return -ENOMEM;
> +				total = -ENOMEM;
> +				goto idx_err;
>  			}
>  
This is a pretty fatal case if we fail to allocate memory here.
Will let Desmond respond if we wanted to keep the mutex locked forever in this
case or if we do want to return and keep mutex locked if it is fatal and there is
no real recovery path.
>  			/* flush rd pointer after a message is dequeued */

