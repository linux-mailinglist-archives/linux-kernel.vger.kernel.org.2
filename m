Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633C03A8440
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhFOPoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhFOPoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:44:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 119D7615A0;
        Tue, 15 Jun 2021 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623771752;
        bh=9ZNCulJ1mJReDza+bVVX3e6UYOyFEPfF83pyWsVPVWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxExpVXmCBQDmmBiFItYFjEyYrtHUz4LYopVdbru9KA0dTo+o9UGVeA0h3WhLMJVf
         wX3zsED0suxgwQUdFdaJ1qOlSRiVFm3AEwU2/vbKqINCg2N8n+F/lr3ECNhoz4hHar
         f1YsPTtxyUcnqvz8Mrvx0KQraVUh3OkOb60XquyA=
Date:   Tue, 15 Jun 2021 17:42:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 1/3] mcb: Use DEFINE_RES_MEM() to simplify code
Message-ID: <YMjKZhC0vHkikUQs@kroah.com>
References: <cover.1623768541.git.johannes.thumshirn@wdc.com>
 <1eefa01948355a890b18a68c1eb6a90dc9dc6a87.1623768541.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eefa01948355a890b18a68c1eb6a90dc9dc6a87.1623768541.git.johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:55:28PM +0900, Johannes Thumshirn wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> The value of '.end' should be "start + size - 1". So the previous writing
> should have omitted subtracted 1.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
> ---
>  drivers/mcb/mcb-lpc.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
> index 506676754538..53decd89876e 100644
> --- a/drivers/mcb/mcb-lpc.c
> +++ b/drivers/mcb/mcb-lpc.c
> @@ -105,17 +105,8 @@ static int mcb_lpc_create_platform_device(const struct dmi_system_id *id)
>  	return ret;
>  }
>  
> -static struct resource sc24_fpga_resource = {
> -	.start = 0xe000e000,
> -	.end = 0xe000e000 + CHAM_HEADER_SIZE,
> -	.flags = IORESOURCE_MEM,
> -};
> -
> -static struct resource sc31_fpga_resource = {
> -	.start = 0xf000e000,
> -	.end = 0xf000e000 + CHAM_HEADER_SIZE,
> -	.flags = IORESOURCE_MEM,
> -};
> +static struct resource sc24_fpga_resource = DEFINE_RES_MEM(0xe000e000, CHAM_HEADER_SIZE);
> +static struct resource sc31_fpga_resource = DEFINE_RES_MEM(0xf000e000, CHAM_HEADER_SIZE);

Does this simplify stuff, or does it fix a bug with the existing
definition?

Your changelog text says one thing, but your subject says the other...

thanks,

greg k-h
