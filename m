Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6955A3596A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhDIHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:44:10 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51908 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232181AbhDIHoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:44:09 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lUlnx-00068B-TO; Fri, 09 Apr 2021 17:43:51 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Apr 2021 17:43:49 +1000
Date:   Fri, 9 Apr 2021 17:43:49 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 5/5] crypto: hisilicon/sgl - fix the sg buf unmap
Message-ID: <20210409074349.GB23352@gondor.apana.org.au>
References: <1617089946-48078-1-git-send-email-yekai13@huawei.com>
 <1617089946-48078-6-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617089946-48078-6-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 03:39:06PM +0800, Kai Ye wrote:
> Add clear data operation for sge data.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/crypto/hisilicon/sgl.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
> index c618aaf..7a58ab3 100644
> --- a/drivers/crypto/hisilicon/sgl.c
> +++ b/drivers/crypto/hisilicon/sgl.c
> @@ -189,6 +189,18 @@ static void update_hw_sgl_sum_sge(struct hisi_acc_hw_sgl *hw_sgl, u16 sum)
>  	hw_sgl->entry_sum_in_chain = cpu_to_le16(sum);
>  }
>  
> +static void clear_hw_sgl_sge(struct hisi_acc_hw_sgl *hw_sgl)
> +{
> +	struct acc_hw_sge *hw_sge = hw_sgl->sge_entries;
> +	int i;
> +
> +	for (i = 0; i < hw_sgl->entry_sum_in_sgl; i++) {
> +		hw_sge[i].page_ctrl = NULL;
> +		hw_sge[i].buf = 0;
> +		hw_sge[i].len = 0;
> +	}
> +}

This causes a new sparse warning:

  CHECK   ../drivers/crypto/hisilicon/sgl.c
  ../drivers/crypto/hisilicon/sgl.c:200:31: warning: restricted __le16 degrades to integer

Please fix.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
