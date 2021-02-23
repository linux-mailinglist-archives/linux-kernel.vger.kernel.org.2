Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92B322E88
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhBWQQA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Feb 2021 11:16:00 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41647 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbhBWQP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:15:58 -0500
X-Originating-IP: 86.210.203.113
Received: from xps13 (lfbn-tou-1-972-113.w86-210.abo.wanadoo.fr [86.210.203.113])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E31DCC0002;
        Tue, 23 Feb 2021 16:15:07 +0000 (UTC)
Date:   Tue, 23 Feb 2021 17:15:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Rename parameter name in macro
Message-ID: <20210223171506.144c982e@xps13>
In-Reply-To: <1613979342-23572-1-git-send-email-mdalam@codeaurora.org>
References: <1613979342-23572-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Md Sadre Alam <mdalam@codeaurora.org> wrote on Mon, 22 Feb 2021
13:05:42 +0530:

> This change will rename parameter name in macro
> nandc_set_read_loc().renamed parameter names are
> cw_offset, read_size, is_last_read_loc.
> Sinc in QPIC V2 on-wards there is separate location
> register to read last code word, so to just differnciate
> b/w is_last_read_loc from last_cw this change needed.

"
Rename the parameters of the nandc_set_read_loc() macro to avoid the
confusion between is_last_read_loc which <explain what it is> and
<last_cw> which <explain what it is as well>.

> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 4189a7f..bfefb4e 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -181,11 +181,11 @@
>  #define	ECC_BCH_4BIT	BIT(2)
>  #define	ECC_BCH_8BIT	BIT(3)
>  
> -#define nandc_set_read_loc(nandc, reg, offset, size, is_last)	\
> +#define nandc_set_read_loc(nandc, reg, cw_offset, read_size, is_last_read_loc)	\
>  nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
> -	      ((offset) << READ_LOCATION_OFFSET) |		\
> -	      ((size) << READ_LOCATION_SIZE) |			\
> -	      ((is_last) << READ_LOCATION_LAST))
> +	      ((cw_offset) << READ_LOCATION_OFFSET) |		\
> +	      ((read_size) << READ_LOCATION_SIZE) |			\
> +	      ((is_last_read_loc) << READ_LOCATION_LAST))
>  
>  /*
>   * Returns the actual register address for all NAND_DEV_ registers

Thanks,
Miquèl
