Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0DB3CAF7F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhGOXFW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jul 2021 19:05:22 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45031 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOXFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:05:21 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id DBADB1C0008;
        Thu, 15 Jul 2021 23:02:25 +0000 (UTC)
Date:   Fri, 16 Jul 2021 01:02:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <David.Woodhouse@intel.com>,
        <Artem.Bityutskiy@nokia.com>, <ext-adrian.hunter@nokia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linfeilong@huawei.com>
Subject: Re: [PATCH] mtd: fix size in mtd_info_user to support 64-bit
Message-ID: <20210716010224.44582046@xps13>
In-Reply-To: <20210708131359.21591-1-linmiaohe@huawei.com>
References: <20210708131359.21591-1-linmiaohe@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaohe,

Miaohe Lin <linmiaohe@huawei.com> wrote on Thu, 8 Jul 2021 21:13:59
+0800:

> From: Feilong Lin <linfeilong@huawei.com>
> 
> The size in struct mtd_info_user is 32-bit, which will cause errors
> when obtaining the size of large-capacity MTD devices, such as TLC
> NAND FLASH-2048Gb.

Besides the fact that such devices are far from being supported by the
Linux kernel, this change would basically break userspace, it cannot
enter as-is...

> Fixes: 69423d99fc18 ("[MTD] update internal API to support 64-bit device size")
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> ---
>  include/uapi/mtd/mtd-abi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
> index b869990c2db2..efe0b53b10c1 100644
> --- a/include/uapi/mtd/mtd-abi.h
> +++ b/include/uapi/mtd/mtd-abi.h
> @@ -128,7 +128,7 @@ struct mtd_write_req {
>  struct mtd_info_user {
>  	__u8 type;
>  	__u32 flags;
> -	__u32 size;	/* Total size of the MTD */
> +	__u64 size;	/* Total size of the MTD */
>  	__u32 erasesize;
>  	__u32 writesize;
>  	__u32 oobsize;	/* Amount of OOB data per block (e.g. 16) */

Thanks,
Miquèl
