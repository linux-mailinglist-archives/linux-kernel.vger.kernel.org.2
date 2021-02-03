Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7515130E0AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhBCROe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhBCROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:14:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1601BC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 09:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=r7si+zACyMa/4dEAc8TIeS4gERRDsVSPiJmZEEJoLuY=; b=MaoSslkYacP7kJBebrhxe1gS9H
        utJGH4jHsoodvJOkNWQPgUX6crZvFK2LQeVQFDRVHPpftmBHrmmshODUyOGPRS+e0SKRcWDGkqF7R
        zwhGjZiB1w5j8ByfMhSAbmJKy2wuPPKMetlEfx5i65CWU45XX6rkR9BjCz2L7cQ3OoUztgdRQn6dG
        tNVH3utqycDQOBZ96tVoFWZ1EiGEm+q3y7IIY8UDOmTbFaAe0GLNTykQY1AIv7YKqrtfi9xRHYqGR
        ZObdXNiSfxllMKQs2dyoDIE2kTR2EZcRVvM2llNX5ZOscijKboNL/CVAekOaN9ZYQCARV+m3Rxooj
        MpYor0dw==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7Lio-00081A-VD; Wed, 03 Feb 2021 17:13:43 +0000
Subject: Re: [PATCH 1/2] misc/pvpanic: split-up generic and platform dependent
 code
To:     Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andriy.shevchenko@linux.intel.com, bobo.shaobowang@huawei.com
References: <1612363439-26656-1-git-send-email-mihai.carabas@oracle.com>
 <1612363439-26656-2-git-send-email-mihai.carabas@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9080b512-33a8-e9f9-7c4c-bc2572ab7e5c@infradead.org>
Date:   Wed, 3 Feb 2021 09:13:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1612363439-26656-2-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 6:43 AM, Mihai Carabas wrote:
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> new file mode 100644
> index 00000000..12bb017
> --- /dev/null
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -0,0 +1,14 @@
> +config PVPANIC
> +	bool "pvpanic device support"
> +	depends on PVPANIC_MMIO
> +	help
> +	  This option enable generic code for pvpanic device driver logic.
> +
> +config PVPANIC_MMIO
> +	tristate "pvpanic mmio device support"

	                  MMIO


Also capitalize PCI in the other patch in the similar location.

> +	depends on HAS_IOMEM && (ACPI || OF)
> +	select PVPANIC
> +	help
> +	  This driver provides support for the pvpanic device.  pvpanic is
> +	  a paravirtualized device provided by QEMU; it lets a virtual machine
> +	  (guest) communicate panic events to the host.


thanks.
-- 
~Randy

