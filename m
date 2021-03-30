Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888A434E296
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhC3Hx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:53:56 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:54004 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231394AbhC3Hxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:53:31 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B49AD100E7B45;
        Tue, 30 Mar 2021 07:53:29 +0000 (UTC)
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA id B1DA3D1515;
        Tue, 30 Mar 2021 07:53:28 +0000 (UTC)
Message-ID: <c18ee8d6786b0aa4d6c868ac2c12e684f348daff.camel@perches.com>
Subject: Re: [PATCH v2 1/5] crypto: hisilicon/sgl - fixup coding style
From:   Joe Perches <joe@perches.com>
To:     Kai Ye <yekai13@huawei.com>, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Date:   Tue, 30 Mar 2021 00:53:27 -0700
In-Reply-To: <1617089946-48078-2-git-send-email-yekai13@huawei.com>
References: <1617089946-48078-1-git-send-email-yekai13@huawei.com>
         <1617089946-48078-2-git-send-email-yekai13@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B1DA3D1515
X-Spam-Status: No, score=0.10
X-Stat-Signature: jr83ri87ew14aqx1muk1erkut1bwoj5a
X-Rspamd-Server: rspamout04
X-HE-Tag: 1617090808-263900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-30 at 15:39 +0800, Kai Ye wrote:
> use a macro replace of a magic number.

Given the use of 32 in the same test, this
seems more obfuscating that useful to me.

> diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
[]
> @@ -9,6 +9,7 @@
>  #define HISI_ACC_SGL_NR_MAX		256
>  #define HISI_ACC_SGL_ALIGN_SIZE		64
>  #define HISI_ACC_MEM_BLOCK_NR		5
> +#define HISI_ACC_BLOCK_SIZE_MAX_SHIFT	31
>  
> 
>  struct acc_hw_sge {
>  	dma_addr_t buf;
> @@ -67,7 +68,8 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
>  	sgl_size = sizeof(struct acc_hw_sge) * sge_nr +
>  		   sizeof(struct hisi_acc_hw_sgl);
>  	block_size = 1 << (PAGE_SHIFT + MAX_ORDER <= 32 ?
> -			   PAGE_SHIFT + MAX_ORDER - 1 : 31);
> +			   PAGE_SHIFT + MAX_ORDER - 1 :
> +			   HISI_ACC_BLOCK_SIZE_MAX_SHIFT);
>  	sgl_num_per_block = block_size / sgl_size;
>  	block_num = count / sgl_num_per_block;
>  	remain_sgl = count % sgl_num_per_block;


