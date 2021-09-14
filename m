Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8040BBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhINWg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbhINWgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:36:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2BAC0613DE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=UU8NPRmd+WrsnL1h2xgrcQ/YKA6+gLoFDMON/ybQaQ0=; b=c1OtSLFAo4M0NNPtWPVb8JIekI
        IaIzxdSMDGHpnQ/h3DlU2zriGdjS+nPr3bdvx1StU1I1WMJ5rYeVznEjTJnoDPnTjx2iseFgWUwqJ
        hCO/4qyxYlXfq0wDbsVDj7Bn+HHoLMtdZ8bO2cSBqRUXTUnGMK4+4JY4yNKtQ39jdMSnesezOoIQf
        StRqZ1SHCGbdngAZxqPWyfsCFFXHBLWuBb9JZQBYEBHReBDfn8hlhUcFkRig4FSoLNsBVrnlElwoL
        v2jorbiu1PiozSKgb8x3q2HUl81ofXrQmn8WTNlVvdOWE/uVHAdUUgnyq6t1FQw2D4bxy9dBdGvb0
        ZNdbqvGQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQH1O-007QoH-OK; Tue, 14 Sep 2021 22:35:22 +0000
Subject: Re: [PATCH v2 5/5] eni_vdpa: add vDPA driver for Alibaba ENI
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <ab98427764198053b4277a127eaea3f32cd40ed5.1631621507.git.wuzongyong@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef57dd1f-e94c-f5f2-6226-8ae53c22bb38@infradead.org>
Date:   Tue, 14 Sep 2021 15:35:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ab98427764198053b4277a127eaea3f32cd40ed5.1631621507.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 5:24 AM, Wu Zongyong wrote:
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 3d91982d8371..9587b9177b05 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -78,4 +78,12 @@ config VP_VDPA
>   	help
>   	  This kernel module bridges virtio PCI device to vDPA bus.
>   
> +config ALIBABA_ENI_VDPA
> +	tristate "vDPA driver for Alibaba ENI"
> +	select VIRTIO_PCI_LEGACY_LIB
> +	depends on PCI_MSI
> +	help
> +	  VDPA driver for Alibaba ENI(Elastic Network Interface) which is build upon

	                          ENI (Elastic                            built upon the

> +	  virtio 0.9.5 specification.
> +
>   endif # VDPA


-- 
~Randy

