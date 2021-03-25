Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451603497BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhCYRTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYRTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:19:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70497C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 10:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=rROXat92FyBtaFBCu7pF+xceqLk6T+MZ+pD6QqoPGxU=; b=KTn85j0wj7ErfrB0rWh2pJEhvU
        DMHrhBsIgZZz/xUvIk7nEWAHN+G+bZS7p+VAlPmkTxk41x5BU8kxYe3FS2shTY93mO3yaSbF5jMPA
        dYaVu/dJgrTPEfxO2rEqigdPGBTBVtuw0Gf1UGo64fdCTGL0t6gij3fWJRI6+s2TFkaAOeT3ckJGZ
        UNZgaKkHizh8Tq40huqV6mo9a3vAw3WEz2y1C3jdc7A3/44Czxn8G/vJ1nRcIPeBhWpMqvB5AzsaT
        BoZUGEFIsO5zlCxmizZLlf9Zgb7rphUd4GPpVFeo1bGcZodyEUV4nNg0a2GU21VCx2eQPO7xBRvh0
        iRMj+gpQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPTe4-001tkq-9t; Thu, 25 Mar 2021 17:19:44 +0000
Subject: Re: [PATCH V2] misc: genwqe: Rudimentary typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, haver@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20210325015513.9373-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0200a521-1b94-f755-0537-288cf1252967@infradead.org>
Date:   Thu, 25 Mar 2021 10:19:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210325015513.9373-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 6:55 PM, Bhaskar Chowdhury wrote:
> s/requsted/requested/
> s/equests/requests/
> s/occured/occurred/
> s/conditon/condition/
> s/emtpy/empty/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Changes from V1:
>   One change incorporated and one elimilated , as Randy found
> 
>  drivers/misc/genwqe/card_ddcb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
> index 0db4000dedf2..500b1feaf1f6 100644
> --- a/drivers/misc/genwqe/card_ddcb.c
> +++ b/drivers/misc/genwqe/card_ddcb.c
> @@ -316,7 +316,7 @@ static int enqueue_ddcb(struct genwqe_dev *cd, struct ddcb_queue *queue,
> 
>  /**
>   * copy_ddcb_results() - Copy output state from real DDCB to request
> - * @req:        pointer to requsted DDCB parameters
> + * @req:        pointer to requested DDCB parameters
>   * @ddcb_no:    pointer to ddcb number being tapped
>   *
>   * Copy DDCB ASV to request struct. There is no endian
> @@ -356,7 +356,7 @@ static void copy_ddcb_results(struct ddcb_requ *req, int ddcb_no)
>  }
> 
>  /**
> - * genwqe_check_ddcb_queue() - Checks DDCB queue for completed work equests.
> + * genwqe_check_ddcb_queue() - Checks DDCB queue for completed work requests.
>   * @cd:         pointer to genwqe device descriptor
>   * @queue:	queue to be checked
>   *
> @@ -498,7 +498,7 @@ int __genwqe_wait_ddcb(struct genwqe_dev *cd, struct ddcb_requ *req)
> 
>  	/*
>  	 * We need to distinguish 3 cases here:
> -	 *   1. rc == 0              timeout occured
> +	 *   1. rc == 0              timeout occurred
>  	 *   2. rc == -ERESTARTSYS   signal received
>  	 *   3. rc > 0               remaining jiffies condition is true
>  	 */
> @@ -982,7 +982,7 @@ static int genwqe_next_ddcb_ready(struct genwqe_dev *cd)
> 
>  	spin_lock_irqsave(&queue->ddcb_lock, flags);
> 
> -	if (queue_empty(queue)) { /* emtpy queue */
> +	if (queue_empty(queue)) { /* empty queue */
>  		spin_unlock_irqrestore(&queue->ddcb_lock, flags);
>  		return 0;
>  	}
> @@ -1002,7 +1002,7 @@ static int genwqe_next_ddcb_ready(struct genwqe_dev *cd)
>   * @cd:         pointer to genwqe device descriptor
>   *
>   * Keep track on the number of DDCBs which ware currently in the
> - * queue. This is needed for statistics as well as conditon if we want
> + * queue. This is needed for statistics as well as condition if we want
>   * to wait or better do polling in case of no interrupts available.
>   */
>  int genwqe_ddcbs_in_flight(struct genwqe_dev *cd)
> --


-- 
~Randy

