Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2930E3651C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 07:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhDTFTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 01:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhDTFTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 01:19:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B093C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 22:18:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e2so14716593plh.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 22:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=73AAcxdshwVHBh5SM/Wh/8tNFMypchVB46zj9Wl6Tpo=;
        b=AEe+OnFJmpMQ2eaKh5qExivHBVzJAoN9mx/uHr8Z4TzuN16v7pDgroD8PE5y8+ONC7
         55AixR19RdBV3W8PsLWpCiLGnJqnWJfsndx6l4IJicFoMlVsI6Hmx8ldr7R5LGDRnx+H
         QBpFlgdl8ecXWFpol1dbW0BpDAHa5XRl8BwhmrFFdBQeSlm5tfjLHpZEJmfpo1XOp13v
         GsBiH1hzy7HCmDBGxd/rJL0R+VpZoYp4L9ls9L3cSTO7+x62oiNZ/PcR7d0y4gXrHm6b
         IcmkGTGgkcZfIQ4ZlGnImTVRMCemi6ZOn8CZCJA47SRM9+xsvO72PyUtHa2q7SvtQtk2
         ywcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=73AAcxdshwVHBh5SM/Wh/8tNFMypchVB46zj9Wl6Tpo=;
        b=r7VzNr7E6z81S19dFZCbOF92sT3idzsPOv0hn/TmXuXmhBTpAAR+uaRZtoTW4dmimu
         Kc04+dGb530gpXvoiweRMSOiqSLM2KvUIKEIgTf6Vp/QYlngr2iFnhhPYpvb/LGVieHJ
         92P1Npr95pu86bZI+CaTobJI2L+kaW8iUCDd0UrAB6jI+j5c1iONckfp9UAUfIUmDvKc
         GI29gQUlqJMYf8d77wkgCR4IqvKNM+mOuDDRbIJ8YEnligbxFTC0ZN0KreVmONTLVr+4
         6zotLkmmCpeC4Puz8/GtsCqeGzGRfdJSNbm6GD465cNZWXFzokSyY+7GP0p1pWrivBOa
         jn7w==
X-Gm-Message-State: AOAM533t7mjjIPWmZJJqgAOLHTQSKAVLD2B3MAS1DtntdpQw77kg0yKz
        yen3ChmuTqHZhJS5qtlkXDPtog==
X-Google-Smtp-Source: ABdhPJy//9ofYwNeDVmogiXfm/F9Svow7vj/jXnh2HHYWuXUt4HyHTuZZYDmjzQ1+zcpxiKChTbB5A==
X-Received: by 2002:a17:902:be02:b029:e6:bb0d:6c1e with SMTP id r2-20020a170902be02b02900e6bb0d6c1emr26915647pls.77.1618895922211;
        Mon, 19 Apr 2021 22:18:42 -0700 (PDT)
Received: from localhost (ppp121-45-194-51.cbr-trn-nor-bras38.tpg.internode.on.net. [121.45.194.51])
        by smtp.gmail.com with UTF8SMTPSA id w21sm1063751pjy.21.2021.04.19.22.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 22:18:41 -0700 (PDT)
Message-ID: <58b28a98-37aa-055f-5dec-d8c0005c9519@ozlabs.ru>
Date:   Tue, 20 Apr 2021 15:18:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [PATCH 1/1] powerpc/pseries/iommu: Fix window size for direct
 mapping with pmem
Content-Language: en-US
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210420045404.438735-1-leobras.c@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210420045404.438735-1-leobras.c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/04/2021 14:54, Leonardo Bras wrote:
> As of today, if the DDW is big enough to fit (1 << MAX_PHYSMEM_BITS) it's
> possible to use direct DMA mapping even with pmem region.
> 
> But, if that happens, the window size (len) is set to
> (MAX_PHYSMEM_BITS - page_shift) instead of MAX_PHYSMEM_BITS, causing a
> pagesize times smaller DDW to be created, being insufficient for correct
> usage.
> 
> Fix this so the correct window size is used in this case.

Good find indeed.

afaict this does not create a huge problem though as 
query.largest_available_block is always smaller than (MAX_PHYSMEM_BITS - 
page_shift) where it matters (phyp).


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> Fixes: bf6e2d562bbc4("powerpc/dma: Fallback to dma_ops when persistent memory present")
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>   arch/powerpc/platforms/pseries/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 9fc5217f0c8e..836cbbe0ecc5 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -1229,7 +1229,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>   	if (pmem_present) {
>   		if (query.largest_available_block >=
>   		    (1ULL << (MAX_PHYSMEM_BITS - page_shift)))
> -			len = MAX_PHYSMEM_BITS - page_shift;
> +			len = MAX_PHYSMEM_BITS;
>   		else
>   			dev_info(&dev->dev, "Skipping ibm,pmemory");
>   	}
> 

-- 
Alexey
