Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7B413EED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 03:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhIVBTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 21:19:17 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:42674 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230469AbhIVBTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 21:19:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=kaige.fu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UpBB9mw_1632273464;
Received: from B-J1X9LVDL-1650.local(mailfrom:kaige.fu@linux.alibaba.com fp:SMTPD_---0UpBB9mw_1632273464)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 09:17:45 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix potential vpe leak
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, maz@kernel.org, shannon.zhao@linux.alibaba.com
References: <d9e36dee512e63670287ed9eff884a5d8d6d27f2.1631672311.git.kaige.fu@linux.alibaba.com>
From:   Kaige Fu <kaige.fu@linux.alibaba.com>
Message-ID: <fc33eb82-cf42-7be4-bcee-ab2db04c2b0a@linux.alibaba.com>
Date:   Wed, 22 Sep 2021 09:17:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d9e36dee512e63670287ed9eff884a5d8d6d27f2.1631672311.git.kaige.fu@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping ...

ÔÚ 2021/9/15 ÉÏÎç10:20, Kaige Fu Ð´µÀ:
> In its_vpe_irq_domain_alloc, when there is error calling its_vpe_init
> with vm->vpes[i], it says that the number of vpes which has been
> initialized are 'i'. So, the correct value passed to
> its_vpe_irq_domain_free should be 'i' instead of 'i - 1' because
> its_vpe_irq_domain_free takes nr_irqs as its third parameter.
> 
> If we pass the 'i - 1' to its_vpe_irq_domain_free, the vpe[i - 1] will
> be leaked. This patch fixes it.
> 
> Fixes: 7d75bbb4bc1a ("irqchip/gic-v3-its: Add VPE irq domain allocation/teardown")
> Signed-off-by: Kaige Fu <kaige.fu@linux.alibaba.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 7f40dca8cda5..eb0882d15366 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4501,7 +4501,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
>   
>   	if (err) {
>   		if (i > 0)
> -			its_vpe_irq_domain_free(domain, virq, i - 1);
> +			its_vpe_irq_domain_free(domain, virq, i);
>   
>   		its_lpi_free(bitmap, base, nr_ids);
>   		its_free_prop_table(vprop_page);
> 
