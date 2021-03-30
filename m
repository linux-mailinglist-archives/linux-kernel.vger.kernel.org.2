Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD8234E2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhC3H4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:56:39 -0400
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:57302 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231259AbhC3H4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:56:06 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B08FA18023455;
        Tue, 30 Mar 2021 07:56:05 +0000 (UTC)
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA id 86F491A29FA;
        Tue, 30 Mar 2021 07:56:04 +0000 (UTC)
Message-ID: <c2dcae1a5ea1f6900e061fe1a7dc393dbaf1bdc5.camel@perches.com>
Subject: Re: [PATCH v2 3/5] crypto: hisilicon/sgl - add some dfx logs
From:   Joe Perches <joe@perches.com>
To:     Kai Ye <yekai13@huawei.com>, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Date:   Tue, 30 Mar 2021 00:56:03 -0700
In-Reply-To: <1617089946-48078-4-git-send-email-yekai13@huawei.com>
References: <1617089946-48078-1-git-send-email-yekai13@huawei.com>
         <1617089946-48078-4-git-send-email-yekai13@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 86F491A29FA
X-Spam-Status: No, score=0.10
X-Stat-Signature: dys1kxe9tdng11f1sfbms1ucoct3bjrk
X-HE-Tag: 1617090964-178579
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-30 at 15:39 +0800, Kai Ye wrote:
> Add some dfx logs in some abnormal exit situations.
[]
> diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
[]
> @@ -87,8 +87,10 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
>  		block[i].sgl = dma_alloc_coherent(dev, block_size,
>  						  &block[i].sgl_dma,
>  						  GFP_KERNEL);
> -		if (!block[i].sgl)
> +		if (!block[i].sgl) {
> +			dev_err(dev, "Fail to allocate hw SG buffer!\n");

This doesn't seem useful as dma_alloc_coherent does a dump_stack
by default on OOM.


