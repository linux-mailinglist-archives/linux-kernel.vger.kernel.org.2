Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3E445D60
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhKEBis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhKEBiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:38:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD92C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=v8DJycKbUDuWHpo+yhZJgQbYGXaKWxErBb27iH0ci4g=; b=WndQzfJNkRgAS34M5fvbOp6U8C
        s5P0cEXvUBtOygmGG99b0voR10xbo2iJGdZIDuuhs0dA2ei9WzbiFi3oFz/ADATvrIe3QhF8oHpEE
        kUEKkd7bhqOGwHBKf8O7wqDXhaUDpaBeK96Lo9af23crHoB7LtRzpBdx5dPF5zvuYtxFw6+CAEyqt
        dQXIXmyk2b37dOTEKbuC0fcy54xiN5SIpdDMq9t0PiuPRintNk365pKCU7CBymCDO7GtNsxf478Ww
        4y+HSmcVqdzUj9su1aCea7hCIOARMdkfzShQyOvI0tOB5WNdt9WZvo7ZyFCEJJ4S2aebtuczD+qgn
        GNT3Berg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mio9G-00AJZy-Bj; Fri, 05 Nov 2021 01:36:06 +0000
Subject: Re: [PATCH v2] drivers/coresight: ultrasoc: Add System Memory Buffer
 driver
To:     Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
References: <20211105012012.86635-1-liuqi115@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <af9dbbbf-64f0-f3c6-fa30-4e306e6156d2@infradead.org>
Date:   Thu, 4 Nov 2021 18:36:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211105012012.86635-1-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/21 6:20 PM, Qi Liu wrote:
> diff --git a/drivers/hwtracing/coresight/ultrasoc/Kconfig b/drivers/hwtracing/coresight/ultrasoc/Kconfig
> new file mode 100644
> index 000000000000..c18c25bf9df3
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/ultrasoc/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: MIT
> +#
> +# ultrasoc configuration
> +#
> +config ULTRASOC_SMB
> +	tristate "Ultrasoc system memory buffer drivers"
> +        depends on ARM64 && CORESIGHT

The "depends" line should be indented with a tab instead of spaces...

> +	help
> +	  This enables support for the Ultrasoc system memory buffer
> +	  driver that is responsible for receiving the trace data from
> +	  Coresight ETM devices and storing them to a system buffer
> +	  respectively.


-- 
~Randy
