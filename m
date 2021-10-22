Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A241743768A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhJVMNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:13:42 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56238 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhJVMNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:13:40 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mdtO7-0001zR-UP; Fri, 22 Oct 2021 20:11:08 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mdtO2-0007Lr-IS; Fri, 22 Oct 2021 20:11:02 +0800
Date:   Fri, 22 Oct 2021 20:11:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     hch@infradead.org, caihuoqing@baidu.com, bbrezillon@kernel.org,
        arno@natisbad.org, schalla@marvell.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: octeontx2 - Use dma_alloc_noncoherent()
 instead of kzalloc/dma_map_single()
Message-ID: <20211022121102.GA28240@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012032229.2307-1-caihuoqing@baidu.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> @@ -1489,11 +1482,9 @@ int otx2_cpt_discover_eng_capabilities(struct otx2_cptpf_dev *cptpf)
> 
>                cptpf->eng_caps[etype].u = be64_to_cpup(rptr);
>        }
> -       dma_unmap_single(&pdev->dev, rptr_baddr, len, DMA_BIDIRECTIONAL);
> +       dma_free_noncoherent(&pdev->dev, len, (void *)result, rptr_baddr, DMA_BIDIRECTIONAL);

Why the cast?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
