Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4F40BBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhINWjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbhINWjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:39:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE557C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cl7UIjCTs1b0KsfXtz6K9iVGx4kWZVf7z5I2bRPh74A=; b=dFFvdcTmcRbqGaT8IsF/AUegtm
        dks6cALCpathKp0032DBi/kakZAvNnbMu2gWMv69Po+1cmxpOa3yXKNGXuvjbFSpAza28qB4JeUoA
        siPW4gQSivNQUOICctwN8p1m9tcmE6JYi75ptc1PR3bFL17UCoAe7vV8kvwwD62uX98JdL45xF6pj
        BJELET3g57V03XK6B5PyC5T3goYFGwyrSwAH9zH2DjlLPbmQgwvA8AF9FQpkXqKUU0AlLWHiz1sE2
        uldWZHHABf++0ne5tcA645N5aP98srburh1QqB93/T+otKWGfl4JYDgMvN//lF5aex4KHzAgsNx6s
        XEFv2utw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQH3j-007Rsg-7C; Tue, 14 Sep 2021 22:37:47 +0000
Subject: Re: [PATCH v2 1/5] virtio-pci: introduce legacy device module
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <f833e77685cd1dfadc5c3b6688d29a0d1383dbb9.1631621507.git.wuzongyong@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ff4bc96-390d-5a75-a881-b7042822bd2b@infradead.org>
Date:   Tue, 14 Sep 2021 15:37:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f833e77685cd1dfadc5c3b6688d29a0d1383dbb9.1631621507.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 5:24 AM, Wu Zongyong wrote:
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index ce1b3f6ec325..b14768dc9e04 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -20,6 +20,15 @@ config VIRTIO_PCI_LIB
>   	  PCI device with possible vendor specific extensions. Any
>   	  module that selects this module must depend on PCI.
>   
> +config VIRTIO_PCI_LIB_LEGACY
> +	tristate
> +	help
> +	  Legacy PCI device (Virtio PCI Card 0.9.x Draft and older device)
> +	  implementation.
> +	  This modules implements the basic probe and control for devices

	       module

> +	  which are based on legacy PCI device. Any module that selects this
> +	  module must depend on PCI.
> +


-- 
~Randy

