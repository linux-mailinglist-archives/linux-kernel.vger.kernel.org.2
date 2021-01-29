Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20683308BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhA2Rwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhA2Rwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:52:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9063C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=NpwFG0OLE9Yz2/yY7izehqzN3Z29cwFwbXcZuoAlr/Q=; b=CykG87k4AnvtENhUpij9nzlS/6
        A06EhgaiwQiVvEySxOh7fDPbni9sb0wqal9Us8NMd8yAaYc4bl185VjwT3bcDQMGdOk/08/KzKmzj
        IrQ/eIgM7Pk57T2Xj6TPTQUsyjrKwT82roxrj8e6xOP3KvZNlvQj0xK00g6dGzF1oJJUXLLF6i1Yt
        c+zdVKFxQqe5dbffvd3DFxskHr7ksSK9n6HG/86NsTzaj+vD2IGxyGTn2uyDKTUOu1Cx4Npg/NPL9
        J+19NQQo08Y/78UAb/kyYvYbyZIWce0owFAeN61tqU2//Z3DlA8b7wl2psIX+L7YyhBBrbXayzRbm
        NuuDVM5g==;
Received: from [2601:1c0:6280:3f0::1d53]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l5Xw6-00A6qL-Ca; Fri, 29 Jan 2021 17:52:01 +0000
Subject: Re: [PATCH 4/5] nvmem: Add driver to expose reserved memory as nvmem
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>
References: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
 <20210129171430.11328-5-srinivas.kandagatla@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <730c11da-7ca0-97d9-207b-24b365d9d540@infradead.org>
Date:   Fri, 29 Jan 2021 09:51:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129171430.11328-5-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/29/21 9:14 AM, Srinivas Kandagatla wrote:
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 954d3b4a52ab..fecc19b884bf 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -270,4 +270,12 @@ config SPRD_EFUSE
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-sprd-efuse.
>   
> +config NVMEM_RMEM
> +	tristate "Reserved Memory Based Driver Support"
> +	help
> +	  This drivers maps reserved memory into an nvmem device. It might be

	  This driver

> +	  useful to expose information left by firmware in memory.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-rmem.
>   endif

