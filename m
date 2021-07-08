Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3A3C1754
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhGHQtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:49:40 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:59658 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229468AbhGHQtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:49:39 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DDF9118481CC3;
        Thu,  8 Jul 2021 16:46:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id C71191E04D6;
        Thu,  8 Jul 2021 16:46:55 +0000 (UTC)
Message-ID: <39a7b7c455c6c23f0bfe7403b4957d2c92196d46.camel@perches.com>
Subject: Re: [PATCH] drivers: parisc: Follow the indentation coding standard
 on printks
From:   Joe Perches <joe@perches.com>
To:     Carlos Bilbao <bilbao@vt.edu>,
        James.Bottomley@hansenpartnership.com
Cc:     deller@gmx.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch
Date:   Thu, 08 Jul 2021 09:46:54 -0700
In-Reply-To: <1793924.CQOukoFCf9@iron-maiden>
References: <1793924.CQOukoFCf9@iron-maiden>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.88
X-Stat-Signature: bf5x7hu4qzo6ebqrqu3zoqskqspn4eqn
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: C71191E04D6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+3oypUb4+2pFpKdBOrW8q0uE0T83Ec5xw=
X-HE-Tag: 1625762815-113199
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-08 at 11:25 -0400, Carlos Bilbao wrote:
> Fix indentation of printks that start at the beginning of the line. Change this 
> for the right number of space characters, or tabs if the file uses them. 

These are ancient codes, but:

> diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
[]
> @@ -633,7 +633,7 @@ static void iosapic_unmask_irq(struct irq_data *d)
>  	printk("\n");
>  }
>  
> 
> -printk("iosapic_enable_irq(): sel ");
> +	printk("iosapic_enable_irq(): sel ");
>  {
>  	struct iosapic_info *isp = vi->iosapic;
>  
> 
> @@ -642,7 +642,7 @@ printk("iosapic_enable_irq(): sel ");
>  		printk(" %x", d1);
>  	}
>  }
> -printk("\n");
> +	printk("\n");
>  #endif

This is in an undefined #ifdef block and the block could be deleted.

> diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
[]
> @@ -1550,7 +1550,7 @@ static void sba_hw_init(struct sba_device *sba_dev)
>  
> 
>  
> 
>  #if 0

#if 0 blocks can be removed.

> -printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
> +	printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
>  	PAGE0->mem_boot.spa, PAGE0->mem_boot.pad, PAGE0->mem_boot.cl_class);
>  
> 
>  	/*


