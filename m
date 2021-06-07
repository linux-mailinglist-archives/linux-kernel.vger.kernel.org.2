Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78FD39D4E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFGGZF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Jun 2021 02:25:05 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:31785 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhFGGZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:25:02 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6A54C240009;
        Mon,  7 Jun 2021 06:23:09 +0000 (UTC)
Date:   Mon, 7 Jun 2021 08:23:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-i3c@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH -next] i3c: master: svc: fix doc warning in
 svc-i3c-master.c
Message-ID: <20210607082308.551cdada@xps13>
In-Reply-To: <20210602085544.4101980-1-yangyingliang@huawei.com>
References: <20210602085544.4101980-1-yangyingliang@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Yang Yingliang <yangyingliang@huawei.com> wrote on Wed, 2 Jun 2021
16:55:44 +0800:

> Fix the following make W=1 warning:
> 
>   drivers/i3c/master/svc-i3c-master.c:207: warning: expecting prototype for struct svc_i3c_i3c_dev_data. Prototype was for struct svc_i3c_i2c_dev_data instead
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index eeb49b5d90ef..879e5a64acaf 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -195,7 +195,7 @@ struct svc_i3c_master {
>  };
>  
>  /**
> - * struct svc_i3c_i3c_dev_data - Device specific data
> + * struct svc_i3c_i2c_dev_data - Device specific data
>   * @index: Index in the master tables corresponding to this device
>   * @ibi: IBI slot index in the master structure
>   * @ibi_pool: IBI pool associated to this device


Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
