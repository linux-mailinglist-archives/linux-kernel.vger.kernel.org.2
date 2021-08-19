Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBED23F1215
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhHSDqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236408AbhHSDqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:46:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0897B60F4C;
        Thu, 19 Aug 2021 03:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629344774;
        bh=0PWjpf7jKGNN5Wc86CUKn91Ytncf9Qqhm1wOt5aMf+I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jyrL+b0DzU+lE7vMa68BjDE/2NRLd8phHfQE3f6VYn/QR7k20sQ/nhxsU9HlP+6Rc
         Xq7LcA7EiG/+x7kWzh/xY+uGofQ8bYgDE4w9gJ4488+NSPn8HTQ08crMcfgx+qcGph
         BkBrgN3QGzIFiMC49NBemW6mp/jljeSx0/as8BB2jzv/E61EuceG0rZsBdX1jKyaFg
         Dvxlg8jXih9ctztWVDVvbqYmOo60CnPgJYfTeiSFiaKxn/CN/afaxljQiyaOcYYP0O
         ig0WXEFK6fyGHzpTbOW1YyaA3CWUZnO0wcVxS8x7JleTelk7XykqcPbbzAY+Wwy2kx
         ODlwL0qPywDwQ==
Subject: Re: [PATCH 2/2] erofs: support reading chunk-based uncompressed files
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210818070713.4437-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <2c833d7e-9f82-f1f7-a576-b9fc50e0cb15@kernel.org>
Date:   Thu, 19 Aug 2021 11:46:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818070713.4437-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/18 15:07, Gao Xiang wrote:
> +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> +			/* fill chunked inode summary info */
> +			vi->chunkformat = __le16_to_cpu(die->i_u.c.format);

le16_to_cpu(),

>   		kfree(copied);
>   		break;
>   	case EROFS_INODE_LAYOUT_COMPACT:
> @@ -160,6 +163,8 @@ static struct page *erofs_read_inode(struct inode *inode,
>   		inode->i_size = le32_to_cpu(dic->i_size);
>   		if (erofs_inode_is_data_compressed(vi->datalayout))
>   			nblks = le32_to_cpu(dic->i_u.compressed_blocks);
> +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> +			vi->chunkformat = __le16_to_cpu(dic->i_u.c.format);

Ditto.

Thanks,
