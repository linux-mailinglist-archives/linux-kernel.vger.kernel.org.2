Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D741822D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 15:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245344AbhIYNJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 09:09:07 -0400
Received: from ciao.gmane.io ([116.202.254.214]:37126 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234877AbhIYNJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 09:09:02 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1mU7Oo-0008Iy-BP
        for linux-kernel@vger.kernel.org; Sat, 25 Sep 2021 15:07:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 3/4] net: sis: Fix a function name in comments
Date:   Sat, 25 Sep 2021 15:07:22 +0200
Message-ID: <1498cb33-bbd1-ccb7-0ea3-12b319e18dbe@wanadoo.fr>
References: <20210925125042.1629-1-caihuoqing@baidu.com>
 <20210925125042.1629-3-caihuoqing@baidu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210925125042.1629-3-caihuoqing@baidu.com>
Content-Language: fr
Cc:     netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/09/2021 à 14:50, Cai Huoqing a écrit :
> Use dma_alloc_coherent() instead of pci_alloc_consistent(),
> because only dma_alloc_coherent() is called here.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>   drivers/net/ethernet/sis/sis190.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sis/sis190.c b/drivers/net/ethernet/sis/sis190.c
> index 3d1a18a01ce5..7e107407476a 100644
> --- a/drivers/net/ethernet/sis/sis190.c
> +++ b/drivers/net/ethernet/sis/sis190.c
> @@ -1070,7 +1070,7 @@ static int sis190_open(struct net_device *dev)
>   
>   	/*
>   	 * Rx and Tx descriptors need 256 bytes alignment.
> -	 * pci_alloc_consistent() guarantees a stronger alignment.
> +	 * dma_alloc_consistent() guarantees a stronger alignment.
>   	 */
>   	tp->TxDescRing = dma_alloc_coherent(&pdev->dev, TX_RING_BYTES,
>   					    &tp->tx_dma, GFP_KERNEL);
> 

Hi,
s/consistent/coherent/

CJ

