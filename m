Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1693839E828
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhFGUPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhFGUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:15:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE2DC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=OBlblsyEe9K54zWGafAt4RwuSBoICXx4jdQjxUflQZ4=; b=yo0tvdzCkg83moiAVunxBlnbUy
        rFMxyHL+WXFdMigSvftvLj/W88r1TbH/IuST2xQ8fbEGp+2Z4d0Gfm1wy527QN81HseSEuhNfv1cP
        hrLMtcPYqWl5gDnU0+4DDw5TqrO/yB5YevWkW2ydMR4WMdld9tfN2nZIxU4n5VVmcDRnrrEsx8Inx
        7j3+Shw4QNHCTLkgzRFNA6QHqqgIqkt0KzwLZkl+tYov6roJ70vk+Po3D6yC0o4o4oCLZrQyNNE/G
        t7u1qnBPHjbIKm1DFyM/UTxAi0CQkyaKGPBIghVeaRITRzCtBIBYv4QTQN+VAut8J0R7BEi1HJcgv
        VHfHq9gQ==;
Received: from [2601:1c0:6280:3f0::bd57]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqLd7-005Hys-4z; Mon, 07 Jun 2021 20:13:49 +0000
Subject: Re: [PATCH v2] mtd: rawnand: marvell: Minor documentation correction
To:     Souptick Joarder <jrdr.linux@gmail.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20210607193736.4654-1-jrdr.linux@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <560cdf7c-c3aa-b102-95f9-b9930dc94b08@infradead.org>
Date:   Mon, 7 Jun 2021 13:13:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210607193736.4654-1-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 12:37 PM, Souptick Joarder wrote:
> Kernel test robot throws below warning ->
> drivers/mtd/nand/raw/marvell_nand.c:454: warning: This comment starts
> with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> 
> Minor documentation correction.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> v2:
> 	Address review comment.
> 
>  drivers/mtd/nand/raw/marvell_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> index 79da6b02e209..f4efdb59467d 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -451,7 +451,7 @@ struct marvell_nfc_timings {
>  };
>  
>  /**
> - * Derives a duration in numbers of clock cycles.
> + * TO_CYCLES() - Derives a duration in numbers of clock cycles.
>   *
>   * @ps: Duration in pico-seconds
>   * @period_ns:  Clock period in nano-seconds
> 


-- 
~Randy

