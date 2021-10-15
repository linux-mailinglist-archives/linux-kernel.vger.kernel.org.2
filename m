Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410E342FBCD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242537AbhJOTPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhJOTPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:15:49 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F8FC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=jpGCHkuYdSR/3o8eROnu0R5nGfFS1MAWWpnW00KwYzU=; b=zDsy6j+Ognfw5Bft8Wp9MkJykI
        9CrolxOt/BLOIQYoC27bl0XyK/Ul0rd4GzwS6XoCscf/zW8K6l4QjtksKsXcPRO0SQfgaKoCzuSjg
        P2DtKOzL9Ew42VETiQEMNvUIcBeggIAj8OBthdi0UVm5s+obe5Yz4ue+lrUyIJmBIYBDBdhY0p4ob
        nN6EK+LsxSEjzC9gE58tP+WROvgi9zmjV21wpC2w036VJgA1yQsZj+GJlRTaAjaLZ/ki0HM6giSCL
        OeUnPjbzGYNBOanB8kSHqif/GC25cLuYBE2G+sCxLz9rDseKGTWfr0b3p9mu2cWam7Et640z/AwFC
        6vJ5/rOg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbSeB-008aka-LI; Fri, 15 Oct 2021 19:13:39 +0000
Subject: Re: [PATCH v5 8/8] eni_vdpa: add vDPA driver for Alibaba ENI
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <57a04a9e516ec4055cb887e9c7b24658ca5b0228.1634281805.git.wuzongyong@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2a92f30a-3ffa-70cb-a054-8bd7b6326ade@infradead.org>
Date:   Fri, 15 Oct 2021 12:13:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <57a04a9e516ec4055cb887e9c7b24658ca5b0228.1634281805.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 12:15 AM, Wu Zongyong wrote:
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 3d91982d8371..c0232a2148a7 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -78,4 +78,12 @@ config VP_VDPA
>   	help
>   	  This kernel module bridges virtio PCI device to vDPA bus.
>   
> +config ALIBABA_ENI_VDPA
> +	tristate "vDPA driver for Alibaba ENI"
> +	select VIRTIO_PCI_LEGACY_LIB
> +	depends on PCI_MSI && !CPU_BIG_ENDIAN
> +	help
> +	  VDPA driver for Alibaba ENI(Elastic Network Interface) which is build upon

	                          ENI (Elastic Network Interface)         built

> +	  virtio 0.9.5 specification.


-- 
~Randy
